

# On the Input-Output Stability of Time-Varying Nonlinear Feedback Systems Part I: Conditions Derived Using Concepts of Loop Gain, Conicity, and Positivity

G. ZAMES, MEMBER, IEEE

**Abstract**—The object of this paper is to outline a stability theory for input-output problems using functional methods. More particularly, the aim is to derive open loop conditions for the boundedness and continuity of feedback systems, without, at the beginning, placing restrictions on linearity or time invariance.

It will be recalled that, in the special case of a linear time invariant feedback system, stability can be assessed using Nyquist's criterion; roughly speaking, stability depends on the amounts by which signals are amplified and delayed in flowing around the loop. An attempt is made here to show that similar considerations govern the behavior of feedback systems in general—that stability of nonlinear time-varying feedback systems can often be assessed from certain gross features of input-output behavior, which are related to amplification and delay.

This paper is divided into two parts: Part I contains general theorems, free of restrictions on linearity or time invariance; Part II, which will appear in a later issue, contains applications to a loop with one nonlinear element. There are three main results in Part I, which follow the introduction of concepts of *gain*, *conicity*, *positivity*, and *strong positivity*:

**THEOREM 1:** If the open loop gain is less than one, then the closed loop is bounded.

**THEOREM 2:** If the open loop can be factored into two, suitably proportioned, conic relations, then the closed loop is bounded.

**THEOREM 3:** If the open loop can be factored into two positive relations, one of which is strongly positive and has finite gain, then the closed loop is bounded.

Results analogous to Theorems 1-3, but with boundedness replaced by continuity, are also obtained.

## I. INTRODUCTION

FEEDBACK, broadly speaking, affects a system in one of two opposing ways: depending on circumstances it is either degenerative or regenerative—either stabilizing or destabilizing. In trying to gain some perspective on the qualitative behavior of feedback sys-

tems we might ask: What are the kinds of feedback that are stabilizing? What kinds lead to a stable system? Can some of the effects of feedback on stability be described without assuming a very specific system representation?

Part I of this paper is devoted to the system of Fig. 1, which consists of two elements in a feedback loop.<sup>1</sup> This simple configuration is a model for many controllers, amplifiers, and modulators; its range of application will be extended to include multi-element and distributed systems, by allowing the system variables to be multidimensional or infinite-dimensional.

![Block diagram of a feedback loop with two elements. The input v enters a summing junction from the left. The output of the summing junction, labeled e1, enters a block labeled H1. The output of H1 is y1. y1 enters another summing junction from the top. The output of this second summing junction, labeled e2, enters a block labeled H2. The output of H2 is y2. y2 is fed back to the first summing junction. The final output of the system is labeled a2x + w2.](4d4c0d9569f139f1b68b2c2549c9a299_img.jpg)

Block diagram of a feedback loop with two elements. The input v enters a summing junction from the left. The output of the summing junction, labeled e1, enters a block labeled H1. The output of H1 is y1. y1 enters another summing junction from the top. The output of this second summing junction, labeled e2, enters a block labeled H2. The output of H2 is y2. y2 is fed back to the first summing junction. The final output of the system is labeled a2x + w2.

Fig. 1. A feedback loop with two elements.

The traditional approach to stability involves Lyapunov's method; here it is proposed to take a different course, and to stress the relation between input-output behavior and stability. An *input-output* system is one in which a function of time, called the output, is required to track another function of time, called the input; more generally the output might be required to track some function of the input. In order to behave properly an input-output system must usually have two properties:

- 1) Bounded inputs must produce bounded outputs—i.e., the system must be nonexplosive.
- 2) Outputs must not be critically sensitive to small changes in inputs—changes such as those caused by noise.

Manuscript received December 29, 1964; revised October 1, 1965; February 2, 1966. This work was carried out at the M.I.T. Electronic Systems Laboratory in part under support extended by NASA under Contract NAS-496 with the Center for Space Research. Parts of this paper were presented at the 1964 National Electronics Conference, Chicago, Ill., and at the 1964 International Conference on Micro-waves, Circuit Theory, and Information Theory, Tokyo, Japan.

The author is with the Department of Electrical Engineering, Massachusetts Institute of Technology, Cambridge, Mass.

<sup>1</sup> The system of Fig. 1 has a *single* input  $v$ , multiplied by constants  $a_1$  and  $a_2$ , and added in at *two* points. This arrangement has been chosen because it is symmetrical and thus convenient for analysis; it also remains invariant under some of the transformations that will be needed. Of course, a single input loop can be obtained by setting  $a_1$  or  $a_2$  to zero. The terms  $w_1$  and  $w_2$  are fixed bias functions, which will be used to account for the effects of initial conditions. The variables  $e_1$ ,  $e_2$ ,  $y_1$ , and  $y_2$  are outputs.

These two properties will form the basis of the definition of stability presented in this paper. It is desired to find conditions on the elements  $H_1$  and  $H_2$  (in Fig. 1) which will ensure that the overall loop will remain stable after  $H_1$  and  $H_2$  are interconnected. It is customary to refer to  $H_1$  and  $H_2$  prior to interconnection as the "open-loop" elements, and to the interconnected structure as the "closed loop." The problem to be considered here can therefore be described as seeking *open-loop conditions for closed-loop stability*.

Although the problem at hand is posed as a feedback problem, it can equally well be interpreted as a problem in networks; it will be found, for example, that the equations of the system of Fig. 1 have the same form as those of the circuit of Fig. 2, which consists of two elements in series with a voltage source, and in parallel with a current source.<sup>2</sup>

![Circuit diagram of a feedback loop equivalent to Fig. 1. It shows a current source i in parallel with two branches. The first branch contains a voltage source v and an element Z2 in series. The second branch contains an element Y1 and a voltage source v in series. The current i splits into i2 and i1. The voltage v is the same across both branches. Below the diagram, the equations are given: v = v* + v2, i2 = i - i1, v2 = Z2i2, i1 = Y1v1.](164d1b48231be457522b31965610ea3b_img.jpg)

Circuit diagram of a feedback loop equivalent to Fig. 1. It shows a current source i in parallel with two branches. The first branch contains a voltage source v and an element Z2 in series. The second branch contains an element Y1 and a voltage source v in series. The current i splits into i2 and i1. The voltage v is the same across both branches. Below the diagram, the equations are given: v = v\* + v2, i2 = i - i1, v2 = Z2i2, i1 = Y1v1.

Fig. 2. A circuit equivalent to the loop of Fig. 1.

### 1.1 Historical Note

The problem of Lyapunov stability has a substantial history with which the names of Lur'e, Malkin, Yakubowitch, Kalman, and many others, are associated. On the other hand, functional methods for stability received less attention until relatively recently, although some versions of the well-known Popov [1] theorem might be considered as fitting into this category.

The present paper has its origin in studies [2a, b] of nonlinear distortion in bandlimited feedback loops, in which contraction methods were used to prove the existence and stability of an inversion scheme. The author's application of contraction methods to more general stability problems was inspired in part by conversations with Narendra during 1962–1963; using Lyapunov's method, Narendra and Goldwyn [3] later obtained a result similar to the circle condition of Part II of this paper.

The key results of this paper, in a somewhat different formulation, were first presented in 1964 [2d, e]. Many

of these results are paralleled in the work of Brockett and Willems [4], who use Lyapunov based methods. Several others have obtained similar or related results by functional methods: Sandberg [5a] extended the nonlinear distortion theory mentioned above; later [5b] he obtained a stability theorem similar to Theorem 1 of this paper. Kudrewicz [6] has obtained circle conditions by fixed point methods. Contraction methods for incrementally positive operators have been developed by Zarantonello [7], Kolodner [8], Minty [9], and Browder [10]. A stability condition for linear time-varying systems has been described by Bongiorno [11].

## 2. FORMULATION OF THE PROBLEM

There are several preliminaries to settle, namely, to specify a system model, to define stability, and to write feedback equations. What is a suitable mathematical model of a feedback element? A "black box" point of view towards defining a model will be taken. That is to say, only input-output behavior, which is a purely external property, will be considered; details of internal structure which underlie this behavior will be omitted. Accordingly, throughout Part I, a feedback element will be represented by an abstract relation, which can be interpreted as a mapping from a space of input functions into a space of output functions. More concrete representations, involving convolution integrals, characteristic graphs, etc., will be considered in Part II.

Some of the elementary notions of functional analysis will be used, though limitations of space prevent an introduction to this subject.<sup>3</sup> Among the concepts which will be needed and used freely are those of an abstract relation, a normed linear space, an inner product space, and the  $L_p$  spaces.

The practice of omitting the quantifier "for all" shall be utilized. For example, the statement

$$"-x^2 \leq x^2(x \in X)"$$

is to be read:

$$\text{"for all } x \in X, -x^2 \leq x^2."$$

**CONVENTION:** *Any expression containing a condition of the type " $x \in X$ ," free of quantifiers, holds for all  $x \in X$ .*

### 2.1 The Extended Normed Linear Space $X_e$

In order to specify what is meant by a system, a suitable space of input and output functions will first be defined.<sup>4</sup> Since unstable systems will be involved, this space must contain functions which "explode," i.e., which grow without bound as time increases [for example, the exponential  $\exp(t)$ ]. Such functions are not contained in the spaces commonly used in analysis, for example, in the  $L_p$  spaces. Therefore it is necessary to

<sup>2</sup> It is assumed that the source voltage  $v$  and the source current  $i$  are inputs, with  $v = a_1x + w_1$  and  $i = a_2x + w_2$ ; the currents and voltages in the two elements are outputs.

<sup>3</sup> A good reference is Kolmogorov and Fomin [12].

<sup>4</sup> The space of input functions will equal the space of output functions.

construct a special space, which will be called  $X_*$ .  $X_*$  will contain both "well-behaved" and "exploding" functions, which will be distinguished from each other by assigning finite norms to the former and infinite norms to the latter.  $X_*$  will be an extension, or enlargement, of an associated normed linear space  $X$  in the following sense. Each finite-time truncation of every function in  $X_*$  will lie in  $X$ ; in other words, the restriction of  $x \in X_*$  to a finite time interval, say to  $[0, t]$ , will have a finite norm—but this norm may grow without limit as  $t \rightarrow \infty$ .

First a time interval  $T$  and a range of input or output values  $V$  will be fixed.

**DEFINITION:**  $T$  is a given subinterval of the reals, of the type  $[t_0, \infty)$  or  $(-\infty, \infty)$ .  $V$  is a given linear space.

[For example, in the analysis of multielement (or distributed) networks,  $V$  is multidimensional (or infinite-dimensional).] Second, the notion of a truncated function is introduced.

**NOTATION:** Let  $x$  be any function mapping  $T$  into  $V$ , that is,  $x: T \rightarrow V$ ; let  $t$  be any point in  $T$ ; then the symbol  $x_t$  denotes the truncated function,  $x_t: T \rightarrow V$ , which assumes the values  $x_t(\tau) = x(\tau)$  for  $\tau < t$  and  $x_t(\tau) = 0$  elsewhere.

(A truncated function is shown in Fig. 3.) Next, the space  $X$  is defined.

![Figure 3: A graph showing a truncated function. The horizontal axis is labeled T and the vertical axis is labeled V. A curve representing a function x starts at the origin and increases. A vertical dashed line at time t truncates the function. The portion of the curve before t is labeled x_t, and the portion after t is labeled x \in X_*. The point on the curve at time t is also labeled x_t.](9ccd03fe518c562a3fe2d3119f50935e_img.jpg)

Figure 3: A graph showing a truncated function. The horizontal axis is labeled T and the vertical axis is labeled V. A curve representing a function x starts at the origin and increases. A vertical dashed line at time t truncates the function. The portion of the curve before t is labeled x\_t, and the portion after t is labeled x \in X\_\*. The point on the curve at time t is also labeled x\_t.

Fig. 3. A truncated function.

**DEFINITION:**  $X$  is a space consisting of functions of the type  $x: T \rightarrow V$ ; the following assumptions are made concerning  $X$ :

- (1)  $X$  is a normed linear space; the norm of  $x \in X$  is denoted by  $\|x\|$ .
- (2) If  $x \in X$  then  $x_t \in X$  for all  $t \in T$ .
- (3) If  $x: T \rightarrow V$ , and if  $x_t \in X$  for all  $t \in T$ , then:
  - (a)  $\|x_t\|$  is a nondecreasing function of  $t \in T$ .
  - (b) If  $\lim_{t \rightarrow \infty} \|x_t\|$  exists, then  $x \in X$  and the limit equals  $\|x\|$ .

(For example, it can be verified that assumptions (1)–(3) are satisfied by the  $L_p$  spaces.) Next,  $X_*$  is defined.

**DEFINITION:** The extension of  $X$ , denoted by  $X_*$ , is the space consisting of those functions whose truncations lie in  $X$ , that is,  $X_* = \{x \mid x: T \rightarrow V, \text{ and } x_t \in X \text{ for all } t \in T\}$ . (NOTE:  $X_*$  is a linear space.) An extended norm, denoted  $\|x\|_*$ , is assigned to each  $x \in X_*$  as follows:  $\|x\|_* = \|x\|$  if  $x \in X$ , and  $\|x\|_* = \infty$  if  $x \notin X$ .

The point of assumptions (2)–(3) on  $X$  can now be appreciated; these assumptions make it possible to determine whether or not an element  $x \in X_*$  has a finite norm, by observing whether or not  $\lim_{t \rightarrow \infty} \|x_t\|$  exists. For example:

**EXAMPLE 1:** Let  $L_2[0, \infty)$  be the normed linear space consisting of those real-valued functions  $x$  on  $[0, \infty)$  for which the integral  $\int_0^\infty x^2(t) dt$  exists, and let this integral equal  $\|x\|^2$ . Let  $X = L_2[0, \infty)$ , and let  $L_{2*} = X_*$ ; that is,  $L_{2*}$  is the extension of  $L_2[0, \infty)$ . Let  $x$  be the function on  $[0, \infty)$  given by  $x(t) = \exp(t)$ . Is  $\|x\|_*$  finite, that is, is  $x \in X$ ? No, because  $\|x_t\|$  grows without limit as  $t \rightarrow \infty$ , or in other words,  $\|x\|_* = \infty$ .

### 2.2 Input-Output Relations

The mathematical model of an input-output system will be a relation on  $X_*$ :

**DEFINITION:** A relation  $H$  on  $X_*$  is any subset of the product space  $X_* \times X_*$ . If  $(x, y)$  is any pair belonging to  $H$  then  $y$  will be said to be  $H$ -related to  $x$ ;  $y$  will also be said to be an image of  $x$  under  $H$ .<sup>5</sup>

In other words, a relation is a set of pairs of functions in  $X_*$ . It will be convenient to refer to the first element in any pair as an input, and to the second element as an output, even though the reverse interpretation is sometimes more appropriate. A relation can also be thought of as a mapping, which maps some (not necessarily all) inputs into outputs. In general, a relation is multi-valued; i.e., a single input can be mapped into many outputs.

The concept of state, which is essential to Lyapunov's method, will not be used here. This does not mean that initial conditions cannot be considered. One way of accounting for various initial conditions is to represent a system by a multi-valued relation, in which each input is paired with many outputs, one output per initial condition. Another possibility is to introduce a separate relation for each initial condition.

Note that the restrictions placed on  $X_*$  tend to limit, a priori, the class of allowable systems. In particular, the requirement that truncated outputs have finite norms means, roughly speaking, that only systems having infinite "escape times," i.e., systems which do not blow up in finite time, shall be considered.

Some additional nomenclature follows:

**DEFINITION:** If  $H$  is a relation on  $X_*$ , then the domain of  $H$  denoted  $Do(H)$ , and the range of  $H$  denoted  $Ra(H)$ , are the sets,

$$Do(H) = \{x \mid x \in X_*, \text{ and there exists } y \in X_* \text{ such that } (x, y) \in H\}$$

$$Ra(H) = \{y \mid y \in X_*, \text{ and there exists } x \in X_* \text{ such that } (x, y) \in H\}$$

<sup>5</sup> In general  $x$  can have many images.

NOTATION: If  $H$  is a relation on  $X_o$ , and if  $x$  is a given element of  $X_o$ , then the symbol  $Hx$  denotes an image of  $x$  under  $H$ .<sup>6</sup>

The idea here is to use a special symbol for an element instead of indicating that the element belongs to a certain set. For example, the statement, "there exists  $Hx$  having property  $P$ " is shorthand for "there exists  $y \in \text{Ra}(H)$ , such that  $y$  is an image of  $x$ , and  $y$  has property  $P$ ."<sup>6</sup>

Observing that  $Hx$  is, according to the definitions used here, a function on  $T$ , the following symbol for the value of  $Hx$  at time  $t$  is adopted:

NOTATION: The symbol  $Hx(t)$  denotes the value assumed by the function  $Hx$  at time  $t \in T$ .

Occasionally a special type of relation, called an operator, will be used:

DEFINITION: An operator  $H$  is a relation on  $X_o$  which satisfies two conditions: 1)  $\text{Do}(H) = X_o$ . 2)  $H$  is single-valued; that is, if  $x$ ,  $y$ , and  $z$  are elements of  $X_o$ , and if  $y$  and  $z$  are images of  $x$  under  $H$ , then  $y = z$ .

### 2.3 The Class $\mathfrak{R}$

DEFINITION:  $\mathfrak{R}$  is the class of those relations  $H$  on  $X_o$  having the property that the zero element, denoted  $o$ , lies in  $\text{Do}(H)$ , and  $Ho = o$ .

The assumption that  $H$  maps zero into zero simplifies many derivations; if this condition is not met at the outset, it can be obtained by adding a compensating bias to the feedback equations.

If  $H$  and  $K$  are relations in  $\mathfrak{R}$ , and  $c$  is a real constant, then the sum  $(H+K)$ , the product  $cH$ , and the composition product  $KH$  of  $K$  following  $H$ , are defined in the usual way,<sup>7</sup> and are relations in  $\mathfrak{R}$ . The inverse of  $H$  in  $\mathfrak{R}$ , denoted by  $H^{-1}$ , always exists. The identity operator on  $X_o$  is denoted by  $I$ .

### 2.4 Input-Output Stability

The term "stable" has been used in a variety of ways, to indicate that a system is somehow well behaved. A system shall be called stable if it is well behaved in two respects: (1) It is bounded, i.e., not explosive. (2) It is continuous, i.e., not critically sensitive to noise.

DEFINITION: A subset  $Y$  of  $X_o$  is bounded if there exists  $A > 0$  such that, for all  $y \in Y$ ,  $\|y\|_e < A$ . A relation  $H$  on  $X_o$  is bounded<sup>8</sup> if the image under  $H$  of every bounded subset of  $X_o$  is a bounded subset of  $X_o$ .

<sup>6</sup> In keeping with the usual convention used here, any statement containing  $Hx$  free of quantifiers holds for all  $x$  in  $\text{Ra}(H)$ . For example, " $Hx > 1$  ( $x \in X_o$ )" means that "for all  $x$  in  $X_o$ , and for all  $Hx$  in  $\text{Ra}(H)$ ,  $Hx > 1$ ."

<sup>7</sup> In particular,  $\text{Do}(H+K) = \text{Do}(H) \cap \text{Do}(K)$ . Note that  $\mathfrak{R}$  is not a linear space; for example, if  $\text{Do}(H) \neq \text{Do}(K)$  then  $\text{Do}(H+K) - K \neq \text{Do}(H)$ .

<sup>8</sup> This definition implies that inputs of finite norm produce outputs of finite norm. More than that, it implies that the sort of situation is avoided in which a bounded sequence of inputs, say  $\|x_n\| < 1$  where  $n = 1, 2, \dots$ , produces a sequence of outputs having norms that are finite but increasing without limit, say  $\|Hx_n\| = n$ .

DEFINITION: A relation  $H$  on  $X_o$  is continuous if  $H$  has the following property: Given any  $x \in X$  (that is,  $\|x\|_e < \infty$ ), and any  $\Delta > 0$ , there exists  $\delta > 0$  such that, for all  $y \in X$ , if  $\|x - y\| < \delta$  then  $\|Hx - Hy\| < \Delta$ .

DEFINITION: A relation  $H$  on  $X_o$  is input-output stable if  $H$  is bounded and continuous.

### 2.5 Feedback Equations

Although negative feedback loops will be of interest, the positive feedback configuration of Fig. 1 has been chosen because it is symmetrical.<sup>1</sup> The equations describing this system, to be known as the FEEDBACK EQUATIONS, are:

$$e_1 = w_1 + a_1x + y_2 \quad (1a)$$

$$e_2 = w_2 + a_2x + y_1 \quad (1b)$$

$$y_2 = H_2e_2 \quad (2a)$$

$$y_1 = H_1e_1 \quad (2b)$$

in which it is assumed that:

- $H_1$  and  $H_2$  are relations in  $\mathfrak{R}$
- $a_1$  and  $a_2$  are real constants
- $w_1$  and  $w_2$  are fixed biases in  $X$
- $x$  in  $X_o$  is an input
- $e_1$  and  $e_2$  in  $X_o$  are (error) outputs
- $y_1$  and  $y_2$  in  $X_o$  are outputs.

(The biases are used to compensate for nonzero zero-input responses and, in particular, for the effects of initial conditions.) The closed-loop relations  $E_1$ ,  $E_2$ ,  $F_1$ , and  $F_2$ , are now defined as follows.

DEFINITION:  $E_1$  is the relation that relates  $e_1$  to  $x$  or, more precisely,  $E_1 = \{(x, e_1) \mid (x, e_1) \in X_o \times X_o, \text{ and there exist } e_2, y_1, y_2, H_1e_1, \text{ and } H_2e_2, \text{ all in } X_o, \text{ such that (1) and (2) are satisfied}\}$ . Similarly  $E_2$  relates  $e_2$  to  $x$ ;  $F_1$  relates  $y_1$  to  $x$ ;  $F_2$  relates  $y_2$  to  $x$ .

All the prerequisites are now assembled for defining the problem of interest which is: Find conditions on  $H_1$  and  $H_2$  which ensure that  $E_1$ ,  $E_2$ ,  $F_1$ , and  $F_2$  are bounded or stable. In general it will be enough to be concerned with  $E_1$  and  $E_2$  only, and to neglect  $F_1$  and  $F_2$ , since every  $F_x$  is related to some  $E_x$  by the equation  $F_x y = E_x x - a_x x - w_x$ , so that  $F_2$  is bounded (or stable) whenever  $E_1$  is, and similarly for  $F_1$  vs.  $E_2$ .

It should be noted that by posing the feedback problem in terms of relations (rather than in terms of operators) all questions of existence and uniqueness of solutions are avoided. For the results to be practically significant, it must usually be known from some other source<sup>9</sup> that solutions exist and are unique (and have infinite "escape times").

<sup>9</sup> Existence and stability can frequently be deduced from entirely separate assumptions. For example, existence can often be deduced, by iteration methods, solely from the fact that (loosely speaking) the open loop delays signals; stability can not. (The connection between existence and generalized delay is discussed in G. Zames, "Realizability conditions for nonlinear feedback systems," *IEEE Trans. on Circuit Theory*, vol. CT-11, pp. 186-194, June 1964.)

## 3. SMALL LOOP GAIN CONDITIONS

To secure a foothold on this problem a simple situation is sought in which it seems likely, on intuitive grounds, that the feedback system will be stable. Such a situation occurs when the open loop attenuates all signals. This intuitive idea will be formalized in Theorem 1; in later sections, a more comprehensive theory will be derived from Theorem 1.

To express this idea, a measure of attenuation, i.e., a notion of gain, is needed.

### 3.1 Gains

Gain will be measured in terms of the ratio of the norm of a truncated output to the norm of the related, truncated input.

**DEFINITION:** The gain of a relation  $H$  in  $\mathfrak{R}$ , denoted by  $g(H)$ , is

$$g(H) = \sup \frac{\|(Hx)_t\|}{\|x_t\|} \quad (3)$$

where the supremum is taken over all  $x$  in  $\text{Do}(H)$ , all  $Hx$  in  $\text{Ra}(H)$ , and all  $t$  in  $T$  for which  $x_t \neq 0$ .

In other words, the supremum is taken over all possible input-output pairs, and over all possible truncations. The reason for using truncated (rather than whole) functions is that the norms of truncated functions are known to be finite *a priori*.

It can be verified that gains have all the properties of norms. In addition, if  $H$  and  $K$  belong to  $\mathfrak{R}$  then  $g(KH) \leq g(K)g(H)$ . Gains also satisfy the following inequalities:

$$\|(Hx)_t\| \leq g(H) \cdot \|x_t\| \quad [x \in \text{Do}(H); t \in T] \quad (4)$$

$$\|Hx\| \leq g(H) \cdot \|x\| \quad [x \in \text{Do}(H)] \quad (5)$$

where (4) is implied by (3), and (5) is derived from (4) by taking the limit as  $t \rightarrow \infty$ .

If  $g(H) < \infty$  then (5) implies that  $H$  is bounded. In fact, conditions for boundedness will be derived using the notion of gain and inequalities such as (5). In a similar way, conditions for continuity will be derived using the notion of incremental gain, which is defined as follows:

**DEFINITION:** The incremental gain of any  $H$  in  $\mathfrak{R}$ , denoted by  $\bar{g}(H)$ , is

$$\bar{g}(H) = \sup \frac{\|(Hx)_t - (Hy)_t\|}{\|x_t - y_t\|} \quad (6)$$

where the supremum is taken over all  $x$  and  $y$  in  $\text{Do}(H)$ , all  $Hx$  and  $Hy$  in  $\text{Ra}(H)$ , and all  $t$  in  $T$  for which  $x_t \neq y_t$ .

Incremental gains have all the properties of norms, and satisfy the inequalities

$$\bar{g}(KH) \leq \bar{g}(K) \cdot \bar{g}(H) \quad (7)$$

$$\begin{aligned} \|(Hx)_t - (Hy)_t\| &\leq \bar{g}(H) \cdot \|x_t - y_t\| \quad [x, y \in \text{Do}(H); t \in T] \quad (8) \end{aligned}$$

$$\|Hx - Hy\| \leq \bar{g}(H) \cdot \|x - y\| \quad [x, y \in \text{Do}(H)]. \quad (9)$$

In the Feedback Equations (1)–(2), the product  $g(H_1) \cdot g(H_2)$  will be called the *open-loop gain-product*, and similarly,  $\bar{g}(H_1) \cdot \bar{g}(H_2)$  will be called the *incremental open-loop gain-product*.

### 3.2 A Stability Theorem

Consider the Feedback Equations (1)–(2).

**THEOREM 1:**<sup>10</sup> a) If  $g(H_1) \cdot g(H_2) < 1$ , then the closed loop relations  $E_1$  and  $E_2$  are bounded. b) If  $\bar{g}(H_1) \cdot \bar{g}(H_2) < 1$ , then  $E_1$  and  $E_2$  are input-output stable.

Theorem 1 is inspired by the well known Contraction Principle.<sup>11</sup>

**PROOF OF THEOREM 1:** (a) Since eqs. (1)–(2) are symmetrical in the subscripts 1 and 2, it is enough to consider  $E_1$ . This proof will consist of showing that there are positive constants  $a$ ,  $b$ , and  $c$ , with the property that any pair  $(x, e_1)$  belonging to  $E_1$  [and so being a solution of eqs. (1)–(2)], satisfies the inequality

$$\|e_1\| \leq a\|w_1\| + b\|w_2\| + c\|x\|. \quad (10)$$

It will follow that if  $x$  is confined to a bounded region, say  $\|x\| \leq A$ , then  $e_1$  will also be confined to a bounded region, in this case  $\|e_1\| \leq a\|w_1\| + b\|w_2\| + cA$ . Thus  $E_1$  will be bounded.

**PROOF OF INEQUALITY (10):** If  $(x, e_1)$  belongs to  $E_1$  then, after truncating eqs. (1a) and (1b), and using the triangle inequality to bound their norms, the following inequalities are obtained:

$$\|e_{1t}\| \leq \|w_{1t}\| + |a_1| \cdot \|x_t\| + \|y_{2t}\| \quad (t \in T) \quad (10a)$$

$$\|e_{2t}\| \leq \|w_{2t}\| + |a_2| \cdot \|x_t\| + \|y_{1t}\| \quad (t \in T) \quad (10b)$$

Furthermore, applying Inequality (4) to eqs. (2), the following is obtained, for each  $t$  in  $T$ :

$$\|y_{2t}\| \leq g(H_2) \cdot \|e_{2t}\| \quad (11a)$$

$$\|y_{1t}\| \leq g(H_1) \cdot \|e_{1t}\|. \quad (11b)$$

Letting  $g(H_1) \triangleq \alpha$  and  $g(H_2) \triangleq \beta$ , and applying (11a) to (10a) and (11b) to (10b), the following inequalities are obtained:

$$\|e_{1t}\| \leq \|w_{1t}\| + |a_1| \cdot \|x_t\| + \beta \|e_{2t}\| \quad (t \in T) \quad (12a)$$

$$\|e_{2t}\| \leq \|w_{2t}\| + |a_2| \cdot \|x_t\| + \alpha \|e_{1t}\| \quad (t \in T). \quad (12b)$$

Applying (12b) to  $\|e_{2t}\|$  in (12a), and rearranging,

$$\begin{aligned} (1 - \alpha\beta) \|e_{1t}\| &\leq \|w_{1t}\| + \beta \|w_{2t}\| \\ &+ (|a_1| + \beta |a_2|) \|x_t\| \quad (t \in T). \quad (13) \end{aligned}$$

<sup>10</sup> A variation of Theorem 1 was originally presented in [2d]. A related continuity theorem was used in [2c]. An independent, related result is Sandberg's [5b].

<sup>11</sup> If  $X$  is a complete space, if all relations are in fact operators, and if the hypothesis of Theorem 1b holds, then the Contraction Principle implies existence and uniqueness of solutions—a matter that has been disregarded here.

Since  $(1 - \alpha\beta) > 0$  (as  $\alpha\beta < 1$ , by hypothesis), Inequality (13) can be divided by  $(1 - \alpha\beta)$ ; after dividing and taking the limit of both sides as  $t \rightarrow \infty$ , the Inequality (10) remains. Q.E.D.

(b) Let  $(x', e_1')$  and  $(x'', e_1'')$  be any two pairs belonging to  $E_1$ . Proceeding as in Part (a) an inequality of the form  $\|e_1'' - e_1'\| \leq c\|x'' - x'\|$  is obtained, which implies that  $E_1$  is continuous. Moreover, since the hypothesis of Part (b) implies the hypothesis of Part (a),  $E_1$  is bounded too. Therefore  $E_1$  is input-output stable.

EXAMPLE 2: In eqs. (1)–(2) (and in Fig. 1) let one of the two relations, say  $H_1$ , be the identity on  $L_{2e}$ . ( $L_{2e}$  is defined in Example 1.) Let the other relation,  $H_2$  on  $L_{2e}$ , be given by the equation  $H_2x(t) = kN[x(t)]$ , where  $k > 0$  is a constant, and  $N$  is a function whose graph is shown in Fig. 4. For what values of  $k$  are the closed loop relations (a) bounded? (b) stable?

(a) First the gain is calculated.

$$g(H_2) = \sup \left\{ \int_0^\infty N^2[x(t)] dt / \int_0^\infty x^2(t) dt \right\}^{1/2}$$

$$= k \sup_{x \text{ real}} \left| \frac{N(x)}{x} \right| = k$$

where the first sup is over  $[x \in \text{Do}(H); Hx \in \text{Ra}(H); t \in T, x_t \neq 0]$ . That is,  $g(H)$  is  $k$  times the supremum of the absolute slopes of lines drawn from the origin to points on the graph of  $N$ . Here  $g(H) = k$ , so Theorem 1 implies boundedness for  $k < 1$ . This example is trivial in at least one respect, namely, in that  $H$  has no memory; examples with memory will be given in Part II.

(b)  $g(H)$  can be worked out to be  $k$  times the supremum of the absolute Lipschitzian slopes of  $N$ , that is,  $g(H) = k \sup_{x, y \text{ real}} |N(x) - N(y)|/|x - y| = 2k$ . The closed loop is therefore stable for  $k < 1/2$ .

![Graph of the relation in Example 2. The graph shows a function N(x) plotted against x. It consists of a straight line with slope 1 for x < 0, a horizontal segment at N(x) = 0 for 0 < x < 1, and a horizontal segment at N(x) = 1 for x > 1. A dashed line from the origin is tangent to the horizontal segment at N(x) = 1. A label 'denotes slope' with an arrow points to the horizontal segments.](29ac39bfd74e57a92045649f83cad949_img.jpg)

Graph of the relation in Example 2. The graph shows a function N(x) plotted against x. It consists of a straight line with slope 1 for x < 0, a horizontal segment at N(x) = 0 for 0 < x < 1, and a horizontal segment at N(x) = 1 for x > 1. A dashed line from the origin is tangent to the horizontal segment at N(x) = 1. A label 'denotes slope' with an arrow points to the horizontal segments.

Fig. 4. Graph of the relation in Example 2.

## 4. CONDITIONS INVOLVING CONIC RELATIONS

The usefulness of Theorem 1 is limited by the condition that the open-loop gain-product be less than one—a condition seldom met in practice. However, a reduced gain product can often be obtained by transforming the feedback equations. For example, if  $cI$  is added to and subtracted from  $H_2$ , as shown in Fig. 5, then  $e_2$  remains

unaffected; however,  $H_1$  is changed into a new relation  $H_1'$ , as in effect  $-cI$  appears in feedback around  $H_1$ . Under what conditions does this transformation give a gain product less than one? It will appear that a sufficient condition is that the input-output relations of the open loop elements be confined to certain “conic” regions in the product space  $X_e \times X_e$ .

![Block diagram illustrating a transformation of feedback systems. The left side shows a feedback loop with input w, output y, and two blocks H1 and H2. H1 is in the forward path, and H2 is in the feedback path. A summing junction adds the output of H1 to a signal c*y. The right side shows the transformed system where H1 is replaced by H1' = H1(cI + H1)^{-1} and H2 is replaced by H2' = H2 + cI. The input is now w + c*y and the output is y.](cfbf0f2ddbc35370b0b8c6d043f25eb2_img.jpg)

Block diagram illustrating a transformation of feedback systems. The left side shows a feedback loop with input w, output y, and two blocks H1 and H2. H1 is in the forward path, and H2 is in the feedback path. A summing junction adds the output of H1 to a signal c\*y. The right side shows the transformed system where H1 is replaced by H1' = H1(cI + H1)^{-1} and H2 is replaced by H2' = H2 + cI. The input is now w + c\*y and the output is y.

Fig. 5. A transformation.

RESTRICTION: In the remainder of this paper, assume that  $X$  is an inner-product space, that  $\langle x, y \rangle$  denotes the inner product on  $X$ , and that  $\langle x, x \rangle = \|x\|^2$ .

This restriction is made with the intention of working mainly in the extended  $L_2[0, \infty)$  norm,<sup>12</sup> with  $\langle x, y \rangle = \int_0^\infty x(t)y(t)dt$ .

### 4.1 Definitions of Conic and Positive Relations

DEFINITION: A relation  $H$  in  $\mathfrak{R}$  is interior conic if there are real constants  $r \geq 0$  and  $c$  for which the inequality

$$\|(Hx)_t - cx\| \leq r\|x_t\| \quad [x \in \text{Do}(H); t \in T] \quad (14)$$

is satisfied.  $H$  is exterior conic if the inequality sign in (14) is reversed.  $H$  is conic if it is exterior conic or interior conic. The constant  $c$  will be called the center parameter of  $H$ , and  $r$  will be called the radius parameter.

The truncated output  $(Hx)_t$  of a conic relation lies either inside or outside a sphere in  $X$ , with center proportional to the truncated input  $x_t$  and radius proportional to  $\|x_t\|$ . The region thus determined in  $X_e \times X_e$  will be called a “cone,” a term suggested by the following special case:

EXAMPLE 3: Let  $H$  be a relation on  $L_{2e}$  (see Example 1); let  $Hx(t)$  be a function of  $x(t)$ , say  $Hx(t) = N[x(t)]$ , where  $N$  has a graph in the plane; then, as shown in Fig. 6, the graph lies inside or outside a conic sector of the plane, with a center line of slope  $c$  and boundaries of slopes  $c-r$  and  $c+r$ . More generally, for  $H$  to be conic [without  $Hx(t)$  necessarily being a function of  $x(t)$ , that is, if  $H$  has memory], it is enough for the point  $[x(t), Hx(t)]$  to be confined to a sector of the plane. In this case, it will be said that  $H$  is instantaneously confined to a sector of the plane.

Inequality (14) can be expressed in the form  $\|(Hx)_t - cx\|^2 - r\|x_t\|^2 \leq 0$ . If norms are expressed in

<sup>12</sup> However, in engineering applications it is often more interesting to prove stability in the  $L_\infty$  norm. The present theory has been extended in that direction in the author's [2f]. The idea is [2f] to transform  $L_2$  functions into  $L_\infty$  functions by means of exponential weighting factors.

![Figure 6: A conic sector in the plane. The plot shows a coordinate system with x(t) on the horizontal axis and Hx(t) on the vertical axis. A shaded region represents a conic sector starting from the origin. Two lines are drawn through the origin: one with a positive slope labeled 'a = c - r' and another with a negative slope labeled 'b = c + r'. The region between these lines is shaded and labeled 'Interior of sector is shaded.'](a6a8016b231533e7f34b550f4676afc6_img.jpg)

Figure 6: A conic sector in the plane. The plot shows a coordinate system with x(t) on the horizontal axis and Hx(t) on the vertical axis. A shaded region represents a conic sector starting from the origin. Two lines are drawn through the origin: one with a positive slope labeled 'a = c - r' and another with a negative slope labeled 'b = c + r'. The region between these lines is shaded and labeled 'Interior of sector is shaded.'

Fig. 6. A conic sector in the plane.

terms of inner products then, after factoring, there is obtained the equivalent inequality

$$\langle (Hx)_t - ax_t, (Hx)_t - bx_t \rangle \leq 0 \quad [x \in \text{Do}(H); t \in T] \quad (15)$$

where  $a = c - r$  and  $b = c + r$ . It will often be desirable to manipulate inequalities such as (15), and a notation inspired by Fig. 6 is introduced:

NOTATION: A conic relation  $H$  is said to be inside the sector  $\{a, b\}$ , if  $a \leq b$  and if Inequality (15) holds.  $H$  is outside the sector  $\{a, b\}$  if  $a \leq b$  and if (15) holds with the inequality sign reversed.

The following relationship will frequently be used: If  $H$  is interior (exterior) conic with center  $c$  and radius  $r$  then  $H$  is inside (outside) the sector  $\{c - r, c + r\}$ . Conversely, if  $H$  is inside (outside) the sector  $\{a, b\}$ , then  $H$  is interior (exterior) conic, with center  $(b + a)/2$  and radius  $(b - a)/2$ .

DEFINITION: A relation  $H$  in  $\mathcal{R}$  is positive<sup>13</sup> if

$$\langle x_t, (Hx)_t \rangle \geq 0 \quad [x \in \text{Do}(H); t \in T]. \quad (16)$$

A positive relation can be regarded as degenerately conic, with a sector from 0 to  $\infty$ . [Compare (15) and (16).] For example, the relation  $H$  on  $L_{2e}$  is positive if it is instantaneously confined (see Example 3) to the first and third quadrants of the plane.

### 4.2 Some Properties of Conic Relations

Some simple properties will be listed. It will be assumed, in these properties, that  $H$  and  $H_1$  are conic relations; that  $H$  is inside the sector  $\{a, b\}$ , with  $b > 0$ ; that  $H_1$  is inside  $\{a_1, b_1\}$  with  $b_1 > 0$ ; and that  $k \geq 0$  is a constant.

- (i)  $I$  is inside  $\{1, 1\}$ .
- (ii)  $kH$  is inside  $\{ka, kb\}$ ;  $-H$  is inside  $\{-b, -a\}$ .
- (iii) SUM RULE:  $(H + H_1)$  is inside  $\{a + a_1, b + b_1\}$ .
- (iv) INVERSE RULE

<sup>13</sup> Short for "positive semidefinite." The terms "passive" and "nondissipative" have also been used.

CASE 1a: If  $a > 0$  then  $H^{-1}$  is inside  $\{1/b, 1/a\}$ .

CASE 1b: If  $a < 0$  then  $H^{-1}$  is outside  $\{1/a, 1/b\}$ .

CASE 2: If  $a = 0$  then  $(H^{-1} - (1/b)I)$  is positive.

(v) Properties (ii), (iii), and (iv) remain valid with the terms "inside  $\{ \}$ " and "outside  $\{ \}$ " interchanged throughout.

(vi)  $g(H) \leq \max \{|a|, |b|\}$ . Hence if  $H$  is in  $\{-r, r\}$  then  $g(H) \leq r$ .

The proofs are in Appendix A. One consequence of these properties is that it is relatively easy to estimate conic bounds for simple interconnections, where it might be more difficult, say, to find Lyapunov functions.

### 4.3 A Theorem on Boundedness

Consider the feedback system of Fig. 1, and suppose that  $H_2$  is confined to a sector  $\{a, b\}$ . It is desirable to find a condition on  $H_1$  which will ensure the boundedness of the closed loop. A condition will be found, which places  $H_1$  inside or outside a sector depending on  $a$  and  $b$ , and which requires either  $H_1$  or  $H_2$  to be bounded away from the edge of its sector by an arbitrarily small amount,  $\Delta$  or  $\delta$ .

THEOREM 2a: [In eqs. (1)–(2)] Let  $H_1$  and  $H_2$  be conic relations. Let  $\Delta$  and  $\delta$  be constants, of which one is strictly positive and one is zero. Suppose that

(I)  $-H_2$  is inside the sector  $\{a + \Delta, b - \Delta\}$  where  $b > 0$ , and,

(II)  $H_1$  satisfies one of the following conditions.

CASE 1a: If  $a > 0$  then  $H_1$  is outside

$$\left\{ \frac{1}{a} - \delta, -\frac{1}{b} + \delta \right\}.$$

CASE 1b: If  $a < 0$  then  $H_1$  is inside

$$\left\{ -\frac{1}{b} + \delta, -\frac{1}{a} - \delta \right\}.$$

CASE 2: If  $a = 0$  then

$$H_1 + \left( \frac{1}{b} - \delta \right) I$$

is positive; in addition, if  $\Delta = 0$  then  $g(H_1) < \infty$ .

Then  $E_1$  and  $E_2$  are bounded.

The proof of Theorem 2a is in Appendix B. Note that the minus sign in front of  $H_2$  reflects an interest in negative feedback.

EXAMPLE 4: If  $H_1$  and  $H_2$  are relations on  $L_{2e}$  instantaneously confined to sectors of the plane (as in Example 3), then the closed loop will be bounded if the sectors are related as in Fig. 7. (More realistic examples will be discussed in Part II.)

![Figure 7: Mutually admissible sectors for H2 and H1. The figure consists of six subplots arranged in a 3x2 grid. The left column shows H2(x(t)) vs x(t) and the right column shows H1(x(t)) vs x(t). Row 1: CASE 1a: Δ > 0. Left plot shows a sector [a, b] for H2 and a sector [a+Δ, b] for H1. Right plot shows a sector [a, b] for H2 and a sector [a-1/a, b] for H1. Row 2: CASE 2: a = 0. Left plot shows a sector [0, b] for H2 and a sector [0, b] for H1. Right plot shows a sector [0, b] for H2 and a sector [-1/b, b] for H1. Row 3: CASE 1b: Δ < 0. Left plot shows a sector [a, b] for H2 and a sector [a, b+Δ] for H1. Right plot shows a sector [a, b] for H2 and a sector [a, b-1/a] for H1. In all cases, Δ > 0, b > 0, and a > 0. Admissible regions are shaded.](d864789b0d8384da1d22fd6a5d76bbdf_img.jpg)

Figure 7: Mutually admissible sectors for H2 and H1. The figure consists of six subplots arranged in a 3x2 grid. The left column shows H2(x(t)) vs x(t) and the right column shows H1(x(t)) vs x(t). Row 1: CASE 1a: Δ > 0. Left plot shows a sector [a, b] for H2 and a sector [a+Δ, b] for H1. Right plot shows a sector [a, b] for H2 and a sector [a-1/a, b] for H1. Row 2: CASE 2: a = 0. Left plot shows a sector [0, b] for H2 and a sector [0, b] for H1. Right plot shows a sector [0, b] for H2 and a sector [-1/b, b] for H1. Row 3: CASE 1b: Δ < 0. Left plot shows a sector [a, b] for H2 and a sector [a, b+Δ] for H1. Right plot shows a sector [a, b] for H2 and a sector [a, b-1/a] for H1. In all cases, Δ > 0, b > 0, and a > 0. Admissible regions are shaded.

NOTE: IN ALL CASES,  $\Delta > 0$ ,  $b > 0$ , and  $a > 0$ .  
ADMISSIBLE REGIONS ARE SHADED.

Fig. 7. Mutually admissible sectors for  $H_2$  and  $H_1$

### 4.4 Incrementally Conic and Positive Relations

Next, it is desired to find a stability result similar to the preceding theorem on boundedness. To this end the recent steps are repeated with all definitions replaced by their "incremental" counterparts.

**DEFINITION:** A relation  $H$  in  $\mathbb{R}$  is incrementally interior (exterior) conic if there are real constants  $r > 0$  and  $c$  for which the inequality

$$\begin{aligned} & \| (Hx - Hy)_t - c(x - y)_t \| \leq r \| (x - y)_t \| \\ & [x, y \in \text{Do}(H); t \in T] \end{aligned} \quad (17)$$

is satisfied (with inequality sign reversed). An incrementally conic relation  $H$  is incrementally inside (outside) the sector  $\{a, b\}$ , if  $a \leq b$  and if the inequality

$$\begin{aligned} & \langle (Hx - Hy)_t - a(x - y)_t, (Hx - Hy)_t - b(x - y)_t \rangle \leq 0 \\ & [x, y \in \text{Do}(H); t \in T] \end{aligned} \quad (18)$$

is satisfied (with inequality sign reversed). A relation  $H$  in  $\mathbb{R}$  is incrementally positive<sup>14</sup> if

$$\langle (x - y)_t, (Hx - Hy)_t \rangle \geq 0 \quad [x, y \in \text{Do}(H); t \in T]. \quad (19)$$

**EXAMPLE 5:** Consider the relation  $H$  on  $L_{2n}$ , with  $Hx(t) = N[x(t)]$ , where  $N$  is a function having a graph in the plane. If  $N$  is incrementally inside  $\{a, b\}$  then  $N$  satisfies the Lipschitz conditions,  $a(x - y) \leq N(x) - N(y) \leq b(x - y)$ . Thus  $N$  lies in a sector of the plane, as in the nonincremental case (see Fig. 6), and in addition has upper and lower bounds to its slope.

Incrementally conic relations have properties similar to those of conic relations (see Section 4.2).

<sup>14</sup> The terms "monotone" and "incrementally passive" have also been used.

**THEOREM 2b:** Let  $H_1$  and  $H_2$  be incrementally conic relations. Let  $\Delta$  and  $\delta$  be constants, of which one is strictly positive and one is zero. Suppose that,

- (I)  $-H_2$  is incrementally inside the sector  $\{a + \Delta, b - \Delta\}$ , where  $b > 0$ , and,
- (II)  $H_1$  satisfies one of the following conditions:

CASE 1a: If  $a > 0$  then  $H_1$  is incrementally outside

$$\left\{ -\frac{1}{a} - \delta, -\frac{1}{b} + \delta \right\}.$$

CASE 1b: If  $a < 0$  then  $H_1$  is incrementally inside

$$\left\{ -\frac{1}{b} + \delta, -\frac{1}{a} - \delta \right\}.$$

CASE 2: If  $a = 0$  then

$$H_1 + \left\{ \frac{1}{b} - \delta \right\} I$$

is incrementally positive; in addition, if  $\Delta = 0$  then  $\bar{g}(H_1) < \infty$ .

Then  $E_1$  and  $E_2$  are input-output stable.

The proof is similar to that of Theorem 1a, and is omitted.

## 5. CONDITIONS INVOLVING POSITIVE RELATIONS

A special case of Theorem 2, of interest in the theory of passive networks, is obtained by, in effect, letting  $a = 0$  and  $b \rightarrow \infty$ . Both relations then become positive; also, one of the two relations becomes strongly positive, i.e.:

**DEFINITION:** A relation  $H$  in  $\mathbb{R}$  is strongly (incrementally) positive if, for some  $\sigma > 0$ , the relation  $(H - \sigma I)$  is (incrementally) positive.

The theorem, whose proof is in Appendix C, is:

**THEOREM 3:<sup>15</sup>** (a) [In eqs. (1)–(2)] If  $H_1$  and  $-H_2$  are positive, and if  $-H_2$  is strongly positive and has finite gain, then  $E_1$  and  $E_2$  are bounded. (b) If  $H_1$  and  $-H_2$  are incrementally positive, and if  $-H_2$  is strongly incrementally positive and has finite incremental gain, then  $E_1$  and  $E_2$  are input-output stable.

For example, if  $H_2$  on  $L_{2n}$  is instantaneously confined to a sector of the plane, then, under the provisions of Theorem 3, the sector of  $H_2$  lies in the first and third quadrants, and is bounded away from both axes.

### 5.1 Positivity and Passivity in Networks

A passive element is one that always absorbs energy. Is a network consisting of passive elements necessarily stable? An attempt will be made to answer this question for the special case of the circuit of Fig. 2.

First, an elaboration is given on what is meant by a

<sup>15</sup> A variation of this result was originally presented in [2d]. Kolodner [8] has obtained related results, with a restriction of linearity on one of the elements.

passive element. Consider an element having a current  $i$  and a voltage  $v$ ; the absorbed energy is the integral  $\int_0^t i(l)v(l)dl$ , and the condition for passivity is that this integral be non-negative. Now, let  $Z$  be a relation mapping  $i$  into  $v$ ; by analogy with the linear theory, it is natural to think of  $Z$  as an *impedance relation*; suppose  $Z$  is defined on  $L_{2e}$ , where the energy integral equals the inner product  $\langle i, v \rangle$ ; then passivity of the element is equivalent to positivity of  $Z$ . Similarly, if  $Y$  on  $L_{2e}$  is an admittance relation, which maps  $v$  into  $i$ , then passivity is equivalent to positivity of  $Y$ .

Now consider the circuit of Fig. 2. This circuit consists of an element characterized by an impedance relation  $Z_2$ , an element characterized by an admittance relation  $Y_1$ , a voltage source  $v$ , and a current source  $i$ . The equations of this circuit are,

$$v_1 = v + v_2 \quad (20a)$$

$$i_2 = i - i_1 \quad (20b)$$

$$v_2 = Z_2 i_2 \quad (21a)$$

$$i_1 = Y_1 v_1. \quad (21b)$$

It is observed that these equations have the same form as the Feedback Equations, provided that the sources  $i$  and  $v$  are constrained by the equations  $v = a_1 x + w_1$ , and  $i = a_2 x + w_2$ . (By letting  $a_1 = 0$  the familiar "parallel circuit" is obtained. Similarly, by letting  $a_2 = 0$  the "series circuit" is obtained.) Thus there is a correspondence between the feedback system and the network considered here. Corresponding to the closed loop relation  $E_1$  there is a voltage transfer relation mapping  $v$  into  $v_1$ . Similarly, corresponding to  $E_2$  there is a current transfer relation mapping  $i$  into  $i_2$ . If Theorem 3 is now applied to eqs. (20)–(21) it may be concluded that: *If both elements are passive, and if, in addition, the relation of one of the elements is strongly positive and has finite gain, then the network transfer relations are bounded.*

## 6. CONCLUSIONS

The main result here is Theorem 2. This theorem provides sufficient conditions for continuity and boundedness of the closed loop, without restricting the open loop to be linear or time invariant. Theorem 2 includes Theorems 1 and 3 as special cases. However, all three theorems are equivalent, in the sense that each can be derived from any of the others by a suitable transformation.

There are resemblances between Theorem 2 and Nyquist's Criterion. For example, consider the following, easily derived, limiting form of Theorem 2: "If  $H_2 = kI$  then a sufficient condition for boundedness of the closed loop is that  $H_1$  be bounded away from the critical value  $-(1/k)I$ , in the sense that

$$\left\| \left( H_1 x - \frac{1}{k} x \right)_t \right\| \geq \delta \|x\|_t$$

for all  $x$  in  $X_e$  and  $t$  in  $T$ , where  $\delta$  is an arbitrarily small

positive constant." In fact, the conic sectors defined here resemble the disk-shaped regions on a Nyquist chart. However, Theorem 2 differs from Nyquist's Criterion in two important respects: (1) Unlike Nyquist's Criterion, Theorem 2 is not necessary, which is hardly surprising, since bounds on  $H_1$  and  $H_2$  are assumed in place of a more detailed characterization. (2) Nyquist's criterion assesses stability from observation of only the eigenfunctions  $\exp(j\omega t)$ , where Theorem 2 involves *all* inputs in  $X_e$ .

There is also a resemblance between the use of the notions of gain and inner product as discussed here, and the use of attenuation and phase shift in the linear theory. A further discussion of this topic is postponed to Part II, where linear systems will be examined in some detail.

One of the broader implications of the theory developed here concerns the use of functional analysis for the study of poorly defined systems. It seems possible, from only coarse information about a system, and perhaps even without knowing details of internal structure, to make useful assessments of qualitative behavior.

## APPENDIX

### A. Proofs of Properties (i–vi)

**Properties (i, ii).** These two properties are immediately implied by the inequalities

$$\langle (Ix)_t - 1 \cdot x_t, (Ix)_t - 1 \cdot x_t \rangle = 0$$

$$\begin{aligned} \langle (cHx)_t - cax_t, (cHx)_t - cax_t \rangle \\ = c^2 \langle (Hx)_t - ax_t, (Hx)_t - ax_t \rangle \leq 0 \end{aligned}$$

in which  $c$  is a (positive or negative) real constant.

**Property (iii).** It is enough to show that  $(H + H_1)$  has center  $\frac{1}{2}(b + b_1 + a + a_1)$  and radius  $\frac{1}{2}(b + b_1 - a - a_1)$ ; the following inequalities establish this:

$$\begin{aligned} & \left\| \left[ (H + H_1)x \right]_t - \frac{1}{2}(b + b_1 + a + a_1)x_t \right\| \\ & \leq \left| (Hx)_t - \frac{1}{2}(b + a)x_t \right| \\ & \quad + \left| (H_1x)_t - \frac{1}{2}(b_1 + a_1)x_t \right| \quad (\text{Triangle Ineq.}) \quad (A1a) \end{aligned}$$

$$\begin{aligned} & \leq \frac{1}{2}(b - a)\|x_t\| + \frac{1}{2}(b_1 - a_1)\|x_t\| \\ & = \frac{1}{2}(b + b_1 - a - a_1)\|x_t\| \quad (A1b) \end{aligned}$$

where eq. (A1b) follows from eq. (A1a) since  $H$  has center  $\frac{1}{2}(b + a)$  and radius  $\frac{1}{2}(b - a)$ , and since  $H_1$  has center  $\frac{1}{2}(b_1 + a_1)$  and radius  $\frac{1}{2}(b_1 - a_1)$ .

#### Property (iv).

CASES 1a AND 1b: Here  $a \neq 0$  and  $b > 0$ , and

$$\begin{aligned} & \left\langle \left( H^{-1}x \right)_t - \frac{1}{b} x_t, \left( H^{-1}x \right)_t - \frac{1}{a} x_t \right\rangle \\ & = \left\langle y_t - \frac{1}{b} (Hy)_t, y_t - \frac{1}{a} (Hy)_t \right\rangle \\ & = \frac{1}{ab} \langle (Hy)_t - ay_t, (Hy)_t - by_t \rangle \end{aligned}$$

where  $H^{-1}x = y$  and  $x = Hy$ . Since, by hypothesis,  $H$  is inside  $\{a, b\}$  and  $b > 0$ , the sign of the last expression is opposite to that of  $a$ . Thus the Inverse Rule is obtained.

CASE 2: Here  $a = 0$ . The property is implied by the inequality,

$$\left\langle x_t, (H^{-1}x)_t - \frac{1}{b} x_t \right\rangle = \frac{1}{b} \langle (Hy)_t, b y_t - (Hy)_t \rangle \geq 0.$$

**Property (v).** Simply reverse all the inequality signs.

**Property (vi).**

$$\begin{aligned} \|(Hx)_t\| &\leq \|(Hx)_t - \frac{1}{2}(b+a)x_t\| \\ &\quad + \|\frac{1}{2}(b+a)x_t\| \quad (\text{Triangle Ineq.}) \quad (A2a) \\ &\leq \frac{1}{2}(b-a)\|x_t\| + \frac{1}{2}|b+a|\|x_t\| \quad (A2b) \\ &= \max(|a|, |b|) \cdot \|x_t\| \end{aligned}$$

where eq (A2b) follows from eq (A2a) since, from the hypothesis,  $H$  has center  $\frac{1}{2}(b+a)$  and radius  $\frac{1}{2}(b-a)$ . It follows that  $g(H) \leq \max(|a|, |b|)$ . Q.E.D.

### B. Proof of Theorem 2a

The proof is divided into three parts: (1) The transformation of Fig. 5 is carried out, giving a new relation  $E_2'$ ;  $E_2'$  is shown to contain  $E_2$ . (2) The new gain product is shown to be less than one. (3)  $E_2'$  is shown to be bounded, by Theorem 1; the boundedness of  $E_2$  and  $E_1$  follows.

Let  $c = \frac{1}{2}(b+a)$  and  $r = \frac{1}{2}(b-a)$ .

#### B.1 Transformation of Eqs. (1)-(2)

The proof will be worked backwards from the end; the equations of the transformed system of Fig. 5 are,

$$e_1' = w_1' + a_1'x + y_2' \quad (A3a)$$

$$e_2 = w_2 + a_2x + y_1 \quad (A3b)$$

$$y_2' = H_2'e_2 \quad (A4a)$$

$$y_1 = H_1'e_1' \quad (A4b)$$

where

$$H_2' = (H_2 + cI) \quad (A5a)$$

$$H_1' = (H_1^{-1} + cI)^{-1}. \quad (A5b)$$

(It may be observed that these equations have the same form as eqs. (1)-(2), but  $H_1$  is replaced by  $H_1'$  and  $H_2$  is replaced by  $H_2'$ .) Let  $E_2'$  be the closed-loop relation that consists of all pairs  $(x, e_2)$  satisfying eqs. (A3)-(A4). It shall now be shown that  $E_2'$  contains  $E_2$ , that is, that any solution of eqs. (1)-(2) is also a solution of eqs. (A3)-(A4); thus boundedness of  $E_2'$  will imply boundedness of  $E_2$ .

In greater detail

- (I) let  $(x, e_2)$  be any given element of  $E_2$ .
- (II) Let  $e_1, y_1, y_2, H_2e_1$ , and  $H_2e_2$  be fixed elements of  $X_e$  that satisfy eqs. (1)-(2) simultaneously with  $x$  and  $e_2$ .

(III) (Using Fig. 5 as a guide,) define two new elements of  $X_e$ ,

$$y_2' = y_2 + ce_2 \quad (A6a)$$

$$e_1' = e_1 + cy_1. \quad (A6b)$$

It shall now be shown that there are elements  $H_1'e_1'$  and  $H_2'e_2'$  in  $X_e$  that satisfy eqs. (A3)-(A4) simultaneously with the elements defined in (I)-(III). Taking eqs. (A3)-(A4) one at a time:

**Equation (A3a).** Substituting eq. (1a) for  $e_1$  in eq. (A6b), and eq. (1b) for  $y_1$ ,

$$e_1' = (w_1 - cw_2) + (a_1 - ca_2)x + (y_2 + ce_2). \quad (A7)$$

If  $w_1' = w_1 - cw_2$  and  $a_1' = a_1 - ca_2$ , then, with the aid of eq. (A6a), eq. (A7) reduces to eq. (A3a).

**Equation (A3b):** This is merely eq. (1b), repeated.

**Equation (A4a):** Recalling that  $H_2' = H_2 + cI$ , it follows, from eqs. (A6a) and (2a), that there is an  $H_2'e_2$  in  $X_e$  for which eq. (A4a) holds.

**Equation (A4b):** If eq. (A6b) is substituted for  $e_1$  in eq. (2b), it is found that there exists  $H_1(e_1' - cy_1)$  in  $X_e$  such that  $y_1 = H_1(e_1' - cy_1)$ . Therefore,

$$\text{(after inversion)} \quad H_1^{-1}y_1 = e_1' - cy_1$$

$$\text{(after rearrangement)} \quad (H_1^{-1} + cI)y_1 = e_1'$$

$$\text{(after inversion)} \quad y_1 = (H_1^{-1} + cI)^{-1}e_1'.$$

That is, there exists  $H_1'e_1'$  in  $X_e$  for which eq. (A4b) holds. Since eqs. (A3)-(A4) are all satisfied,  $(x, e_2)$  is in  $E_2'$ . Since  $(x, e_2)$  is an arbitrary element of  $E_2$ ,  $E_2'$  contains  $E_2$ .

#### B.2 Boundedness of $E_2'$

It will be shown that  $g(H_1') \cdot g(H_2') < 1$ .

**The Case  $\Delta > 0, \delta = 0$ :**  $g(H_2')$  will be bounded first. Since  $H_2$  is in  $\{-b+\Delta, -a-\Delta\}$  by hypothesis,  $(H_2+cI)$  is in  $\{-b+\Delta+c, -a-\Delta+c\}$  by the Sum Rule of Section 4.2. Observing that  $(H_2+cI) = H_2'$ , that  $(-b+c) = -r$ , and that  $(-a+c) = r$ , it is concluded that  $H_2'$  is in  $\{-r+\Delta, r-\Delta\}$ . Therefore  $g(H_2') \leq r-\Delta$ .

Next,  $g(H_1')$  will be bounded. In Case 1a, where  $a > 0$  and  $H_1$  is outside

$$\left\{ -\frac{1}{a}, -\frac{1}{b} \right\},$$

the Inverse Rule of Section 4.2 implies that  $H_1^{-1}$  is outside  $\{-b, -a\}$ ; the same result is obtained in Cases 1b and 2. In all cases, therefore, the Sum Rule implies that  $(H_1^{-1}+cI)$  is outside  $\{-r, r\}$ . By the Inverse Rule again,  $(H_1^{-1}+cI)^{-1}$  is in

$$\left\{ -\frac{1}{r}, \frac{1}{r} \right\}.$$

Therefore  $g(H_1') \leq 1/r$ .

Finally,

$$g(H_1') \cdot g(H_2') \leq \frac{r-\Delta}{r} < 1.$$

**The Case  $\Delta=0, \delta>0$ :** It shall be shown that this is a special case of the case  $\Delta>0, \delta=0$ . In other words, it will be shown that there are real constants  $a^*, b^*$ , and  $\Delta^*$  for which the conditions of the case  $\Delta>0, \delta=0$  are fulfilled, but with  $a$  replaced by  $a^*$ ,  $b$  by  $b^*$ , and  $\Delta$  by  $\Delta^*$ .

Consider Case 1a, in which  $a>0$ . (Cases 1b and 2 have similar proofs, which will be omitted.) It must be shown that: (1)  $-H_2$  is in  $\{a^*+\Delta, b^*-\Delta\}$ . (2)  $H_1$  is outside

$$\left\{ -\frac{1}{a^*}, \frac{1}{b^*} \right\}.$$

Without loss of generality it can be assumed that  $\delta$  is smaller than either  $1/a$  or  $1/b$ . Choose  $a^*$  and  $b^*$  in the ranges

$$\frac{a}{1+a\delta} < a^* < a \quad \text{and} \quad b < b^* < \frac{b}{1-b\delta}.$$

Since  $-H_2$  is in  $\{a, b\}$  by hypothesis, and since  $a^* < a$  and  $b^* > b$  by construction, there must be a  $\Delta^*>0$  such that  $H_2$  satisfies condition (1). Since  $H_1$  is outside

$$\left\{ -\frac{1}{a} - \delta, -\frac{1}{b} + \delta \right\}$$

by hypothesis, and since by construction

$$-\frac{1}{a^*} > -\frac{1}{a} - \delta \quad \text{and} \quad -\frac{1}{b^*} < -\frac{1}{b} + \delta,$$

condition (2) is satisfied. Hence this is, indeed, a special case of the previous one.

#### B.3 Conclusion of the Proof

Since  $g(H_1') \cdot g(H_2') < 1$ ,  $E_2'$  is bounded by Theorem 1, and so is  $E_2$ , which is contained in  $E_2'$ . Moreover, the boundedness of  $E_2$  implies the boundedness of  $E_1$ ; for, if  $(x, e_1)$  is in  $E_1$  and  $(x, e_2)$  is in  $E_2$ , then

$$\|e_1\| \leq \|w_1\| + |a_1| \cdot \|x\| + g(H_2)\|e_2\|. \quad (A8)$$

Thus, if  $\|x\| \leq \text{const.}$  and  $\|e_2\| \leq \text{const.}$ , then  $\|e_1\| \leq \text{const.}$  (Inequality (A8) was obtained by applying the Triangle Inequality and Inequality (4) to eq. (1a), and taking the limit as  $t \rightarrow \infty$ . It may be noted that  $g(H_2) < \infty$ , since  $-H_2$  is in  $\{a, b\}$  by hypothesis.) Q.E.D.

### C. Proof of Theorem 2

This shall be reduced to a special case of Theorem 2 [Case 2 with  $\delta=0$ ]. In particular, it shall be shown that there are constants  $b>0$  and  $\Delta>0$  for which (I)  $-H_2$  is inside  $\{\Delta, b-\Delta\}$ , and, (II) the relation  $|H_1+(1/b)I|$  is positive.

$|H_1+(1/b)I|$  is clearly positive for any  $b>0$ , since by hypothesis  $H_2$  is positive; the second condition is therefore satisfied. To prove the first condition it is enough to show that  $H_2$  is conic with center  $-r$  and radius  $r-\Delta$ , where  $r=b/2$ . This is shown as follows: The hypothesis implies that, for some constant  $\sigma>0$  and for any constant  $\lambda>g(H_2)$ , the following inequalities are true

$$-\langle x_t, (H_2 x_t) \rangle \geq \sigma \|x_t\|^2 \quad (A9)$$

$$\|(H_2 x_t)\|^2 \leq \lambda^2 \|x_t\|^2 \quad (A10)$$

for any  $x$  in  $X_t$  and for any  $t$  in  $T$ . Hence, for any  $r>0$ ,

$$\|(H_2 x_t)_t + r x_t\|^2 \leq (\lambda^2 - 2\sigma r + r^2) \|x_t\|^2. \quad (A11)$$

Equation (A11) was obtained by expanding the square on its l.h.s., and applying eqs. (A9) and (A10). Constants  $\lambda, r$ , and  $\Delta$ , are selected so that  $\lambda>\sigma, r=\lambda/\sigma$ , and  $\Delta=r[1-\sqrt{1-(\sigma/\lambda)^2}]$ . Now it can be verified that, for this choice of constants, the term  $(\lambda^2 - 2\sigma r + r^2)$  in eq. (A11) equals  $(r-\Delta)^2$ ; also,  $0 < \Delta < r$  since  $(\sigma/\lambda) < 1$ ; therefore eq. (A11) implies that  $H_2$  is conic with center  $-r$  and radius  $r-\Delta$ . Q.E.D.

## ACKNOWLEDGMENT

The author thanks Dr. P. Falb for carefully reading the draft of this paper, and for making a number of valuable suggestions concerning its arrangement and concerning the mathematical formulation.

## REFERENCES

- [1] V. M. Popov, "Absolute stability of nonlinear systems of automatic control," *Automation and Remote Control*, pp. 857-875, March 1962. (Russian original in August 1961.)
- [2] (a) G. Zames, "Conservation of bandwidth in nonlinear operations," M.I.T. Res. Lab. of Electronics, Cambridge, Mass., Quarterly Progress Rept. 55, pp. 98-109, October 15, 1959.  
(b) —, "Nonlinear operators for system analysis," M.I.T. Res. Lab. of Electronics, Tech. Rept. 370, September 1960.  
(c) —, "Functional analysis applied to nonlinear feedback systems," *IEEE Trans. on Circuit Theory*, vol. CT-10, pp. 392-404, September 1963.  
(d) —, "On the stability of nonlinear, time-varying feedback systems," *Proc. NEC*, vol. 20, pp. 725-730, October 1964.  
(e) —, "Contracting transformations: A theory of stability and iteration for nonlinear, time-varying systems," *Summaries, 1964 Internat'l Conf. on Microwaves, Circuit Theory, and Information Theory*, pp. 121-122.  
(f) —, "Nonlinear time varying feedback systems—Conditions for  $L_\infty$ -boundedness derived using conic operators on exponentially weighted spaces," *Proc. 1965 Allerton Conf.*, pp. 460-471.
- [3] K. S. Narendra and R. M. Goldwyn, "A geometrical criterion for the stability of certain nonlinear nonautonomous systems," *IEEE Trans. on Circuit Theory (Correspondence)*, vol. CT-11, pp. 406-408, September 1964.
- [4] R. W. Brockett and J. W. Willems, "Frequency domain stability criteria," pts. 1 and II, 1965 *Proc. Joint Automatic Control Conf.*, pp. 735-747.
- [5] (a) I. W. Sandberg, "On the properties of some systems that distort signals," *Bell Sys. Tech. J.*, vol. 42, p. 2033, September 1963, and vol. 43, pp. 91-112, January 1964.  
(b) —, "On the  $L_\infty$ -boundedness of solutions of nonlinear functional equations," *Bell Sys. Tech. J.*, vol. 43, pt. II, pp. 1581-1599, July 1964.
- [6] J. Kudrewicz, "Stability of nonlinear feedback systems," *Automatyka i Telemechanika*, vol. 25, no. 8, 1964 (and other papers).
- [7] E. H. Zaronantello, "Solving functional equations by contractive averaging," U. S. Army Math. Res. Ctr., Madison, Wis. Tech. Summary Rept. 160, 1960.
- [8] I. I. Kolodner, "Contractive methods for the Hammerstein equation in Hilbert spaces," University of New Mexico, Albuquerque, Tech. Rept. 35, July 1963.
- [9] G. J. Minty, "On nonlinear integral equations of the Hammerstein type," survey appearing in *Nonlinear Integral Equations*, P. M. Anselone, Ed. Madison, Wis.: University Press, 1964, pp. 99-154.
- [10] F. E. Browder, "The solvability of nonlinear functional equations," *Duke Math. J.*, vol. 30, pp. 557-566, 1963.
- [11] J. J. Bongiorno, Jr., "An extension of the Nyquist-Barkhausen stability criterion to linear lumped-parameter systems with time-varying elements," *IEEE Trans. on Automatic Control (Correspondence)*, vol. AC-8, pp. 166-170, April 1963.
- [12] A. N. Kolmogorov and S. V. Fomin, *Functional Analysis*, vols. I and II. New York: Graylock Press, 1957.