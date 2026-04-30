---
source_url: 
ingested: 2026-04-29
sha256: d275990d41de384d1f665d0d4814ae86c755c2dd7e384908938684b69fa34ab5
---

# Information Thermodynamics: Maxwell’s Demon in Nonequilibrium Dynamics 

Takahiro Sagawa and Masahito Ueda 

November 27, 2024 

## Abstract 

We review theory of information thermodynamics which incorporates effects of measurement and feedback into nonequilibrium thermodynamics of a small system, and discuss how the second law of thermodynamics should be extended for such situations. We address the issue of the maximum work that can be extracted from the system in the presence of a feedback controller (Maxwell’s demon) and provide a few illustrative examples. We also review a recent experiment that realized a Maxwell’s demon based on a feedback-controlled ratchet. 

## Contents 

|1|Introduction|Introduction||2|
|---|---|---|---|---|
|2|Szilard Engine|||3|
|3|Information Content in Thermodynamics|||5|
||3.1|Shannon Information . . . . . . . . . . . . . . . . .|. . . . . . . . . .|5|
||3.2|Mutual Information . . . . . . . . . . . . . . . . . .|. . . . . . . . . .|6|
||3.3|Examples<br>. . . . . . . . . . . . . . . . . . . . . . .|. . . . . . . . . .|8|
|4|Second Law of Thermodynamics with Feedback Control|||10|
||4.1|General Bound<br>. . . . . . . . . . . . . . . . . . . .|. . . . . . . . . .|11|
||4.2|Generalized Szilard Engine . . . . . . . . . . . . . .|. . . . . . . . . .|12|
||4.3|Overdamped Langevin System . . . . . . . . . . . .|. . . . . . . . . .|13|
||4.4|Experimental Demonstration: Feedback-Controlled Ratchet . . . . . .||15|
||4.5|The Carnot Efciency with Two Heat Baths . . . .|. . . . . . . . . .|17|
|5|Nonequilibrium Equalities with Feedback Control|||18|
||5.1|Preliminaries<br>. . . . . . . . . . . . . . . . . . . . .|. . . . . . . . . .|18|
||5.2|Measurement and Feedback<br>. . . . . . . . . . . . .|. . . . . . . . . .|21|
||5.3|Nonequilibrium Equalities with Mutual Information|. . . . . . . . . .|22|
||5.4|Nonequilibrium Equalities with Efcacy Parameter|. . . . . . . . . .|24|



1 

- 6 Thermodynamic Energy Cost for Measurement and Information Erasure 26 

- 7 Conclusions 29 A Proof of Eq. (56) 29 

## 1 Introduction 

The profound interrelationship between information and thermodynamics was first brought to light by J. C. Maxwell [1] in his gedankenexperiment about a hypothetical being of intelligence which was later christened by William Thomson as Maxwell’s demon. Since then, numerous discussions have been spurred as to whether and how Maxwell’s demon is compatible with the second law of thermodynamics [2–4]. 

To understand the roles of Maxwell’s demon, let us consider a situation in which a gas is confined in a box surrounded by adiabatic walls. A barrier is inserted at the center of the box to divide it into two. The temperatures of the gases in the two boxes are assumed to be initially the same. We assume that the demon is present near the barrier and can close or open a small hole in the barrier. If a faster-than-average (slower-than-average) molecule comes from the right (left) box, the demon opens the hole. Otherwise, the demon keeps it closed. By doing so over and over again, the temperature of the left gas becomes higher than that of the right one, in apparent contradiction with the second law of thermodynamics. This example illustrates the two essential roles of the demon: 

- The demon observes individual molecules, and obtains the information about their velocities. 

- The demon opens or closes the hole based on each measurement outcome, which is the feedback control. 

In general, feedback control implies that a control protocol depends on the measurement outcome, or equivalently, we control a system based on the obtained information [5, 6]. The crucial point here is that the measurements are performed at the level of thermal fluctuations (i.e., the demon can distinguish the velocities of individual molecules). Therefore, Maxwell’s demon can be characterized as a feedback controller that utilizes information about a thermodynamic system at the level of thermal fluctuations (see also Fig. 1). 

In the nineteenth century, it was impossible to observe and control individual atoms and molecules, and therefore it was not necessary to take into account the effect of feedback control in the formulation of thermodynamics. However, due to the recent advances in manipulating microscopic systems, the effect of feedback control on thermodynamic systems has become relevant to real experiments. We can simulate the role of Maxwell’s demon in real experiments and can reduce the entropy of small thermodynamic systems. 

2 

**==> picture [199 x 94] intentionally omitted <==**

**----- Start of picture text -----**<br>
Information<br>System Demon<br>Feedback<br>**----- End of picture text -----**<br>


Figure 1: Maxwell’s demon as a feedback controller. The demon performs feedback control based on the information obtained from measurement at the level of thermal 

In this chapter, we review a general theory of thermodynamics that involves measurements and feedback control [7–44]. We generalize the second law of thermodynamics by including information contents concerning the thermodynamics of feedback control. We note that, by the “demon,” we mean a type of devices that perform feedback control at the level of thermal 

This chapter is organized as follows. In Sec. 2, we discuss the Szilard engine which is a prototypical model of Maxwell’s demon and examine the consistency between the demon and the second law. In Sec. 3, we review information contents that are used in the following sections. In Sec. 4, we discuss a generalized second law of thermodynamics with feedback control, which is the main part of this chapter. In Sec. 5, we generalize nonequilibrium equalities such as the fluctuation theorem and the Jarzynski equality to the case with feedback control. In Sec. 6, we discuss the energy cost (work) that is needed for measurement and information erasure. In Sec. 7, we conclude this chapter. 

## 2 Szilard Engine 

In 1929, L. Szilard proposed a simple model of Maxwell’s demon that illustrates the quantitative relationship between information and thermodynamics [45]. In this section, we briefly review the model, which is called the Szilard engine, and discuss its physical implications. 

The Szilard engine consists of a single-particle gas that is in contact with a single heat bath at temperature T . By a measurement, we obtain one bit of information about the position of the particle and use that information to extract work from the engine via feedback control. While the engine eventually returns to the initial equilibrium, the total amount of the extracted work is positive. The details of the control protocol are as follows (see Fig. 2). 

Step 1: Initial state. We prepare a single-particle gas in a box of volume V0, which is at thermal equilibrium with temperature T . 

3 

**==> picture [199 x 136] intentionally omitted <==**

**----- Start of picture text -----**<br>
Step 1: Thermal equilibrium. Step 2: Insertion of the barrier.<br>Step 3:        Measurement.<br>Step 4: Expansion.<br>**----- End of picture text -----**<br>


Figure 2: The Szilard engine. See the text for details. 

Step 2: Insertion of the barrier. We insert a barrier in the middle of the box, and divide it into two with equal volume V0/2. 

Step 3: Measurement. We perform an error-free measurement of the position of the particle to find which box the molecule is in. Because the particle will be found to be in each box with probability 1/2, the amount of information gained from this measurement is one bit. We note that one (= log2 2) bit of information in the binary logarithm corresponds to ln 2 nat of information in the natural logarithm. 

Step 4: Feedback. If the particle is in the left (right) box, we quasi-statically expand it by moving the barrier to the rightmost (leftmost) position. By this process, we can extract work Wext given by 

**==> picture [299 x 32] intentionally omitted <==**

where we used pV = kBT with p, V , and kB respectively being the pressure, the volume and the Boltzmann constant. This process corresponds to feedback control, because the direction of the expansion (i.e., left or right) depends on the measurement outcome. After this expansion, the gas returns to the initial thermal equilibrium with volume V0. 

The extracted work is proportional to the obtained information with proportionality constant kBT . This is due to the fact that the entropy of the system is effectively decreased by ln 2 via feedback control, and the decrease in entropy leads to the increase in the free energy by kBT ln 2, which is the resource of the extracted work. 

The Szilard engine prima facie seems to contradict the second law of thermodynamics, which dictates that one cannot extract positive work from a single heat bath with a thermodynamic cycle (Kelvin’s principle). In fact, the Szilard engine is consistent with the second law, due to an additional energy cost (work) that is needed for 

4 

the measurement and information erasure of the measurement device or the demon. This additional cost compensates for the excess work extracted from the engine. In his original paper, Szilard argued that there must be an entropic cost for the measurement process [45]. We stress that the work performed on the demon need not be transferred to the engine; only the information obtained by the measurement should be utilized for the feedback. This is the crucial characteristic of the information heat engine. 

By utilizing the obtained information in feedback control, we can extract work from the engine without decreasing its free energy, or we can increase the engine’s free energy without injecting any work to the engine directly. The resource of the work or the free energy is thermal fluctuations of the heat bath; by utilizing information via feedback, we can rectify the thermal energy of the bath and convert it into the work or the free energy. This method allows us to control the energy balance of the engine beyond the conventional thermodynamics. We shall call such a feedbackcontrolled heat engine as an “information heat engine.” The Szilard engine works as the simplest model that illustrates the quintessence of information heat engines. Quantum versions of the Szilard engine have also been studied [12,31,38,43]. 

## 3 Information Content in Thermodynamics 

In this section, we briefly review the Shannon information and the mutual information [46,47]. In particular, the mutual information plays a crucial role in thermodynamics of information processing. 

## 3.1 Shannon Information 

Let x ∈ X be a probability variable which represents a finite set of possible events. We write as P [x] the probability of event x being realized. The information content that is associated with event x is then defined as − ln P [x], which implies that the rarer an event is, the more information is associated with it. The Shannon information is then given by the average of − ln P [x] over all possible events: 

**==> picture [288 x 26] intentionally omitted <==**

The Shannon information satisfies 0 ≤ H(X) ≤ ln N, where N is the number of the possible events (the size of set X). Here, the lower bound (H(X) = 0) is achieved if P [x] = 1 holds for some x; in this case, the event is indeed deterministic, while the upper bound (H(X) = ln N) is achieved if P [x] = 1/N for arbitrary x. In general, the Shannon information characterizes the randomness of a probability variable; the more random the variable, the greater the Shannon information. Consider, for example, a simple case in which x takes two values: x = 0 or x = 1. We set P [0] =: p and P [1] =: 1 − p with 0 ≤ p ≤ 1. The Shannon information is then given by H(X) = −p ln p − (1 − p) ln(1 − p), which takes the maximum value ln 2 for p = 1/2 and the minimal value 0 for p = 0 or 1. 

5 

## 3.2 Mutual Information 

The mutual information characterizes the correlation between two probability variables. Let x ∈ X and y ∈ Y be the two probability variables, and P [x, y] be their joint distribution. The marginal distributions are given by P [x] =[�] y[P][[][x, y][],][ P][[][y][] =] �x[P][[][x, y][].][If the two variables are statistically independent, then][ P][[][x, y][] =][ P][[][x][]][P][[][y][].] Otherwise, they are correlated. If the two variables are perfectly correlated, the joint distribution 

**==> picture [322 x 13] intentionally omitted <==**

where δ(·, ·) is the Kronecker’s delta and f (·) is a bijection function on Y . For example, if P [0, 1] = P [1, 0] = 1/2 and P [0, 0] = P [1, 1] = 0 with X = {0, 1} and Y = {0, 1}, the two variables are perfectly correlated with f (0) = 1 and f (1) = 0. If f (·) is the identity function that satisfies f (y) = y for any y, Eq. (3) reduces to P [x, y] = δ(x, y)P [x] = δ(x, y)P [y]. 

The conditional probability of x for given y is given by P [x|y] = P [x, y]/P [y]. If the two probability variables are statistically independent, the conditional probability reduces to P [x|y] = P [x]. This implies that we cannot obtain any information about x from knowledge of y. On the other hand, in the case of the perfect correlation (3), we obtain P [x|y] = δ(x, f (y)). This means that we can precisely estimate x from y by x = f (y). 

We next introduce the joint Shannon information and the conditional Shannon information. The Shannon information for the joint probability P [x, y] is given by 

**==> picture [306 x 27] intentionally omitted <==**

On the other hand, the Shannon information for the conditional probability P [x|y], where x is the relevant probability variable, is given by 

**==> picture [302 x 26] intentionally omitted <==**

By averaging H(X|y) over y, we define the conditional Shannon information 

**==> picture [353 x 27] intentionally omitted <==**

The conditional Shannon information satisfies the following properties: 

**==> picture [371 x 13] intentionally omitted <==**

By definition, H(X|y) ≥ 0 and H(X|Y ) ≥ 0. Hence 

**==> picture [313 x 13] intentionally omitted <==**

6 

which implies that the randomness decreases if only one of the two variables is concerned. 

The mutual information is defined by 

**==> picture [317 x 13] intentionally omitted <==**

or equivalently, 

**==> picture [306 x 33] intentionally omitted <==**

As shown below, the mutual information satisfies 

**==> picture [336 x 13] intentionally omitted <==**

Here, I(X : Y ) = 0 is achieved if X and Y are statistically independent, i.e., P [x, y] = P [x]P [y]. On the other hand, I(X : Y ) = H(X) is achieved if H(X|Y ) = 0, or equivalently, if H(X|y) = 0 for any y. This condition is equivalent to the condition that, for any y, there exists a single x such that P [x|y] = 1, which implies that we can estimate x from y with certainty. Similarly, I(X : Y ) = H(Y ) is achieved if H(Y |X) = 0. In particular, if the correlation between x and y is perfect such that Eq. (3) holds, I(X : Y ) = H(X) = H(Y ). In general, the mutual information describes the correlation between two probability variables; the more strongly x and y are correlated, the larger I(X : Y ) is. 

The proof of inequalities (11) goes as follows. Because ln(t[−][1] ) ≥ 1 − t for t > 0, where the equality is achieved if and only if t = 1, we obtain 

**==> picture [369 x 32] intentionally omitted <==**

which implies I(X : Y ) ≥ 0. On the other hand, Eq. (9) leads to 

**==> picture [345 x 13] intentionally omitted <==**

which implies I(X : Y ) ≤ H(X) and I(X : Y ) ≤ H(Y ). 

We note that Eqs. (7), (9), and (13) can be illustrated by using a Venn diagram shown in Fig. 3 [46]. This diagram is useful to memorize the relationship among H(X|Y ), H(Y |X), and I(X : Y ). 

The mutual information can be used to characterize the effective information that can be obtained by measurements. Let us consider a situation in which x is a phase-space point of a physical system and y is an outcome that is obtained from a measurement on the system. In the case of the Szilard engine, x specifies the location of the particle (“left” or “right”), and y is the measurement outcome. If the measurement is error-free as we assumed in Sec. 2, x = y is always satisfied and the correlation between the two variables is perfect. In this case, I(X : Y ) = H(X) = H(Y ) holds, and therefore the obtained information can be characterized by the Shannon information as is the argument in Sec. 2. In general, there exist 

7 

**==> picture [142 x 103] intentionally omitted <==**

**----- Start of picture text -----**<br>
H ( X ) H ( Y )<br>H ( X|Y ) I ( X:Y ) H ( Y|X )<br>**----- End of picture text -----**<br>


Figure 3: A Venn diagram [46] illustrating the relationship among different information contents. The entire region represents the joint Shannon information H(X, Y ). 

measurement errors, and the obtained information by the measurement needs to be characterized by the mutual information. The less the amount of the measurement error is, the more the mutual information is. 

We next discuss the cases in which the probability variables take continuous values. The probability distributions such as P [x, y] and P [x] should then be interpreted as probability densities, where the corresponding probabilities are given by P [x, y]dxdy and P [x]dx with dxdy and dx being the integral elements. The Shannon information of x can be formally defined as 

**==> picture [292 x 27] intentionally omitted <==**

However, Eq. (14) is not invariant under the transformation of the variable. In fact, if we change x to x[′] such that P [x]dx = P [x[′] ]dx[′] , Eq. (14) is given by 

**==> picture [348 x 28] intentionally omitted <==**

Thus, that the Shannon information is not uniquely defined for the case of continuous variables. Only when we fix some probability variable, we can give the Shannon information a unique meaning. On the other hand, the mutual information is defined as 

**==> picture [317 x 30] intentionally omitted <==**

which is invariant under the transformation of the variables. In this sense, the mutual information is uniquely defined for the cases of continuous variables, regardless of the choices of probability variables. 

## 3.3 Examples 

We now discuss two typical examples of probability variables: discrete and continuous variables. 

8 

Example 1 (Binary channel) We consider a binary channel with which at most one bit of information is sent from variable x to y [see Fig. 4 (a)]. Let x = 0, 1 be the sender’s bit and y = 0, 1 be the receiver’s bit. We regard this binary channel as a model of a measurement, in which x describes the state of the measured system and y describes the measurement outcome. We assume that the error in the communication (or the measurement error) is characterized by 

**==> picture [334 x 30] intentionally omitted <==**

where ε0 and ε1 are the error rates for x = 0 and x = 1, respectively. The crucial assumption here is that the error property is only characterized by a pair (ε0, ε1), which is independent of the probability distribution of x. If ε0 = ε1 =: ε, this model is called a binary symmetric channel. 

**==> picture [284 x 91] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) Sender Receiver (b) 0.7<br>0 1 -  ε 0 0 0.6<br>0.5<br>ε 1 0.40.3<br>0.2<br>ε 0 0.1<br>1 1 -  ε 1 1 0.2 0.4 0.6 0.8 1.0<br>ε<br>) X : Y<br>(<br>I<br>**----- End of picture text -----**<br>


Figure 4: (a) A binary channel with error rates ε0 and ε1. (b) Mutual information I(X : Y ) versus error rate ε for a binary symmetric channel with ε0 = ε1 =: ε and p = 1/2, which gives I(X : Y ) = ln 2 + ε ln ε + (1 − ε) ln(1 − ε). 

Let P [x = 0] =: p and P [x = 1] =: 1 − p be the probability distribution of x. The joint distribution of x and y is then given by P [x = 0, y = 0] = p(1 − ε0), P [x = 0, y = 1] = pε0, P [x = 1, y = 0] = (1 − p)ε1, P [x = 1, y = 1] = (1 − p)(1 − ε1), and the distribution of y is given by P [y = 0] = p(1 − ε0) + (1 − p)ε1 =: q, P [y = 1] = pε0 +(1 − p)(1 − ε1) =: 1 − q. By definition, we can show that the mutual information is given by 

**==> picture [329 x 13] intentionally omitted <==**

where H(Y ) := −q ln q − (1 − q) ln(1 − q) is the Shannon information for Y , and we defined H(εi) := −εi ln εi − (1 − εi) ln(1 − εi) for i = 0 and 1. From Eq. (18), I(X : Y ) = H(Y ) holds for (ε0, ε1) = (0, 0), (0, 1), (1, 0), or (1, 1). For a binary symmetric channel, Eq. (18) reduces to I(X : Y ) = H(Y ) − H(ε). Figure 4 (b) shows I(X : Y ) versus ε for the case of p = 1/2. The mutual information takes the maximum value if ε = 0 or ε = 1. In this case, we can precisely estimate x from y. We note that, if ε = 1, we can just relabel “0” and “1” of y such that x = y holds. 

Example 2 (Gaussian channel) We next consider a Gaussian channel with continuous variables x and y. Let x be the sender’s variable or the “signal” and y be 

9 

the receiver’s variable or the “outcome.” We can also interpret that x describes the phase-space point of a physical system such as the position of a Brownian particle, and that y describes the outcome of the measurement on the system. We assume that the error is characterized by a Gaussian noise 

**==> picture [308 x 30] intentionally omitted <==**

where N is the variance of the noise. For simplicity, we also assume that the probability density of x is also Gaussian: 

**==> picture [288 x 30] intentionally omitted <==**

where S is the variance of x. The joint probability density of x and y is then given by 

**==> picture [365 x 30] intentionally omitted <==**

On the other hand, the probability density of y is given by 

**==> picture [323 x 32] intentionally omitted <==**

which implies that the variance of the outcome y is enhanced by factor 1 + N/S compared with the original variance S of the signal x. We can also calculate the conditional probability density as 

**==> picture [412 x 37] intentionally omitted <==**

which implies that the variance of the conditional distribution of x is suppressed compared with the original variance S by a factor of 1 + S/N. 

We can straightforwardly calculate the mutual information as 

**==> picture [287 x 30] intentionally omitted <==**

which is determined by the signal-to-noise ratio S/N alone. In the limit of S/N → 0, where the noise dominates the signal, the mutual information vanishes. On the other hand, in the limit of S/N →∞ where the noise is negligible compared with the signal, the mutual information diverges, as the variable is continuous. 

## 4 Second Law of Thermodynamics with Feedback Control 

In this section, we discuss a universal upper bound of the work that can be extracted from information heat engines such as the Szilard engine. Starting from a general 

10 

argument for isothermal processes in Sec. 4.1, we discuss two models with which the universal bound is achieved in Sec. 4.2 and 4.3. Moreover, we will discuss an experimental result that demonstrates an information heat engine in Sec. 4.4. We will also discuss the Carnot efficiency with two heat baths in Sec. 4.5. 

## 4.1 General Bound 

In the conventional thermodynamics, we extract a work from a heat engine by changing external parameters such as the volume of a gas or the frequency of an optical tweezer. In addition to such parameter changes, we perform measurements and feedback control for the case of information heat engines. 

Suppose that we have a thermodynamic engine that is in contact with a single heat bath at temperature T . We perform a measurement on a thermodynamic engine, and obtain I of mutual information. After that, we extract a positive amount of work by changing external parameters. The crucial point here is that the protocol of changing the external parameters can depend on the measurement outcome via feedback control. 

In the case of the Szilard engine, we obtain ln 2 nat of information, and extract kBT ln 2 of work. How much work can we extract in principle under the condition that we have I of mutual information about the system? The answer of this fundamental question is given by the following inequality [22,26]: 

**==> picture [273 x 13] intentionally omitted <==**

where Wext is the average of the work that is extracted from the engine, and ∆F is the free-energy difference of the engine between the initial and final states. Inequality (25) has been proved for both quantum and classical regimes [22,26]. However, the mutual information in (25) needs to be replaced by a quantum extension of the mutual information [22,48,49] for quantum cases. We will prove inequality (25) for classical cases by invoking the detailed fluctuation theorem in Sec. 5. 

Inequality (25) states that we can extract an excess work up to kBTI if we utilize I of mutual information obtained by the measurement. In the conventional thermodynamics, the upper bound of the extractable work is bounded only by the free-energy difference ∆F , which is determined by the initial and final values of external parameters. For information heat engines, the mutual information is also needed to determine the upper bound of the extractable work. In this sense, inequality (25) is a generalization of the second law of thermodynamics for feedback-controlled processes, in which thermodynamic variables (W and ∆F ) and the information content (I) are treated on an equal footing. 

The equality in (25) is achieved with the “best” protocol, which means that the process is quasi-static and the post-feedback state is independent of the measurement outcome, i.e., we utilize all the obtained information. This condition is achieved by the Szilard engine, as discussed above. Some models that achieves the equality in (25) have been proposed [23,34,35,44]. Two of them [35,44] are discussed in Secs. 4.2 

11 

and 4.3. The Szilard engine, which gives W = kBT ln 2, ∆F = 0, and I = ln 2, achieves the upper bound of the extractable work, and its special role in information heat engines parallels that of the Carnot cycle in conventional thermodynamics. 

## 4.2 Generalized Szilard Engine 

We discuss a generalization of the Szilard engine with measurement errors and imperfect feedback [44], with which the equality in (25) is achieved. The control protocol is described as follows (see Fig. 5): 

**==> picture [199 x 148] intentionally omitted <==**

**----- Start of picture text -----**<br>
Step 1: Thermal equilibrium. Step 2: Insertion of the barrier.<br>p 1 -  p<br>Step 5:        Removal of the barrier. Step 3:        Measurement.<br>v 0 1 - v 0<br>y= 0<br>y= 1<br>1 - v 1 v 1 Step 4: Shift of the barrier.<br>**----- End of picture text -----**<br>


Figure 5: Generalized Szilard engine. See the text for details. 

Step 1: Initial state. A single-particle gas is in thermal equilibrium, which is in contact with a single heat bath at temperature T . 

Step 2: Insertion of the barrier. We insert a barrier to the box and divide it into two with the volume ratio being p : 1 − p. 

Step 3: Measurement. We perform a measurement to find out which box the particle is in. The possible outcomes are “left” and “right,” which we respectively denote as “0” and “1.” The measurement can then be modeled by the binary channel with error rates ε0 and ε1 (see Sec. 3), where x (= 0, 1) specifies the location of the particle and y (= 0, 1) shows the measurement outcome. 

Step 4: Feedback. We quasi-statically move the barrier depending on the measurement outcome. If the outcome is “left” (y = 0), we move the barrier, so that the final ratio of the volumes of the two boxes is given by v0 : 1 − v0 (0 ≤ v0 ≤ 1). If the outcome is “right” (y = 1), we move the the barrier, so that the final ratio of the volumes of the two boxes is given by 1 − v1 : v1 (0 ≤ v1 ≤ 1). We note that the feedback protocol is specified by (v0, v1). 

12 

Step 5: Removal of the barrier. We remove the barrier, and the system returns to the initial thermal equilibrium by a free expansion. 

We now calculate the amount of the work that is extracted in step 4. By using the equation of states pV = kBT , we find that the extracted work is kBT ln[v0/p] for (x, y) = (0, 0), kBT ln[(1 − v1)/p] for (0, 1), kBT ln[(1 − v0)/(1 − p)] for (1, 0), and kBT ln[v1/(1 − p)] for (1, 1). Therefore the average work is given by 

**==> picture [426 x 27] intentionally omitted <==**

The mutual information obtained by the measurement is given by Eq. (18). The upper bound of inequality (25) is not necessarily achieved with a general feedback protocol (v0, v1). We then maximize Wext in terms of v0 and v1. The optimal feedback protocol with the maximum work is determined by equations ∂Wext/∂v0 = 0 and ∂Wext/∂v1 = 0, which lead to v0 = p(1 − ε0)/q = P [x = 0|y = 0] and v1 = (1 − p)(1 − ε1)/(1 − q) = P [x = 1|y = 1]. Therefore, we obtain the maximum work as 

**==> picture [252 x 13] intentionally omitted <==**

which achieves the upper bound of the generalized second law (25). 

## 4.3 Overdamped Langevin System 

We next discuss a feedback protocol for an overdamped Langevin system, which also achieves the upper bound of inequality (25) as shown in Ref. [35]. We consider a Brownian particle with a harmonic potential, which obeys the following overdamped Langevin equation: 

**==> picture [285 x 26] intentionally omitted <==**

where η is a friction constant and ξ(t) is a Gaussian white noise satisfying ⟨ξ(t)ξ(t[′] )⟩ = 2ηkBTδ(t − t[′] ) with δ(·) being the delta function. The harmonic potential can be controlled through two external parameters (λ1, λ2) such that 

**==> picture [286 x 25] intentionally omitted <==**

where λ1 and λ2 respectively describe the spring constant and the center of the potential. We consider the following feedback protocol (see Fig. 6). 

Step 1: Initial state. The particle is initially in thermal equilibrium with initial external parameters λ1(0) =: k and λ2(0) = 0. 

Step 2: Measurement. We measure the position of the particle and obtain outcome y. The measurement error is assumed to be Gaussian that is given by Eq. (19), where S is the variance of x in the initial equilibrium state (i.e., S = kBT/k), and N is 

13 

**==> picture [250 x 208] intentionally omitted <==**

**----- Start of picture text -----**<br>
Step 1: Thermal equilibrium.<br>Step 2:<br>Measurement.<br>0 0 μ’<br>Step 3:        Switching.<br>Step 4:<br>Expansion.<br>μ’ μ’<br>**----- End of picture text -----**<br>


Figure 6: Feedback control on a Langevin system with a harmonic potential. See the text for details. 

the variance of the noise in the measurement [see Eq. (19)]. Immediately after the measurement, the conditional probability is given by Eq. (23). The obtained mutual information I is given by Eq. (24). 

Step 3: Feedback. Immediately after the measurement, we instantaneously change λ1 from k to k[′] := (1 + S/N)k and λ2 from 0 to µy := Sy/(S + N). By this change, the conditional distribution (23) becomes thermally equilibrated with new parameters (λ1, λ2) = (k[′] , µy). 

Step 4: Work extraction. We quasi-statically expand the potential by changing λ1 from k[′] to k thereby extracting the work. The system then get thermally equilibrated with parameters (λ1, λ2) = (k, µy). 

We now calculate the work that can be extracted from this engine. Let P [x, t|y] be the probability distribution of x at time t under the condition of y. The average of the work for step 3 is given by 

**==> picture [365 x 27] intentionally omitted <==**

where P [x, 0|y] is given by P [x|y] in Eq. (23), and P [y] is given by Eq. (22). The 

14 

work for Step 4 is given by 

**==> picture [388 x 95] intentionally omitted <==**

where we used the fact that the expansion is quasi-static. Comparing Eqs. (30) and (31) with mutual information (24), we obtain 

**==> picture [292 x 16] intentionally omitted <==**

which achieves the upper bound of inequality (25). 

## 4.4 Experimental Demonstration: Feedback-Controlled Ratchet 

We next discuss a recent experiment that realized an information heat engine by using a real-time feedback control on a colloidal particle in water at room temperature [30]. 

In the experiment, a colloidal particle with diameter 300 nm is attached to the cover glass, and another particle is attached to the first one [Fig. 7 (a)]. The second particle then moves around the first as a rotating Brownian particle which we observe and control. An AC electric field is applied with four electrodes, and the particle undergoes an effective potential as illustrated in Fig. 7 (b). We note that the potential can take two configurations depending on the phases of the electric field. Each configuration consists of a spatially-periodic potential and a constant slope. The slope is created by a constant torque around the circle along which the particle rotates. This potential is like spiral stairs. The depth of the periodic potential is about 3kBT , and the gradient of the slope per angle 2π is about kBT . 

If the periodic potential without the slope was asymmetric and the two potential configurations were periodically switched, the particle would be transported in one direction as a flashing ratchet [50–54]. In the present setup, however, the periodic potential without the slope is symmetric and is not switched periodically but switched in a manner that depends on the measured position of the particle via feedback control [17, 20, 25, 52]. Such a feedback-controlled ratchet has been experimentally realized [20]. In the present experiment, the work and the free energy were measured precisely for quantitatively comparing the experimental results with the theoretical bound (25). It has been pointed out [52,55] that the feedback-controlled ratchet, as well as the flashing ratchet, can be a model of biological molecular motors [56]. 

The feedback protocol in the experiment [30] was done as follows [see Fig. 7 (c)]. The position of the particle was probed every 40 ms by a microscope, a camera, and an image analyzer. Only if the particle was found in the switching region described by “S” in Fig. 7 (c), the potential configuration was switched after a short delay time 

15 

ε. By this switching, when the particle reached the hilltop, the potential is inverted, so that the peak of the potential changed into the bottom of the valley, and therefore the particle is transported to the right direction. Without the switching, the particle would be more likely to go back to the left valley. This position-dependent switching via feedback control induces the reduction of the entropy in a manner analogous to the feedback control in the Szilard engine. By performing this protocol many times, the particle is expected to be transported to the right direction by climbing up the potential slope. 

**==> picture [283 x 161] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) avidin linker (c) S S S S<br>dimeric particle<br>15-20 µm elliptically-rotating  measurement<br>electric fields<br>chromium<br>(b) 30 m electrodes ε : small<br> 3 feedback<br> 2 ε : large<br> 1 switch<br> 0<br>-1<br>-2<br>-90  0  90  180  270  360  450 ε : small<br>Angular Position (deg) ε : large<br>T)Potential Energy (kB<br>**----- End of picture text -----**<br>


Figure 7: Experimental setup of the feedback-controlled ratchet (reproduced from Ref. [30] with permission). (a) A rotating Brownian particle. (b) Two possible configurations of the potential that can be switched into each other. (c) Feedback protocol. Only if the particle is found in region “S,” the potential is switched. Figure 8 (a) shows typical trajectories of the particle. If the feedback delay ε is sufficiently shorter than the relaxation time of the particle in each well (≃ 10 ms), the particle climbs up the potential. If the feedback delay is longer than the relaxation time, the feedback does not work and the particle moves down the potential in agreement with the conventional second law of thermodynamics. Figure 8 (c) shows the averaged velocity of the particle versus ε, which implies that the shorter the feedback delay is, the faster the average velocity is. 

Figure 8 (c) shows the energy balance of this engine. The shaded region is prohibited by the conventional second law of thermodynamics ⟨∆F − W ⟩≤ 0, where ∆F is the free-energy difference corresponding to the height of the potential, W is the work performed on the particle during the switching, and ⟨· · ·⟩ represents the ensemble average over all trajectories. By using information via feedback, however, the shaded region is indeed achieved if ε is sufficiently small. The resource of the excess free-energy gain is thermal fluctuations of the heat bath, which are rectified by feedback control. This is an experimental realization of an information heat engine. 

For the case of ε = 1.1 ms, ⟨∆F − W ⟩ = 0.062kBT . On the other hand, the obtained information is given by I = 0.22, which can be calculated from the histogram 

16 

**==> picture [227 x 156] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) (b)<br> 20  0.1<br> 12<br> 15 ε = 1.1 ms  0<br> 10  11<br>-0.1<br> 5 8.8 ms  36  40  44  0  10  20  30  40<br> 0 (c)<br>-5  0.1<br>-10 35.2 ms<br> 0<br>-15<br>-20 -0.1<br>-25<br> 0  20  40  60  80  100  0  10  20  30  40<br>Time (s)<br>Revolutions<br>**----- End of picture text -----**<br>


Figure 8: Experimental results on the feedback-controlled ratchet (reproduced from Ref. [30] with permission). (a) Typical trajectories of the particle with feedback delays ε = 1.1 ms, 8.8 ms, and 35.2 ms. (b) The averaged velocity of the particle versus the feedback delay. (c) Energy balance of feedback control. The shaded region is prohibited by the conventional second law of thermodynamics, and can only be achieved by feedback control. 

of the measurement outcomes by assuming that the measurement is error-free. By comparing this experimental data with the theoretical bound (25), the efficiency of this information heat engine is determined to be ⟨∆F − W ⟩/kBTI = 0.062/0.22 ≃ 0.28. The reason why the efficiency is less than unity is twofold: (1) the switching is not quasi-static but instantaneous, and (2) the obtained information is not utilized if the particle is found outside of the switching region. 

We note that various experiments that are analogous to Maxwell’s demon have been performed with, for example, a granular gas [57,58], supramolecules [59], and ultracold atoms [60]; however, these examples do not explicitly involve the measurement and feedback, as the controlled system and the demon constitute an autonomous system in those experiments. Such autonomous versions of Maxwell’s demon have also been theoretically studied [61–66]. In contrast, in the experiment of Ref. [30], the demon (the camera and the computer) is separated from the controlled system (the colloidal particle) as in the case for the Szilard engine. We also note that an information heat engine similar to that in Ref. [30] has been proposed for an electron pump system in Ref. [39]. 

## 4.5 The Carnot Efficiency with Two Heat Baths 

We next consider the case in which there are two heat baths and the process is a thermodynamic cycle. Without feedback control, the heat efficiency is bounded by the Carnot bound. If we perform measurements and feedback control on this system, 

17 

the extractable work is bounded from above by [22] 

**==> picture [297 x 29] intentionally omitted <==**

where TH and TL are the temperatures of the hot and cold heat baths, respectively, and QH is the heat that is absorbed by the engine from the hot heat bath. The proof of inequality (33) will be given in Sec. 5. The last term on the right-hand side (rhs) of (33) describes the effect of feedback. We note that the coefficient of the last term is given by the temperature of the cold bath. 

The equality in (33) is achieved in the following example. We consider a singleparticle gas in a box, and quasi-statically control it as in the case of the usual Carnot cycle. We then perform the Szilard-engine-type operation consisting of measurement and feedback on the system while it is in contact with the cold bath. In this case, we have kBTL ln 2 of excess work, and QH remains unchanged. Therefore, the equality in (33) is achieved with I = ln 2. 

We can also achieve the equality in (33) if we perform the Szilard-engine-type operation while the engine is in contact with the hot heat bath. In this case, we can extract kBTHI of excess work, and QH is increased by kBTHI. Therefore, we again obtain the equality in (33) with I = ln 2. 

## 5 Nonequilibrium Equalities with Feedback Control 

Since the late 1990’s, a number of universal equalities have been found for nonequilibrium processes [67–75], and they have been shown to reproduce the second law of thermodynamics and the fluctuation-dissipation theorem. The fluctuation theorem and the Jarzynski equality are two prime examples of the nonequilibrium equalities. In this section, we generalize the nonequilibrium equalities to situations in which a thermodynamic system is subject to measurements and feedback control in line with Refs. [26,29,44]. As corollaries, we derive inequalities (25) and (33). 

## 5.1 Preliminaries 

First of all, we review the nonequilibrium equalities without feedback control. We consider a stochastic thermodynamic system in contact with heat bath(s) with inverse temperatures βm (m = 1, 2, · · · ). Let x be the phase-space point of the system. The system is controlled through external parameters λ, which describe, for instance, the volume of a gas or the frequency of an optical tweezer. Even when the initial state of the system is in thermal equilibrium, the system can be driven far from equilibrium by changing the external parameters. We consider such a stochastic dynamics of the system from time 0 to τ . The state of the system stochastically evolves as x(t) under a deterministic protocol of the external parameters denoted collectively as λ(t). 

18 

Let Xτ := {x(t)}0≤t≤τ be the trajectory of the phase-space point and Λτ := {λ(t)}0≤t≤τ be that of the external parameters. The heat that is absorbed by the system from heat bath “m” is a trajectory-dependent quantity, which we write as Qm[Xτ |Λτ ]. The work that is performed on the system is also trajectory-dependent and is denoted as W [Xτ |Λτ ]. The first law of thermodynamics is then given by 

**==> picture [368 x 26] intentionally omitted <==**

where H[x|λ] is the Hamiltonian with external parameters λ, and the work can be written as 

**==> picture [316 x 29] intentionally omitted <==**

Let P [Xτ |Λτ ] be the probability density of trajectory Xτ with control protocol Λτ . It can be decomposed as P [Xτ |Λτ ] = P [Xτ |x(0), Λτ ]Pf[x(0)], where P [Xτ |x(0), Λτ ] is the probability density under the condition that the initial state is x(0), and Pf[x(0)] is the initial distribution of the forward process. 

We next introduce backward processes of the system. Let x[∗] be the time-reversal of x. For example, if x = (r, p) with r being the position and p being the momentum, then x[∗] = (r, −p). Similarly, we denote the time-reversal of λ as λ[∗] . For example, if λ is the magnetic field, then λ[∗] = −λ. Let Xτ[†][be][the][time-reversed][trajectory][of][X][τ] defined as Xτ[†][:=][ {][x][∗][(][τ][ −][t][)][}][0][≤][t][≤][τ][.][We also write the time-reversal][of control protocol] Λτ as Λ[†] τ[:=][{][λ][∗][(][τ][−][t][)][}][0][≤][t][≤][τ][,][and][write][as][P][[][X] τ[†][|][Λ][†] τ[]][the][probability][density][of][the] time-reversed trajectory with the time-reversed control protocol. We can decompose P [Xτ[†][|][Λ][†] τ[]][as][ P][[][X] τ[†][|][Λ][†] τ[] =][ P][[][X] τ[†][|][x][†][(0)][,][ Λ][τ][]][P][b][[][x][†][(0)],][where][P][[][X] τ[†][|][x][†][(0)][,][ Λ][†] τ[]][is the prob-] ability density under the condition that the initial state of the backward process is x[†] (0), and Pb[x[†] (0)] the initial distribution of the backward process. We stress that the initial distribution of the backward process Pb[x[†] (0)] can be set independently of the final distribution of the forward process. In experiments, we can initialize the system before we start a backward process so that its initial distribution can be chosen independently of the forward process. 

The detailed fluctuation theorem (the transient fluctuation theorem) is given by [68–71] 

**==> picture [305 x 30] intentionally omitted <==**

Defining the entropy production as 

**==> picture [357 x 26] intentionally omitted <==**

we obtain 

**==> picture [274 x 30] intentionally omitted <==**

19 

By taking the ensemble average of Eq. (38), we have 

**==> picture [416 x 43] intentionally omitted <==**

where we used dXτ = dXτ[†][.][Therefore,][we][obtain][the][integral][fluctuation][theorem] 

**==> picture [243 x 13] intentionally omitted <==**

By using the concavity of the exponential function, we find from Eq. (40) that 

**==> picture [238 x 13] intentionally omitted <==**

which is an expression of the second law of thermodynamics. In the following, we discuss the physical meanings of entropy production σ for typical situations. The equality in (41) is achieved if P [Xτ[†][|][Λ][†] τ[]][=][P][[][X][τ][|][Λ][τ][]][holds][for][any][X][τ][,][which][implies] the reversibility of the process. 

We first consider isothermal processes. In this case, we choose the initial distributions of the forward and backward processes as 

**==> picture [338 x 33] intentionally omitted <==**

where F [λ] := −kBT ln � dxe[−][βH][[][x][|][λ][]] is the free energy of the system. We assume that the Hamiltonian has the time-reversal symmetry 

**==> picture [265 x 13] intentionally omitted <==**

and therefore the canonical distribution 

**==> picture [332 x 15] intentionally omitted <==**

The entropy production then reduces to 

**==> picture [283 x 13] intentionally omitted <==**

where ∆F := F [λ(τ )] − F [λ(0)]. Thus, the integral fluctuation theorem (40) leads to the Jarzynski equality [67] 

**==> picture [260 x 15] intentionally omitted <==**

and inequality (41) gives the second law of thermodynamics 

**==> picture [246 x 13] intentionally omitted <==**

where Wext := −⟨W ⟩ is the work that is extracted from the system. 

We next consider a case with multi-heat baths, and assume that the initial distributions of the forward and the backward processes are given by the canonical distributions as in (42) with a reference inverse temperature β. In practice, β can be 

20 

taken as one of βm’s, which can be realized if the system is initially attached only to that particular heat bath. We then have 

**==> picture [330 x 27] intentionally omitted <==**

where ∆E[Xτ ] := H[x(τ )|λ(τ )] − H[x(0)|λ(0)] is the difference of the internal energy of the system. Inequality (41) leads to 

**==> picture [295 x 26] intentionally omitted <==**

In particular, if the process is a cycle such that ∆F = 0 and ⟨∆E⟩ = 0 hold, inequality (49) reduces to 

**==> picture [259 x 27] intentionally omitted <==**

which is the Clausius inequality. If there are two heat baths with temperatures TH and TL, (50) gives the Carnot bound 

**==> picture [283 x 30] intentionally omitted <==**

where ⟨QH⟩ is the average of the heat that is absorbed by the engine from the hot heat bath. 

## 5.2 Measurement and Feedback 

We now formulate measurements and feedback on the thermodynamic system [26, 29, 44]. We perform measurements at time tk (k = 1, 2, · · · , M) with 0 ≤ t1 < t2 < · · · < tM < τ . Let y(tk) be the measurement outcome at time tk. For simplicity, we assume that the measurement is instantaneous; the measurement error of y(tk) can be characterized only by the conditional probability Pc[y(tk)|x(tk)], which implies that only y(tk) has the information about x(tk). (Note, however, that this assumption can be relaxed [44].) We write the sequence of the measurement outcomes as Yτ := (y(t1), y(t2), · · · , y(tM )), and write 

**==> picture [297 x 27] intentionally omitted <==**

We then introduce the following quantity: 

**==> picture [286 x 29] intentionally omitted <==**

which can be interpreted as a stochastic version of the mutual information. The ensemble average of Eq. (53) gives the mutual information obtained by the measurements as 

**==> picture [319 x 29] intentionally omitted <==**

**==> picture [13 x 9] intentionally omitted <==**

We note that ⟨Ic⟩ describes the correlation between Xτ and Yτ that is induced only by measurements, and not by feedback control. The suffix “c” represents this property of Ic. We then identify ⟨Ic⟩ with I in the foregoing arguments. See Ref. [44] for details. We note that ⟨Ic⟩ has been discussed and referred to as the transfer entropy in Ref. [76]. The following equality also holds by definition: 

**==> picture [244 x 14] intentionally omitted <==**

We next consider feedback control by using the obtained outcomes. The control protocol after time tk can depend on the outcome y(tk) in the presence of feedback control. We write this dependence as Λτ (Yτ ). We can show that the joint probability of (Xτ , Yτ ) is given by 

**==> picture [306 x 13] intentionally omitted <==**

which satisfies the normalization condition � dXτ dYτ P [Xτ , Yτ ] = 1. Equality (56) is proved in Appendix A (see also Ref. [44]). The probability of obtaining outcome Yτ in the forward process is given by the marginal distribution as P [Yτ ] = � dXτ P [Xτ , Yτ ], and the conditional probability is given by P [Xτ |Yτ ] = P [Xτ , Yτ ]/P [Yτ ]. In the presence of measurement and feedback, the ensemble average is taken over all trajectories and all outcomes; for an arbitrary stochastic quantity A[Xτ , Yτ ], its ensemble average is given by 

**==> picture [310 x 28] intentionally omitted <==**

The detailed fluctuation theorem for a given Yτ can be written as 

**==> picture [294 x 30] intentionally omitted <==**

We note that Eq. (58) is valid in the presence of feedback control, because the detailed fluctuation theorem is satisfied once a control protocol is fixed. Equality (58) provides the basis for the derivations of the formulas in the following section. 

## 5.3 Nonequilibrium Equalities with Mutual Information 

In this subsection, we generalize the nonequilibrium equalities by incorporating the mutual information. First of all, from Eq. (53), we have 

**==> picture [261 x 30] intentionally omitted <==**

By multiplying the both-hand sides of this equality by those of Eq. (58), we obtain 

**==> picture [329 x 31] intentionally omitted <==**

22 

To measure P [Xτ[†][|][Λ][τ][(][Y][τ][)][†][]][P][[][Y][τ][],][we][follow][the][backward][process][corresponding][to] each forward outcome and count the occurrences of the time-reversed trajectories. By taking the ensemble average of the both-hand sides of Eq. (60) with formula (57), we obtain a generalized integral fluctuation theorem with feedback control: 

**==> picture [250 x 14] intentionally omitted <==**

Using the concavity of the exponential function, Eq. (61) leads to 

**==> picture [249 x 13] intentionally omitted <==**

Inequality (62) is a generalized second law of thermodynamics, which states that the entropy production can be decreased by feedback control, and that the lower bound of the entropy production is given by the mutual information ⟨Ic⟩. As shown below, inequalities (25) and (33) in Sec. 4 are special cases of inequality (62). The equality in (62) is achieved if P [Xτ[†][|][Λ][τ][(][Y][τ][)][†][]][P][[][Y][τ][] =][ P][[][X][τ][, Y][τ][]][holds for any][ X][τ][and][Y][τ][,][which] implies the reversibility with feedback control as discussed in Ref. [34]. 

The generalized integral fluctuation theorem of the form (61) was first shown in Ref. [26] for a single measurement, and Eq. (60) was obtained in Ref. [29, 44] for multiple measurements. These results has also been generalized to the optimal control process with continuous measurement and the Kalman filter in Ref. [28]. 

A generalized fluctuation theorem was also obtained in Ref. [19], which is similar to Eq. (61). In Ref. [19], feedback control is performed based on information about the continuously-monitored velocity of a Langevin system. The result of Ref. [19] includes an quantity that describes the decrease in the entropy by continuous feedback control, instead of the mutual information obtained by the continuous measurement. 

We consider isothermal processes with a single heat bath, in which the entropy production is given by Eq. (45). Equality (61) then reduces to a generalized Jarzynski equality 

**==> picture [265 x 15] intentionally omitted <==**

and inequality (62) reduces to 

**==> picture [274 x 13] intentionally omitted <==**

which implies inequality (25) with identifications Wext = −⟨W ⟩, ∆F = ⟨∆F ⟩, and I = ⟨Ic⟩. 

We next consider the cases in which there are two heat baths and the process is a cycle, in which the entropy production is given by the ensemble average of Eq. (48) with ⟨∆E⟩ = ⟨∆F ⟩ = 0. The generalized second law (62) then leads to 

**==> picture [281 x 13] intentionally omitted <==**

which can be rewritten as 

**==> picture [312 x 30] intentionally omitted <==**

By identifying QH = ⟨QH⟩, inequality (66) implies inequality (33). 

23 

## 5.4 Nonequilibrium Equalities with Efficacy Parameter 

In this subsection, we discuss another generalization of nonequilibrium equalities. We define the time-reversal of outcomes Yτ as Yτ[†][:= (][y][(][τ][ −][t][M][)][∗][,][ · · ·][, y][(][τ][ −][t][2][)][∗][, y][(][τ][ −][t][1][)][∗][),] where y[∗] is the time-reversal of y, and introduce the probability that we obtain outcome Yτ[†][with][control][protocol][Λ][τ][(][Y][τ][)][†][,][which][is][given][by] 

**==> picture [341 x 28] intentionally omitted <==**

We stress that no feedback control is performed in the backward processes. We then assume that the measurement error has the time-reversal symmetry 

**==> picture [276 x 15] intentionally omitted <==**

This assumption is satisfied if Pc[y(tk)|x(tk)] = Pc[y(τ − tk)[∗] |x(τ − tk)[∗] ] holds for k = 1, 2, · · · , M. By using Eq. (67) and assumption (68), we can show that 

**==> picture [281 x 30] intentionally omitted <==**

where ⟨· · ·⟩Yτ denotes the conditional average with condition Yτ such that 

**==> picture [319 x 28] intentionally omitted <==**

Equality (69) has been shown for Hamiltonian systems [72] and stochastic systems [26, 44]. By noting that 

**==> picture [289 x 28] intentionally omitted <==**

we obtain yet another generalization of the integral fluctuation theorem [26,44] 

**==> picture [243 x 13] intentionally omitted <==**

where 

**==> picture [280 x 27] intentionally omitted <==**

is the sum of the probabilities that we obtain the time-reversed outcomes with a time-reversed protocol. For the cases of isothermal processes, Eq. (72) reduces to 

**==> picture [258 x 15] intentionally omitted <==**

We note that γ characterizes the efficacy of feedback control. The more efficient the feedback protocol is, the larger the amount of γ is. Without feedback control, P [Yτ[†][|][Λ][†] τ[]][reduces][to][a][single][unconditional][probability][distribution,][and][we][therefore] obtain 

**==> picture [280 x 27] intentionally omitted <==**

24 

**==> picture [199 x 149] intentionally omitted <==**

**----- Start of picture text -----**<br>
Step 4: Removal of the barrier.<br>Step 1: Thermal equilibrium.<br>Step 2:   Compression. Step 3:    Measurement.<br>y= 0<br>y= 1<br>**----- End of picture text -----**<br>


Figure 9: Backward processes of the Szilard engine. See the text for details. 

which reproduces the integral fluctuation theorem (40) without feedback. We note that the maximum value of γ is the number of the possible outcomes of Yτ . 

We illustrate the efficacy parameter γ for the case of the Szilard engine that is described in Sec. 2. The backward control protocol of the Szilard engine is as follows (see also Fig. 9) [26]. 

Step 1: Initial state. The single-particle gas is initially in thermal equilibrium. 

Step 2: Compression of the box. In accordance with the measurement outcome in the forward process, which is “0” (= “left”) or “1” (= “right”), we quasi-statically compress the box by moving the wall in the box to the center. By this compression, the volume of the box becomes half. 

Step 3: Measurement. We measure the position of the particle to find which box the particle is in. The outcome of this backward measurement is “0” (= “left”) or “1” (= “right”) with unit probability corresponding to forward outcome “0” or “1,” respectively. 

Step 4: We remove the barrier at the center of the box, and the engine returns to the initial state by a free expansion. 

In these backward processes, the measurement outcomes in step 2 satisfy P [0|Λτ(0)[†] ] = 1 and P [1|Λτ (1)[†] ] = 1, and therefore we obtain γ = P [0|Λτ(0)[†] ] + P [1|Λτ (1)[†] ] = 2, which gives the maximum value of γ for situations in which the number of possible outcomes is two. On the other hand, since W = −kBT ln 2 and ∆F = 0 in the absence of fluctuations, the generalized Jarzynski equality (74) is satisfied as ⟨e[β][(∆][F][ −][W][ )] ⟩ = 2 = γ. 

The generalized Jarzynski equality (74) has been experimentally verified in the experiment described in Sec. 4.4 by measuring ∆F − W and γ separately in the 

25 

forward and backward experiments, respectively [30]. Equalities (63) and (74) have been obtained in Hamiltonian systems [37]. Equality (74) has also been generalized to quantum systems [32,42]. 

While Eq. (61) only includes the obtained mutual information and does not describe how we utilize the information via feedback, Eq. (72) includes the term of feedback efficacy that depends on the feedback protocol. To quantitatively discuss the relationship between mutual information Ic and efficacy parameter γ, we define C[A] := − ln⟨e[−][A] ⟩. By noting Eq. (55), we obtain 

**==> picture [303 x 13] intentionally omitted <==**

If the joint distribution of σ and Ic is Gaussian, Eq. (76) reduces to 

**==> picture [279 x 13] intentionally omitted <==**

Equalities (76) and (77) imply that, the more efficiently we use the obtained information to decrease the entropy production by feedback control, the larger γ is. In fact, if γ is large, the left-hand sides of Eqs. (76) and (77) are both small, which means that the obtained information Ic has a large negative correlation with σ. Without feedback control, γ = 1 holds and therefore Ic is not correlated with σ. In this sense, γ characterizes the efficacy of feedback control. 

## 6 Thermodynamic Energy Cost for Measurement and Information Erasure 

So far, we have discussed the energy balance of information heat engines controlled by the demon. In this section, we discuss the energy cost that is needed for the demon itself, which has been a subject of active discussion [2–4,77–92]. 

Suppose that the demon has a memory that can store the outcome obtained by a measurement. If the outcome is binary, the memory can be modeled by a system with a binary potential (see Fig. 10). Before the measurement, the memory is in the initial standard state 0. The memory then interacts with a measured system such as the Szilard engine, and stores the measurement outcome. Figure 10 illustrates a case with a binary outcome. Let pk be the probability of obtaining outcome k. After the measurement, the memory is detached from the measured system and returns to the initial standard state, which is the erasure of the obtained information. The central question in this section is how much work is needed for the demon during the measurement and the information erasure. 

Let Fk[M] be the free energy of the memory under the condition that the outcome is “k.” During the measurement process, the free energy of the memory is changed on average by ∆F[M] :=[�] k[p][k][F] k[ M][−][F] 0[ M][,][where][F] 0[ M] is the free energy of the initial standard state. If Fk[M][’s][are][the][same][for][all][k][’s][including][k][=][0][(i.e.,][the][memory’s] potential is symmetric), ∆F[M] = 0 holds for every {pk}. It has been shown [92] that 

26 

**==> picture [251 x 142] intentionally omitted <==**

**----- Start of picture text -----**<br>
Measured system<br>Interaction<br>0 1<br>Erasure Measurement<br>or<br>0 1 0 1<br>**----- End of picture text -----**<br>


Figure 10: A schematic of the measurement and erasure of information for the case of an asymmetric binary memory. While the memory is in the standard state with unit probability before the measurement, the memory stores the measurement outcome in accordance with the state of the measured system. The measurement and erasure processes are time-reversal with each other except for the fact that the memory establishes a correlation with the measured system during the measurement process. 

the averaged work Wmeas[M][that][is][performed][on][the][memory][during][the][measurement] is bounded as 

**==> picture [299 x 15] intentionally omitted <==**

where H := −[�] k[p][k][ ln][ p][k][is][the][Shannon][information][of][the][outcomes][and][I][is][the] mutual information obtained by the measurement. For the special case with ∆F[M] = 0 and H = I, the rhs of inequality (78) reduces to zero. 

On the other hand, during the information erasure, the change of the free energy of the memory is given by −∆F[M] . The averaged work Weras[M][that][is][needed][for][the] erasure process is bounded as [92] 

**==> picture [281 x 14] intentionally omitted <==**

If ∆F[M] vanishes, inequality (79) reduces to 

**==> picture [255 x 15] intentionally omitted <==**

which is known as the Landauer principle [78]. The additional term −∆F[M] on the rhs of (79) arises from the asymmetry of the memory. By summing up inequalities (78) and (79), we obtain the fundamental inequality 

**==> picture [276 x 14] intentionally omitted <==**

which implies that the work needed for the demon is only bounded by the mutual information if we take into account both the measurement and erasure processes. 

We stress that, while inequality (79) is a generalized Landauer principle for the information erasure, inequality (81) is completely different from the Landauer principle. In fact, while the lower bound of the Landauer principle is given by the Shannon 

27 

information that characterizes the randomness of the measurement outcomes, the lower bound of (81) is given by the mutual information that characterizes the correlation between the measured system and the measurement outcome. Moreover, both terms on the rhs of (79) is exactly canceled by the first and second terms on the rhs of (78). The reason for the cancellation lies in the fact that the dynamics of the memory during the erasure process is the time-reversal of the measurement process, except for the fact that the memory interacts with the measured system and establishes a correlation (or equivalently, gains information) only in the measurement process (see also Fig. 10). The additional cost for the establishment of the correlation is given by the last term on the rhs of (78), which also appears in the rhs of (81). Therefore, the mutual information term in inequality (81) is induced by the measurement process. 

Historically, there has been a lot of discussions [2–4] as to what compensates for the additional work of kBT ln 2 which can be extracted from the Szilard engine. Szilard considered that an entropic cost must be needed for the measurement process [45]. L. Brillouin [77] argued that we need the work greater than kBT ln 2 for the measurement process, based on a specific model of measurement. Later, by explicitly constructing a model of the memory does not require any work for the measurement, C. H. Bennett argued that, based on the Landauer principle (80), we always need the work of at least kBT ln 2 for the erasure process [79,85]. The key observation here is that the erasure process is logically irreversible while the measurement process can be logically reversible. In fact, if we assume that the Shannon information of the measurement outcome equals the thermodynamic entropy of the memory, the logically irreversible erasure should be accompanied by a reduction in the thermodynamic entropy of the memory, which implies that kBT ln 2 of heat should be transfered to the heat bath and, therefore, the same amount of the work is needed. 

However, the argument by Landauer and Bennett is valid only for symmetric memories with ∆F[M] = 0. As discussed in Refs. [88–92], the Shannon information does not equal the thermodynamic entropy of the memory in general. If the memory is asymmetric as illustrated in Fig. 10, the lower bound of the energy cost needed for the information erasure is not given by (80), and the Landauer principle needs to be generalized to inequality (79) for asymmetric memories. We note that the Landauer principle can also be violated for symmetric memories in the quantum regime due to the initial correlation between the memory and the heat bath [86, 87]. A more detailed historical review about the Landauer principle is given in Ref. [4]. 

As a consequence, the lower bound of the individual energy cost for measurement or erasure processes can be made arbitrarily small for asymmetric memories, while their sum (81) is bounded from below by kBTI that originates from the measurement process. The total work given in the left-hand-side of (81) then compensates for kBTI of additional work in (25) that is extracted from an information heat engine by the demon. This compensation confirms the consistency between the demon and the second law of thermodynamics; we cannot extract any positive amount of work by a cycle from the total system consisting of the engine and the memory of the demon. 

Nevertheless, feedback control is still useful for manipulating small thermodynamic systems. In fact, as discussed in Sec. 2, feedback control enables us to increase 

28 

the engine’s free energy without injecting energy to the engine directly. In other words, the work (81) needed for the demon is not necessarily transfered to the engine, which can be energetically separated from the demon. Therefore, by using information heat engines, we can control thermodynamic systems beyond the energy balance that is imposed by the conventional thermodynamics. 

## 7 Conclusions 

In this chapter, we have discussed a generalized thermodynamics that can be applied to feedback-controlled systems which we call information heat engines. The Szilard engine described in Sec. 2 is the simplest model of information heat engines. Based on the information theory reviewed in Sec. 3, we have formulated a generalized second law involving the term of the mutual information in Sec. 4. The generalized second law gives an upper bound of the work that can be extracted from a heat bath with the assistance of feedback control. We also discussed some typical examples of information heat engines including a recent experimental result [30]. In Sec. 5, we discussed nonequilibrium equalities with feedback control, and derived the generalized second law discussed in Sec. 4. We also discussed the energy cost that is needed for the measurement and the information erasure in Sec. 6. 

Inequalities (25), (78), (79), and (81) are the generalizations of the second law of thermodynamics, giving the fundamental bounds of the work needed for information processing. In fact, if we set the information contents to be zero (i.e., I = H = 0) in these inequalities, all of them reduce to the conventional second law of thermodynamics. In this sense, these inequalities constitute the second law of “information thermodynamics,” which is a generalized thermodynamics for information processing. 

While the studies of information and thermodynamics have a long history, recent developments of nonequilibrium physics and nanotechnologies have shed new light on classic problems from the modern point of view. Thermodynamics of information processing will open a fruitful research arena that enables us to quantitatively analyze the energy costs of the feedback control and information processing in small thermodynamic systems. Possible applications of this new research field include designing designing and controlling nanomachines [93] and nanodevices. 

## A Proof of Eq. (56) 

In this appendix, we prove Eq. (56). We introduce notations Xtk−1<t≤tk := {x(t)}tk−1<t≤tk , Xtk := {x(t)}0≤t≤tk , Λtk := {λ(t)}0≤t≤tk , and Ytk := (y(t1), · · · , y(tk)). The joint probability of (Xτ , Yτ ) is given by 

**==> picture [390 x 54] intentionally omitted <==**

**==> picture [13 x 10] intentionally omitted <==**

where we set t0 := 0. We note that Λtk depends only on Ytk−1 due to the causality. We also note that 

**==> picture [409 x 36] intentionally omitted <==**

(83) 

By combining Eqs. (52), (82), and (83), we obtain Eq. (56). We can confirm that the joint probability satisfies the normalization condition � dXτ dYτ P [Xτ , Yτ ] = 1 by integrating Eq. (82) in the order of XtM <t≤τ → y(tM ) → XtM −1<t≤tM → y(tM −1) → · · · → y(t1) → X0<t≤t1 → x(0) due to the causality. 

Acknowledgment. The authors are grateful to Shoichi Toyabe, Eiro Muneyuki, and Masaki Sano for providing us the experimental data discussed in Sec. 4.4. This work was supported by KAKENHI 22340114, a Grant-in-Aid for Scientific Research on Innovation Areas ”Topological Quantum Phenomena” (KAKENHI 22103005), a Global COE Program ”the Physical Sciences Frontier”, the Photon Frontier Network Program, and the Grant-in-Aid for Research Activity Start-up (KAKENHI 11025807), from MEXT of Japan. 

## References 

- [1] J. C. Maxwell, “Theory of Heat,” (Appleton, London, 1871). 

- [2] “Maxwell’s demon 2: Entropy, Classical and Quantum Information, Computing”, H. S. Leff and A. F. Rex (eds.), (Princeton University Press, New Jersey, 2003). 

- [3] K. Maruyama, F. Nori, and V. Vedral, Rev. Mod. Phys. 81, 1 (2009). 

- [4] O. J. E. Maroney, “Information Processing and Thermodynamic Entropy”, The Stanford Encyclopedia of Philosophy (Fall 2009 Edition), Edward N. Zalta (ed.). 

- [5] J. C. Doyle, B. A. Francis, and A. R. Tannenbaum, “Feedback Control Theory,” (Macmillan, New York, 1992). 

- [6] K. J.[˚] Astrom and R. M. Murray, “Feedback Systems: An Introduction for Scientists and Engineers,” ( Princeton University Press, 2008). 

- [7] S. Lloyd, Phys. Rev. A 39, 5378 (1989). 

- [8] C. M. Caves, Phys. Rev. Lett. 64, 2111 (1990). 

- [9] S. Lloyd, Phys. Rev. A 56, 3374 (1997). 

- [10] M. A. Nielsen, C. M. Caves, B. Schumacher, and H. Barnum, Proc. R. Soc. London A 454, 277 (1998). 

30 

- [11] H. Touchette and S. Lloyd, Phys. Rev. Lett. 84, 1156 (2000). 

- [12] W. H. Zurek, arXiv:quant-ph/0301076 (2003). 

- [13] T. D. Kieu, Phys. Rev. Lett. 93, 140403 (2004). 

- [14] A.E. Allahverdyan, R. Balian, Th.M. Nieuwenhuizen, J. Mod. Optics, 51, 2703 (2004). 

- [15] H. Touchette and S. Lloyd, Physica A 331, 140 (2004). 

- [16] H. T. Quan, Y. D. Wang, Y-x. Liu, C. P. Sun, and F. Nori, Phys. Rev. Lett. 97, 180402 (2006). 

- [17] F. J. Cao, L. Dinis, J. M. R. Parrondo, Phys. Rev. Lett. 93, 040603 (2004). 

- [18] K. H. Kim and H. Qian, Phys. Rev. Lett. 93, 120602 (2004). 

- [19] K. H. Kim and H. Qian, Phys. Rev. E 75, 022102 (2007). 

- [20] B. J. Lopez, N. J. Kuwada, E. M. Craig, B. R. Long, and H. Linke, Phys. Rev. Lett. 101, 220601 (2008). 

- [21] A. E. Allahverdyan and D. B. Saakian, Europhys Lett. 81, 30003 (2008). 

- [22] T. Sagawa and M. Ueda, Phys. Rev. Lett. 100, 080403 (2008). 

- [23] K. Jacobs, Phys. Rev. A 80, 012322 (2009). 

- [24] F. J. Cao and M. Feito, Phys. Rev. E 79, 041118 (2009). 

- [25] F.J. Cao, M. Feito, and H. Touchette, Physica A 388, 113 (2009). 

- [26] T. Sagawa and M. Ueda, Phys. Rev. Lett. 104, 090602 (2010). 

- [27] M. Ponmurugan, Phys. Rev. E 82, 031129 (2010). 

- [28] Y. Fujitani and H. Suzuki, J. Phys. Soc. Jpn. 79, 104003 (2010). 

- [29] J. M. Horowitz and S. Vaikuntanathan, Phys. Rev. E 82, 061120 (2010). 

- [30] S. Toyabe, T. Sagawa, M. Ueda, E. Muneyuki, and M. Sano, Nature Physics 6, 988 (2010). 

- [31] S. W. Kim, T. Sagawa, S. De Liberato, and M. Ueda, Phys. Rev. Lett. 106, 070401 (2011). 

- [32] Y. Morikuni and H. Tasaki, J. Stat. Phys. 143, 1 (2011). 

- [33] S. Ito and M. Sano, Phys. Rev. E 84, 021123 (2011). 

31 

- [34] J. M. Horowitz and J. M. R. Parrondo, Europhys Lett. 95, 10005 (2011). 

- [35] D. Abreu and U. Seifert, Europhys Lett. 94, 10001 (2011). 

- [36] S. Vaikuntanathan and C. Jarzynski, Phys. Rev. E 83, 061120 (2011). 

- [37] T. Sagawa, J. Phys.: Conf. Ser. 297, 012015 (2011). 

- [38] H. Dong, D. Z. Xu, C. Y. Cai, and C. P. Sun, Phys. Rev. E 83, 061108 (2011). 

- [39] D. V. Averin, M. M¨ott¨onen, and J. P. Pekola, Phys. Rev. B 84, 245448 (2011). 

- [40] J. M. Horowitz and J. M. R. Parrondo, New J. Phys. 13, 123019 (2011). 

- [41] L. Granger and H. Kantz, Phys. Rev. E 84, 061110 (2011). 

- [42] S. Lahiri, S. Rana, and A. M. Jayannavar, J. Phys. A: Math. Theor. 45, 065002 (2012). 

- [43] Y. Lu and G. L. Long, Phys. Rev. E 85, 011125 (2012). 

- [44] T. Sagawa and M. Ueda, Phys. Rev. E 85, 021104 (2012). 

- [45] L. Szilard, Z. Phys. 53, 840 (1929). 

- [46] T. M. Cover and J. A. Thomas, “Elements of Information Theory” (John Wiley and Sons, New York, 1991). 

- [47] C. Shannon, Bell System Technical Journal 27, 379-423 and 623-656 (1948). 

- [48] H. J. Groenewold, Int. J. Theor. Phys. 4, 327 (1971). 

- [49] M. Ozawa, J. Math. Phys. 27, 759 (1986). 

- [50] R. D. Vale and F. Oosawa, Adv. Biophys. 26, 97 (1990). 

- [51] F. Julicher, A. Ajdari, and J. Prost, Rev. Mod. Phys. 69, 1269 (1997). 

- [52] J. M. R. Parrondo and B. J. De Cisneros, Appl. Phys. A 75,179 (2002). 

- [53] P. Reimann. Phys. Rept. 361, 57 (2002). 

- [54] P. H¨anggi and F. Marchesoni, Rev. Mod. Phys. 81, 387 (2009). 

- [55] M. Bier, Biosystems 88, 201 (2007). 

- [56] M. Schliwa and G. Woehlke, Nature 422, 759 (2003). 

- [57] H. J. Schlichting and V. Nordmeier, Math. Naturwiss. Unterr. 49, 323 (1996). 

- [58] K. van der Weele, D. van der Meer, M. Versluis and D. Lohse, Europhys. Lett. 53, 328 (2001). 

32 

- [59] V. Serreli, C-F. Lee, E. R. Kay, and D. A. Leigh, Nature 445, 523 (2007). 

- [60] G. N. Price, S. T. Bannerman, K. Viering, E. Narevicius, and M. G. Raizen, Phys. Rev. Lett. 100, 093004 (2008). 

- [61] M. M. Millonas, Phys. Rev. Lett. 74, 10 (1995). 

- [62] A. M. Jayannavar, Phys. Rev. E 53, 2957 (1996). 

- [63] J. Eggers, Phys. Rev. Lett. 83, 5322 (1999). 

- [64] J. J. Brey, F. Moreno, R. Garcia-Rojo, and M. J. Ruiz-Montero, Phys. Rev. E 65, 011305 (2001). 

- [65] C. Van den Broeck, P. Meurs, and R. Kawai, New J. Phys. 7, 10 (2005). 

- [66] A. Ruschhaupt, J. G. Muga, and M. G. Raize, J. Phys. B: At. Mol. Opt. Phys. 39, 3833 (2006). 

- [67] C. Jarzynski, Phys. Rev. Lett. 78, 2690 (1997). 

- [68] G. E. Crooks, J. Stat. Phys. 90, 1481 (1998). 

- [69] G. E. Crooks, Phys. Rev. E 60, 2721 (1999). 

- [70] C. Jarzynski, J. Stat. Phys. 98, 77 (2000). 

- [71] U. Seifert, Phys. Rev. Lett. 95, 040602 (2005). 

- [72] R. Kawai, J. M. R. Parrondo, and C. Van den Broeck, Phys. Rev. Lett. 98, 080602 (2007). 

- [73] C. Bustamante, J. Liphardt, and F. Ritort, Physics Today, 58, 43 (2005). 

- [74] J. Liphardt et al., Science 296, 1832 (2002). 

- [75] D. Collin et al., Nature 437, 231 (2005). 

- [76] T. Schreiber, Phys. Rev. Lett. 85, 461 (2000). 

- [77] L. Brillouin, J. Appl. Phys. 22, 334 (1951). 

- [78] R. Landauer, IBM J. Res. Dev. 5, 183 (1961). 

- [79] C. H. Bennett, Int. J. Theor. Phys. 21, 905 (1982). 

- [80] W. H. Zurek, Nature 341, 119 (1989). 

- [81] W. H. Zurek, Phys. Rev. A 40, 4731 (1989). 

- [82] K. Shizume, Phys. Rev. E 52, 3495 (1995). 

33 

- [83] H. Matsueda, E. Goto, and K-F. Loe, RIMS Kˆokyˆuroku 1013, 187 (1997). 

- [84] B. Piechocinska, Phys. Rev. A 61, 062314 (2000). 

- [85] C. H. Bennett, Stud. Hist. Phil. Mod. Phys. 34, 501 (2003). 

- [86] A. E. Allahverdyan and T.M. Nieuwenhuizen, Phys. Rev. E 64, 0561171 (2001). 

- [87] C. Horhammer and H. Buttner, J. Stat. Phys. 133, 1161 (2008). 

- [88] M. M. Barkeshli, arXiv:cond-mat/0504323 (2005). 

- [89] J. D. Norton, Stud. Hist. Phil. Mod. Phys. 36, 375 (2005). 

- [90] O. J. E. Maroney, Phys. Rev. E 79, 031105 (2009). 

- [91] S. Turgut, Phys. Rev. E 79, 041102 (2009). 

- [92] T. Sagawa and M. Ueda, Phys. Rev. Lett. 102, 250602 (2009); 106, 189901(E) (2011). 

- [93] E. R. Kay, D. A. Leigh, and F. Zerbetto, Angew. Chem. 46, 72 (2007). 

34 

