---
title: "Lecture 4 — Hidden Markov Models"
course: "Machine Learning 2/2-X (SoSe 2026)"
instructor: "Klaus-Robert Müller"
source: lecture
ingested: 2026-05-07
sha256: 9e89c1190dab81d86195b45b5c69df8b295f2ff9e0f5cb0039f1a5753d206e30
conversion: pymupdf4llm
---

SoSe 2026 

**==> picture [27 x 23] intentionally omitted <==**

Machine Learning 2/2-X 

**==> picture [63 x 35] intentionally omitted <==**

**==> picture [22 x 96] intentionally omitted <==**

**==> picture [219 x 96] intentionally omitted <==**

**==> picture [109 x 96] intentionally omitted <==**

Lecture 4 Hidden Markov Models 

## **Introduction** 

**==> picture [117 x 116] intentionally omitted <==**

World is represented by a vector of variables governed by a probability function 

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

## **Introduction** 

**==> picture [117 x 116] intentionally omitted <==**

World is represented by a vector of variables 

governed by a probability function 

Goal: learn from a few observations a model         that that is close to the true probability function 

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

## **Example: caltech101 silhouettes** 

**==> picture [131 x 130] intentionally omitted <==**

Each image consists of 28x28 pixels either black or white.   There are 228x28 possible images. 

Question: can we simply estimate the frequency of each of these possible images? 

Answer: Unfeasible, because data (and memory) are *nite. 

Therefore, we need to impose a structure to our probability function. 

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

## **What Kind of Structure?** 

nearby pixel activities distant pixel activities are strongly dependent are less dependent 

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

**==> picture [172 x 115] intentionally omitted <==**

## **What Kind of Structure?** 

Dependence over l t to keep track of (e.g. chaotic systems). 

successive posititions depedent 

**==> picture [114 x 113] intentionally omitted <==**

http://rocs.hu-berlin.de/explorables/explorables/double-trouble/ 

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

## **Directed Graphical Models** 

Pictorial way of representing independence assumptions in the data. Each graphical model can be mapped to a given distribution. 

**==> picture [230 x 129] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

## **Factored models of probabilities** 

Example: Markov Chain 

Number of parameters kept low by imposing the Markov propertyand stationarity. 

We can sample from the model in a forward pass. Learning algorithm: parameters are the transition counts obtained from the data. 

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

## **Discrete Markov Process** 

**==> picture [268 x 28] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

**==> picture [192 x 182] intentionally omitted <==**

Source: L. Rabiner. A Tutorial on HMMs (1989). 

9/42 

## **Discrete Markov Process** 

**==> picture [120 x 113] intentionally omitted <==**

**==> picture [188 x 11] intentionally omitted <==**

**==> picture [170 x 38] intentionally omitted <==**

**==> picture [267 x 60] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

Source: L. Rabiner. A Tutorial on HMMs (1989). 

10/42 

## **Discrete Markov Process: Example** 

**==> picture [111 x 41] intentionally omitted <==**

**==> picture [136 x 58] intentionally omitted <==**

**==> picture [267 x 85] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

11/42 

Source: L. Rabiner. A Tutorial on HMMs (1989). 

## **Discrete Markov Process: Example** 

**==> picture [111 x 41] intentionally omitted <==**

**==> picture [136 x 58] intentionally omitted <==**

**==> picture [254 x 77] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

Source: L. Rabiner. A Tutorial on HMMs (1989). 

12/42 

## **Extension for Hidden Markov Models** 

**==> picture [268 x 73] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

13/42 

Source: L. Rabiner. A Tutorial on HMMs (1989). 

## **Elements of an Hidden Markov Model** 

**==> picture [253 x 13] intentionally omitted <==**

**==> picture [253 x 46] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [255 x 42] intentionally omitted <==**

**==> picture [256 x 65] intentionally omitted <==**

**==> picture [248 x 34] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

Source: L. Rabiner. A Tutorial on HMMs (1989). 

14/42 

## **Generating with an HMM** 

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [276 x 197] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

Source: L. Rabiner. A Tutorial on HMMs (1989). 

15/42 

## **Parameters of an HMM** 

**==> picture [268 x 111] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

16/42 

Source: L. Rabiner. A Tutorial on HMMs (1989). 

## **Three Basic Problems for HMMs** 

**==> picture [257 x 161] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

Source: L. Rabiner. A Tutorial on HMMs (1989). 

17/42 

## **Solution of Problem 1** 

**==> picture [269 x 157] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

Source: L. Rabiner. A Tutorial on HMMs (1989). 

18/42 

## **Solution of Problem 1** 

**==> picture [266 x 101] intentionally omitted <==**

**==> picture [187 x 48] intentionally omitted <==**

**==> picture [86 x 16] intentionally omitted <==**

**==> picture [199 x 12] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

Source: L. Rabiner. A Tutorial on HMMs (1989). 

19/42 

## **Solution of Problem 1** 

**==> picture [266 x 35] intentionally omitted <==**

**==> picture [266 x 87] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

20/42 

Source: L. Rabiner. A Tutorial on HMMs (1989). 

## **Solution of Problem 1** 

**==> picture [266 x 18] intentionally omitted <==**

**==> picture [245 x 161] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

Source: L. Rabiner. A Tutorial on HMMs (1989). 

21/42 

## **Solution of Problem 1** 

**==> picture [245 x 50] intentionally omitted <==**

**==> picture [125 x 115] intentionally omitted <==**

**==> picture [266 x 25] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

Source: L. Rabiner. A Tutorial on HMMs (1989). 

22/42 

## **Three Basic Problems for HMMs** 

**==> picture [257 x 161] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

Source: L. Rabiner. A Tutorial on HMMs (1989). 

23/42 

## **Solution of Problem 2** 

**==> picture [266 x 80] intentionally omitted <==**

**==> picture [265 x 40] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

24/42 

Source: L. Rabiner. A Tutorial on HMMs (1989). 

## **Solution of Problem 2** 

**==> picture [266 x 27] intentionally omitted <==**

**==> picture [232 x 33] intentionally omitted <==**

**==> picture [232 x 59] intentionally omitted <==**

**==> picture [227 x 42] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

Source: L. Rabiner. A Tutorial on HMMs (1989). 

25/42 

## **Solution of Problem 2** 

**==> picture [232 x 59] intentionally omitted <==**

**add pointers to recover the most likely sequence.** 

**==> picture [95 x 24] intentionally omitted <==**

**==> picture [232 x 39] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

Source: L. Rabiner. A Tutorial on HMMs (1989). 

26/42 

## **Three Basic Problems for HMMs** 

**==> picture [257 x 161] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

Source: L. Rabiner. A Tutorial on HMMs (1989). 

27/42 

## **Solution of Problem 3** 

**==> picture [62 x 12] intentionally omitted <==**

**==> picture [36 x 11] intentionally omitted <==**

**==> picture [84 x 13] intentionally omitted <==**

**==> picture [58 x 11] intentionally omitted <==**

**==> picture [124 x 14] intentionally omitted <==**

**==> picture [107 x 19] intentionally omitted <==**

**==> picture [160 x 19] intentionally omitted <==**

**==> picture [14 x 16] intentionally omitted <==**

**==> picture [31 x 15] intentionally omitted <==**

**==> picture [58 x 55] intentionally omitted <==**

**==> picture [15 x 18] intentionally omitted <==**

**==> picture [67 x 66] intentionally omitted <==**

**==> picture [26 x 22] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

Source: L. Rabiner. A Tutorial on HMMs (1989). 

28/42 

## **Solution of Problem 3** 

**==> picture [62 x 12] intentionally omitted <==**

**==> picture [37 x 11] intentionally omitted <==**

**==> picture [84 x 13] intentionally omitted <==**

**==> picture [58 x 11] intentionally omitted <==**

**==> picture [124 x 14] intentionally omitted <==**

**how to compute it?** 

**==> picture [107 x 19] intentionally omitted <==**

**==> picture [160 x 19] intentionally omitted <==**

**==> picture [14 x 16] intentionally omitted <==**

**==> picture [31 x 15] intentionally omitted <==**

**==> picture [58 x 55] intentionally omitted <==**

**==> picture [15 x 18] intentionally omitted <==**

**==> picture [67 x 66] intentionally omitted <==**

**==> picture [26 x 22] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

Source: L. Rabiner. A Tutorial on HMMs (1989). 

29/42 

## **Solution of Problem 3** 

**==> picture [107 x 19] intentionally omitted <==**

**==> picture [64 x 12] intentionally omitted <==**

**==> picture [19 x 11] intentionally omitted <==**

**==> picture [128 x 46] intentionally omitted <==**

**==> picture [23 x 11] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [168 x 18] intentionally omitted <==**

**==> picture [180 x 22] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

Source: L. Rabiner. A Tutorial on HMMs (1989). 

**==> picture [79 x 13] intentionally omitted <==**

**==> picture [81 x 12] intentionally omitted <==**

30/42 

## **The Forward-Backward Model** 

**==> picture [79 x 13] intentionally omitted <==**

**==> picture [245 x 53] intentionally omitted <==**

**==> picture [82 x 12] intentionally omitted <==**

**==> picture [269 x 54] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

Source: L. Rabiner. A Tutorial on HMMs (1989). 

31/42 

## **Solution of Problem 3** 

**==> picture [62 x 13] intentionally omitted <==**

**==> picture [37 x 11] intentionally omitted <==**

**==> picture [84 x 13] intentionally omitted <==**

**==> picture [58 x 11] intentionally omitted <==**

**==> picture [124 x 14] intentionally omitted <==**

**==> picture [107 x 19] intentionally omitted <==**

**==> picture [160 x 19] intentionally omitted <==**

**==> picture [14 x 16] intentionally omitted <==**

**==> picture [31 x 15] intentionally omitted <==**

**==> picture [58 x 55] intentionally omitted <==**

**==> picture [15 x 18] intentionally omitted <==**

**==> picture [67 x 66] intentionally omitted <==**

**==> picture [26 x 22] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

Source: L. Rabiner. A Tutorial on HMMs (1989). 

32/42 

## **Solution of Problem 3** 

**==> picture [62 x 13] intentionally omitted <==**

**==> picture [37 x 11] intentionally omitted <==**

**==> picture [84 x 13] intentionally omitted <==**

**==> picture [58 x 11] intentionally omitted <==**

**==> picture [155 x 163] intentionally omitted <==**

**----- Start of picture text -----**<br>
Is it optimal?<br>**----- End of picture text -----**<br>


**==> picture [124 x 14] intentionally omitted <==**

**==> picture [107 x 19] intentionally omitted <==**

**==> picture [160 x 19] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

Source: L. Rabiner. A Tutorial on HMMs (1989). 

33/42 

## **Solution of Problem 3** 

**==> picture [48 x 37] intentionally omitted <==**

**==> picture [8 x 7] intentionally omitted <==**

**----- Start of picture text -----**<br>
A<br>**----- End of picture text -----**<br>


**==> picture [59 x 42] intentionally omitted <==**

**==> picture [66 x 39] intentionally omitted <==**

**==> picture [8 x 7] intentionally omitted <==**

**----- Start of picture text -----**<br>
B<br>**----- End of picture text -----**<br>


**==> picture [13 x 17] intentionally omitted <==**

**==> picture [14 x 15] intentionally omitted <==**

**==> picture [48 x 45] intentionally omitted <==**

**==> picture [29 x 13] intentionally omitted <==**

**==> picture [51 x 50] intentionally omitted <==**

**==> picture [19 x 16] intentionally omitted <==**

**==> picture [268 x 62] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

Source: L. Rabiner. A Tutorial on HMMs (1989). 

34/42 

## **Beyond HMMs** 

- HMMs are directed graphical models that match prior knowledge about the modeled task (latent states generates observations, current latent state generates next latent state). 

- For more general models, the causality may be unknown. Setting the causality wrong may introduce a modeling bias. 

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

35/42 

# **Conditional Independence** 

**==> picture [289 x 136] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

## **Reversing Causality** 

**==> picture [293 x 135] intentionally omitted <==**

Variables a and b are no longer conditionally dependent. This effect is called “explaining away”. 

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

## **Removing Causality** 

**==> picture [121 x 103] intentionally omitted <==**

Probabilities are replaced by more general potential functions. We introduce a normalization term _Z_ . 

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

## **Examples of Undirected Models** 

Gaussian Distribution: 

**==> picture [94 x 85] intentionally omitted <==**

**==> picture [60 x 51] intentionally omitted <==**

**==> picture [146 x 109] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

## **Examples of Undirected Models** 

Boltzmann Machine: 

**==> picture [94 x 85] intentionally omitted <==**

Like for the Gaussian distribution, the model is composed of pairwise interactions. Normalization term is hard to evaluate, however, it remains easy to compute conditional probabilities. 

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

## **Examples of Undirected Models** 

**==> picture [94 x 84] intentionally omitted <==**

## Conditional probabilities 

**==> picture [283 x 99] intentionally omitted <==**

## **Directed vs. Undirected Models** 

**==> picture [323 x 131] intentionally omitted <==**

**==> picture [24 x 20] intentionally omitted <==**

**==> picture [20 x 17] intentionally omitted <==**

42/42 

Source: C. Sutton. An Introduction to CRFs (2011). 

