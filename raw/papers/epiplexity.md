---
source_url: https://arxiv.org/abs/2601.03220
ingested: 2026-04-29
sha256: ae74760628bdda9d8355dd03ffa7a5255fa45ab14e9360084b978cf069fd6fe0
---

# **From Entropy to Epiplexity: Rethinking Information for Computationally Bounded Intelligence** 

**Marc Finzi** _[∗]_[1] **Shikai Qiu** _[∗]_[2] **Yiding Jiang** _[∗]_[1] **Pavel Izmailov**[2] **J. Zico Kolter**[1] **Andrew Gordon Wilson**[2] 

> 1Carnegie Mellon University 

> 2New York University 

## **Abstract** 

Can we learn more from data than existed in the generating process itself? Can new and useful information be constructed from merely applying deterministic transformations to existing data? Can the learnable content in data be evaluated without considering a downstream task? On these questions, Shannon information and Kolmogorov complexity come up nearly empty-handed, in part because they assume observers with unlimited computational capacity and do not target the useful information content. In this work, we identify and exemplify three seeming paradoxes in information theory: (1) information cannot be increased by deterministic transformations; (2) information is independent of the order of data; (3) likelihood modeling is merely distribution matching. To shed light on the tension between these results and modern practice, and to quantify the value of data, we introduce _epiplexity[†]_ , a formalization of information capturing what computationally bounded observers can learn from data. Epiplexity captures the structural content in data while excluding time-bounded entropy, the random unpredictable content exemplified by pseudorandom number generators and chaotic dynamical systems. With these concepts, we demonstrate how information can be created with computation, how it depends on the ordering of the data, and how likelihood modeling can produce more complex programs than present in the data generating process itself. We also present practical procedures to estimate epiplexity which we show capture differences across data sources, track with downstream performance, and highlight dataset interventions that improve out-of-distribution generalization. In contrast to principles of model selection, epiplexity provides a theoretical foundation for _data selection_ , guiding how to select, generate, or transform data for learning systems. 

## **1 Introduction** 

As AI research progresses towards more general-purpose intelligent systems, cracks are beginning to show in mechanisms for grounding mathematical intuitions. Much of learning theory is built around controlling generalization error with respect to a given distribution, treating the training distribution as fixed and focusing optimization effort on the choice of model. Yet modern systems are expected to transfer across tasks, domains, and objectives that were not specified at training time, often after large-scale pretraining on diverse and heterogeneous data. In this regime, success or failure frequently hinges less on architectural choices than on what data the model was exposed to in the first place. Pursuing broad generalization to diverse out-of-distribution tasks forces a shift in perspective: instead of treating data as given and optimizing for in-distribution performance, we need to choose and curate data to facilitate generalization to unseen tasks. This shift makes the value of data itself a central question—how much usable, transferable information can a model acquire from training? In other words, instead of model selection, how do we perform _data selection_ ? On this question, existing theory offers little guidance and often naively contradicts empirical observations. 

> *Equal contribution. 

> †Code available at `https://github.com/shikaiqiu/epiplexity` . 

1 

**==> picture [427 x 201] intentionally omitted <==**

**----- Start of picture text -----**<br>
Random vs structural information Information can be created by computation<br>Low random info, low structural info<br>Computation<br>def is_even(n):<br>if n == 0: return True<br>elif n == 1: return False<br>elif n == 2: return True<br>elif n == 3: return False<br>elif n == 4: return True<br>elif... n == 5: return False Entropy Apparent<br>Initial Randomness<br>def dijkstra(g, Moderate random info, high structural info s): Epiplexity Condition DeterministicDynamics EmergentStructure<br>D = defaultdict(lambda:float('inf'))<br>D[s] = 0; q = [(0, s)]<br>while q:<br>dif, du === popD[u(]:q) Structural information   OOD generalization<br>for v, w in g.get(u, []):<br>if (nd := d + w) < D[v]:<br>D[v] = nd; push(q, (nd, v)) Entropy Entropy<br>return D OOD performance<br>High random info, low structural info Epiplexity<br>API_KEYUSER_IDBUCKET ==="s3://data-8a3f1b-west-prod""sk_7aF2jK1ycP9LmvYzz34""usr_4f8a2c1e9b7d3065" shared circuits,Reuse<br>SAVE_DIRSAVE_CKPTDEBUG = False=="/mnt/marc/exp_7f2a/ckpts"True Epiplexity subprograms,...<br>SEED = 9284715<br>...<br>**----- End of picture text -----**<br>


Figure 1: **Random vs structural information for computationally bounded observers.** ( **Left** ) Illustration of random vs structural information of different data for computationally bounded observers, which we formalize with time-bounded entropy and epiplexity (Section 3) and can be estimated from loss curves of neural networks trained on that data (Section 4). ( **Top Right** ) Unlike other forms of information, time-bounded entropy and epiplexity can be increased through computational processes, such as simulating dynamical systems (cellular automation, Lorenz equations) and interventions like changing the data ordering, which can produce apparent randomness but also learnable, emergent structures like gliders and the Lorenz attractor invariant measure (Section 5). ( **Bottom Right** ) Whereas time-bounded entropy captures the in-distribution randomness and unpredictability, epiplexity measures the amount of structural information the model extracts from the data to its weights, which can be useful for OOD tasks such as by reusing learned circuits shared between the in-distribution and OOD tasks. 

Consider synthetic data, crucial for further developing model capabilities (Abdin et al., 2024; Maini et al., 2024) when existing natural data are exhausted. Existing concepts in information theory like the data processing inequality appear to suggest that synthetic data adds no additional value. Questions about what information is transferred to a given model seem naturally within the purview of information theory, yet, quantifying this information with existing tools proves to be elusive. Even basic questions, such as the source of the information in the weights of an AlphaZero game-playing model (Silver et al., 2018), are surprisingly tricky to answer. AlphaZero takes in zero human data, learning merely from the deterministic rules of the game and the AlphaZero RL algorithm, both of which are simple to describe. Yet the resulting models achieve superhuman performance and are large in size. To assert that AlphaZero has learned little to no information in this process is clearly missing the mark, and yet both Shannon and algorithmic information theory appear to say so. 

In this paper, we argue that the amount of structural information a _computationally bounded_ observer can extract from a dataset is a fundamental concept that underlies many observed empirical phenomena. As we will show, existing notions from Shannon and algorithmic information theory are inadequate when forced to quantify this type of information. These frameworks often lend intuitive or mathematical support to beliefs that, in fact, obscure important aspects of empirical phenomena. To highlight the limitations of classical frameworks and motivate the role of computational constraints in quantifying information, we identify and demonstrate three _apparent paradoxes_ : statements which can be justified mathematically by Shannon and algorithmic information theory, and yet are in tension with intuitions and empirical phenomena. 

2 

- Paradox 1: **Information cannot be increased by deterministic processes.** For both Shannon entropy and Kolmogorov complexity, deterministic transformations cannot meaningfully increase the information content of an object. And yet, we use pseudorandom number generators to produce randomness, synthetic data improves model capabilities, mathematicians can derive new knowledge by reasoning from axioms without external information, dynamical systems produce emergent phenomena, and self-play loops like AlphaZero learn sophisticated strategies from games (Silver et al., 2018). 

- Paradox 2: **Information is independent of factorization order.** A property of both Shannon entropy and Kolmogorov complexity is that total information content is invariant to factorization: the information from observing first _X_ and then _Y_ is the same as observing _Y_ followed by _X_ . On the other hand, LLMs learn better on English text ordered left-to-right than reverse ordered text, picking out an “ _arrow of time_ ” (Papadopoulos et al., 2024; Bengio et al., 2019), and we have cryptography built on the existence of functions that are computationally hard to predict in one direction and easy in another. 

- Paradox 3: **Likelihood modeling is merely distribution matching.** Maximizing the likelihood is often equated with matching the training data generating process: the true data-generating process is a perfect model of itself, and no model can achieve a higher expected likelihood. As a consequence, it is often assumed that a model trained on a dataset cannot extract more structure or learn useful features that were not used in generating the data. However, we show that a computationally-limited observer can in fact uncover much more structure than is in the data generating process. For example, in Conway’s game of life the data are generated via simple programmatic rules that operate on two-dimensional arrays of bits. Applying these simple rules sequentially, we see emergent structures, such as different species of objects that move and interact in a predictable way. While an unbounded observer can simply simulate the evolution of the environment exactly, a computationally bounded observer would make use of the emergent structures and learn the different types of objects and their behaviors. 

The tension between these theoretical statements and empirical phenomena can be resolved by imposing computational constraints on the observer and separating the random content from the structural content. Drawing on ideas from cryptography, algorithmic information theory, and these unexplained empirical phenomena, we define a new information measure, **epiplexity** (epistemic complexity), which formally defines the amount of structural information that a computationally bounded observer can extract from the data (Section 3, Definition 8). Briefly, epiplexity is the information in the model that minimizes the description length of data under computational constraints. A simple heuristic measurement is the area under the loss curve above the final loss, while a more rigorous approach uses the cumulative KL divergence between a teacher and student model (Section 4, Figure 2). 

Our definitions capture the intuition that an object contains both random, inherently unpredictable information (entropy), and predictable structured information that enables observers to generalize by identifying patterns (epiplexity). In Figure 1 (left) we illustrate this divide. In the top row, we have highly redundant and repetitive code and simple color gradients, which have little information content, be it structural or random. In the middle row, we have the inner workings of an algorithm and pictures of animals, showing complex, long-range interdependencies between the elements from which a model can learn complex features and subcircuits that are helpful even for different tasks. In contrast, on the bottom, we have random data with little structure: configuration files with randomly generated API keys, file paths, hashes, arbitrary boolean flags have negligible learnable content and no long-range dependencies or complex circuits that result from learning on this task. Similarly, uniformly shuffled pixels from the animal pictures have high entropy but are fundamentally unpredictable, and no complex features or circuits arise from training on these data. 

3 

An essential property of our formulation is that information is _observer dependent_ : the same object may appear random or structured depending on the computational resources of the observer. For instance, the output of a strong pseudorandom generator appears indistinguishable from true randomness to any polynomial-time observer lacking the secret key (seed), regardless of the algorithm or function class. In other situations, such as chaotic dynamical systems, both apparently random behavior is produced along with structure: the state of the system cannot be predicted precisely over long time-scales, but such observers may still learn meaningful predictive distributions, as shown by the invariant measure in Figure 1 (top right). 

Models trained to represent these distributions are computer programs, and substructures within these programs, like circuits for performing specific tasks, or induction heads (Olsson et al., 2022), can be reused even for seemingly unrelated data. This view motivates selecting high epiplexity data that induces more structural information in the model, since these structures can then be reused for unseen out-of-distribution (OOD) tasks, as illustrated in Figure 1 (bottom right). We emphasize, however, that epiplexity is a measure of information, _not_ a guarantee of OOD generalization to specific tasks. Epiplexity quantifies the amount of structural information a model extracts, while being agnostic to whether these structures are relevant to a _specific_ downstream task. 

To build intuition, we explore a range of phenomena and provide experimental evidence for behaviours that are poorly accounted for by existing information-theoretic tools, yet naturally accommodated by epiplexity. We show that information _can_ be created purely through computation, giving insights into synthetic data (subsection 5.1). We examine how certain factorizations of the same data can increase structural information and downstream OOD performance—even as they result in worse training loss (subsection 5.2). We show why likelihood modeling is more than distribution matching, identifying induction and emergence as two settings where the observer can learn more information than was present in the data generating process (subsection 5.3). By measuring epiplexity, we can better understand why pre-training on text data transfers more broadly than image data, and why certain data selection strategies for LLMs are empirically successful (Section 6). Together, our results provide clarity on the motivating questions: the information content of data can be compared independently of a specific task, new information can be created by computation, and models can learn more information than their generating processes contain. In short, we identify a disparity between existing concepts in information theory and modern practice, embodied by three apparent paradoxes, and introduce epiplexity as a measurement of structural information acquired by a computationally bounded observer to help resolve them. We formally define epiplexity in Section 3 (Definition 8) and present measurement procedures in Section 4. In Section 5, we show how epiplexity and time-bounded entropy shed light on these paradoxes, including induction and emergent phenomena. Finally, in Section 6, we demonstrate that epiplexity correlates with OOD generalization, helping explain why certain data enable broader generalization than others. 

## **2 Background** 

In order to define the interesting, structural, and predictive component of information, we must separate it out from random information—that which is fundamentally unpredictable given the computational constraints of the observer. Along the way, we will review algorithmic randomness as developed in algorithmic information theory as well as notions of pseudo-randomness used in cryptography, and how these concepts crucially depend on the observer. 

4 

## **2.1 What Does it Mean for An Object to Be Random?** 

**Random Variables and Shannon Information.** Many common intuitions about randomness start from random variables and Shannon information. A random variable defines a map from a given measurable probability space to different outcomes, with probabilities corresponding to the measure of the space that lead to a certain outcome. Shannon information assigns to each outcome _x_ a self-information (or surprisal) log 1 _/P_ ( _x_ ) based on the probability _P_ , and an entropy for the random variable H( _X_ ) = E[log 1 _/P_ ( _X_ )], which provides a lower bound on the average code length needed to _communicate_ samples to another party (Shannon, 1948). In Shannon’s theory, information comes only from distributions and random variables—objects that are not random must contain no information. As a result, non-random information is seemingly contradictory, and thus we must draw from a broader mathematical perspective to describe such concepts. 

In the mid 1900s, mathematicians were interested in formalizing precisely what it means for a given sample to be a random draw from a given distribution, to ground the theory of probability and random variables (Shafer and Vovk, 2006). A central consideration involves a uniformly sampled binary sequence _u_ 1: _∞_ from which other distributions of interest can be constructed. This sequence can also be interpreted as the binary expression of a number [0 _,_ 1). Intuitively, one might think that all sequences should be regarded as equally random, as they are all equally likely according to the probability distribution: 1111111 _. . ._ has the same probability mass as 10011101 _. . ._ and also the same self-information. However, looking at statistics on these sequences reveals something missing from this perspective; from the law of large numbers, for example, it must be that lim _N →∞ N_[1] � _Ni_ =1 _[u][i]_[= 0] _[.]_[5][,] which is clearly not satisfied by the first sequence of 1s. 

**Martin-Löf Randomness: No algorithm exists to predict the sequence.** Initial attempts were made to formalize randomness as sequences which pass all statistical tests for randomness, such as the law of large numbers for selected substrings. However, under such definitions all sequences fail to be random since tests like _u_ 1: _∞_ = _y_ 1: _∞_ for any particular sequence _y_ must also be included (Downey and Hirschfeldt, 2019). The solution to these issues was found by defining random sequences not as those that pass all tests of randomness, but those that pass all _computable_ tests of randomness, in a formalization known as Martin-Löf randomness (Martin-Löf, 1966). As it turned out, this definition is equivalent to a number of seemingly distinct definitions, such as the inability for any gambler to exploit properties of the sequence to make a profit, or that all prefixes of the random sequence should be nearly incompressible (Terwijn, 2016). For this last definition, we must invoke Kolmogorov complexity, a notion of compressibility and a key concept in this paper. 

**Definition 1 (Prefix Kolmogorov complexity (Kolmogorov, 1968; Chaitin, 1975))** _Fix a universal prefix-free Turing machine U. The (prefix) Kolmogorov complexity of a finite binary string x is K_ ( _x_ ) = min _{ |p|_ : _U_ ( _p_ ) = _x }. That is, K_ ( _x_ ) _is the length of the shortest self-delimiting program (a program which also encodes its length) that outputs x and halts. The conditional complexity K_ ( _x|y_ ) _is the length of the shortest program that outputs x and halts when provided y as input._ 

Due to the universality of Turing machines, the Kolmogorov complexity for two Turing machines (or programming languages) _U_ 1 and _U_ 2 differ by at most a constant, _|KU_ 1( _x_ ) _− KU_ 2( _x_ ) _|≤ C_ , where the constant _C_ depends only on _U_ 1 _, U_ 2, but not on _x_ (Li et al., 2008). 

**Definition 2 (Martin–Löf random sequence (Martin-Löf, 1966))** _An infinite sequence x_ 1: _∞ ∈{_ 0 _,_ 1 _}_[N] _is Martin–Löf random iff there exists a constant c such that for all n, K_ ( _x_ 1: _n_ ) _≥ n−c. Using this criterion, all computable randomness tests are condensed into a single incomputable randomness test concerning Kolmogorov complexity._ 

5 

One can extend Martin-Löf randomness to finite sequences. We say that a sequence _x ∈{_ 0 _,_ 1 _}[n]_ is _c_ -random if _K_ ( _x_ ) _> n − c_ . Equivalently, _randomness discrepancy_ is defined as _δ_ ( _x_ ) = _n − K_ ( _x_ ), which measures how far away _x_ is from having maximum Kolmogorov complexity. A sequence _x_ is _c_ -random if _δ_ ( _x_ ) _< c_ . High Kolmogorov complexity, low randomness discrepancy, sequences are overwhelmingly likely when sampled from uniform randomly sampled random variables. From Kraft’s inequality (Kraft, 1949; McMillan, 1956), there are at most 2 _[n][−][c]_ (prefix-free) programs of length _L ≤ n − c_ , therefore in the 2 _[n]_ possibilities in uniformly sampling _X ∼ Un_ , the probability that _K_ ( _X_ ) is size _L_ or smaller is _P_ ( _K_ ( _X_ ) _≤ n − c_ ) = _P_ ( _δ_ ( _X_ ) _≥ c_ ) _<_ 2 _[−][c]_ . The randomness discrepancy of a sequence can thus be viewed as a test statistic for rejecting the null hypothesis that the object _X_ was indeed sampled uniformly at random (Grünwald et al., 2008). For a sequence to have low randomness discrepancy, it must exhibit no discernible pattern, and thus there is an objective sense in which 1001011100 is more random than 0101010101. 

Given the Martin-Löf definition of infinite random sequences, every random sequence is incomputable; in other words, there is no program that can implement the function N _→{_ 0 _,_ 1 _}_ which produces the bits of the sequence. One should contrast such random numbers from those like _π/_ 4 or _e/_ 3, which though transcendental, are computable, as there exist programs that can compute the bits of their binary expressions. While the computable numbers in [0 _,_ 1) form a countable set, algorithmically random numbers in [0 _,_ 1) are uncountably large in number. With the incomputability of random sequences in mind we can appreciate the Von Neumann quote 

_“Anyone who considers arithmetical methods of producing random digits is, of course, in a state of sin.”_ (Von Neumann, 1951) 

which anticipates the Martin–Löf formalization that came later. But this viewpoint also misses something essential, as evidenced by the success of pseudorandom number generation, derandomization, and cryptography. 

**Cryptographic Randomness: No polynomial time algorithm exists to predict the sequence.** An important practical and theoretical development of random numbers has come from the cryptography community, by once again limiting the computational model of the observer. 

Rather than passing all computable tests as with Martin-Löf randomness, cryptographically secure pseudorandom number generators (CSPRNG or PRG) are defined as functions which produce sequences that pass all _polynomial time_ tests of randomness. Such functions are conjectured to be constructible by computer programs and are central to cryptographic research. 

**Definition 3 (Non-uniform PRG (Blum and Micali, 1982; Goldreich, 2006))** _A function G stretching k input bits into n output bits is a pseudorandom generator (PRG) if its outputs cannot be distinguished from a random sequence by any polynomial time algorithm more than a negligible fraction of the time. More precisely, G is a (non-uniform) PRG iff for every non-uniform probabilistic polynomial time algorithm Dk_ : _{_ 0 _,_ 1 _}[n] →{_ 0 _,_ 1 _} (making use of advice strings {ak}k∈_ N _of length_ poly( _k_ ) _) has at most negligible advantage ϵ_ ( _k_ ) _distinguishing outputs of G from uniformly random sequences u ∼ Un:_ 

**==> picture [352 x 25] intentionally omitted <==**

The definition of indistinguishability via polynomial time tests is equivalent to a definition on the failure to predict the next element of a sequence given the previous elements: no polynomial time 

> 1. Here negl( _k_ ) means that the function decays faster than the reciprocal of any polynomial, i.e., negl( _k_ ) _< k_[1] _[c]_[for][all] integers _c >_ 0 and sufficiently large _k_ . 

6 

predictor can predict the next bit of the sequence with probability negligibly better than random guessing (Yao, 1982). 

Following from the indistinguishability definition, randomness of this kind can be substituted for Martin-Löf randomness in the vast majority of practical circumstances.[2] For a concrete example, if a use-case of randomness that runs in polynomial time like quicksort, and takes more iterations to run with PRG sequences than with truly random sequences, and this difference could be determined within polynomial time such as by measuring the quicksort runtime, then this construction could be used as a polynomial time distinguisher, which by the definition of PRG does not exist. If PRGs exist, then quicksort must run nearly as fast using pseudorandom number generation as it does with truly random sequences. 

The existence of PRGs hinges on the existence of _one way functions_ (OWF), from which PRGs and other cryptographic primitives are constructed, forming the basis of modern cryptography (Goldreich and Levin, 1989). For example, the backbone algorithm for parallel random number generation in Jax (Bradbury et al., 2018), works to create random numbers _u_ 1 _, u_ 2 _, . . . uN_ by simply encrypting the numbers 1 _,_ 2 _, . . . , N_ : _uk_ = _E_ ( _k, s_ ) where the encryption key _s_ is the random seed and _E_ is the threefish block cypher (Salmon et al., 2011). Block ciphers, like other primitives, are constructed using one way functions. 

**Definition 4 (Non-uniform one-way function, OWF (Yao, 1982; Goldreich, 2006))** _Let f_ : _{_ 0 _,_ 1 _}[n] →{_ 0 _,_ 1 _}[m] (with m > n) be computable in time_ poly( _n_ ) _where n_ = _|x|. We say f is_ one-way against non-uniform PPT adversaries _if for every non-uniform probabilistic polynomial time algorithm An (i.e., a polynomial-time algorithm A with advice strings {an}n∈_ N _of length_ poly( _n_ ) _),_ 

**==> picture [182 x 17] intentionally omitted <==**

_where the probability is over the uniform choice of x (and any internal randomness in A)._ 

While cryptographers are most interested in the polynomial versus nonpolynomial compute separations for security, cryptographic primitives with respect to less extreme compute separations have been constructed and are believed to exist, for example for quadratic time (Merkle, 1978), quasipolynomial time (Liu and Pass, 2024), and even constraints on circuit depth (Applebaum, 2016). While the results we prove in this paper are based on the polynomial vs nonpolynomial separation in cryptographic primitives, it seems likely that a much wider array of compute separations are relevant for information in the machine learning context even if not as important for cryptography. For example, the separations between quadratic or cubic time and higher order polynomials may be relevant to transformer self attention, or gaps between fixed circuit depth and variable depth as made possible with chain of thought or other mechanisms. 

## **2.2 Random vs Structural Information** 

With these notions of randomness in hand, we can use what is random to define what is not random. In algorithmic information theory, there is a lesser known concept that captures exactly this idea, known as _sophistication_ (Koppel, 1988), which has no direct analog in Shannon information theory. While several variants of the definition exist, the most straightforward is perhaps the following: 

**Definition 5 (Naive Sophistication (Mota et al., 2013))** _Sophistication, like Kolmogorov complexity, is defined on individual bitstrings, and it uses the compressibility criterion from Martin-Löf_ 

> 2. Specifically, when the difference between outcomes can be measured in polynomial time. 

7 

_randomness to carve out the random content of the bitstring. Sophistication is defined as the smallest Kolmogorov complexity of a set S such that x is a random element from that set (at randomness discrepancy of c)._ 

**==> picture [324 x 15] intentionally omitted <==**

Informally, sophistication describes the structural component of an object; however, it is surprisingly difficult to give concrete examples of high sophistication objects. The difficulty of finding high sophistication objects is a consequence of Chaitin’s incompleteness theorem (Chaitin, 1974). This theorem states that in a given formal system there is a constant _L_ for which there are no proofs that any specific string _x_ has _K_ ( _x_ ) _> L_ , even though nearly all strings have nearly maximal complexity. Since nsoph _c_ ( _x_ ) _> L_ implies _K_ ( _x_ ) _> L − O_ (1), there can be no proofs that the sophistication of a particular string exceeds a certain constant either. It is known that high sophistication strings exist by a diagonalization argument (Antunes et al., 2005), but we cannot pinpoint any specific strings which have high sophistication. On typical Turing machines, _L_ is often not more than a few thousand (Chaitin, 1998), far from the terabytes of information that frontier AI models have encoded. 

We look towards complex systems and behaviors as likely examples of high sophistication objects; however in many of these cases the objects could conceivably be produced by simpler descriptions given tremendous amounts of computation. The mixing of two fluids for example can produce extremely complex transient behavior due to the complexities of fluid dynamics; however, with access to unlimited computation and some appropriately chosen random initial data one should be able to reproduce the exact dynamics (Aaronson et al., 2014). Owing to the unbounded compute available for the programs in sophistication, many complex objects lose their complexity. Additionally, for strings that _do_ have high sophistication, the steps of computation required for the optimal program grow faster than any computable function with the sophistication content (Ay et al., 2010). For a computationally bounded observer, an encrypted message or a _cryptographically secure pseudorandom number generator_ (CSPRNG) output _is_ random, and measurements that do not recognize this randomness do not reflect the circumstances of this observer. These limitations of sophistication leads to a disconnect with real systems with observers that have limited computation, and it is our contention that this disconnect is an essential one, central to phenomena such as emergence, induction, chaos, and cryptography. 

## **2.3 The Minimum Description Length Principle** 

Finally, we review the minimum description length principle (MDL), used as a theoretical criterion for model selection, which we will use in defining epiplexity. The principle states that among models for the data, the best explanation minimizes the total description length of the data, including both the description of the data using the model and the description of the model itself (Rissanen, 2004). The most common instantiation of this idea is via the statistical two-part code MDL. 

**Definition 6 (Two-part MDL (Rissanen, 2004; Grünwald, 2007))** _Let x ∈{_ 0 _,_ 1 _}[n][×][d] be the data and H be a set of candidate models. The two-part MDL is:_ 

**==> picture [148 x 15] intentionally omitted <==**

_where L_ ( _H_ ) _specifies the number of bits required to encode the model H, and −_ log _P_ ( _x | H_ ) _is the number of bits required to encode the data given the model._ 

This formulation provides an intuitive implementation of Occam’s Razor: complex models (large _L_ ( _H_ )) are penalized unless they provide a reduction in the data’s description length (large _P_ ( _x | H_ )). 

8 

If there are repeating patterns in the data, they can be stored in the model _H_ rather than being duplicated in the code for the data. We review the modern developments of MDL in Appendix H. While MDL is a criterion for model selection given a fixed dataset, epiplexity, which we introduce next, can be viewed as its dual: a criterion for data selection given a fixed computation budget. 

## **3 Epiplexity: Structural Information Extractable by a Computationally Bounded Observer** 

Keeping in mind the distinction between structural and random information in the unbounded compute setting, and the computational nature of pseudorandomness in cryptography, we now introduce epiplexity. _Epiplexity_ captures the structural information present to a computationally bounded observer. As the computational constraints of this observer change, so too does the division between random and structured content. After introducing epiplexity here, we present ways of measuring epiplexity in Section 4. In Sections 5 and 6 we show how epiplexity can shed light on seeming paradoxes in information theory around the value of data, and OOD generalization. 

First we will define what it means for a probability distribution to have an efficient implementation, requiring that it be implemented on a prefix-free universal Turing machine (UTM) and halt in a fixed number of steps. 

**Definition 7 (Time-bounded probabilistic model)** _Let T_ : N _→_ N _be a non-decreasing timeconstructible function and let U be a fixed prefix-free universal Turing machine. A (prefix-free) program_ P _is a T_ -time probabilistic model _over {_ 0 _,_ 1 _}[n] if it supports both sampling and probability evaluation in time T_ ( _n_ ) _:_ 

_**Evaluation.** On input_ (0 _, x_ ) _with x ∈{_ 0 _,_ 1 _}[n] , U_ (P _,_ (0 _, x_ )) _halts within T_ ( _n_ ) _steps and outputs an element in_ [0 _,_ 1] _(with a finite binary expansion), denoted_ 

**==> picture [114 x 11] intentionally omitted <==**

_**Sampling.** On input_ (1 _, u_ ) _where u ∈{_ 0 _,_ 1 _}[∞] is an infinite random tape, U_ (P _,_ (1 _, u_ )) _halts within T_ ( _n_ ) _steps and outputs an element of {_ 0 _,_ 1 _}[n] , denoted_ 

**==> picture [126 x 11] intentionally omitted <==**

_These outputs must define a normalized distribution matching the sampler:_ 

**==> picture [348 x 25] intentionally omitted <==**

_Let PT be the set of all such programs. To simplify the notation, we will use italicized P to denote the probability mass function_ ProbP _in contrast with the non-italicized_ P _, which denotes the program._ 

Here, _n_ denotes the dimension of the underlying sample space (e.g., the length of the binary string.) This definition allows us to constrain the amount of computation the function class can use. Such a model class enforces that the functions of interest are both efficiently sampleable and evaluable, which include most sequence models. While in this work we focus primarily on computational constraints which we consider most fundamental, other constraints such as memory or within a given function class _F_ can be accommodated by replacing _PT_ with _PF_ , and may be important for understanding 

9 

particular phenomena.[3] With these preliminaries in place, we can now separate the random and structural components of information. 

We define epiplexity and time-bounded entropy in terms of the program which achieves the best expected compression of the random variable _X_ , minimizing the two-part code length (model and data given model bits) under the given runtime constraint. 

**Definition 8 (Epiplexity and Time-Bounded Entropy)** _Consider a random variable X on {_ 0 _,_ 1 _}[n] . Let_ 

P _[⋆]_ = arg min _{|_ P _|_ +E[log 1 _/P_ ( _X_ )] _}_ (3) P _∈PT_ 

_be the program that minimizes the time bounded MDL with ties broken by the smallest program, and expectations taken over X. |_ P _| denotes the length of the program_ P _in bits, and logarithms are in base_ 2 _. We define the T -bounded_ epiplexity S _T and_ entropy H _T of the random variable X as_ 

S _T_ ( _X_ ) := _|_ P _[⋆] |, and_ H _T_ ( _X_ ) := E[log 1 _/P[⋆]_ ( _X_ )] _._ (4) 

The time-bounded entropy H _T_ captures the amount of information in the random variable that is random and unpredictable, whereas the epiplexity S _T_ captures the amount of structure and regularity visible within the object at the given level of compute _T_ . Uniform random variables have trivial epiplexity because a model (or equivalently a program) as simple as the uniform distribution achieves a small two-part code length, despite having large time-bounded entropy. Explicitly, for a uniform random variable _Un_ on _{_ 0 _,_ 1 _}[n]_ , and even a constant time bound _T_ ( _n_ ) _≥ c_ 1, S _T_ ( _Un_ ) + H _T_ ( _Un_ ) _≤ n_ + _c_ 2 where _c_ 2 is the length of a program for the uniform distribution running in time _c_ 1, and since H _T_ ( _Un_ ) _≥_ H( _Un_ ) = _n_ , it must be that S _T_ ( _Un_ ) _≤ c_ 2. Random variables with simple patterns, like 0101010101 _..._ with probability 1 _/_ 2 and 1010101010 _..._ with probability 1 _/_ 2, also have low epiplexity because the time bounded MDL minimal model is simple. In this case with linear time _T_ ( _n_ ) = Θ( _n_ ), both S _T_ ( _X_ ) = _O_ (1) and H _T_ ( _X_ ) = _O_ (1). Henceforth, we will abbreviate MDL _T_ ( _X_ ) := S _T_ ( _X_ ) + H _T_ ( _X_ ), which is the total time-bounded information content. We will now enumerate a few basic consequences of these definitions. 

## **Basic Properties** 

(1) S _T_ ( _X_ ) _≥_ 0 _,_ H _T_ ( _X_ ) _≥_ 0 _,_ (2) H( _X_ ) _≤_ S _T_ ( _X_ ) + H _T_ ( _X_ ) _≤ n_ + _c_ 1 _,_ (3) MDL _T ′_ ( _X_ ) _≤_ MDL _T_ ( _X_ ) whenever _T[′]_ ( _n_ ) _≥ T_ ( _n_ ) _,_ (4) MDL _T ′_ ( _f[−]_[1] ( _X_ )) _≤_ MDL _T_ ( _X_ ) + _|_ f _|_ + _c_ 2 _,_ with _T[′]_ ( _n_ ) = _T_ ( _n_ ) + Time(f) _._ 

Statement 4 (defined for programs f that run in a fixed time implementing a bijection) is an analog of the information non-increase property _K_ ( _f_ ( _x_ )) _≤ K_ ( _x_ ) + _K_ ( _f_ ) + _c_ . However, note that while the Kolmogorov complexity for _K_ ( _f_ ) and _K_ ( _f[−]_[1] ) are the same to within an additive constant, in our setting of a fixed computational budget having a short program for _f[−]_[1] does not imply one for _f_ , 

> 3. One such possibility is to constrain the function class to all models reachable by a given optimization procedure with a given neural network architecture. 

10 

and vice versa. This gap between a function and its inverse has important consequences for the three paradoxes as we will see in Section 5. 

**Pseudorandom number sequences have high random content and little structure.** Unlike Shannon entropy, Kolmogorov complexity, or even resource bounded forms of Kolmogorov complexity (Allender et al., 2011), we show that CSPRNGs have nearly maximal time-bounded entropy for polynomial time observers. Additionally, while CSPRNGs produce random content, they do not produce structured content as the epiplexity is negligibly larger than constant. Formally, let _Uk_ be the uniform distribution on _k_ bits. 

**Theorem 9** _For any G ∈_ PRG _that stretches the input to n_ = poly( _k_ ) _bits and allowing for an advantage of at most ε_ ( _k_ ) _, the polynomial time bounded entropy is nearly maximal:_ 

**==> picture [170 x 12] intentionally omitted <==**

_for a fixed constant c, and epiplexity is nearly constant_ 

**==> picture [114 x 11] intentionally omitted <==**

_Proof: see Appendix A.1._ 

In contrast, the Shannon entropy is H( _G_ ( _Uk_ )) = _k_ , polynomial time bounded Kolmogorov complexity will be at most _k_ + _c_ (assuming _n_ is fixed or specified ahead of time) as there is a short and efficiently runnable program _G_ which produces the output, and similarly with other notions such as Levin complexity (Li and Vitányi, 2008) or time bounded Kolmogorov complexity (Allender et al., 2011). Taken together, these results show that epiplexity appropriately characterizes pseudorandom numbers as carrying a large amount of time-bounded randomness but essentially no learnable structure, exactly as intuition suggests. 

**Existence of Random Variables with High Epiplexity.** One may wonder whether any high epiplexity random variables exist at all. Indeed, assuming the existence of one-way functions, we can show via a counting argument that there exists a sequence of random variables whose epiplexity grows at least logarithmically with the dimension. 

**Theorem 10** _Assuming the existence of one-way functions secure against non-uniform probabilistic polynomial-time adversaries, there exists a sequence of random variables {Xn}[∞] n_ =1 _over {_ 0 _,_ 1 _}[n] such that_ 

SPoly( _Xn_ ) = Ω(log _n_ ) _._ 

_Proof: see Appendix A.4._ 

This result implies that epiplexity can be unbounded; however, logarithmically growing information content only admits a very modest amount of structural information, still far from the power law scaling we see with some natural data. We also note that the argument is nonconstructive and hence does not compromise cryptographic security. 

**Conditional Entropy and Epiplexity.** To describe situations like image classification, where we are only interested in a function which predicts the label from the image, and not the information in generating the images, we define _conditional_ time-bounded entropy and epiplexity. 

11 

**Definition 11 (Conditional epiplexity and time-bounded entropy)** _For a pair of random variables X and Y , define PT[X]_ ( _n_ ) _[as][the][set][of][probabilistic][models][P][such][that][for][each][fixed][x][,] the conditional model_ P _Y |x is in PT_ ( _n_ ) _. The optimal conditional model with access to X is:_ 

**==> picture [322 x 21] intentionally omitted <==**

_The conditional_ epiplexity _and_ time-bounded entropy _are defined as:_ 

**==> picture [362 x 19] intentionally omitted <==**

_These quantities are defined with respect to the time bounded MDL over programs which take as input X, Y and output the probabilities over Y (conditioned on X), and with expectations taken over both X and Y . We note that in general this definition is not equivalent to the difference of the joint and individual entropies,_ H _T_ ( _Y, X_ ) _−_ H _T_ ( _X_ ) _̸_ = H _T_ ( _Y |X_ ) _. Unlike Shannon entropy, we can also condition on deterministic strings, which will change the values on account of not needing such a large program_ P _. For example, we may be interested in the conditional epiplexity_ S _T_ ( _X|m_ ) _or entropy_ H _T_ ( _X|m_ ) _given a model m. For a deterministic string d ∈{_ 0 _,_ 1 _}[∗] we define the conditional epiplexity via_ 

**==> picture [313 x 20] intentionally omitted <==**

_where the minimization is over time bounded functions P_ ( _· | ·_ ) _that take in the string d as the second argument (which we refer to as PT[{]_[0] _[,]_[1] _[}][∗] )._ 

For the machine learning setting, we take the random variable _X_ to refer to the _entire dataset_ of interest, i.e. typically a collection _X_ = [ _X_ 1 _, X_ 2 _, . . ._ ] of many iid samples from a given distribution, rather than a lone sample from, and E[log 1 _/P_ ( _X_ )] scales with the dataset size. Epiplexity typically grows with the size of the dataset (see detailed arguments for why this is the case in Section B.4) as larger datasets allow identifying and extracting more intricate structure and patterns, mirroring the practice of ML training. Moreover, as we will see later, the epiplexity of a typical dataset is orders of magnitudes smaller than the random information content. While not a focus of this paper, conditioning on deterministic strings opens up the possibility to understand what additional data is most useful for a specific machine learning model, such as on top of a pretrained LLM. 

## **4 Measuring Epiplexity and Time-Bounded Entropy** 

We have now introduced epiplexity and time-bounded entropy as measures of structural and random information of the data. In this section, we present practical procedures to estimate upper bounds and empirical proxies for these quantities. Intuitively, we want to find a probabilistic model _P_ ( _·_ ) of the data _X_ that achieves low expected loss E[log 1 _/P_ ( _X_ )], is described by a short program P _,_ and evaluating _P_ ( _X_ ) takes time at most _T_ ( _|X|_ ) _,_ which we will abbreviate as _T._ Using this model, we thereby decompose the information of the data into its structural and random components, namely, (1) epiplexity S _T_ ( _X_ ): the length of the program _|_ P _|,_ accounting for the bits required to model the data distribution, and (2) time-bounded entropy H _T_ ( _X_ ): the expected length for entropy coding the data using this model, which accounts for the bits required to specify the particular realization of _X_ within that distribution. We estimate conditional epiplexity analogously, providing random variable conditioning as input into the model. 

Since directly searching over the space of programs is intractable, we restrict attention to probabilistic models parameterized by neural networks, as they achieve strong empirical compression across data 

12 

**==> picture [435 x 115] intentionally omitted <==**

**----- Start of picture text -----**<br>
ECA Induct Easy<br>log 1/Pi [t][(][Z][i][)] 5.02.5 6<br>log 1/Pi [s][(][Z][i][)] 0.0 54<br>|Ppreq| 0.0 0.5 1.0 0.1 0.5 0.9<br>|Preq| HT(X) = E log 1/P [*] (X) Induct Hard 90 Natural<br>ST(X) = |P [*] | 65 50<br>4 10<br>log 1/PD [t] [(][Z][0][,] , ZD 1 [)] 0.50 0.75 1.00 10 30 50<br># Train Tokens Compute (T = 6ND + 2N ) Sreq (MB)<br>(a) Estimate information in model (b) Compute-optimal 2-part code (c) Requential vs Prequential<br>)<br>(XP )N<br> (MB)<br> log 1/<br>Train NLL  E preq<br>S<br># Params (<br>|P| +<br>**----- End of picture text -----**<br>


Figure 2: **How to estimate epiplexity.** ( **a** ) We consider two approaches for efficiently coding trained neural networks. Prequential estimation estimates information content as the area under the loss curve of a model above its final loss, with the training set matching the test data distribution. Requential coding, which provides an explicit code for _P_[s] with expected length as the cumulative KL between a student model _P_[s] and the teacher _P_[t] that generates its _synthetic_ training data, visualized approximately by their loss gap. We typically choose _P_[t] to be a model trained on the _real_ training set, as in prequential coding. ( **b** ) Using either approach, we optimize hyperparameters (model size _N_ , training tokens _D_ , etc.) to find the shortest two-part code for each compute budget, which decomposes into the estimated epiplexity and time-bounded entropy. ( **c** ) Comparing prequential and requential coding on four groups of datsets used in this work. The prequential estimate is typically larger, but the two correlate well, particularly within each group. 

modalities (MacKay, 2003; Goldblum et al., 2023; Delétang et al., 2023; Ballé et al., 2018) and capture the most relevant ML phenomenology. While a naive approach is to let P be a program that directly stores the architecture and weights of a neural network and evaluates it on the given data, this approach can significantly overestimate the information content in the weights, particularly for large models trained on relatively little data. Instead, we will use a more efficient approach that encodes the training process that produces the weights. We will discuss two approaches for encoding neural network training processes, based on _prequential coding_ (Dawid, 1984) and _requential coding_ (Finzi et al., 2026), respectively. The former is more straightforward to understand and evaluate, but relies on a heuristic argument to separate structure bits from noise bits, while the latter is rigorous at the cost of being more difficult to evaluate. Fortunately, both approaches often yield comparable rankings of epiplexity across datasets (Section 4.3). 

Moving forward, we will measure time by the number of floating-point operations (FLOPs) and dataset size by number of tokens, so that training a model with _N_ parameters on _D_ tokens takes time approximately 6 _ND_ (Kaplan et al., 2020), while evaluating it on _X_ takes time 2 _N D_ with _D_ = _|X|_ the number of tokens in _X._ To distinguish _X_ from the training dataset, which we are free to choose, we will refer to _X_ as the test dataset, as it is the data we need to perform inference on. 

## **4.1 Approximating Model Description Length with Prequential Coding** 

Prequential coding provides a classic approach for compressing the training process of a neural network. We assume a batch size of one for simplicity, but generalizing to batch sizes larger than one is straightforward. Starting with a randomly initialized network _P_ 0 (where the subscript indicates timestep), we proceed iteratively: at each step _i_ , we entropy encode the current training token _Zi_ using log 1 _/Pi_ ( _Zi_ ) bits, then train the model on this token to produce _Pi_ +1. Typically _Zi_ ’s are drawn i.i.d. from the same distribution as _X._ On the side of the decoder, a synchronized model is maintained; the model decodes _Zi_ using _Pi_ and then trains on it to produce the identical _Pi_ +1. Omitting small constant overheads for specifying the random initialization, architecture, and training algorithm, a total of _L_ ( _Z_ : _M , PM_ ) =[�] _[M] i_ =0 _[−]_[1][log][ 1] _[/P][i]_[(] _[Z][i]_[)][bits][yields][an][explicit][code][for][both][the][training][data] _Z_ : _M_ = _{Z_ 0 _, . . . , ZM −_ 1 _}_ and the final model weights _PM_ , which can be decoded in time 6 _ND_ for a 

13 

model with _N_ parameters trained on _D_ tokens (typically _D > M_ as each example contains multiple tokens). Despite having an explicit code for _Z, PM_ , we cannot easily separate this into a code for _PM_ alone for estimating epiplexity. 

To isolate the description length of _PM_ alone, we adopt the heuristic in Zhang et al. (2020) and Finzi et al. (2025): we first estimate the description length of the training data given _PM_ as its entropy code length under the final model, _L_ ( _Z_ : _M |PM_ ) =[�] _[M] i_ =0 _[−]_[1][log][ 1] _[/P][M]_[(] _[Z][i]_[)][.][Then,][appealing] to the symmetry of information, which states _K_ ( _PM_ ) = _K_ ( _Z_ : _M , PM_ ) _− K_ ( _Z_ : _M |PM_ ) up to constant terms, we estimate the description length of _PM_ as the difference _L_ ( _Z_ : _M , PM_ ) _− L_ ( _Z_ : _M |PM_ ): 

**==> picture [315 x 30] intentionally omitted <==**

If _Zi_ is sampled i.i.d., as is typically the case, then the code length for the model _can be visualized as the area under the loss curve above the final loss_ in Figure 2a. Intuitively, the model absorbs a significant amount of information from the data if training yields a sustained and substantial reduction in loss. For random data, log 1 _/Pi_ ( _Zi_ ) never decreases, while for simple data, log 1 _/Pi_ ( _Zi_ ) drops rapidly and stabilizes, both leading to small _|_ Ppreq _|._ We note that the prequential loss values are effectively taken on estimates of the _test loss_ , because they evaluate the log probabilities on a batch before it is trained on, a central detail to the coding scheme. In cases where train and test diverge, such as when there is overfitting, this difference could become important important. 

Encoding the test dataset _X_ (not to be confused with the training data) using this model, we obtain a two-part code of expected length _|_ Ppreq _|_ +E[log 1 _/PM_ ( _X_ )] that runs in time 6 _ND_ + 2 _N D._ We optimize the training hyperparameters (e.g., learning rate) and the trade-off between _N_ and _D_ subject to the time bound 6 _ND_ + 2 _N D ≤ T_ to find the optimal _P[⋆]_ that minimizes the two-part code within this family, and estimate epiplexity and time-bounded entropy as S _T_ ( _X_ ) = _|_ P _[⋆]_ preq _[|]_[and] H _T_ ( _X_ ) = E[log 1 _/P[⋆]_ ( _X_ )] _._ The better these hyperparameters are optimized, the more accurate our estimates become. We use the Maximal Update Parameterization ( _µ_ P) (Yang et al., 2022) to ensure the optimal learning rate and initialization are consistent across model sizes, simplifying tuning. We estimate the expectation E[log 1 _/PM_ ( _X_ )] by its empirical value on held-out validation data, i.e., the validation loss scaled by the size of _X_ . We detail the full procedure in Section B, such as how we choose the hyperparameters and estimate the Pareto frontier of MDL vs compute. 

While conceptually simple, practically useful, and easy to evaluate, this prequential approach to approximating epiplexity is not rigorous for two reasons. First, both _L_ ( _Z_ : _M , PM_ ) and _L_ ( _Z_ : _M |PM_ ) can only upper-bound the respective Kolmogorov complexities, and thus their difference does not yield an upper bound for _K_ ( _PM_ ) _._[4] Second, even setting this issue aside, the argument only establishes the existence of a program that encodes _PM_ with length _|_ Ppreq _|,_ but does not guarantee that its runtime falls within 6 _ND,_ since the symmetry of information does not extend to time-bounded Kolmogorov complexity. Nevertheless, prequential coding can serve as a useful starting point for crudely estimating epiplexity, particularly convenient when one already has access to the loss curve from an existing training run. 

## **4.2 Explicitly Coding the Model with Requential Coding** 

To address the shortcomings of the previous approach based on prequential coding, we adopt requential coding (Finzi et al., 2026) for constructing an explicit code of the model with a known runtime. Rather than trying to code a particular training dataset, with requential coding one can use the insensitivity to the exact data points sampled to code for _a_ sampled dataset that leads 

> 4. We have _L_ ( _Z_ : _M , PM_ ) + _O_ (1) _≥ K_ ( _Z_ : _M , PM_ ) _,_ but not that _L_ ( _Z_ : _M |PM_ ) + _O_ (1) _≤ K_ ( _Z_ : _M |PM_ ) _._ 

14 

to a performant model but without paying for the entropy of the data. Specifically, it encodes a training run where at step _i_ a student model _Pi_[s][is][trained][on][a][synthetic][token][sampled][randomly] from a teacher model _Pi_[t][,][where][the][sequence] _[P]_[ t] 0 _[, . . . , P] M_[ t] _−_ 1[are][arbitrary][teacher][model][checkpoints.] We typically choose _Pi_[t][to][be][the][checkpoints][from][training][on][the][original] _[real]_[training][set,][as][in] prequential� coding. Using relative entropy coding (Theis and Ahmed, 2022), the synthetic tokens _Zi ∼ Pi_[t][can][be][coded][given][only][the][student] _[P]_[ s] _i_[(synchronized][between][encoder][and][decoder)][using] KL( _Pi_[t] _[∥][P] i_[ s][)+][log(][1+][KL][(] _[P]_[ t] _i[∥][P] i_[ s][)][)][+4][ bits in expectation.][Summing over all steps gives the requential] code length for _PM_[s][:] 

**==> picture [389 x 30] intentionally omitted <==**

where the logarithmic and constant overheads are typically negligible due to large sequence length and batch size, and as before we omit the small constant cost of specifying the random initialization, architecture, and training algorithm. In addition to providing an explicit code, a key advantage of requential coding is its flexibility in choosing the teacher sequence: by selecting teachers _Pi_[t][that] remain close to the student _Pi_[s][while still pointing toward the target distribution, we keep the per-step] coding cost KL( _Pi_[t] _[∥][P] i_[ s][)][small][while][effectively][guiding][the][student’s][learning.] 

Figure 2a connects requential coding to the student’s and teacher’s loss curves: suppose we take as teachers the checkpoints _P_ 0[t] _[, . . . , P] M_[ t] _−_ 1[from][a][model][trained][on][real][data] _[Z]_[0] _[, . . . , Z][M][−]_[2] _[∼][P][X]_[.][For] visualization, we can then estimate KL( _Pi_[t] _[∥][P]_[ s] _i_[)][by][the][loss][gap][log][ 1] _[/P] i_[ s][(] _[Z][i]_[)] _[ −]_[log][ 1] _[/P] i_[ t][(] _[Z][i]_[)][,][which][is] accurate when _Pi_[t] _[≈][P][X]_[.][We][can][thus][visualize][the][code][length][for][the][student][as][approximately][the] area between the teacher’s and student’s loss curves on real data, as shown in Figure 2a. 

The two-part code has expected length _|_ Preq _|_ +E[log 1 _/PM_[s][(] _[X]_[)]] _[,]_[consisting][of][first][decoding] _[P]_[ s] _M_[by] replaying the training process, which takes time 6 _ND_ for a total of _D_ requential training tokens, and then evaluating _PM_[s][on][the][test][dataset] _[X,]_[taking][an][additional][time][2] _[N][D][,]_[for][a][total][runtime][of] 6 _ND_ + 2 _N D_ . We optimize the training hyperparameters, teacher choices, and the trade-off between _N_ and _D_ subject to the specified time bound _T_ to find the optimal model _P[⋆]_ minimizing the two-part code, and estimate S _T_ ( _X_ ) = _|_ P _[⋆]_ req _[|]_[and][H] _[T]_[(] _[X]_[) =][ E][[log 1] _[/P][ ⋆]_[(] _[X]_[)]] _[.]_[See][details][in][Section][B.1.] 

## **4.3 Comparison Between the Two Approaches and Practical Recommendations** 

Figure 2c compares the estimated epiplexity obtained by the two approaches across four groups of datasets used in this work: ECA (Section 5.1), easy and hard induction (Section 5.3.1), and natural datasets (Section 6.2). While the prequential estimate is typically several times larger than the requential estimate, the two estimates correlate well, particularly within each group where the datasets yield similar learning dynamics. We detail the datasets and time bounds used in Section C.7. This general agreement is expected since the prequential estimate can be viewed as an approximation of requential coding with a static teacher (Section B.2). In general, however, the discrepancy between the two estimates will depend on particular datasets and training configurations, and a good correlation between the two is not guaranteed. 

While requential coding is the more rigorous approach, it is typically 2 _×_ to 10 _×_ slower than prequential coding, which requires only standard training. The overhead depends on batch size, sequence length, and inference implementation (smaller overhead for large batches and short sequences), as requential coding requires repeatedly sampling from the teacher, though it is possible that the overhead can be reduced with more efficient algorithms. Therefore, we recommend using prequential coding for crudely estimating epiplexity and ranking the epiplexity of different datasets, particularly when one has access to the loss curve from an existing expensive training run (e.g., see an application in Section 6.2), and requential coding for obtaining the most accurate estimates otherwise. 

15 

## **4.4 How Epiplexity and Time-Bounded Entropy Scale with Compute and Data** 

Under natural assumptions about neural network training—namely, that larger models are more sample-efficient and that there are diminishing returns to scaling model size or data alone—we expect epiplexity and time-bounded entropy to exhibit certain generic scaling behavior as a function of the compute budget _T_ and dataset size _D_ . In Section B.4, we show that, under these assumptions, the compute-optimal model size _N[⋆]_ ( _T_ ) and training data size _D[⋆]_ ( _T_ ) are generally increasing in the compute budget _T_ , which implies that epiplexity S _T_ ( _X_ ) typically grows with _T_ while time-bounded entropy H _T_ ( _X_ ) decreases. In the infinite-compute limit, epiplexity S _∞_ ( _X_ ) typically grows with the test set size _D_ = _|X|_ , while the per-token time-bounded entropy H _∞_ ( _X_ ) _/D_ decreases. These results align with our intuition that larger compute budgets and more data allow the model to extract more structural information from the dataset and reduce the apparent randomness remaining in each sample. However, they should be understood only as typical trends, with a counterexample shown in Section 5.3.2 relating to the phenomenon of emergence. 

## **5 Three Apparent Paradoxes of Information** 

To illustrate the lacunae in existing information theory perspectives, we highlight three _apparent paradoxes_ of information: (1) information cannot be created by deterministic transformations; (2) total information content of an object is the same regardless of the factorization; and (3) likelihood modeling can only learn to match the data-generating process. Each statement captures some existing sentiment within the machine learning community, can be justified mathematically by Shannon and algorithmic information theory, and yet seems to be in conflict with intuitions and experimental observations. In this section, we will show with both theoretical results and empirical evidence that time bounding and epiplexity help resolve these apparent paradoxes. 

## **5.1 Paradox 1: Information Cannot be Created by Deterministic Transformations** 

Both Shannon and algorithmic information theory state in some form that the total information cannot be increased by applying deterministic transformations on existing data. The data processing inequality (DPI) states that if some information source _W_ produces natural data _X_ that are collected, then no deterministic _or stochastic_ transformations used to produce _Y_ from _X_ can increase the mutual information with the variable of interest _W_ : _I_ ( _Y_ ; _W_ ) _≤ I_ ( _X_ ; _W_ ). Similarly, information non-increase states that a deterministic transformation _f_ can only preserve or decrease the Shannon information, a property that holds pointwise _−_ log _PY_ ( _f_ ( _x_ )) _≤−_ log _PX_ ( _x_ ) and in expectation: H( _f_ ( _X_ )) _≤_ H( _X_ ) (we note _X_ here is a discrete random variable). In algorithmic information theory, there is a corresponding property: _K_ ( _f_ ( _x_ )) _≤ K_ ( _x_ ) + _K_ ( _f_ ) + _c_ for a fixed constant _c_ . These inequalities appear to rule out creating new information with deterministic computational processes. 

How can we reconcile this fact with algorithms like AlphaZero (Silver et al., 2018) that can be run in a closed environment from a small deterministic program on the game of chess, extracting insights about the game, different openings, the relative values of pieces in different positions, tactics and high level strategy, and requiring megabytes of information stored in the weights? Similarly we have dynamical systems with simple descriptions of the underlying laws that produce rich and unexpected structures, from which we can learn new things about them and mathematics. 

We also have evidence that synthetic data is helpful for model capabilities (Liu et al., 2024; Gerstgrasser et al., 2024; Maini et al., 2024; OpenAI, 2025). Moreover, if we believe that the processes that create natural data could in principle have been simulated to sufficient precision on a large computer, then all data could have been equivalently replaced with synthetic data. For practical synthetic 

16 

**==> picture [432 x 99] intentionally omitted <==**

**----- Start of picture text -----**<br>
×10 [8] ×10 [6] ×10 [8]<br>1.0 1.0<br>5<br>0.8 Rule 0.8<br>15 4<br>0.6 30 3 0.6<br>54<br>0.4 2 0.4<br>0.2 1 0.2<br>0.0 0 0.0<br>Rule 15 Rule 30 Rule 54 10 [14] 10 [17] 10 [14] 10 [17] 10 [14] 10 [17]<br>Compute Compute Compute<br>| log 1/)(XYP E |)(SXYT |)(XYHT<br>|P| +<br>**----- End of picture text -----**<br>


Figure 3: **Information created with cellular automata.** ( **Left** ) Example rollouts from random initial conditions of the class II rule 15, class III rule 30, and class IV rule 54. Time flows from up to down. ( **Right** ) Measuring epiplexity on data produced by these transformations, we see that rule 15 produces little information (low H _T_ , low S _T_ ), rule 30 produces lots of unpredictable random information (high H _T_ , low S _T_ ), and rule 54 produces both random and structural information (medium H _T_ , high S _T_ ). These observations are reflected in the training loss curve of LLMs, which saturates quickly for rule 15, makes no progress for rule 30, and makes continued progress with compute for rule 54. 

data produced from transformations of samples from a given model and prompt, this sampling is performed with pseudorandom number generators, making the entire transformation deterministic. If we consider _f_ as the transformations we use to produce synthetic data and _x_ was the limited real data we started with, these inequalities appear to state very concretely that our synthetic data adds no additional information beyond the model and training data. 

Whatever information it is that we mean when we say that AlphaZero has produced new and unexpected insights in chess, or new theoretical results in mathematics, or with synthetic data, it is not Shannon or algorithmic information. We argue that these unintuitive properties of information theory are a consequence of assuming unlimited computation for the observer. With limited computation, a description of the AlphaZero algorithm and the result of running AlphaZero for thousands of TPU hours are distinct. To build intuition, we start with the humble CSPRNG which also creates time-bounded information through computation (albeit random information). 

**Theorem 12** _Let G_ : _{_ 0 _,_ 1 _}[k] →{_ 0 _,_ 1 _}[n] be a_ PRG _which admits advantage ε_ ( _k_ ) _and Uk be the uniform distribution._ HPoly( _G_ ( _Uk_ )) _−_ HPoly( _Uk_ ) _> n − k − nε_ ( _k_ ) _− c for a fixed constant c. Proof: see Appendix A.2._ 

Notably, we have a deterministic function which dramatically increases the time-bounded information content of the input. It is worth contrasting this result with Equation 3, where the time-bounded information content increase from a deterministic function _can_ be bounded if the inverse function has a short program which can run efficiently. The statement highlights an important asymmetry between the function _G_ and its inverse with fixed computation that does not hold with unlimited computation (e.g. _K_ ( _G[−]_[1] ) = _K_ ( _G_ ) + _O_ (1)). Simultaneously, it provides some useful guidance for synthetic data: if we want to produce interesting information, we should make sure the functions we use do not have simple and efficiently computable inverses. 

As an illustrative example, consider the iterated dynamics of elementary cellular automata (Wolfram and Gad-el Hak, 2003; Zhang et al., 2024). An elementary cellular automaton (ECA) is a one-dimensional array of binary cells that evolves in discrete time steps according to a _fixed_ rule mapping each cell’s current state and the states of its two immediate neighbors to its next state. Despite their simple formulation – only 256 possible rules—these systems can produce a rich variety of behaviors, from stable and periodic patterns to chaotic and computationally universal dynamics. We setup the problem of predicting _Yi_ = _F_ ( _Xi_ ) from random initial data _Xi_ for _F_ being an ECA 

17 

iterated 48 times on a grid of size 64, and assemble these pairs into a dataset _X_ = [ _X_ 1 _, . . . , XK_ ] and _Y_ = [ _Y_ 1 _, . . . , YK_ ] for a total dataset of _D_ = 100M tokens. We measure the conditional information content _Y |X_ (epiplexity and entropy) for ECA rules 15, 30, and 54 by training LLMs on this dataset. We provide a visualization of these dynamics in Figure 3 (left). For the class II rule 15 in the Wolfram hierarchy (Wolfram and Gad-el Hak, 2003), the produced behavior is periodic and has a simple inverse. Consequently, in Figure 3 (right), we see that training dynamics that rapidly converge to optimal predictions and with little epiplexity or time-bounded entropy. With the class III rule 30, the computation produces outputs that are inherently intractable to predict with limited computation, and as a result we see that there is maximal time-bounded entropy that is produced but no epiplexity. For the class IV rule 54, we see that the dynamics are complex but also partly understandable: the loss decreases slowly and much epiplexity is produced. These results highlight the sensitivity of epiplexity to the generating process. With the same compute spent and with a very similar program we can have drastically different outcomes, producing simple objects, producing only random content, and producing a mix of random and structured content. 

## **5.2 Paradox 2: Information Content is Independent of Factorization** 

An important property of Shannon’s information is the symmetry of information, which states that the amount of information content does not change with factorization. The information we acquire when predicting _x_ and then _y_ is exactly equal to when predicting _y_ and then _x_ : Shannon entropy satisfies H( _Y | X_ ) + H( _X_ ) = H( _X, Y_ ) = H( _X | Y_ ) + H( _Y_ ). An analogous property also holds for Kolmogorov complexity, known as the symmetry of information identity: _K_ ( _y | x_ )+ _K_ ( _x_ ) = _K_ ( _x | y_ )+ _K_ ( _y_ )+ _O_ (1). 

On the other hand, multiple works have observed that natural text is better compressed (with final model achieving higher likelihoods) when modeled in the left-to-right order (for English) than when modeled in reverse order (Papadopoulos et al., 2024; Bengio et al., 2019), picking out an _arrow of time_ in LLMs where one direction of modeling is preferred over the other. It seems likely that for many documents, other orderings may lead to more information extracted by LLMs. Similarly, as we will show later, small rearrangements of the data can lead to substantially different losses and downstream performance. Cryptographic primitives like one way functions and block cyphers also provide examples where the order of conditioning can make all the difference to how entropic the data appears, for example considering autoregressive modeling of two prime numbers followed by their product vs the reverse ordering. These experimental results and cryptographic ideas indicate what can be learned is dependent on the ordering of the data, which in turn suggests that different amounts of “information” are extracted from these different orderings. 

Our time-bounded definitions capture this discrepancy. Under the existence of one way permutations, we can prove that a gap in prediction exists over different factorizations for time bounded entropy. 

**Theorem 13** _Let f be a one-way permutation and let X_ = _Un be uniform and Y_ = _f_ ( _X_ ) _._ HPoly( _X | Y_ ) + HPoly( _Y_ ) _>_ HPoly( _Y | X_ ) + HPoly( _X_ ) + _ω_ (log _n_ ) _. Proof: see Appendix A.5._ 

As a corollary, we show no polynomial time probability model which can fit a one way function’s forward direction can satisfy Bayes theorem (see Theorem 26). Adding to these theoretical results, we look empirically at the gap in time-bounded entropy for one way functions, and the gap in both entropy and epiplexity over two orderings of predicting chess data. 

In Figure 4(a), we choose _f_ to be given by the 8 steps of evolution of the ECA rule 30 with state size _n_ and periodic boundary conditions (Wolfram and Gad-el Hak, 2003). Though distinct from the one way functions used in cryptography, rule 30 is believed to be one way (Wolfram and Gad-el 

18 

**==> picture [433 x 130] intentionally omitted <==**

**----- Start of picture text -----**<br>
W pawn to e4<br>Forward B pawn to e5 ... 8 ×10 [9] ×10 [8]<br>100 Random Guess 1. e4 e5 2.5<br>7 Orde r<br>75 Forward 2.0<br>6<br>50 Reverse W pawn to e4B pawn to e5 ... Rev erse 1.5<br>25 forward 1. e4 e5 5 1.0<br>Entropy reverse 4 0.5<br>0 OWF("secret")="ehjzdv"<br>20 n (state size)40 60 ReverseForward "secret""ehjzdv" ""secret"ehjzdv" 10Compute [16] 10 [18] 10Compute [16] 10 [18]<br>(a) One way functions (b) Factorization order (c) Chess orderings<br>)(B HT<br>) +B )(XHT )(SXT<br>(AHT<br>**----- End of picture text -----**<br>


Figure 4: **Factorization matters.** ( **a** ) We compare the losses from modeling a conjectured one way function in forward and reverse as the state size _n_ is increased. The model reaches Shannon entropy in the forward direction, but with a persistent gap in the reverse direction. ( **b** ) The two orderings produce different outcomes. Analogous to the OWF, predicting the moves followed by the final board state is the direction that can be predicted with a straightfoward computation. Predicting the board first and then the moves requires more complex behaviors. ( **c** ) As compute increases, the same chess data presented in the reverse order leads to higher time-bounded entropy and epiplexity, showing it becomes more difficult to predict but allows more structure to be learned. 

Hak, 2003) and unlike typical one way functions, the forward pass of rule 30 can be modeled by an autoregressive transformer, which we demonstrate by constructing an explicit RASP-L (Zhou et al., 2023; Weiss et al., 2021) program in Appendix D. As shown in Figure 4(a), the model achieves the Shannon entropy (gray) in the forward direction, but has a consistent gap in the reverse direction. 

Beyond just how the random information can vary with orderings, the structural information can also differ as we will show next. We demonstrate this fact by training autoregressive transformer models on the Lichess dataset, a large collection of chess games where the moves are recorded in algebraic chess notation. We consider two variants of this dataset: (1) formatting each game as the move sequence followed by final board state in FEN notation, and (2) formatting each game as the final board state followed by the move sequence, as illustrated in Figure 4b. We provide full experiment details in Section C.4. While there is no clear polynomial vs non-polynomial time separation in this setup, the first ordering is analogous to the forward direction as the final board state can be straightforwardly mapped from the moves with a simple function, while the latter ordering is analogous to the reverse direction, where recovering the moves from the final board state requires the inverse function that infers the intermediate moves from the final state. We hypothesize the reverse direction is a more complex task and will lead the model to acquire more structural information, such as a deeper understanding of the board state. Figure 4c confirms this hypothesis, showing that the reverse order has both time-bounded higher entropy and epiplexity. This gap vanishes at small compute budgets where the model likely learns only surface statistics common to both orderings before the additional complexity of the reverse task forces it to develop richer board-state representations. 

## **5.3 Paradox 3: Likelihood Modeling is Merely Distribution Matching** 

There is a prevailing view that from a particular training distribution, we can at best hope to match the data generating process. If there is a property or function that is not present in the data-generating process, then we should not expect to learn it in our models. As an extension, if the generating process is simple, then so are models that attempt to match it. This viewpoint can be supported by considering the likelihood maximization process abstractly, arg min _P_ E _X∼Q_ [ _−_ log _P_ ( _X_ )] = _Q_ ; the 

19 

**==> picture [402 x 104] intentionally omitted <==**

**----- Start of picture text -----**<br>
×10 ×10 [3] ×10 [6]<br>5 1.6<br>4<br>0 1 1 0 10 [1] Hidden Bits 4 1.5<br>h = 0 Hidden Rows 3<br>Generation h = 1 3 h = 0<br>1 0 1 1 1 0 hh = 2 = 3 2 1.4 hh = 2 = 4 2<br>10 [0] hh = 5= 4 1 1.3 h h = 8 = 6 1<br>Prediction 1 0 ? ? ? ? 10 [14] Compute (flops)10 [15] 10 [16] Hidden Bits012345 0 10 [13] Compute (flops)10 [14] 10 [15] Hidden Rows0 2 4 6 8 0<br>(a) Data generating process (b) Induction (hard) (c) Induction (easy)<br>Train Loss (Bits) Measured Epiplexity Train Loss (Bits) Measured Epiplexity<br>**----- End of picture text -----**<br>


Figure 5: **Studying induction through epiplexity.** (a) Our setup for creating induction problems. (b) Predicting Rule 30 ECA with hidden inputs. The LLM must induct on the _h_ bits missing from the input, paying a cost exponential in _h_ . For _h_ small enough but _>_ 0, epiplexity is increased. (c) Predicting Markov chain samples with hidden transition probabilities. Models that need to both use the provided probabilities and induct on the missing ones acquire the most epiplexity. 

test NLL is minimized when the two distributions match. The extent to which the distributions differ is regarded as a failure either from too limited a function class or insufficient data for generalization. From these arguments we could reasonably believe that AI models cannot surpass human intelligence when pretraining on human data. Here we provide two classes of phenomena that seem to contradict this viewpoint: induction, and emergence. In both cases, restricting the compute available to AI models leads them to extract more structural information than what is required for implementing the generating process itself. 

## 5.3.1 Induction 

The generative modeling community is often challenged with simultaneously wanting a tractable sampling process and tractable likelihood evaluation, with autoregressors, diffusion models, VAEs, GANs, and normalizing flows each providing different approaches. For natural generative processes, it is often the case that one direction may be much more straightforward than the other. Here we investigate generative processes which can be constructed by transforming latent variables such that computing likelihoods requires inducting on the values of those latents. 

A window into the phenomenon can be appreciated through this quote from Ilya Sutskever: 

“ _You’re reading a murder mystery and at some point the text reveals the identity of the criminal. ... If the model can predict [the name] then it must have figured out [who perpetrated the murder from the evidence provided]._ ” (Sutskever, 2019) 

The author of the book on the other hand, need not have made that same induction. Instead, they may have chosen the murderer first and then painted a compelling story of their actions. This example highlights a gap between the generating process and the requirements of a predictive model, a gap which we explore with the following more mathematical setup. 

As we illustrate in Figure 5(a), consider a simple to model random variable _Z_ over _{_ 0 _,_ 1 _}[n]_ which we transform with two functions _m_ and _f_ , which are both short in length and efficient to compute, and produce the data _Y_ = ( _m_ ( _Z_ ) _, f_ ( _Z_ )). We choose _m_ : _{_ 0 _,_ 1 _}[n] →{_ 0 _,_ 1 _}[n][−][h]_ as a masking function which removes the bits at a total of _h_ fixed locations in the input, leaving the rest unchanged. The generating process is simple to implement and can be executed efficiently. Now consider a likelihood generative model learning to model _Y_ , under any given factorization. With appropriate properties of the function _f_ , in producing the likelihoods the model must learn to induct on the missing information in the state _Z_ , and then apply the transformation given by the data generating process. We consider 

20 

cases both where the function _f_ is hard to invert and those where _f_ is not especially hard to invert. In both cases, predictive circuits must be learned that were not present in the data generating process, but with hard _f_ these circuits only appear at exponentially high compute. 

**Induction Hard: Rule 30 ECA.** For the first setting we use uniform _Z_ = _Un_ and _f_ as 4 steps of the rule 30 ECA on state size _n_ = 32, _m_ simply removes the first _h_ bits, and we also compute the loss only on _f_ ( _Z_ ) (conditioned on _m_ ( _Z_ )) as the bits in _m_ ( _Z_ ) are uniform and only add noise. We use an LLM, and the loss curves and measured epiplexities are shown in Figure 5b. The loss converges to the number of hidden bits _−_ log _P_ ( _f_ ( _Z_ ) _| m_ ( _Z_ )) = _h_ , representing the 2 _[h]_ possible inductions on the hidden state. However, the total compute required for this loss to converge grows exponentially with _h_ , an overall behavior consistent with a strategy of passing all 2 _[h]_ candidates through _f_ and then eliminating inconsistent candidates as values of _f_ ( _Z_ ) _i_ are observed with the autoregressive factorization. This complex learned function stands in contrast with the mere _f_ ( _Z_ ) and simple postprocessing removing bits with masking. This picture is mirrored by the measured epiplexity: as the model is forced to induct on the missing bits, the epiplexity grows. 

**Induction Easy: Random Markov Chains.** In the second setting, we leverage the statistical induction heads setup (Edelman et al., 2024) with a few modifications. _Z_ is given by a random Markov chain transition matrix with _V_ = 8 symbols, and _m_ removes _h_ columns of the matrix at fixed random locations. The function _f_ ( _Z_ ) computes a sampled sequence from the Markov chain of length _n_ = 512. When _h >_ 0, the optimal solution involves 1) using the provided rows _Z_ to perfectly predict next-token probabilities on _V − h_ of the symbols, and 2) inducting on the missing rows of _Z_ in-context based on the empirically observed transitions to improve remaining predictions. For _h_ = 0 _,_ the first is sufficient, and for _h_ = 8 the second is sufficient. In Figure 5c, we find evidence that both strategies are employed whenever 0 _< h <_ 8 as the final loss achieved matches the theoretical loss of both (the lower of the two dotted lines). The higher horizontal line marks the loss achievable using 1) along with a simple unigram strategy (Edelman et al., 2024), showing that the transformer learns 1) first and later the induction strategy 2). While the data generating program only only involves strategy one followed by the postprocessing masking step, the model must learn both strategies to reach these values. Measured epiplexity matches this picture, with values 0 _< h <_ 8 having higher epiplexity than _h_ = 0 or _h_ = 8. We emphasize that the induction strategy was never present in the data-generating process, yet it is learned by a generative model trained on that same data distribution. In Section G, we argue the induction phenomena are not specific to autoregressive models, but occur more generally for models trained via Maximum Likelihood Estimation as they need to be able to evaluate the likelihood _P_ ( _x_ ) for an arbitrary data point _x_ rather than merely sample random _x_ from _P._ VAEs (Kingma et al., 2013) provide a clear example of explicitly performing induction in non-autoregressive models: the encoder is trained specifically to approximate the posterior _PZ|X_ , enabling tractable likelihood estimation, yet this encoder is entirely unnecessary if the goal is merely to sample from the model. 

In both of the hard and easy induction examples, the size of the program needed to perform the induction strategy is greater than the size of the program needed generate the data. We can expect that with limited computational constraints, it will not be generically possible to invert the generation process using brute force, and thus, in cases where alternative inverse strategies exist (like the easy induction example with the statistical induction heads), those additional strategies increase the epiplexity. Given that there is likely no single generally applicable strategy for these computationally efficient inverses across problems, it is likely to be possible as a source of epiplexity. 

To make these statements more precise, it seems likely that there are _no_ constants _c_ 1 and _c_ 2 for which the following property holds: 

21 

**Limited Epiplexity Increase Property:** Given any program G : _{_ 0 _,_ 1 _}[k] →{_ 0 _,_ 1 _}[n]_ running in time at most _T_ 1 on random variable _Z_ , the epiplexity of _G_ ( _Z_ ) is increased by at most a constant more than the size of _G_ : S _T_ 2( _G_ ( _Uk_ )) _≤|_ G _|_ + _c_ 1 for _T_ 2( _n_ ) _> T_ 1( _k_ ) + _c_ 2. 

In other words, there is no bound on how much larger the MDL optimal probability model will be than the generating program even when the model is allowed more compute than the generating program. We present this phenomenon in contrast to Shannon information or Kolmogorov complexity, where a function and its inverse can differ in complexity by at most a fixed constant: _K_ ( _F[−]_[1] ) = _K_ ( _F_ )+ _O_ (1). When the computational constraints are lifted, the brute force inverse is possible, and there is no essential gap between deduction and induction, or between sampling and likelihood computation. 

## 5.3.2 Emergent Phenomena 

One of the most striking counterexamples to the “distribution matching” viewpoint is _emergence_ . Even when a system’s underlying dynamics admit a simple description, an observer with limited computation may need to learn a richer, and seemingly unrelated, set of concepts to predict or explain its behavior. As articulated by Anderson (1972), reductionism—that a complex object’s behavior follows from its parts—does not guarantee that knowing those parts lets us predict the whole. Across biology and physics, many-body interactions give rise to behaviors (e.g. bird flocking, Conway’s Game of Life patterns, molecular chemistry, superconductivity) that are not apparent from the microscopic laws alone. Here we sketch how emergence critically relates to the computational constraints of the observer, demonstrating how observers predicting future states may be required to learn _more_ than their unbounded counterparts who can execute the full generating process. 

Consider Type-Ib emergence in the Carroll and Parola (2024) classification, in which higher-level patterns arise from local rules yet resist prediction from those rules. A canonical example is Conway’s Game of Life (see Appendix E for definition), where iterating a simple computational rule Φ on a 2D grid leads to complex emergent behavior. For observers that lack the computational resources to directly compute the iterated evolution Φ _[k]_ , an alternate description must be found. In the state evolution, one can identify localized “species” (static blocks, oscillators, gliders, guns) which propagate through space and time. By classifying these species, learning their velocities, and how they are altered under collisions with other species, as well as the ability to identify their presence in the initial state, computationally more limited observers can make predictions about the future state of the system. Doing so, however, requires a more complex program in the sense of description length, and the epiplexity will be higher. We can formalize this intuition into the following definition of emergence. 

**Definition 14 (Epiplexity Emergent)** _Let {_ Φ _n}n≥_ 1 _be a computable family_ Φ _n_ : _{_ 0 _,_ 1 _}[n] →{_ 0 _,_ 1 _}[n] and let {Xn}n≥_ 1 _be random variables over {_ 0 _,_ 1 _}[n] . We say_ (Φ _, X_ ) _is_ epiplexity-emergent _if there exist time bounds T_ 1 _, T_ 2 _with T_ 1( _n_ ) = _o_ ( _T_ 2( _n_ )) _and an iteration schedule k_ ( _n_ ) _such that as n →∞,_ 

**==> picture [316 x 27] intentionally omitted <==**

_where we have suppressed the dependence of Xn and_ Φ _n on n for clarity._ 

22 

In words, Φ _, X_ displays emergent phenomena if two observers see equivalent structural complexity in the one step map, but asymptotically more structural complexity in the multistep map for the observer with fewer computational resources. 

Considering Φ from the Game of Life as an example, _P_ (Φ( _X_ ) _| X, n_ ) could be well estimated by both _T_ 1 and _T_ 2-bounded observers using the exact time evolution rule, using constant bits for both. _P_ (Φ _[k]_ ( _X_ ) _| X, n, k_ ) could be estimated by _T_ 2 using the iterated rule, but not by _T_ 1. Using knowledge of the different pattern species improves predictions of Φ _[k]_ ( _X_ ) _| X_ , so they would need to be learned; however, the number of patterns that needs to be considered in the time-bounded optimal solution is unbounded, and grows with the size of the board _n_ , and thus the gap in epiplexity for the two time bounds grows with _n_ . We have not proven that the Game of Life satisfies this definition, which is likely difficult as small changes to the evolution rule can destroy the emergent behavior; however, we provide empirical evidence for this set being non-empty with the example below. 

In Figure 6, we empirically demonstrate the emergence phenomenon by training a transformer to predict the iterated dynamics of ECA rule 54, a class IV rule that produces complex patterns. As in Conway’s Game of Life, a model with sufficient computation can exactly simulate the dynamics by directly iterating the per-step rule—a brute-force solution with a short description length. However, a compute-limited model cannot afford this approach and must instead learn emergent patterns (e.g., gliders and their collision rules) that approximately shortcut the infeasible exact simulation. The brute-force solution can be naturally implemented by learning to autoregressively unroll intermediate ECA states rather than directly predicting the final state, resembling the use of chain-of-thought (Wei et al., 2022) or looped transformers (Dehghani et al., 2018; Giannou 

**==> picture [153 x 101] intentionally omitted <==**

**----- Start of picture text -----**<br>
×10 [9] ×10 [7]<br>1.00 1.5<br>non-looped<br>0.75 looped<br>1.0<br>0.50<br>0.5<br>0.25<br>0.00 0.0<br>10 [15] 10 [17] 10 [15] 10 [17]<br>Compute Compute<br>)(XP<br> log 1/ E )(SXT<br>| +<br>|P<br>**----- End of picture text -----**<br>


Figure 6: **Emergence in ECA.** Compute-constrained models extract high epiplexity from data generated by simple rules, trading increased program length for reduced computation. 

et al., 2023; Saunshi et al., 2025). We provide experiment details in Section C.8. While initially the non-looped model (directly predicting final state) gradually achieves better MDL and higher epiplexity as compute increases, we identify a compute threshold beyond which the looped model suddenly becomes favorable, causing an abrupt drop in MDL and epiplexity, likely by learning the simple, brute-force solution. Below this threshold, the looped model underperforms likely because it lacks the compute to fully unroll the dynamics. The non-looped model, unable to rely on brute-force simulation, must instead learn increasingly sophisticated emergent rules, recognizing more species and their interactions, thus causing epiplexity to initially rise with compute before eventually falling. 

While this experiment cleanly demonstrates how compute-limited models can learn richer structure from data, it is a more uncommon situation where the brute-force solution is accessible, and where training with more compute reveals a much simpler underlying structure. With natural data and compute bounds that are not extraordinarily high, we expect that expending additional compute leads to increased rather than decreased observed structure. 

We explore other kinds of emergence, such as in chaotic dynamical systems or in the optimal strategies of game playing agents in Appendix F. Each of these examples presents clear evidence that in pursuit of the best probability distribution to explain the data, observers with limited compute will require models with greater description length than the minimal data generating process in order to achieve comparable predictive performance (Martínez et al., 2006; Redeker, 2010). Epiplexity provides a general tool for understanding and quantifying these phenomena of emergence, and how simple rules can create meaningful, complex structures that AI models can learn from, as recently demonstrated empirically by Zhang et al. (2024). 

23 

## **6 Epiplexity, Pre-Training, and OOD Generalization** 

Pre-training on internet-scale data has led to remarkable OOD generalization, yet a thorough understanding of this phenomenon remains elusive. What kinds of data provide the best signal for enabling broad generalization? Why does pre-training on text yield capabilities that transfer across domains while image data does not? As high-quality internet data becomes exhausted, what metric should guide the selection or synthesis of new pre-training data? In this section, we show how epiplexity helps answer these foundational questions. 

OOD generalization is fundamentally about how much reusable structure the model acquires, not how well it predicts in-distribution. Two models trained on different corpora can achieve the same in-distribution loss, yet differ dramatically in their ability to transfer to OOD tasks. This happens because loss captures only the residual unpredictability, corresponding to the time-bounded entropy, not how much reusable structure the model has internalized to achieve that loss. Epiplexity measures exactly this missing component: the amount of information in the learned program. Intuitively, loss indicates how random the data looks to the model, while epiplexity indicates how much structure the model must acquire to explain away the non-random part. If OOD generalization depends on reusing learned mechanisms rather than memorizing superficial statistics, then epiplexity is a natural lens through which to understand the relationship between pre-training data and OOD transfer. As a motivating toy example, Zhang et al. (2024) observed that downstream task performance benefits most from training on type IV ECA rules over the other ECA rules, aligned with Figure 3 where we showed that rule 54 (a type IV rule) induces much higher epiplexity compared to other rules. 

## **6.1 Epiplexity Correlates with OOD Generalization in Chess** 

We finetune models trained on either ordering from Section 5.2 on ×10[8] 0.3 0.3 two downstream tasks: (1) solving chess puzzles, where the model 2.5 must predict the _optimal_ next move given a board state (Burns 2.0 0.2 0.2 et al., 2023), and (2) predicting centipawn evaluation, where the 1.5 model evaluates positional advantage from FEN notation—a more 1.0 0.1 0.1 substantial distribution shift from next-move prediction learned in 0.5 0.0 0.0 0.0 pre-training. Experiment details are in Section C.4. As shown Epiplexity Puzzle Acc CP Acc in Figure 7, the reverse (board-then-moves) ordering yields higher Forward Reverse epiplexity and better downstream performance: matching accuracy Figure 7: **Epiplexity and** on chess puzzles but significantly higher accuracy on the centipawn **OOD performance in chess.** task. This result supports our hypothesis: the reverse order forces the Models trained on the higher epimodel to develop richer board-state representations needed to infer plexity reverse order performs the intermediate moves, and these representations transfer to OOD better in OOD tasks. tasks like centipawn evaluation that similarly require understanding the board state. This example reflects a more general principle: epiplexity measures the learnable structural information a model extracts from data to its weights, which is precisely the source of the information transferable to novel tasks, making epiplexity a plausible indicator for the potential of OOD generalization. However, we emphasize that higher epiplexity does not guarantee better generalization to any specific task: epiplexity measures the amount of structural information, irrespective of its content. A model trained on high epiplexity data can learn a lot of structures, but these structures may or may not be relevant to the particular downstream task of interest. 

Figure 7: **Epiplexity and OOD performance in chess.** Models trained on the higher epiplexity reverse order performs better in OOD tasks. 

## **6.2 Measuring Structural Information in Natural Data** 

Among different modalities of natural data, language has proven uniquely fruitful for pre-training, not only for improving in-distribution performance such as language understanding (Radford et al., 2019), 

24 

**==> picture [434 x 108] intentionally omitted <==**

**----- Start of picture text -----**<br>
2.5 1e10 0.60 12.3 16.0<br>10 [10] ST HT 10 [12] ST HT 2.82.6 ADO Natural 2.01.5 0.590.58 12.2 15.515.0<br>14.5<br>10 [9] 2.4 1.0 0.57 12.1 14.0<br>10 [10] 2.2 0.5 0.56 13.5<br>10 [8] 2.0 0.55 12.0 13.0<br>0.0 2.5 5.0<br>Step 1e4<br>(a) Epiplexity in natural data (b) Estimation via scaling laws (c) ADO: epiplexity and downstream metrics<br>LanguageImg VQ 32Img VQ 162 Vid VQ 162 Img 323 Img 162 2Img 82 Epiplexity AccuracyPerplexity 1Perplexity 2<br>OWText Chess (R) Chess CIFAR-5M<br>Training Loss<br>Information (bits) Information (bits)<br>**----- End of picture text -----**<br>


Figure 8: **Epiplexity reveals differences in the structural information across data modalities and can guide pre-training data selection.** ( **a** ) Estimated epiplexity and time-bounded entropy using requential coding for 1B OpenWebText, Chess, and CIFAR-5M tokens at 6 _×_ 10[18] FLOPs. ( **b** ) Estimated values based on scaling laws and prequential coding for 1T language, image, and video tokens at 10[25] FLOPs. ( **c** ) Selecting pre-training data using ADO (Jiang et al., 2025) leads to different loss curves than standard sampling (natural). Our measurement shows ADO selects data with higher epiplexity, in line with the improved downstream performance and OOD perplexity on different text corpora. 

but also for out-of-distribution tasks such as robotics control (Ahn et al., 2022), formal theorem proving (Song et al., 2024), and time-series forecasting (Gruver et al., 2023). While equally abundant total information is available in other modalities, such as images and videos, pre-training on those data sources typically does not confer a similarly broad increase in capabilities. We now show that epiplexity helps explain this asymmetry by revealing differences in their structural information content. In Figure 8a, we show the estimated decomposition of the information in 5B tokens of data from OpenWebText, Lichess, and CIFAR-5M (Nakkiran et al., 2020) into epiplexity (structural) and time-bounded entropy (random) with a time-bound of 6 _×_ 10[18] FLOPs, by training models of up to 160M parameters on at most 5B tokens using requential coding. In all cases, epiplexity accounts for only a tiny fraction of the total information, with the OpenWebText carrying the most epiplexity, followed by chess data. Despite having the most total information, CIFAR-5M data has the least epiplexity, as over 99% of its information is random (e.g., unpredictability of the exact pixels). 

## **6.3 Estimating Epiplexity from Scaling Laws** 

We can estimate the epiplexities of larger datasets at higher 10[11] 10[12] compute budgets using reported scaling laws, which describe the loss achieved by an _N_ -parameter model trained 10[10] on _D_ tokens as _L_ ( _N, D_ ) = _E_ + ( _N/N_ 0) _[−][α]_ + ( _D/D_ 0) _[−][β]_ , 10[11] for some dataset-specific constants _α, β, N_ 0 _, D_ 0 _, E_ (Hoff10[9] mann et al., 2022; Kaplan et al., 2020; Henighan et al., S (X) D[*] = 2020). By estimating the model’s description length via 10[22] 10[28] 10[22] 10[28] the prequential coding approach (Section 4.3), we obtain Compute Compute estimates for the epiplexity and time-bounded entropy for Language Img VQ 16[2] Img 32[2] Img 8[2] language, image, and video datasets, with varying resoluImg VQ 32[2] Vid VQ 16[3] Img 16[2] tions and tokenizations of size _D_ = 10[12] (1T) tokens under Figure 9: **Epiplexity and optimal train-** a compute budget of 10[25] FLOPs (equivalent to the train- **ing tokens for each fixed dataset con-** ing compute of Llama3 70B), illustrated in Figure 8b (see **verge to predictable limits as compute** details in Section C.9). Consistent with our smaller-scale **increases.** experiments, we find that language data has the highest epiplexity, while image data has the least. For image data, applying VQ tokenization leads to a significant increase in epiplexity, likely as a result of allowing the model to focus on higher-level 

Figure 9: **Epiplexity and optimal training tokens for each fixed dataset converge to predictable limits as compute increases.** 

25 

semantic structures. Video data has less time-bounded entropy and epiplexity than image data with the same resolution, likely due to significant redundancy across the temporal dimension. 

Using this approach, we can also gain some analytical insights about epiplexity for data admitting scaling laws of this form. As we derive in Section B.3, for a fixed dataset _X_ with _D_ tokens, the optimal split of the compute budget between training and inference (evaluating the trained model on _X_ ) approaches a fixed ratio as compute increases, with the optimal asymptotic training tokens _D∞[⋆]_[=] _[ D]_[and asymptotic epiplexity][ S] _[∞]_[(] _[X]_[) =] 1 _−ββ[D]_ 0 _[β][D]_[1] _[−][β][,]_[ both illustrated in Figure 9.][As expected,] the maximum amount of extractable structural information is ultimately capped by the dataset size _D_ when compute is not the bottleneck, and epiplexity can increase further if we also grow the dataset size. For large _D,_ the scale of the asymptotic epiplexity is primarily determined by _β_ and _D_ 0 _,_ with smaller _β_ and larger _D_ 0 leading to higher epiplexity, corresponding to slower improvement in loss and thus more (estimated) information absorbed per token. In line with our discussion on emergence in Section 5.3.2, it is possible that with significantly more compute much simpler programs can model these natural datasets, such as by directly simulating the basic laws of physics from which the natural world emerges, but the amount of required computation is likely so high that such programs remain inaccessible to any physically realizable observer and we must treat natural data as having high epiplexity for all practical purposes. 

## **6.4 Pre-Training Data Selection and Curriculum for Language Models** 

A crucial step in pretraining a language model is designing the composition of the pretraining data, but there lack clear guidelines for this step. Existing data mixtures are designed through extensive trial-and-error and rely on heuristic guidelines such as “diversity” or “high-quality”. More importantly, the primary way of comparing different training data is via perplexity metrics of held-out datasets and downstream performance. These procedures are highly susceptible to data contamination, overfitting to a narrow set of downstream evaluations, and Goodhart’s law. After all, no suite of downstream evaluations is extensive enough to faithfully capture the range of tasks that a general-purpose language model will encounter in the real world. 

As we argued above, epiplexity measures the structural information learned by the model, which could be affected by data selection strategies. Jiang et al. (2025) demonstrated that models of the loss curves for different data subsets can be used to dynamically adjust the data distribution online to favor data subsets whose training losses are _decreasing faster_[5] . Intuitively, this objective aligns with increasing the prequential estimate of epiplexity described in Section 4.1 by maximizing information absorbed per token. We hypothesize that the proposed algorithm, Adaptive Data Optimization (ADO), inadvertently achieves higher epiplexity. Experiments of Jiang et al. (2025) are conducted on decoder-only transformers with 1.3B parameters trained on 125B tokens from the Pile dataset (Gao et al., 2020). The models are evaluated on a suite of 7 zero-shot downstream tasks and two OOD validation datasets, SlimPajama (Soboleva et al., 2023) and FineWeb (Penedo et al., 2024). 

In Figure 8c(c), we show the estimated epiplexity and the downstream performance as well as perplexity on two OOD datasets, adapted from Jiang et al. (2025). As shown in Jiang et al. (2025), ADO achieves higher downstream performance than a standard data sampling strategy that uniformly samples from the entire dataset (denoted by _Natural_ in Figure 8c), despite not being optimized for any of these metrics. Interestingly, we see that ADO indeed achieves higher epiplexity measured by prequential coding. While these downstream evaluations do not capture everything about a pretrained model, they do offer evidence that epiplexity is a potentially useful concept for understanding the intrinsic value of pretraining data without particular downstream evaluations. 

> 5. It is worth noting that choosing data subsets with faster-decreasing loss does not mean that the observed training loss would be smaller because such data subsets tend to have higher loss values since there is more learnable information in them. Consequently, training on them often leads to a larger area under the training loss curve. 

26 

## **7 Additional Related Work** 

Epiplexity builds on a number of related ideas in algorithmic information theory and complexity science that attempt to theoretically characterize _meaningful information_ . A group of closely related concepts are sophistication (subsection 2.2), effective complexity, and logical depth. Similar to sophistication, effective complexity aims to separate random from structural content (Gell-Mann and Lloyd, 1996). From a different starting point, Bennett (1988) introduced logical depth, measuring the number of time steps required by a nearly optimal program to produce a given string, and which was later shown to be equivalent to sophistication through the busy beaver function (Antunes et al., 2005; Ay et al., 2010). Several other formal measures have been developed to quantify structured or meaningful complexity. Algorithmic statistics offers a principled decomposition of data into regular versus random components by introducing the notion of an algorithmic sufficient statistic (Vereshchagin and Vitányi, 2004), a concept closely tied to sophistication. Relatedly, statistical complexity in computational mechanics (Shalizi and Crutchfield, 2001) measures the entropy of causal states in an optimally predictive model, capturing structure in time-series data. As we argued above, these existing notions of complexity do not account for the limited computation available to the observer, which is essential for understanding machine learning algorithms. Being oblivious to computational limits means that they cannot characterize CSPRNGs or encrypted objects as being random. One might think that these failures are surface-level; for example, a plausible strategy would be to upgrade sophistication by replacing Kolmogorov complexity with time-bounded Kolmogorov complexity in (Definition 5). However, this approach does not work for several reasons, the most obvious being that CSPRNG outputs do have short and efficiently runnable generating programs and thus their time-bounded Kolmogorov complexities are small. A more subtle reason is that doing so results in trivial sophistication for all strings, which we discuss in more detail in Appendix A.6. 

Our work is also closely related to several lines of work trying to characterize observer-dependent notions of information. In cryptography, Barak et al. (2003) and Hsiao et al. (2007) discuss several possible definitions for _computational pseudoentropy_ , an observer-dependent analogue of entropy. HILL-pseudoentropy (Håstad et al., 1999) is defined relative to a class of tests: a source is considered random if no test within the class can distinguish it from a high-entropy distribution with nontrivial advantage, and Yao-pseudoentropy is defined via compressing and decompressing an object for example. Both definitions are closely related to time-bounded entropy, which measures the random content to a given computationally bounded observer; however, our formulation directly maps on to machine learning practice and allows for separating out the structural information content, a key contribution of our work. More recently, Xu et al. (2020) propose _V_ -entropy, a generalization of Shannon entropy to the minimum expected negative log probability over a given family of probability models, such as those with given computational constraints. With _V_ -entropy, the symmetry of information can be violated, and so too can the data processing inequality, though neither is explicitly proven in the paper. Unlike time-bounded entropy, the computational constraint in _V_ -entropy only limits the inference time, and does not account for the time to find such a model. Hence, the minimizer can be far away from the regime that is practically evaluated (such as models that are _trained_ on infinite data or with infinite compute). While these undesirable behaviors can be overcome by imposing further data constraints, we believe our formulation of imposing a single bound on both training and inference time leads to fewer complications. More importantly, both pseudoentropy and _V_ -entropy, much like time-bounded entropy, capture only the random component of information since it still measures the unpredictability of the random variable under the best feasible model. For understanding what useful information a model has learned, we are more interested in the non-random component of information as measured by epiplexity. Using existing measures of complexity, such as the Lempel-Ziv complexity and Wolfram classification, Zhang et al. (2024) showed that models trained on complex data like Class IV ECA rules tend to perform better on downstream tasks. 

27 

Other parts, such as the area under the curve estimate of epiplexity, have seen some related exploration in prior work. The concept of excess entropy, independently introduced under various names (Crutchfield and Packard, 1983; Shaw, 1984; Grassberger, 1986) and reviewed in Feldman (1998), is defined as the area between finite-block entropy density estimates and the asymptotic entropy rate of a stationary process, an analogous construction to our prequential estimate of epiplexity. However, excess entropy is defined for stationary processes observed by computationally unbounded agents, lacking the explicit dependence on the observer’s compute budget that we view as essential for the machine learning setting. More recently, Whitney et al. (2020) introduced surplus description length (SDL), which is the summed online loss of the training algorithm, with either the entropy of the data or a fixed baseline performance subtracted out. The authors use this measurement to evaluate pre-trained representations for solving a downstream task, arguing that smaller SDL is preferred as they lead to more efficient downstream learning. In contrast, we seek to create datasets and interventions to the data which _increase_ epiplexity. More analogous to the spirit of epiplexity is information transfer from Zhang et al. (2020), which sums a variant of a loss difference, adapted to held out test data and for the classification setting. In this work, the authors present information transfer to measure how much is learned from the data. Epiplexity is complementary to these works, clarifying the role of computation in defining information, and explicitly separating random and structural information. 

Several works have also explored how to quantify data complexity. Dziugaite and Roy (2025) suggests that the complexity of a minimal near-optimal reference model can be viewed as a measure of data complexity under the PAC-Bayes framework and how such data complexity gives rise to empirical scaling laws. This perspective is related to epiplexity in that both associate data complexity with the size of compact models that explain the data well. However, the two notions differ in important ways. In particular, the PAC-Bayes formulation is concerned with the existence of some small reference model achieving good in-distribution performance, whereas epiplexity characterizes the amount of structural information extractable by a computationally bounded observer, formalized through a two-part code that explicitly accounts for the cost of obtaining such a model. Further, our primary interest is not in characterizing in-distribution generalization, but in using epiplexity to measure the intrinsic value of data in settings that extend beyond supervised learning. Relatedly, Hutter (2021) shows that power-law learning curves can emerge under specific assumptions on the data-generating distribution, illustrating how properties of the data itself can shape empirical scaling behavior. While this line of work focuses on explaining observed learning dynamics rather than defining a complexity measure, it similarly emphasizes the role of data structure in determining learning outcomes. These perspectives on data complexity can be viewed as instances of _coarse graining_ , where one seeks a compressed representation that preserves some notion of “relevant” structure. A canonical example is the information bottleneck framework, which formalizes coarse graining as a trade-off between compression and retained information about a relevant variable (Tishby et al., 2000). Epiplexity is aligned with this perspective, but rather than defining relevance through a task variable or through distinguishability to tests, it measures the amount of structural information extractable by a computationally bounded learner, while explicitly accounting for the cost of obtaining the model. 

More broadly, our work is related to several lines of work on how resource constraints fundamentally alter the notion of simplicity and learnability. In algorithmic information theory, Schmidhuber (2002) proposes the speed prior, which replaces Solomonoff’s universal prior with a _computable_ semimeasure that favors both shorter program length and smaller computation time, thereby incorporating computational resources directly into the definition of simplicity. Achille and Soatto (2025) argue that in the transductive setting, the role of information from past data is to reduce the time needed to solve new tasks rather than to reduce uncertainty, with the optimal speedup tightly characterized by the amount of shared algorithmic information between past data and future tasks. In this setting, _larger_ information content is shown to be more conducive to better performance. In learning theory, a related line of work shows that computational limitations can directly affect what can be learned 

28 

from data. For instance, in the problem of sparse PCA detection, Berthet and Rigollet (2013) show that although there exist procedures that succeed with an information-theoretically minimal number of samples, any algorithm that runs in polynomial time necessarily requires more data under widely used average-case hardness assumptions. Memory and space constraints alone can also qualitatively change learnability. Steinhardt et al. (2016) show that restricting a learner’s memory can dramatically increase the amount of data required to learn, even when the target concept itself has a very concise description. They identify parity functions as a canonical example where this tension is conjectured to be sharp. Raz (2018) later resolves this conjecture by proving that any learner with sub-quadratic memory requires exponentially many samples to learn parity from random examples. 

## **8 Discussion** 

Much of classical information theory is concerned with the representation and transmission of information, and abstracts away key aspects of the computational processes by which information is extracted and used. While complexity theory and cryptography treat computation as fundamental, machine learning theory typically does not. Yet learning, whether biological or artificial, is an inherently computational process. What can be learned from data depends not only on statistical feasibility, but on the available resources. This perspective calls for more theoretical tools that place computation on an equal footing with information. 

This work reframes information as a property of data relative to a computationally bounded observer, and demonstrates that information can be decomposed into time-bounded entropy and epiplexity, a formalization of structural information. It also sheds light on how perceived information can be changed through computation. This perspective resolves several tensions between information theory and empirical machine learning—including the usefulness of synthetic data, the dependence of learning on factorization and ordering, and the emergence of structure beyond the data-generating process itself. Technically, epiplexity connects ideas from algorithmic statistics, cryptography, and learning theory, showing that standard assumptions (i.e., existence of one-way functions) suffice to produce distributions with high structural complexity for efficient learners. 

Our framework opens several exciting directions for future work. On the theoretical side, it invites a systematic and more fine-grained understanding of how structural information changes with computational budget, model class, and data transformations, potentially yielding new lower bounds and impossibility results for representation learning and transfer. Taking information and computation as the fundamental resources may offer new explanations for the relative universality observed in large-scale training, including why scaling law exponents depend only weakly on architectural and optimizer details. There is also a possibility of a compute-aware analogue of classical notions such as sufficient statistics and information bottlenecks. More broadly, framing emergence, induction, and generalization through the lens of computationally bounded observers may offer a unifying language across learning theory, algorithmic information theory, cryptography, and complexity theory. 

On the empirical side, epiplexity provides a way to reason about why some data sources, formatting, and transformations can lead to more transferable models than others, even when they do not improve training loss. The framework suggests that pretraining data should be evaluated not only by held-out perplexity, but by how much reusable structural information it induces in a computationally bounded model. This perspective helps explain empirical successes of curriculum design, data ordering, augmentation strategies, and even synthetic data that appear counterintuitive from a purely statistical viewpoint. Our empirical estimator offers a concrete starting point for comparing datasets and interventions in data centric research. In the long run, we believe epiplexity could provide guidance on how to generate new synthetic data from existing data. 

29 

Finally, representation learning can be understood as the gradual accumulation of epiplexity: the construction of increasingly rich internal programs that approximate a data distribution within a fixed time budget. While epiplexity in isolation is not a measure of generalization, or a complete theory of learning, this perspective raises the possibility of new notions of hardness for learning and transfer that are orthogonal to classical PAC-style measures, capturing not sample complexity but the size of the structure that must be extracted. Such notions may help explain why certain tasks appear to require disproportionately large models or long training horizons despite admitting simple generative descriptions, and why improvements in generalization sometimes correlate more strongly with training dynamics or data structure than with likelihood alone. 

**Acknowledgements.** We thank NSF CAREER IIS-2145492, NSF CDS&E-MSS 2134216, and DARPA AIQ HR00112590066 for support, and Scott Aaronson, Alan Amin, Brandon Amos, Martin Marek, Zhili Feng, Vaishnavh Nagarajan, Patrick Shafto, Charlie Chen, Alex Ozdemir, Andres Potapczynski, and Ethan Baron for helpful feedback. This work was supported by Google’s TPU Research Cloud (TRC) program: `https://sites.research.google/trc` . YJ thanks the support of the Google PhD Fellowship, and SQ thanks the support of the Two Sigma Fellowship. 

## **References** 

- Scott Aaronson, Sean M Carroll, and Lauren Ouellette. Quantifying the rise and fall of complexity in closed systems: the coffee automaton. _arXiv preprint arXiv:1405.6903_ , 2014. 

- Marah Abdin, Jyoti Aneja, Harkirat Behl, Sébastien Bubeck, Ronen Eldan, Suriya Gunasekar, Michael Harrison, Russell J Hewett, Mojan Javaheripi, Piero Kauffmann, et al. Phi-4 technical report. _arXiv preprint arXiv:2412.08905_ , 2024. 

- Alessandro Achille and Stefano Soatto. Ai agents as universal task solvers. _arXiv preprint arXiv:2510.12066_ , 2025. 

- Michael Ahn, Anthony Brohan, Noah Brown, Yevgen Chebotar, Omar Cortes, Byron David, Chelsea Finn, Chuyuan Fu, Keerthana Gopalakrishnan, Karol Hausman, et al. Do as i can, not as i say: Grounding language in robotic affordances. _arXiv preprint arXiv:2204.01691_ , 2022. 

- Eric Allender, Michal Kouck`y, Detlef Ronneburger, and Sambuddha Roy. The pervasive reach of resource-bounded kolmogorov complexity in computational complexity theory. _Journal of Computer and System Sciences_ , 77(1):14–40, 2011. 

- Philip W Anderson. More is different: Broken symmetry and the nature of the hierarchical structure of science. _Science_ , 177(4047):393–396, 1972. 

- Luis Antunes, Lance Fortnow, Dieter van Melkebeek, and N. V. Vinodchandran. Sophistication revisited. _Theory of Computing Systems_ , 38(4):535–555, 2005. 

- Benny Applebaum. Cryptographic hardness of random local functions: Survey. _Computational complexity_ , 25(3):667–722, 2016. 

- Nihat Ay, Markus Müller, and Arleta Szkola. Effective complexity and its relation to logical depth. _IEEE transactions on information theory_ , 56(9):4593–4607, 2010. 

- Johannes Ballé, David Minnen, Saurabh Singh, Sung Jin Hwang, and Nick Johnston. Variational image compression with a scale hyperprior. _arXiv preprint arXiv:1802.01436_ , 2018. 

30 

- Boaz Barak, Ronen Shaltiel, and Avi Wigderson. Computational analogues of entropy. In _International Workshop on Randomization and Approximation Techniques in Computer Science_ , pages 200–215. Springer, 2003. 

- Yoshua Bengio, Tristan Deleu, Nasim Rahaman, Rosemary Ke, Sébastien Lachapelle, Olexa Bilaniuk, Anirudh Goyal, and Christopher Pal. A meta-transfer objective for learning to disentangle causal mechanisms. _arXiv preprint arXiv:1901.10912_ , 2019. 

- Charles H Bennett. Logical depth and physical complexity. _The Universal Turing Machine: A Half-Century Survey_ , 1:227–257, 1988. 

- Quentin Berthet and Philippe Rigollet. Computational lower bounds for sparse pca. _arXiv preprint arXiv:1304.0828_ , 2013. 

- Manuel Blum and Silvio Micali. How to generate cryptographically strong sequences of pseudo random bits. In _23rd Annual Symposium on Foundations of Computer Science (sfcs 1982)_ , pages 112–117, 1982. doi: 10.1109/SFCS.1982.72. 

- James Bradbury, Roy Frostig, Peter Hawkins, Matthew James Johnson, Chris Leary, Dougal Maclaurin, George Necula, Adam Paszke, Jake VanderPlas, Skye Wanderman-Milne, and Qiao Zhang. JAX: composable transformations of Python+NumPy programs, 2018. URL `http: //github.com/jax-ml/jax` . 

- Collin Burns, Pavel Izmailov, Jan Hendrik Kirchner, Bowen Baker, Leo Gao, Leopold Aschenbrenner, Yining Chen, Adrien Ecoffet, Manas Joglekar, Jan Leike, et al. Weak-to-strong generalization: Eliciting strong capabilities with weak supervision. _arXiv preprint arXiv:2312.09390_ , 2023. 

Sean M Carroll and Achyuth Parola. What emergence can possibly mean. _arXiv preprint arXiv:2410.15468_ , 2024. 

- Gregory J Chaitin. Information-theoretic limitations of formal systems. _Journal of the ACM (JACM)_ , 21(3):403–424, 1974. 

- Gregory J Chaitin. A theory of program size formally identical to information theory. _Journal of the ACM (JACM)_ , 22(3):329–340, 1975. 

- Gregory J Chaitin. _The limits of mathematics: A course on information theory and the limits of formal reasoning_ . Springer, 1998. 

- James P Crutchfield and NH719053 Packard. Symbolic dynamics of noisy chaos. _Physica D: Nonlinear Phenomena_ , 7(1-3):201–223, 1983. 

- A Philip Dawid. Present position and potential developments: Some personal views statistical theory the prequential approach. _Journal of the Royal Statistical Society: Series A (General)_ , 147(2): 278–290, 1984. 

- Mostafa Dehghani, Stephan Gouws, Oriol Vinyals, Jakob Uszkoreit, and Lukasz Kaiser. Universal transformers. _arXiv preprint arXiv:1807.03819_ , 2018. 

- Grégoire Delétang, Anian Ruoss, Paul-Ambroise Duquenne, Elliot Catt, Tim Genewein, Christopher Mattern, Jordi Grau-Moya, Li Kevin Wenliang, Matthew Aitchison, Laurent Orseau, et al. Language modeling is compression. _arXiv preprint arXiv:2309.10668_ , 2023. 

- Nolan Dey, Bin Claire Zhang, Lorenzo Noci, Mufan Li, Blake Bordelon, Shane Bergsma, Cengiz Pehlevan, Boris Hanin, and Joel Hestness. Don’t be lazy: Completep enables compute-efficient deep transformers. _arXiv preprint arXiv:2505.01618_ , 2025. 

31 

- Rod Downey and Denis R Hirschfeldt. Algorithmic randomness. _Communications of the ACM_ , 62 (5):70–80, 2019. 

- Gintare Karolina Dziugaite and Daniel M Roy. The size of teachers as a measure of data complexity: Pac-bayes excess risk bounds and scaling laws. In _The 28th International Conference on Artificial Intelligence and Statistics_ , 2025. 

- Benjamin L Edelman, Ezra Edelman, Surbhi Goel, Eran Malach, and Nikolaos Tsilivis. The evolution of statistical induction heads: In-context learning markov chains. _arXiv preprint arXiv:2402.11004_ , 2024. 

David Feldman. Information theory, excess entropy. 1998. 

- Marc Finzi, Sanyam Kapoor, Diego Granziol, Anming Gu, Christopher De Sa, J Zico Kolter, and Andrew Gordon Wilson. Compute-optimal llms provably generalize better with scale. _arXiv preprint arXiv:2504.15208_ , 2025. 

Marc Finzi, et, and al. Requential coding. Forthcoming, 2026. 

- Aviezri S Fraenkel and David Lichtenstein. Computing a perfect strategy for n _×_ n chess requires time exponential in n. In _International Colloquium on Automata, Languages, and Programming_ , pages 278–293. Springer, 1981. 

- Leo Gao, Stella Biderman, Sid Black, Laurence Golding, Travis Hoppe, Charles Foster, Jason Phang, Horace He, Anish Thite, Noa Nabeshima, et al. The pile: An 800gb dataset of diverse text for language modeling. _arXiv preprint arXiv:2101.00027_ , 2020. 

Martin Gardner. Mathematical games. _Scientific american_ , 222(6):132–140, 1970. 

- Murray Gell-Mann and Seth Lloyd. Information measures, effective complexity, and total information. _Complexity_ , 2(1):44–52, 1996. 

- Matthias Gerstgrasser, Rylan Schaeffer, Apratim Dey, Rafael Rafailov, Henry Sleight, John Hughes, Tomasz Korbak, Rajashree Agrawal, Dhruv Pai, Andrey Gromov, et al. Is model collapse inevitable? breaking the curse of recursion by accumulating real and synthetic data. _arXiv preprint arXiv:2404.01413_ , 2024. 

- Angeliki Giannou, Shashank Rajput, Jy-yong Sohn, Kangwook Lee, Jason D Lee, and Dimitris Papailiopoulos. Looped transformers as programmable computers. In _International Conference on Machine Learning_ , pages 11398–11442. PMLR, 2023. 

- Micah Goldblum, Marc Finzi, Keefer Rowan, and Andrew Gordon Wilson. The no free lunch theorem, kolmogorov complexity, and the role of inductive biases in machine learning. _arXiv preprint arXiv:2304.05366_ , 2023. 

- Oded Goldreich. _Foundations of Cryptography: Volume 1, Basic Tools_ . Cambridge University Press, 2006. 

- Oded Goldreich and Leonid A Levin. A hard-core predicate for all one-way functions. In _Proceedings of the twenty-first annual ACM symposium on Theory of computing_ , pages 25–32, 1989. 

- Peter Grassberger. Toward a quantitative theory of self-generated complexity. _International Journal of Theoretical Physics_ , 25(9):907–938, 1986. 

Peter D Grünwald. _The minimum description length principle_ . MIT press, 2007. 

Peter D Grünwald, PM Vitányi, et al. Algorithmic information theory, 2008. 

32 

- Nate Gruver, Marc Finzi, Shikai Qiu, and Andrew G Wilson. Large language models are zero-shot time series forecasters. _Advances in Neural Information Processing Systems_ , 36:19622–19635, 2023. 

- Alex Hägele, Elie Bakouch, Atli Kosson, Leandro Von Werra, Martin Jaggi, et al. Scaling laws and compute-optimal training beyond fixed training durations. _Advances in Neural Information Processing Systems_ , 37:76232–76264, 2024. 

- Johan Håstad, Russell Impagliazzo, Leonid A Levin, and Michael Luby. A pseudorandom generator from any one-way function. _SIAM Journal on Computing_ , 28(4):1364–1396, 1999. 

- Tom Henighan, Jared Kaplan, Mor Katz, Mark Chen, Christopher Hesse, Jacob Jackson, Heewoo Jun, Tom B Brown, Prafulla Dhariwal, Scott Gray, et al. Scaling laws for autoregressive generative modeling. _arXiv preprint arXiv:2010.14701_ , 2020. 

- Jordan Hoffmann, Sebastian Borgeaud, Arthur Mensch, Elena Buchatskaya, Trevor Cai, Eliza Rutherford, Diego de Las Casas, Lisa Anne Hendricks, Johannes Welbl, Aidan Clark, et al. Training compute-optimal large language models. _arXiv preprint arXiv:2203.15556_ , 2022. 

- Chun-Yuan Hsiao, Chi-Jen Lu, and Leonid Reyzin. Conditional computational entropy, or toward separating pseudoentropy from compressibility. In _Annual International Conference on the Theory and Applications of Cryptographic Techniques_ , pages 169–186. Springer, 2007. 

- Marcus Hutter. Learning curve theory. _arXiv preprint arXiv:2102.04074_ , 2021. 

- Yiding Jiang, Allan Zhou, Zhili Feng, Sadhika Malladi, and J Zico Kolter. Adaptive data optimization: Dynamic sample selection with scaling laws. In _The Thirteenth International Conference on Learning Representations_ , 2025. URL `https://openreview.net/forum?id=aqok1UX7Z1` . 

- Jared Kaplan, Sam McCandlish, Tom Henighan, Tom B Brown, Benjamin Chess, Rewon Child, Scott Gray, Alec Radford, Jeffrey Wu, and Dario Amodei. Scaling laws for neural language models. _arXiv preprint arXiv:2001.08361_ , 2020. 

- Diederik P Kingma, Max Welling, et al. Auto-encoding variational bayes, 2013. 

- A. N. Kolmogorov. Three approaches to the quantitative definition of information *. _International Journal of Computer Mathematics_ , 2(1-4):157–168, 1968. doi: 10.1080/00207166808803030. URL `https://doi.org/10.1080/00207166808803030` . 

- Moshe Koppel. Structure. In Rolf Herken, editor, _The Universal Turing Machine: A Half-Century Survey_ , pages 435–452. Oxford University Press, 1988. 

- Leon G. Kraft. A device for quantizing, grouping, and coding amplitude-modulated pulses. S.m. thesis, Massachusetts Institute of Technology, Cambridge, MA, 1949. URL `https://hdl.handle. net/1721.1/12390` . 

- Ming Li and Paul Vitányi. _An introduction to Kolmogorov complexity and its applications_ . Springer, New York, NY, 2008. 

- Ming Li, Paul Vitányi, et al. _An introduction to Kolmogorov complexity and its applications_ , volume 3. Springer, 2008. 

- Aixin Liu, Bei Feng, Bing Xue, Bingxuan Wang, Bochao Wu, Chengda Lu, Chenggang Zhao, Chengqi Deng, Chenyu Zhang, Chong Ruan, et al. Deepseek-v3 technical report. _arXiv preprint arXiv:2412.19437_ , 2024. 

33 

- Yanyi Liu and Rafael Pass. A direct prf construction from kolmogorov complexity. In _Annual International Conference on the Theory and Applications of Cryptographic Techniques_ , pages 375–406. Springer, 2024. 

- David JC MacKay. _Information theory, inference and learning algorithms_ . Cambridge university press, 2003. 

- Pratyush Maini, Skyler Seto, He Bai, David Grangier, Yizhe Zhang, and Navdeep Jaitly. Rephrasing the web: A recipe for compute and data-efficient language modeling. _arXiv preprint arXiv:2401.16380_ , 2024. 

- Per Martin-Löf. The definition of random sequences. _Information and control_ , 9(6):602–619, 1966. 

- Genaro Juárez Martínez, Andrew Adamatzky, and Harold V McIntosh. Phenomenology of glider collisions in cellular automaton rule 54 and associated logical gates. _Chaos, Solitons & Fractals_ , 28 (1):100–111, 2006. 

- Sean McLeish, John Kirchenbauer, David Yu Miller, Siddharth Singh, Abhinav Bhatele, Micah Goldblum, Ashwinee Panda, and Tom Goldstein. Gemstones: A model suite for multi-faceted scaling laws. _arXiv preprint arXiv:2502.06857_ , 2025. 

- Brockway McMillan. Two inequalities implied by unique decipherability. _IRE Transactions on Information Theory_ , 2(4):115–116, December 1956. doi: 10.1109/TIT.1956.1056818. 

- Ralph C Merkle. Secure communications over insecure channels. _Communications of the ACM_ , 21 (4):294–299, 1978. 

- Roger J. Metzger. Sinai-ruelle-bowen measures for contracting Lorenz maps and flows. _Annales de l’I.H.P. Analyse non linéaire_ , 17(2):247–276, 2000. URL `https://www.numdam.org/item/AIHPC_ 2000__17_2_247_0/` . 

- Francisco Mota, Scott Aaronson, Luís Antunes, and André Souto. Sophistication as randomness deficiency. In _Descriptional Complexity of Formal Systems: 15th International Workshop, DCFS 2013, London, ON, Canada, July 22-25, 2013. Proceedings 15_ , pages 172–181. Springer, 2013. 

- Preetum Nakkiran, Behnam Neyshabur, and Hanie Sedghi. The deep bootstrap framework: Good online learners are good offline generalizers. _arXiv preprint arXiv:2010.08127_ , 2020. 

- Catherine Olsson, Nelson Elhage, Neel Nanda, Nicholas Joseph, Nova DasSarma, Tom Henighan, Ben Mann, Amanda Askell, Yuntao Bai, Anna Chen, et al. In-context learning and induction heads. _arXiv preprint arXiv:2209.11895_ , 2022. 

- OpenAI. GPT-5 System Card. `https://cdn.openai.com/gpt-5-system-card.pdf` , August 2025. Version dated August 13, 2025. Accessed: 2026-01-05. 

- Vassilis Papadopoulos, Jérémie Wenger, and Clément Hongler. Arrows of time for large language models. In _Forty-first International Conference on Machine Learning_ , 2024. URL `https:// openreview.net/forum?id=UpSe7ag34v` . 

- Tim Pearce and Jinyeop Song. Reconciling kaplan and chinchilla scaling laws. _arXiv preprint arXiv:2406.12907_ , 2024. 

- Guilherme Penedo, Hynek Kydlíček, Anton Lozhkov, Margaret Mitchell, Colin A Raffel, Leandro Von Werra, Thomas Wolf, et al. The fineweb datasets: Decanting the web for the finest text data at scale. _Advances in Neural Information Processing Systems_ , 37:30811–30849, 2024. 

34 

- Ya B Pesin. Characteristic lyapunov exponents and smooth ergodic theory. _Russian Mathematical Surveys_ , 32(4):55, 1977. 

- Alec Radford, Jeffrey Wu, Rewon Child, David Luan, Dario Amodei, Ilya Sutskever, et al. Language models are unsupervised multitask learners. _OpenAI blog_ , 1(8):9, 2019. 

- Ran Raz. Fast learning requires good memory: A time-space lower bound for parity learning. _Journal of the ACM (JACM)_ , 66(1):1–18, 2018. 

- Markus Redeker. A language for particle interactions in one-dimensional cellular automata. _arXiv preprint arXiv:1012.0158_ , 2010. 

- Jorma Rissanen. Minimum description length principle. _Encyclopedia of statistical sciences_ , 7, 2004. 

- John K Salmon, Mark A Moraes, Ron O Dror, and David E Shaw. Parallel random numbers: as easy as 1, 2, 3. In _Proceedings of 2011 international conference for high performance computing, networking, storage and analysis_ , pages 1–12, 2011. 

- Nikunj Saunshi, Nishanth Dikkala, Zhiyuan Li, Sanjiv Kumar, and Sashank J Reddi. Reasoning with latent thoughts: On the power of looped transformers. _arXiv preprint arXiv:2502.17416_ , 2025. 

- Jürgen Schmidhuber. The speed prior: a new simplicity measure yielding near-optimal computable predictions. In _International conference on computational learning theory_ , pages 216–228. Springer, 2002. 

- Glenn Shafer and Vladimir Vovk. The sources of kolmogorov’s grundbegriffe. 2006. 

- Cosma Rohilla Shalizi and James P Crutchfield. Computational mechanics: Pattern and prediction, structure and simplicity. _Journal of Statistical Physics_ , 104(3–4):817–879, 2001. 

- Claude E Shannon. A mathematical theory of communication. _The Bell system technical journal_ , 27 (3):379–423, 1948. 

- Claude E. Shannon. Programming a computer for playing chess. _Philosophical Magazine_ , 41(314): 256–275, 1950. 

- Robert Shaw. The dripping faucet as a model chaotic system. _(No Title)_ , 1984. 

- David Silver, Thomas Hubert, Julian Schrittwieser, Ioannis Antonoglou, Matthew Lai, Arthur Guez, Marc Lanctot, Laurent Sifre, Dharshan Kumaran, Thore Graepel, et al. A general reinforcement learning algorithm that masters chess, shogi, and go through self-play. _Science_ , 362(6419):1140–1144, 2018. 

- Daria Soboleva, Faisal Al-Khateeb, Robert Myers, Jacob R Steeves, Joel Hestness, and Nolan Dey. SlimPajama: A 627B token cleaned and deduplicated version of RedPajama. `https://cerebras. ai/blog/slimpajama-a-627b-token-cleaned-and-deduplicated-version-of-redpajama` , 2023. URL `https://huggingface.co/datasets/cerebras/SlimPajama-627B` . 

- Peiyang Song, Kaiyu Yang, and Anima Anandkumar. Towards large language models as copilots for theorem proving in lean. _arXiv preprint arXiv:2404.12534_ , 2024. 

- Jacob Steinhardt, Gregory Valiant, and Stefan Wager. Memory, communication, and statistical queries. In _Conference on Learning Theory_ , pages 1490–1516. PMLR, 2016. 

- Ilya Sutskever. Gpt-2. Presented at the Scaled Machine Learning Conference 2019, Computer History Museum, 2019. `https://www.youtube.com/watch?v=T0I88NhR_9M` . 

35 

- Sebastiaan A Terwijn. The mathematical foundations of randomness. In _The Challenge of Chance: A Multidisciplinary Approach from Science and the Humanities_ , pages 49–66. Springer International Publishing Cham, 2016. 

- Lucas Theis and Noureldin Y Ahmed. Algorithms for the communication of samples. In _International Conference on Machine Learning_ , pages 21308–21328. PMLR, 2022. 

- Naftali Tishby, Fernando C Pereira, and William Bialek. The information bottleneck method. _arXiv preprint physics/0004057_ , 2000. 

- Nikolay Vereshchagin and Paul M.B. Vitányi. Kolmogorov’s structure functions and model selection. _IEEE Transactions on Information Theory_ , 50(12):3265–3290, 2004. 

- John von Neumann. Zur theorie der gesellschaftsspiele. _Mathematische Annalen_ , 100(1):295–320, 1928. 

- John Von Neumann. Various techniques used in connection with random digits. _Appl. Math Ser_ , 12 (36-38):3, 1951. 

- Jason Wei, Xuezhi Wang, Dale Schuurmans, Maarten Bosma, Fei Xia, Ed Chi, Quoc V Le, Denny Zhou, et al. Chain-of-thought prompting elicits reasoning in large language models. _Advances in neural information processing systems_ , 35:24824–24837, 2022. 

- Gail Weiss, Yoav Goldberg, and Eran Yahav. Thinking like transformers. In _International Conference on Machine Learning_ , pages 11080–11090. PMLR, 2021. 

- William F Whitney, Min Jae Song, David Brandfonbrener, Jaan Altosaar, and Kyunghyun Cho. Evaluating representations by the complexity of learning low-loss predictors. _arXiv preprint arXiv:2009.07368_ , 2020. 

- Stephen Wolfram and M Gad-el Hak. A new kind of science. _Appl. Mech. Rev._ , 56(2):B18–B19, 2003. 

- Yilun Xu, Shengjia Zhao, Jiaming Song, Russell Stewart, and Stefano Ermon. A theory of usable information under computational constraints. _arXiv preprint arXiv:2002.10689_ , 2020. 

- Greg Yang and Etai Littwin. Tensor programs ivb: Adaptive optimization in the infinite-width limit. _arXiv preprint arXiv:2308.01814_ , 2023. 

- Greg Yang, Edward J Hu, Igor Babuschkin, Szymon Sidor, Xiaodong Liu, David Farhi, Nick Ryder, Jakub Pachocki, Weizhu Chen, and Jianfeng Gao. Tensor programs v: Tuning large neural networks via zero-shot hyperparameter transfer. _arXiv preprint arXiv:2203.03466_ , 2022. 

- Andrew Chi-Chih Yao. Theory and applications of trapdoor functions (extended abstract). In _23rd Annual Symposium on Foundations of Computer Science (FOCS)_ , pages 80–91. IEEE Computer Society, 1982. doi: 10.1109/SFCS.1982.95. 

- Shiyang Zhang, Aakash Patel, Syed A Rizvi, Nianchen Liu, Sizhuang He, Amin Karbasi, Emanuele Zappala, and David van Dijk. Intelligence at the edge of chaos. _arXiv preprint arXiv:2410.02536_ , 2024. 

- Xiao Zhang, Xingjian Li, Dejing Dou, and Ji Wu. Measuring information transfer in neural networks. _arXiv preprint arXiv:2009.07624_ , 2020. 

- Hattie Zhou, Arwen Bradley, Etai Littwin, Noam Razin, Omid Saremi, Josh Susskind, Samy Bengio, and Preetum Nakkiran. What algorithms can transformers learn? a study in length generalization. _arXiv preprint arXiv:2310.16028_ , 2023. 

36 

## **Appendix Outline** 

This appendix provides the technical details, proofs, and experimental specifications supporting the main text. 

**Appendix A** presents rigorous proofs of all theoretical results, including properties of cryptographically secure pseudorandom number generators under time-bounded entropy and epiplexity (Theorem 9), creation of information through deterministic transformations (Theorem 12), the existence of high-epiplexity random variables (Theorem 10), the factorization dependence of information content (Theorem 13). 

**Appendix B** details the practical methodology for estimating epiplexity, covering both prequential and requential coding implementations, hyperparameter optimization procedures for compute-optimal two-part codes, the connection between prequential and requential estimates under a static teacher assumption, and a solvable analytical model combining neural scaling laws with prequential coding. We also establish general properties showing that optimal model size and training tokens increase monotonically with compute budget, that optimal training tokens for prequential coding generally saturate at the test set size for large compute budgets, and that epiplexity and per-token entropy exhibit predictable monotonicity with respect to dataset size. 

**Appendix C** provides comprehensive experimental specifications for all empirical results, including architectural choices, hyperparameters, and dataset details for elementary cellular automata experiments, easy and hard variants of induction tasks, chess experiments (with both pre-training data formatting and downstream evaluation tasks), natural data experiments on OpenWebText and CIFAR-5M, comparisons between prequential and requential coding estimates, and scaling law estimation procedures. 

**Appendix D** presents executable RASP-L code demonstrating that elementary cellular automaton evolution rules can be implemented within the transformer computational model, providing constructive evidence that autoregressive transformers are capable of solving these tasks. 

**Appendix E** contains definitions of elementary cellular automata and Conway’s Game of Life, emergence examples referenced in the paper. 

**Appendix F** explores additional examples illustrating the relationship between emergence and epiplexity, including the Lorenz system as a case study in chaotic dynamics where entropy is created at a rate determined by Lyapunov exponents, and chess strategy as exemplified by the contrast between AlphaZero’s multi-million parameter networks solution at moderate compute and the simple minimax algorithm available at very high compute. 

**Appendix G** argues that induction phenomena occur not merely in autoregressive models; instead, the key requirement is maximum likelihood estimation rather than autoregressive factorization specifically. 

**Appendix H** provides a more comprehensive review of MDL, in particular on two-part code, one-part code and the notion of regret, related to epiplexity. 

**Compute Resources.** A cluster of 6 2080Ti was used for many of the smaller scale experiments. A cluster of 6 Titan RTX and 32 TPUv4 provided by the Google TPU Research Cloud was used for the more computationally expensive natural data experiments. We refer the reader to Jiang et al. (2025) for computational resources required in evaluating ADO. 

**Licenses.** The Chess data used in Section 5.2 is released under Creative Commons CC0 license ( `database.lichess.org/` ). The OpenWebText dataset used in Section 6.2 is released under Creative Commons CC0 license. 

37 

## **Appendix A. Proofs** 

First, we prove two short lemmas about the basic properties of epiplexity and time-bounded entropy. 

**Lemma 15 (Maximum expected description length)** _For any random variable X on {_ 0 _,_ 1 _}[n] there exists constants c_ 1 _, c_ 2 _, c_ 3 _such that:_ 

S _T_ ( _X_ ) + H _T_ ( _X_ ) _≤ n_ + _c_ 1 (11) 

_for time bounds T_ ( _n_ ) _≥ c_ 2 _n_ + _c_ 3 _._ 

**Proof** Let _Un_ be the uniform distribution _Q_ unif ( _x_ ) = 2 _[−][n]_ . _Q_ unif can be computed in linear time (just by outputting 2 _[−][n]_ for each input) and with a program of constant size _c_ 1 and in time _c_ 2 _n_ + _c_ 3 with constants depending on the Turing machine.. 

**==> picture [254 x 11] intentionally omitted <==**

**Lemma 16 (Time-bounded entropy of uniform distribution)** _Let X_ = _Un be the uniform distribution on {_ 0 _,_ 1 _}[n] . The time-bounded entropy of Un for T_ ( _n_ ) _≥ c_ 2 _n_ + _c_ 3 _is:_ 

**==> picture [249 x 11] intentionally omitted <==**

## **Proof** 

For the lower bound, we have 

**==> picture [230 x 11] intentionally omitted <==**

given that the KL is always positive. For the upper bound, we have that 

**==> picture [126 x 11] intentionally omitted <==**

. 

## **A.1 PRGs/CSPRNGs have (nearly) maximal time-bounded Entropy and low epiplexity** 

**Theorem 17** _Let X_ = _Uk and n_ = _ℓ_ ( _k_ ) _for a non-uniform PRG G that admits advantage ε_ ( _n_ ) _. Then, for every polynomial time bound T_ ( _n_ ) _,_ 

**==> picture [269 x 11] intentionally omitted <==**

**Proof** Fix P _∈PT_ and let _L_ ( _x_ ) = _−_ log _P_ ( _x_ ). For each precision level _t ∈{_ 1 _,_ 2 _, . . . , n}_ , we define the following distinguisher: 

**==> picture [210 x 13] intentionally omitted <==**

38 

For any solution _P_ for MDL _T_ , we have that MDL _T_ ( _X_ ) = _|_ P _|_ +E[ _−_ log _P_ ( _X_ )] _≤ n_ + _c_ . Since both quantities are positive, it must be the case that _|_ P _|≤ n_ + _c_ , which means that _|_ P _|∈_ poly( _n_ ). Since P belongs in _PT_ and cannot be longer than _n_ , each _Dt_ is a non-uniform PPT algorithm with polysized advice (i.e., P) that PRGs are secure against. 

**==> picture [308 x 41] intentionally omitted <==**

**Uniform threshold bound.** 

Hence , 

**==> picture [166 x 23] intentionally omitted <==**

**PRG transfers bound to** _X_ := _G_ ( _Uk_ ) **.** By the security of _G_ , for each _t_ , 

**==> picture [248 x 12] intentionally omitted <==**

**From threshold probabilities to an entropy lower bound.** For any non-negative random variable _Z_ , we have the layercake representation: 

**==> picture [349 x 167] intentionally omitted <==**

Now we change the bounds to be in terms of _t_ with _t_ = _n − u_ . The lower bound becomes _t_ = _n_ . The upper bound becomes _t_ = 1, which yields 

**==> picture [202 x 30] intentionally omitted <==**

Let _Z_ = _L_ ( _X_ ) = _−_ log _P_ ( _X_ ): 

**==> picture [350 x 28] intentionally omitted <==**

The last two steps come from the fact that _X_ is a CSPRNG. This means that: 

**==> picture [260 x 11] intentionally omitted <==**

Since this is true for any _P ∈PT_ , taking the minimum yields: 

**==> picture [268 x 16] intentionally omitted <==**

39 

## **A.2 Deterministic transformation can increase time bounded entropy and epiplexity** 

**Theorem 18** _Let G_ : _{_ 0 _,_ 1 _}[k] →{_ 0 _,_ 1 _}[n] be a_ CSPRNG _which admits advantage ε_ ( _k_ ) _and Uk be the uniform distribution._ HPoly( _G_ ( _Uk_ )) _>_ HPoly( _Uk_ ) + _n − k − nε_ ( _k_ ) _− c for a fixed constant c. Proof: see Appendix A.1._ 

**Proof** By Lemma 15 applied to the uniform distribution on _{_ 0 _,_ 1 _}[k]_ , there is an absolute constant _c_ such that 

**==> picture [82 x 11] intentionally omitted <==**

Rearranging gives _k ≥_ Hpoly( _Uk_ ) _− O_ (1). Combining this with the assumed CSPRNG lower bound (Lemma 17), 

**==> picture [134 x 12] intentionally omitted <==**

we obtain, 

**==> picture [238 x 27] intentionally omitted <==**

## **A.3 CSPRNGs have low epiplexity** 

**Theorem 19** _Let X_ = _Uk and n_ = _ℓ_ ( _k_ ) _for CSPRNG G that admits advantange ε_ ( _n_ ) _. Then, for every polynomial time bound T_ ( _n_ ) _, the epiplexity of Y_ = _G_ ( _X_ ) _is,_ 

**==> picture [244 x 11] intentionally omitted <==**

**Proof** We know from Theorem 17 that H _T_ ( _G_ ( _Uk_ )) _≥ n − nε_ ( _k_ ) _−_ 2, which means: 

**==> picture [311 x 11] intentionally omitted <==**

We also have from Lemma 15 that S _T_ ( _Y_ ) + H _T_ ( _Y_ ) _≤ n_ + _c_ . Combining these two results yields: 

**==> picture [336 x 11] intentionally omitted <==**

## **A.4 Existence of High Epiplexity random variables** 

**Definition 20 (Pseudorandom functions (PRF))** _Let_ PRF _be the class of keyed functions F_ : _{_ 0 _,_ 1 _}[k] × {_ 0 _,_ 1 _}[n] →{_ 0 _,_ 1 _}[m] that are computable in polynomial time and satisfy the following property: For any probabilistic polynomial-time distinguisher D with oracle access to the provided function,_ 

**==> picture [294 x 22] intentionally omitted <==**

_for all integers c >_ 0 _and sufficiently large n. Here, FK_ ( _·_ ) _denotes the function F_ ( _K, ·_ ) _with the key K fixed, and Fn is the set of all functions mapping {_ 0 _,_ 1 _}[n] to {_ 0 _,_ 1 _}[m] ._ 

40 

**Cryptographic assumptions.** Assume one-way functions exist (secure against non-uniform PPT adversaries with inversion probability at most _ε_ ( _n_ )). By standard constructions (Håstad et al., 1999), this implies the existence of PRFs secure against non-uniform PPT distinguishers with advantage poly( _ε_ ( _n_ )) (and in particular negligible if _ε_ ( _n_ ) is negligible). 

**Definition 21 (Heavy set)** _For a distribution Q on {_ 0 _,_ 1 _}[n] , m < n, and a fixed threshold t ≥_ 0 _, the_ ( _Q, t_ ) _-heavy set is:_ 

**==> picture [285 x 14] intentionally omitted <==**

**Lemma 22** _Let P be a distribution on {_ 0 _,_ 1 _}[n] with entropy_ H( _P_ ) = _m. If_ KL( _P, Q_ ) _≤ t, then P_ ( _AQ,t_ ) _≥_[1] 2 _[.]_ 

**Proof** First, observe the standard inequality: 

**==> picture [325 x 79] intentionally omitted <==**

Applying Markov’s inequality, we get: 

Taking the complement gives: 

**==> picture [369 x 25] intentionally omitted <==**

**Lemma 23** _Let Un be the uniform distribution over {_ 0 _,_ 1 _}[n] , the weights of AQ,t under Un is Un_ ( _AQ,t_ ) _≤_ 2 _[−]_[(] _[n][−]_[2(] _[m]_[+] _[t]_[))] 

**==> picture [434 x 44] intentionally omitted <==**

**Theorem 24** _If there exists a PRF family FK_ : _{_ 0 _,_ 1 _}[m] →{_ 0 _,_ 1 _}[k] that is indexed by K ∈ {_ 0 _,_ 1 _}[m] and secure against a non-uniform PPT distinguisher Dm allowing for an advantage of at most ε_ ( _m_ ) _, there exists n_ 0 _such that for all n_ = _m_ + _k ≥ n_ 0 _, there exists a sequence of random variables {Xk}[n] k_ =1 _[over][{]_[0] _[,]_[ 1] _[}][n][such][that]_[S][Poly][(] _[X][n]_[) = Ω(log] _[ n]_[)] _[.]_ 

**Proof** We will prove the existence of such _P_ via a counting argument. First, we define the family of distributions of interest. Concretely, we draw a sample _PK_ as follows: 

41 

1. Sample _x ∼ Um_ 

**==> picture [154 x 11] intentionally omitted <==**

Since _FK_ is a deterministic function, H( _PK_ ) = _m_ . 

We also defined a _keyed model_ Q _K_ that models _PK_ by directly storing the key _K_ and the program for generating PRF from _K_ inside its program: 

**==> picture [136 x 10] intentionally omitted <==**

This model matches the density of _PK_ so KL( _PK∥QK_ ) = 0, and: 

**==> picture [236 x 11] intentionally omitted <==**

_c_ 1 is the constant overhead to implement the PRF evaluation and sampling wrapper under a fixed encoding (i.e., a UTM). 

**Constructing distinguisher from** _Q_ **.** Given a model _Q_ and its heavy set _AQ,t_ (Definition 21), we can turn _Q_ into a _single-query_ distinguisher _D[O]_ : 

1. Sample _x ∼ Um_ and query the oracle _y_ = _O_ ( _x_ ) and set _z_ = ( _x, y_ ). 

2. Output 1 if _z ∈ AQ,t_ i.e., _Q_ ( _z_ ) _≥_ 2 _[−]_[2(] _[m]_[+] _[t]_[)] else 0. 

If _O_ is a truly random function _R_ , then ( _x, R_ ( _x_ )) follows _Un_ and by Lemma 23: 

**==> picture [318 x 18] intentionally omitted <==**

If _O_ is the PRF _FK_ for a _K_ that satisfies KL( _PK∥Q_ ) _≤ t_ , Lemma 22 gives: 

**==> picture [297 x 22] intentionally omitted <==**

Let _pQ,t_ = Pr _K_ [KL( _PK∥Q_ ) _≤ t_ ]. We can average over all possible _K_ and obtain the following bound: 

**==> picture [384 x 21] intentionally omitted <==**

Therefore, the distinguishing advantage of _D[O]_ is: 

**==> picture [361 x 21] intentionally omitted <==**

Rearranging: 

**==> picture [297 x 14] intentionally omitted <==**

Since _FK_ is a PRF and _DO_ is a PPT distinguisher, the advantage is upperbounded by _ε_ ( _m_ ): 

**==> picture [288 x 14] intentionally omitted <==**

**Union bound over short models.** Given a maximum program length _s_ , there are at most 2 _[s]_[+1] candidate programs Q with _|_ Q _|≤ s_ . Applying union bound on all such _Q_ ’s: 

**==> picture [396 x 19] intentionally omitted <==**

Now, it suffices to choose parameters such that the RHS of equation 33 is smaller than 1, which implies there exists a hard key _K[⋆]_ such that: 

**==> picture [303 x 11] intentionally omitted <==**

42 

**MDL lower bound from** _K[⋆]_ **.** For _K[⋆]_ , every _|_ Q _|≤ s_ satisfies: 

**==> picture [320 x 11] intentionally omitted <==**

Meanwhile, the keyed model _QK[⋆]_ satisfies: _L_ ( _QK[⋆] , PK[⋆]_ ) _≤_ 2 _m_ + _c_ 1 _._ If we set: 

**==> picture [70 x 10] intentionally omitted <==**

we get a margin of ∆: 

**==> picture [344 x 11] intentionally omitted <==**

This implies that there exists at least one model that achieves a lower description length than any Q with _|_ Q _|≤ s_ and the MDL minimizer must have _|_ Q _[⋆] |> s_ . 

**Choosing parameters.** Set: 

- _s_ = log _m_ 

- ∆= log _m_ 

- _t_ = _m_ + _c_ 1 + ∆= _m_ + _c_ 1 + log _m_ 

- _k_ = 4 _m_ + 4∆+ 2 _c_ 1 

We now plug these values into Equation 33. First, 2 _[s]_[+1] = poly( _m_ ) and lim _m→∞_ 2 _[s]_[+1] _·_ 2 _ε_ ( _m_ ) = 0. For the second term: 

2 _[s]_[+1] _·_ 2 _·_ 2 _[−]_[(] _[n][−]_[2(] _[m]_[+] _[t]_[))] =2[log] _[ m]_[+1] _·_ 2 _·_ 2 _[−]_[(] _[m]_[+4] _[m]_[+4∆+2] _[c]_[1] _[−]_[2(] _[m]_[+] _[m]_[+] _[c]_[1][+log] _[ m]_[))] =2[log] _[ m]_[+2] _·_ 2 _[−]_[(5] _[m]_[+4 log] _[ m]_[+2] _[c]_[1] _[−]_[2(2] _[m]_[+] _[c]_[1][+log] _[ m]_[))] =2[log] _[ m]_[+2] _·_ 2 _[−]_[(] _[m]_[+2 log] _[ m]_[)] =2 _[−][m][−]_[log] _[ m]_[+2] _._ 

This term also approaches 0 as _m_ increases. So for sufficiently large _m_ the RHS of Equation 33 is less than 1 as desired. 

## **A.5 Information Content is not Independent of Factorization** 

**Theorem 25 (OWP induces entropy asymmetry)** _Let f_ : _{_ 0 _,_ 1 _}[n] →{_ 0 _,_ 1 _}[n] be a polynomial-time computable one-way permutation secure against non-uniform PPT inverters with negligible success probability. Let X_ = _Un and Y_ = _f_ ( _X_ ) _. Let_ Hpoly( _·_ ) _and_ Hpoly( _· | ·_ ) _be defined as in Definition 8. Then for every constant c >_ 0 _there exists N such that for all n ≥ N ,_ Hpoly( _X | Y_ ) + Hpoly( _Y_ ) _>_ Hpoly( _Y | X_ ) + Hpoly( _X_ ) + _c_ log _n._ 

**Proof** We prove bounds on each term. 

43 

**Unconditional terms** Hpoly( _X_ ) **and** Hpoly( _Y_ ) **.** Since _X_ = _Un_ and _f_ is a permutation, _Y_ = _f_ ( _X_ ) is also uniform on _{_ 0 _,_ 1 _}[n]_ . By Lemma 15 (time-bounded entropy of the uniform distribution), there is a constant _c_ 0 such that 

**==> picture [226 x 12] intentionally omitted <==**

In particular, _−c_ 0 _≤_ Hpoly( _Y_ ) _−_ Hpoly( _X_ ) _≤ c_ 0, so Hpoly( _Y_ ) _−_ Hpoly( _X_ ) = _O_ (1). 

**Forward conditional term** Hpoly( _Y | X_ ) **.** There is a deterministic conditional sampler that on input _x_ outputs _f_ ( _x_ ). For this sampler, _P_ ( _Y | X_ ) = 1, hence log(1 _/P_ ( _Y | X_ )) = 0. Since Hpoly( _Y | X_ ) is the expected log-loss of the MDL-optimal conditional sampler, we obtain 

**==> picture [94 x 11] intentionally omitted <==**

**Hard conditional term** Hpoly( _X | Y_ ) **.** Let _P[⋆]_ := _PX[⋆] |Y_[be][the][MDL-optimal][conditional][proba-] bilistic model for _X | Y_ over the class of non-uniform PPT model, and define 

**==> picture [186 x 20] intentionally omitted <==**

Because _Y_ = _f_ ( _X_ ) and _f_ is a permutation, we have _X_ = _f[−]_[1] ( _Y_ ), and thus 

_P[⋆]_ ( _X | Y_ ) = _P[⋆]_ ( _f[−]_[1] ( _Y_ ) _| Y_ ) = _ϕ_ ( _Y_ ) a.s. 

Therefore 

**==> picture [222 x 23] intentionally omitted <==**

By Jensen’s inequality for the convex function log(1 _/t_ ), 

**==> picture [130 x 24] intentionally omitted <==**

Now consider the inverter _I_ that on input _y_ runs the sampler _P[⋆]_ ( _X | Y_ ) once and outputs the resulting _x_ . Since _P[⋆]_ is a non-uniform PPT sampler, _I_ is a non-uniform PPT inverter. Moreover, its inversion success probability is exactly 

**==> picture [138 x 13] intentionally omitted <==**

Equivalently (since _Y_ = _f_ ( _X_ )), 

**==> picture [140 x 16] intentionally omitted <==**

By one-wayness, this success probability is negligible. In particular, for every constant _c >_ 0 there exists _N_ such that for all _n ≥ N_ , 

**==> picture [68 x 11] intentionally omitted <==**

Plugging into the Jensen bound yields, for all _n ≥ N_ , 

**==> picture [174 x 24] intentionally omitted <==**

**Combine.** For _n ≥ N_ , we have 

**==> picture [370 x 41] intentionally omitted <==**

where we used Hpoly( _Y | X_ ) = _O_ (1) and Hpoly( _Y_ ) _−_ Hpoly( _X_ ) _≥−c_ 0. 

44 

**Corollary 26** _Let f be a one-way permutation and lef X_ = Unif( _{_ 0 _,_ 1 _}[n]_ ) _, Y_ = _f_ ( _X_ ) _. Define P as a family of probabilistic generative model that allows for multiple factorizations of the data, ie P ∈P it can make predictions P_ 1 _→_ 2( _X, Y_ ) = _P_ 1( _X_ ) _P_ 2( _Y_ ; _X_ ) _and P_ 2 _→_ 1( _X, Y_ ) = _P_ 2( _Y_ ) _P_ 1( _X_ ; _Y_ ) _for the functions P_ 1( _·_ ) _, P_ 1( _·_ ; _·_ ) _,P_ 2( _·_ ) _, P_ 2( _·_ ; _·_ ) _that are normalized probability distributions over the first variable._ 

_Suppose that P fits the forward direction of f (and the input uniform distributions)_ 

**==> picture [132 x 26] intentionally omitted <==**

_then it must violate Bayes theorem P_ 1 _→_ 2 = _P_ 2 _→_ 1 _by a margin growing with n. Specifically, for any value of c there exists N such that for all n > N , there exists at least one x ∈{_ 0 _,_ 1 _}[n] such that_ 

**==> picture [303 x 12] intentionally omitted <==**

**Proof** From Theorem 25 which applies also for each _P_ , we have 

**==> picture [122 x 11] intentionally omitted <==**

The minimim value of E [ _−_ log _P_ 2( _f_ ( _X_ ))] is _n_ since _f_ is a bijection. Assembling these components, 

**==> picture [317 x 25] intentionally omitted <==**

Since the inequality holds in expectation, it also must hold for at least one value of _X_ . Exponentiating provides the final result. 

## **A.6 Problems with time-bounded sophistication** 

Epiplexity can be seen as a time-bounded and distributional generalization of sophistication. A natural question is whether we can directly define a time-bounded version of sophistication for individual strings. We show below that a naive time-bounded generalization degenerates: it makes the “model” part essentially constant for _every_ string. 

**Preliminaries.** Fix a reference universal (prefix-free or plain) Turing machine _U_ . For a program _p_ and auxiliary input _d_ , we write _U_ ( _p, d_ ) for the output of running _p_ on input _d_ . The length of a binary string _p_ is denoted _|p|_ . A program _p_ is _total_ if _U_ ( _p, d_ ) halts for every input _d_ (i.e., _p_ computes a total function). 

We write _K_ ( _x_ ) for Kolmogorov complexity (plain or prefix; the choice only changes values by _O_ (1)). For a time bound _t_ ( _·_ ), the time-bounded Kolmogorov complexity is 

**==> picture [250 x 12] intentionally omitted <==**

(Any standard time-constructible _t_ suffices for the discussion.) 

We adopt the definition of sophistication from Koppel (1988) and Antunes et al. (2005), phrased for finite strings as in later expositions. For a significance level _c ≥_ 0, the sophistication of _x_ is 

45 

**Definition 27 (Sophistication at significance** _c_ **)** 

soph _c_ ( _x_ ) := min _|p|_ : _p is total and ∃d such that U_ ( _p, d_ ) = _x and |p|_ + _|d|≤ K_ ( _x_ ) + _c . p_ � � 

Intuitively, ( _p, d_ ) is a near-optimal two-part description of _x_ . The requirement that _p_ be _total_ is crucial: it prevents taking _p_ to be a tiny universal interpreter and pushing all information into _d_ (since a universal interpreter is not total). One of the most intuitive attempts at “time-bounded sophistication” is to simply replace _K_ ( _x_ ) by the time-bounded complexity _K[t]_ ( _x_ ) in Definition 27. 

**Definition 28 (Naive time-bounded sophistication)** _Fix a time bound t_ ( _·_ ) _and significance level c ≥_ 0 _. Define_ 

soph _[t] c_[(] _[x]_[)][:=][min] _|p|_ : _p is total and ∃d such that U_ ( _p, d_ ) = _x and |p|_ + _|d|≤ K[t]_ ( _x_ ) + _c . p_ � � 

The definition above _collapses_ , essentially because time bounds make it easy to “totalize” a universal interpreter by adding a timeout. 

**Lemma 29 (Naive time-bounded sophistication is** _O_ (1) **)** _For every time bound t_ ( _·_ ) _and every c ≥_ 0 _, there exists a constant Ct (depending only on t and the choice of U ) such that for every string x,_ 

soph _[t] c_[(] _[x]_[)] _[ ≤][C][t][.]_ 

_In particular,_ soph _[t] c_[(] _[x]_[)] _[does][not][meaningfully][distinguish][structured][strings][from][random-] looking strings._ 

**Proof** [sketch] Fix _t_ . Let _p_ tl be a constant-size program that, on input _d_ , simulates _U_ ( _d_ ) for at most _t_ ( _|x|_ ) steps (or more generally for the same time budget used in the definition of _K[t]_ ( _x_ )), and: (i) if the simulation halts within the budget, output the same result; otherwise (ii) output a fixed default string (say 0). By construction, _p_ tl is _total_ (it always halts, because it enforces a timeout). 

Now let _d[⋆]_ be a shortest program witnessing _K[t]_ ( _x_ ), i.e., _|d[⋆] |_ = _K[t]_ ( _x_ ) and _U_ ( _d[⋆]_ ) outputs _x_ within the allowed time. Then _U_ ( _p_ tl _, d[⋆]_ ) = _x_ . Moreover, 

_|p_ tl _|_ + _|d[⋆] |_ = _|p_ tl _|_ + _K[t]_ ( _x_ ) _≤ K[t]_ ( _x_ ) + _c_ for all _c ≥|p_ tl _|._ 

Thus _p_ tl is feasible in Definition 28, giving soph _[t] c_[(] _[x]_[)] _[ ≤|][p]_[tl] _[|]_[=] _[ C][t]_[for][all] _[x]_[.] 

In the original (unbounded-time) Definition 27, totality prevents a universal interpreter from being used as the “model” part, because such an interpreter cannot halt on inputs that encode non-halting computations. However, once we commit to a time bound in the _optimality criterion_ (i.e., we compare against _K[t]_ ( _x_ )), the data part _d_ can be chosen to be a short program that is _guaranteed to halt quickly_ . A constant-size _clocked interpreter p_ tl is then total and suffices for every _x_ , pushing all of the description length into _d_ . This is precisely the sense in which the naive time-bounded generalization becomes degenerate. 

## **Appendix B. Measuring Epiplexity** 

## **B.1 Further details on estimating epiplexity** 

Here we provide further details on measuring epiplexity. 

46 

**Evaluating code lengths and time bounds.** As described in Section 4, evaluating the code length for the model boils down to tracking the training losses (prequential) or teacher-student KL (requential) at each step _i_ : 

**==> picture [316 x 65] intentionally omitted <==**

For prequential coding, we need to compute the loss of the final model summed over the entire training dataset,[�] _[M] i_ =0 _[−]_[1][log][ 1] _[/P][M]_[(] _[Z][i]_[)][,][which][is][time-consuming][if][done][exactly.][Since][all][of][our] experiments are in the one-epoch training regime without data repeat and training data _Zi_ are drawn i.i.d. (except for the ADO experiment Section 6.4), we make the assumption that the generalization gap is small and estimate[�] _[M] i_ =0 _[−]_[1][log][ 1] _[/P][M]_[(] _[Z][i]_[)][ as] _[ M]_[ log][ 1] _[/P][M]_[(] _[Z][M]_[)] _[,]_[ where the latter is a rescaled loss] for _PM_ on unseen data _ZM ._ The i.i.d. assumption breaks down for the ADO experiment Section 6.4, where we instead compute[�] _[M] i_ =0 _[−]_[1][log 1] _[/P][M]_[(] _[Z][i]_[)][exactly.] 

For requential coding, we need to evaluate the teacher-student KL, KL( _P_[t] _∥P_[s] ) _,_ at each training step. The KL divergence over sequences decomposes as a sum over token positions and is estimated as: 

**==> picture [354 x 74] intentionally omitted <==**

where _Z ∼ P_[t] is a sample from the teacher, _L_ is the sequence length, and _V_ is the vocabulary. We evaluate this estimator using the sample _Z_ generated by the teacher to train the student, along with their next-token-prediction logits _{P_[t] ( _Zj|Z<j_ ) _, P_[s] ( _Zj|Z<j_ ) _}j_ recorded on the generated sequence 

Finally, to estimate the expected entropy code length for the test data E[log 1 _/P_ ( _X_ )] under the trained _X._ ˆ Let _K_ modeland _P,K_ ˆ wedenoteuse antheappropriatelynumber of examplesscaled empiricalin each dataset.entropy Then:code length of a heldout test set 

**==> picture [296 x 67] intentionally omitted <==**

**==> picture [232 x 32] intentionally omitted <==**

where we assumed the datasets _X_ and _X_[ˆ] consist of i.i.d. draws from the same distribution. This estimator is simply a scaled version of the standard empirical test loss, and it converges to the true expectation as _K_[ˆ] becomes large. To speedup evaluation, we typically choose _K_[ˆ] _≪ K,_ but this choice does not affect our time-bound calculation: for both prequential and requential coding, the total decoding time of the two-part code for the test dataset _X_ is estimated as 6 _ND_ + 2 _N D_ where _N_ is the number of parameters of the (student) model, _D_ is the number of (student) training tokens, 

47 

**==> picture [432 x 117] intentionally omitted <==**

**----- Start of picture text -----**<br>
×10 [8] ×10 [7] ×10 [7] ×10 [7]<br>7 8 9<br>8<br>7 8<br>7 6<br>5 7<br>4<br>6 6 3 6<br>2<br>5<br>5<br>10 [16] 10 [17] 10 [16] 10 [17] 10 [16] 10 [17] 10 [16] 10 [17]<br>Compute Compute Compute Compute<br>Exact Frontier Empirical Frontier Lower Convex Hull Hull + Median per N<br>)(XP<br> log 1/ ST<br> E<br>|P| + Optimal Params<br>Optimal Train Tokens<br>**----- End of picture text -----**<br>


Figure 10: **Estimating the Pareto frontier from a finite number of training runs.** While the exact Pareto frontier is smooth and the optimal model size and training tokens increase smoothly with compute, the empirical frontier is jagged and includes many spurious points due to selecting over only a finite number of hyperparameter combinations. Replacing the empirical Pareto frontier with the lower convex hull and retaining only the median point (ordered by compute) belong to a single training run with a fixed model size results in a much more accurate estimate of the true Pareto frontier. The example training curves are generated using the scaling laws in Hoffmann et al. (2022) and prequential coding. The exact frontier is found via root finding for Equation (56). 

and _D_ is the number of tokens in the test dataset. When evaluating conditional epiplexity S _T_ ( _Y |X_ ) _,_ decoding time takes into account both the input ( _X_ ) and label ( _Y_ ) tokens, but code length only needs to be computed for the label tokens (tokens contributing to the training loss). 

**Finding Hyperparameters for Compute-Optimal Two-Part Code.** To identify models that lead to compute-optimal two-part code, we need to optimize several key hyperparameters, including model size ( _N_ ), training tokens ( _D_ ), width-depth ratio, learning rate, etc. Through our early experiments, we found two interventions that reduce the model code length under requential coding: (1) distilling from an exponential moving average (EMA) of teacher checkpoints rather than instantaneous checkpoints, which reduces noise in the distillation signal, and (2) imposing a maximum KL threshold between teacher and student—when exceeded, the teacher is frozen while the student catches up, preventing divergence that would otherwise inflate the code length. The EMA time scale and the maximum KL threshold are additional hyperparameters for requential coding. 

In each experiment, we first identify a good learning rate for a small model size and use the Maximum Update Parameterization (Yang et al., 2022) and CompleteP (Dey et al., 2025) to transfer the found learning rate to larger models. We also optimize the EMA time scale and maximum KL threshold for the small model when using requential coding. We then train models of various depths and widths to simultaneously sweep over model size and width-depth ratios, for a total number of training tokens chosen to be larger than the test dataset size _D,_ motivated by the observation that the optimal training tokens typically grows with the model size but do not exceed _D_ (see Section B.4). To avoid separately training a model for intermediate training token budgets, we record an EMA of the iterates (for requential coding, this is done for the student) under a constant learning rate schedule, rather than using a decaying learning rate schedule, following Hägele et al. (2024). Each training run traces a curve in the _|_ P _|_ +E[1 _/_ log _P_ ( _X_ )] vs _T_ plane as more training tokens are seen. The Pareto frontier of all such curves yields the optimal hyperparameters ( _N, D,_ width, depth, etc.) as a function of the compute budget. 

**Estimating the Pareto Frontier.** Due to computational constraints, we can only sweep over a limited set of hyperparameter combinations, which makes the empirical Pareto frontier noisy and jagged; we therefore use the lower convex hull of the resulting curves as a smoother approximation to the true Pareto frontier, a strategy often used in the compute-optimal scaling law literature 

48 

(Henighan et al., 2020; McLeish et al., 2025) to overcome similar issues. After applying this strategy, we still often observe that multiple checkpoints from a single training run appear on the Pareto frontier. This is an artifact of finite hyperparameter sweeps: we expect both the optimal training tokens _D_ and model size _N_ to vary smoothly with compute budget, precluding multiple values of _D_ at the same _N_ from lying on the true Pareto frontier. These spurious points cause noisy, oscillatory trends in the estimated epiplexity, as shown in Figure 10. As a simple workaround, we retain only the median point (ordered by compute) per training run (which has a fixed model size) on the lower convex hull. 

**Sources of errors.** In addition to the artifacts produced by finite ( _N, D_ ) combinations, our estimated epiplexity may differ from the true value for a few reasons: 1) potential systematic errors introduced by using the lower convex hull and taking the median point, 2) using a fixed architecture (e.g., the transformer) and learning algorithm (e.g., requential training with Adam) rather than considering all possible programs, and 3) suboptimality of other hyperparameters, such as the learning rate, Adam ( _β_ 1 _, β_ 2) _,_ etc. In most cases, we believe these sources of errors only contribute sub-leading corrections to the estimated epiplexity that do not impact the result qualitatively. For example, they are unlikely to alter the ordering between datasets if the estimated epiplexity gap is already significant or there is a clear trend along some axis of variation (e.g., number of hidden bits in the induction experiment in Section 5.3.1) 

## **B.2 Prequential Coding Approximates Requential Coding with a Static Teacher** 

In this section, we show that the prequential coding estimate in Equation (8) can be viewed as an approximation to requential coding with a static teacher, providing an alternative justification for its use beyond the symmetry of information argument. 

Consider requential coding with a fixed teacher across all time steps, i.e., _Pi_[t][=] _[P]_[ t][for][all] _[i][∈] {_ 0 _, . . . , M −_ 1 _}_ . The requential code length becomes 

**==> picture [355 x 30] intentionally omitted <==**

Now suppose the static teacher closely matches the true data distribution, i.e., _P_[t] _≈ PX_ 1 (we use _PX_ 1 in order to refer to the distribution of a single example, not the dataset). Under this assumption, we can make three simplifying approximations: 

1. The expectation under the teacher can be replaced by the expectation under the data distribution: E _P_ t[ _·_ ] _≈_ E _PX_ 1 [ _·_ ]. 

2. Training the student on synthetic samples from _P_[t] yields similar dynamics to training on real data samples from _PX_ 1. 

3. If the student converges to the teacher, then _PM_[s] _[≈][P]_[ t][,][allowing][us][to][estimate][the][teacher’s] loss E _PX_ 1 [log 1 _/P_[t] ( _X_ )] by the final student’s loss E _PX_ 1 [log 1 _/PM_[s][(] _[X]_[)]][.] 

Applying these approximations, the requential code length with a static teacher becomes 

**==> picture [319 x 30] intentionally omitted <==**

49 

which, when estimated empirically on real training data _Z_ 0 _, . . . , ZM −_ 1 _∼ PX_ 1 , recovers precisely the prequential estimate from Equation (8): 

**==> picture [312 x 30] intentionally omitted <==**

This connection also lends some justification to treating 6 _ND_ as the decoding time for the model in prequential coding, as it relates to a requential scheme that achieves this runtime. Since a static teacher is generally suboptimal compared to the time-varying teachers used in full requential coding, which can remain close to the student throughout training while still guiding it toward the target distribution, we expect the prequential estimate to be an overestimate of the requential code length. This is consistent with the empirical observations in Figure 2c, where the prequential estimate is typically several times larger than the requential estimate. 

## **B.3 A Solvable Model Using Scaling Laws** 

In this section, we present a simplified analytical model from combining neural scaling laws with prequential coding to gain insight into how epiplexity and compute-optimal hyperparameters typically vary with compute and dataset size, along with their asymptotic behaviors. 

We adopt a standard scaling law for the loss as a function of model size _N_ and training tokens _D_ : 

**==> picture [296 x 27] intentionally omitted <==**

where _E_ is the irreducible loss, _N_ 0 and _D_ 0 are scaling constants, and 0 _< α, β <_ 1 are the scaling exponents. The total compute for training and evaluating on _D_ test tokens is _T_ = 6 _ND_ + 2 _N D_ = 2 _N_ (3 _D_ + _D_ ). 

To simplify the analysis, we work in natural units: _n_ = _N/N_ 0, _d_ = _D/D_ 0, _δ_ = _D/D_ 0, and _t_ = _T/_ (2 _N_ 0 _D_ 0). The loss becomes _L_ ( _n, d_ ) = _E_ + _n[−][α]_ + _d[−][β]_ , and the compute constraint simplifies to _t_ = _n_ (3 _d_ + _δ_ ). 

**Two-part code length.** The two-part code Ptot consists of the model description and the data encoded using the model. The data code length on the test set is _δD_ 0 _· L_ ( _n, d_ ). 

For the model description length, we use the prequential estimate from Equation (8), which corresponds to the area under the loss curve above the final loss[6] : 

**==> picture [325 x 65] intentionally omitted <==**

where the _O_ (1) term remains bounded as _D →∞_ . Evaluating the integral and dropping _O_ (1) terms, we obtain the expression valid for large _D_ : 

**==> picture [270 x 23] intentionally omitted <==**

> 6. We start the sum and integral at 1 to avoid the singularity at 0 _,_ which is an artifact of the scaling law as it typically only holds for large _D._ 

50 

**Optimality condition.** Dropping the constant term _δD_ 0 _E_ from the two-part code length and dividing by _D_ 0, we seek to minimize 

**==> picture [299 x 24] intentionally omitted <==**

subject to _t_ = _n_ (3 _d_ + _δ_ ). 

**Solution.** Eliminating _n_ using the constraint _n_ = _t/_ (3 _d_ + _δ_ ), we obtain a one-dimensional optimization problem in _d_ . Setting the derivative to zero and simplifying, the optimal _d[⋆]_ ( _t_ ) satisfies 

**==> picture [300 x 12] intentionally omitted <==**

with the corresponding optimal model size given by 

**==> picture [260 x 23] intentionally omitted <==**

While Equation (56) does not admit a simple closed-form solution in general, we can extract the asymptotic behavior in the large- and small-compute regimes. 

**Large-compute regime (** _t →∞_ **).** As _t_ grows, the right-hand side of Equation (56) scales as _t[−][α] →_ 0. For the equation to remain balanced, we require _δ−d →_ 0, i.e., _d[⋆]_ ( _t_ ) _→ δ_ . The leading-order scaling is therefore: 

**==> picture [297 x 20] intentionally omitted <==**

In this regime, the optimal training set size saturates at the test set size _δ_ , while the model size grows linearly with compute. Correspondingly, the epiplexity saturates to 

**==> picture [310 x 23] intentionally omitted <==**

For the entropy, we have ( _n[⋆]_ ) _[−][α] →_ 0 while ( _d[⋆]_ ) _[−][β] → δ[−][β]_ , so 

**==> picture [309 x 14] intentionally omitted <==**

The entropy approaches the irreducible entropy _DE_ plus a residual term from finite training data that scales sublinearly with the test set size, meaning that the achieved per-token loss is _E_ + _O_ ( _D[−][β]_ ) _._ 

**Small-compute regime (** _d[⋆] ≪ δ_ **).** When compute is limited such that _d ≪ δ_ , we approximate _δ − d ≈ δ_ and (3 _d_ + _δ_ ) _[α][−]_[1] _≈ δ[α][−]_[1] . Substituting into Equation (56) and solving for _d_ gives 

**==> picture [279 x 28] intentionally omitted <==**

Since 3 _d[⋆] ≪ δ_ in this regime, the optimal model size is 

**==> picture [241 x 21] intentionally omitted <==**

Here, the model size is constrained by the need to evaluate on _δ_ tokens, and the optimal training set size grows sublinearly with compute as _d[⋆] ∝ t[α/]_[(] _[β]_[+1)] . The epiplexity in this regime scales as 

**==> picture [301 x 23] intentionally omitted <==**

51 

growing sublinearly with compute. 

For the entropy, both the model and data contributions are significant. The model contribution scales as 

**==> picture [280 x 25] intentionally omitted <==**

while the data contribution scales as 

**==> picture [260 x 15] intentionally omitted <==**

Since _αβ/_ ( _β_ + 1) _< α_ , the data term decays more slowly and dominates for larger _t_ within this regime. The entropy above the irreducible level is thus 

**==> picture [270 x 15] intentionally omitted <==**

decaying as a power law with compute. 

For typical scaling exponents (e.g., _α ≈_ 0 _._ 34 and _β ≈_ 0 _._ 28 from Hoffmann et al. (2022)), the epiplexity grows as S _T ∝ T_[0] _[.]_[19] and the entropy decays as H _T −DE ∝ T[−]_[0] _[.]_[07] in the small-compute regime. 

## **B.4 How Epiplexity and Time-Bounded Entropy Scale with Compute and Dataset Size** 

In this section, we analyze how epiplexity and time-bounded entropy scale with compute budget and dataset size under natural assumptions about neural network training, without relying on specific functional forms for scaling laws. The goal is to provide some general intuitions for how these quantities are expected to vary as a function of the compute budget and dataset size. Section B.3 explicitly demonstrates using scaling laws and prequential coding that (1) epiplexity grows with both compute and dataset size, and (2) for a fixed _X_ , epiplexity saturates to a finite value in the limit of infinite compute—specifically, to the amount of information acquired by an arbitrarily large model trained on a training set of the same size as the test set _X_ , while time-bounded entropy decays to the loss achievable by an infinitely large model on this training set. Here, we show that similar or weaker statements hold more generally, requiring only a few natural assumptions about the effect of increasing model size _N_ and training data size _D_ . These assumptions capture typically observed regularities in deep learning, such as the smoothly diminishing returns in scaling only model size while holding training set size fixed, but they may fail to capture rare exceptions like grokking and sudden improvement in performance above certain compute thresholds (as in Section 5.3.2). 

Denote the code length for an _N_ -parameter model trained on _D_ tokens as _|_ P _|_ ( _N, D_ ) _,_ the per-token loss it achieves as _L_ ( _N, D_ ), the compute-optimal model size as _N[⋆]_ ( _T_ ) and training data size as _D[⋆]_ ( _T_ ) _,_ so that S _T_ ( _X_ ) = _|_ P _|_ ( _N[⋆]_ ( _T_ ) _, D[⋆]_ ( _T_ )) and H _T_ ( _X_ ) = _D L_ ( _N[⋆]_ ( _T_ ) _, D[⋆]_ ( _T_ )) _._ We establish the following results as we vary _T_ and _D_ = _|X|_ , fixing the distribution of _Xi_ (only the dataset size changes): • **Monotonicity of** _N[⋆]_ ( _T_ ) **,** _D[⋆]_ ( _T_ ) **,** S _T_ ( _X_ ) **, and** H _T_ ( _X_ ) (Section B.4.1): Under natural assumptions on the effect of increasing _N_ and _D_ , the compute-optimal model size _N[⋆]_ ( _T_ ) and training data size _D[⋆]_ ( _T_ ) are both increasing in the compute budget _T_ . As a result, epiplexity typically grows with _T_ while time-bounded entropy typically decreases with _T_ . 

- **Monotonicity of** S _∞_ ( _X_ ) **and** H _∞_ ( _X_ ) **in** _D_ (Section B.4.2): In the infinite-compute limit, epiplexity S _∞_ ( _X_ ) is nondecreasing in _D_ = _|X|_ , while the per-token time-bounded entropy _h∞_ ( _XD_ ) := H _∞_ ( _XD_ ) _/D_ is nonincreasing in _D_ . 

52 

   - _D[⋆]_ ( _T_ ) **generally approaches** _D_ **in prequential coding** (Section B.4.3): For prequential coding, the compute-optimal training set size satisfies _D[⋆]_ ( _T_ ) _→D_ as _T →∞_ , where _D_ is the test set size, without assuming the scaling law form. Combined with monotonicity of _D[⋆]_ ( _T_ ), this implies _D[⋆]_ ( _T_ ) _↑D_ from below. 

- B.4.1 Monotonicity of _N[∗]_ ( _T_ ), _D[∗]_ ( _T_ ), S _T_ ( _X_ ), and H _T_ ( _X_ ) 

The following theorem shows that the compute-optimal model size and training data size are both monotonically increasing in the compute budget under natural assumptions. 

**Theorem 30 (Monotone growth of compute-optimal** _N_ **and** _D_ **)** _Define the effective data D_[�] = 6 _D_ + 2 _D, so that the compute constraint becomes T_ = _N D_[�] _. Let J_ ( _N, D_[�] ) _denote the two-part code length as a function of model size N and effective data D_[�] _, and assume J is twice continuously differentiable. Consider the constrained MDL problem_ 

**==> picture [292 x 20] intentionally omitted <==**

_Assume that for each T in the regime of interest there is a unique interior optimizer_ ( _N[⋆]_ ( _T_ ) _, D_[�] _[⋆]_ ( _T_ )) _with D_[�] _[⋆]_ ( _T_ ) _>_ 2 _D and N[⋆]_ ( _T_ ) _D_[�] _[⋆]_ ( _T_ ) = _T . Work in logarithmic coordinates µ_ := log _N and ν_ := log _D_[�] _, and by slight abuse of notation write J_ ( _µ, ν_ ) = _J_ ( _e[µ] , e[ν]_ ) _. Assume that for all such T , the following conditions hold at the corresponding optimum_ ( _µ[⋆]_ ( _T_ ) _, ν[⋆]_ ( _T_ )) _:_ 

_1._ _**Complementarity (larger models are more sample-efficient):**_ 

**==> picture [212 x 25] intentionally omitted <==**

_2._ _**Diminishing returns in model size (in log coordinates):**_ 

**==> picture [209 x 25] intentionally omitted <==**

_3._ _**Diminishing returns in effective data (in log coordinates):**_ 

**==> picture [209 x 23] intentionally omitted <==**

_Then both compute-optimal choices are strictly increasing functions of T :_ 

**==> picture [336 x 13] intentionally omitted <==**

**Proof** Work in logarithmic coordinates 

**==> picture [310 x 13] intentionally omitted <==**

The compute constraint _N D_[�] = _T_ becomes the affine constraint 

**==> picture [294 x 11] intentionally omitted <==**

By slight abuse of notation, write _J_ ( _µ, ν_ ) := _J_ ( _e[µ] , e[ν]_ ) and denote its partial derivatives by _Jµ, Jν, Jµµ, Jνν, Jµν_ , etc., all taken with respect to the log-coordinates ( _µ, ν_ ). 

53 

Define the _restricted objective_ along the compute frontier by 

**==> picture [267 x 11] intentionally omitted <==**

For each _τ_ in the regime of interest, let _µ[⋆]_ ( _τ_ ) denote the unique interior minimizer of _f_ ( _·, τ_ ), and set _ν[⋆]_ ( _τ_ ) := _τ − µ[⋆]_ ( _τ_ ). 

Holding _τ_ fixed and differentiating _f_ with respect to _µ_ gives 

**==> picture [305 x 65] intentionally omitted <==**

where _ν_ = _τ − µ_ . The optimality condition for _µ[⋆]_ ( _τ_ ) is therefore 

**==> picture [363 x 11] intentionally omitted <==**

Differentiating the identity _fµ_ ( _µ[⋆]_ ( _τ_ ) _, τ_ ) = 0 with respect to _τ_ yields 

**==> picture [340 x 22] intentionally omitted <==**

Assuming _fµµ_ ( _µ[⋆]_ ( _τ_ ) _, τ_ ) _̸_ = 0 (verified below), we obtain 

**==> picture [320 x 25] intentionally omitted <==**

We now express _fµτ_ and _fµµ_ in terms of second partial derivatives of _J_ . From (75) and the chain rule, using _∂τ_ ( _τ − µ_ ) = 1, 

**==> picture [303 x 62] intentionally omitted <==**

with _ν_ = _τ − µ_ . Similarly, differentiating (75) with respect to _µ_ while holding _τ_ fixed, and using _∂µ_ ( _τ − µ_ ) = _−_ 1 together with symmetry _Jνµ_ = _Jµν_ , yields 

**==> picture [370 x 81] intentionally omitted <==**

Substituting (79)–(80) into (78) gives 

**==> picture [323 x 24] intentionally omitted <==**

54 

with all second partial derivatives of _J_ evaluated at ( _µ, ν_ ) = ( _µ[⋆]_ ( _τ_ ) _, ν[⋆]_ ( _τ_ )). 

By the assumptions _Jνν >_ 0 and _Jµν ≤_ 0 at the optimum, the numerator in (81) satisfies _Jνν −Jµν >_ 0. By the assumptions _Jµµ >_ 0, _Jνν >_ 0, and _Jµν ≤_ 0, the denominator satisfies _Jµµ_ + _Jνν −_ 2 _Jµν >_ 0. Hence 

**==> picture [237 x 22] intentionally omitted <==**

Since _ν[⋆]_ ( _τ_ ) = _τ − µ[⋆]_ ( _τ_ ), we also have 

**==> picture [307 x 25] intentionally omitted <==**

where positivity follows from _Jµµ >_ 0 and _Jµν ≤_ 0 together with the same positive denominator. 

Finally, _N[⋆]_ ( _T_ ) = exp( _µ[⋆]_ (log _T_ )) and _D_[�] _[⋆]_ ( _T_ ) = exp( _ν[⋆]_ (log _T_ )), so _dµ[⋆] /dτ >_ 0 and _dν[⋆] /dτ >_ 0 imply that both _N[⋆]_ ( _T_ ) and _D_[�] _[⋆]_ ( _T_ ) are strictly increasing functions of _T_ . 

**Empirical plausibility of the assumptions.** The three conditions in Theorem 30 reflect welldocumented empirical phenomena in deep learning. The complementarity condition _∂_[2] _J/∂µ∂ν ≤_ 0 captures the observation that larger models are more sample-efficient: increasing model size leads to faster learning (Kaplan et al., 2020; Yang et al., 2022), which leads to a faster decrease in both the model description length and data code length (final loss), and thus _∂J/∂ν_ should decrease with _µ_ . The diminishing returns conditions _∂_[2] _J/∂µ_[2] _>_ 0 and _∂_[2] _J/∂ν_[2] _>_ 0 simply state that there is diminishing return in successive doubling of the model size or training data size, holding the other quantity fixed. 

**Asymptotic growth of** S _T_ **and monotone decay of** H _T_ **.** The monotone growth of the computeoptimal _N[⋆]_ ( _T_ ) and _D[⋆]_ ( _T_ ) does not by itself imply that S _T_ ( _X_ ) := _|_ P _|_ ( _N[⋆]_ ( _T_ ) _, D[⋆]_ ( _T_ )) is monotone for all _T_ . Intuitively, while we expect the model description length _|_ P _|_ ( _N, D_ ) to grow with _D_ , it need not increase with _N_ : larger models can be more sample-efficient, which may reduce the effective complexity of the learned predictor under some coding schemes. However, one should still expect S _T_ ( _X_ ) to grow with _T_ , at least asymptotically, if we assume (1) the compute-optimal model size diverges while the optimal training horizon converges, as in the scaling-law model of Section B.3, and (2) the existence of infinite-model-size limits of the training dynamics. 

That is, assume that along the compute-optimal path, 

**==> picture [349 x 11] intentionally omitted <==**

Assume moreover that for bounded training horizons, the description length admits a well-defined infinite-model-size limit: there exists a function _|_ P _|∞_ ( _D_ ) such that for each fixed _D_ , 

**==> picture [300 x 11] intentionally omitted <==**

This assumption is motivated by the existence of infinite-width and depth limits of neural networks under appropriate parameterizations (Yang and Littwin, 2023; Dey et al., 2025), where scalar quantities such as loss and teacher–student KL divergence that determine _|_ P _|_ ( _N, D_ ) admit stable large-model limits for bounded training durations. Under these conditions, any non-monotonic dependence of _|_ P _|_ on _N_ is a finite-model effect; once _N[⋆]_ ( _T_ ) is large enough, _|_ P _|_ ( _N[⋆]_ ( _T_ ) _, D[⋆]_ ( _T_ )) is well-approximated by the limiting curve _|_ P _|∞_ ( _D[⋆]_ ( _T_ )). Since _D[⋆]_ ( _T_ ) is monotone increasing and convergent under our earlier assumptions, the large- _T_ behavior of S _T_ ( _X_ ) is therefore governed 

55 

primarily by the behavior of _D[⋆]_ ( _T_ ) alone, which we have shown is increasing with _T_ , so one expects S _T_ ( _X_ ) to increase at large _T_ as _|_ P _|∞_ ( _D_ ) should increase with _D._ 

For the entropy term H _T_ ( _X_ ) := _D L_ ( _N[⋆]_ ( _T_ ) _, D[⋆]_ ( _T_ )), the conclusion is simpler and does not require taking _N →∞_ . Assume only that the loss _L_ ( _N, D_ ) is nonincreasing in both _N_ and _D_ (more data and parameters cannot make the loss worse). Since _N[⋆]_ ( _T_ ) and _D[⋆]_ ( _T_ ) are increasing in _T_ , we have 

**==> picture [346 x 11] intentionally omitted <==**

and therefore H _T_ ( _X_ ) is nonincreasing in _T_ . In particular, whenever H _T_ ( _X_ ) has a finite large-compute limit H _∞_ ( _X_ ), it approaches this limit from above. 

## B.4.2 Monotonicity of S _∞_ ( _X_ ) and H _∞_ ( _X_ ) in _D_ 

We now show that epiplexity and time-bounded entropy (after appropriate normalization) in the infinite-compute limit are monotonic in the test set size _D_ = _|X|_ , regardless of the coding scheme. 

Fix a dataset _XD_ of length _D_ tokens. For a two-part code of the form 

**==> picture [300 x 11] intentionally omitted <==**

let ( _NT[⋆]_[(] _[D]_[)] _[, D] T[⋆]_[(] _[D]_[))][denote][the][compute-optimal][choices.][We][write] 

**==> picture [312 x 26] intentionally omitted <==**

**==> picture [304 x 22] intentionally omitted <==**

In the infinite-compute limit _T →∞_ , the compute constraint becomes irrelevant, so the limiting quantities coincide with the optimum of the unconstrained problem 

**==> picture [343 x 16] intentionally omitted <==**

Thus 

**==> picture [338 x 11] intentionally omitted <==**

We claim that S _∞_ ( _XD_ ) is nondecreasing in _D_ , and _h∞_ ( _XD_ ) is nonincreasing in _D_ , assuming that for each _D >_ 0 the unconstrained problem (91) admits at least one minimizer. 

To see this, fix _D_ 2 _> D_ 1 and let ( _Ni, Di_ ) be minimizers of (91) at _D_ = _Di_ . Write _Pi_ := _|_ P _|_ ( _Ni, Di_ ) and _Li_ := _L_ ( _Ni, Di_ ). Optimality of ( _N_ 2 _, D_ 2) at _D_ 2 implies 

**==> picture [273 x 11] intentionally omitted <==**

Optimality of ( _N_ 1 _, D_ 1) at _D_ 1 implies 

**==> picture [273 x 11] intentionally omitted <==**

Adding (93) and (94) gives 

**==> picture [346 x 41] intentionally omitted <==**

hence _L_ 2 _≤ L_ 1 since _D_ 2 _> D_ 1, i.e., the achieved loss _h∞_ ( _XD_ ) is nonincreasing in _D_ . Substituting _L_ 2 _≤ L_ 1 back into (94) yields _P_ 2 _≥ P_ 1, i.e., S _∞_ ( _XD_ ) is nondecreasing in _D_ . 

56 

## B.4.3 _D[⋆]_ ( _T_ ) Generally Approaches _D_ in Prequential Coding 

We now show that the compute-optimal training set size for prequential coding generically saturates at _D_ = _D_ as _T →∞_ , without assuming specific scaling laws. 

In continuous time, the prequential model description length is the area above the final loss: 

**==> picture [316 x 26] intentionally omitted <==**

The corresponding two-part code length for a test set of size _D_ is 

**==> picture [333 x 41] intentionally omitted <==**

We express _N_ in terms of _D_ for fixed _T_ using the constraint 6 _ND_ + 2 _N D_ = _T_ : 

**==> picture [262 x 22] intentionally omitted <==**

**Large-compute limit.** Assume: (i) _L_ ( _N, D_ ) is nonincreasing in _N_ and admits a pointwise infinitemodel-size limit _L∞_ ( _D_ ) := lim _N →∞ L_ ( _N, D_ );[7] (ii) _L∞_ is continuously differentiable and strictly decreasing, i.e., _L[′] ∞_[(] _[D]_[)] _[ <]_[ 0][.][Along][the][compute][frontier][(98)][,][for][any][fixed] _[D]_[we][have] _[N][T]_[(] _[D]_[)] _[ →∞]_ as _T →∞_ , hence 

**==> picture [364 x 26] intentionally omitted <==**

Differentiating gives 

**==> picture [276 x 12] intentionally omitted <==**

Since _L[′] ∞_[(] _[D]_[)] _[ <]_[ 0][,][we][have] _[J] ∞[′]_[(] _[D]_[)] _[ <]_[ 0][for] _[D][<][ D]_[and] _[J] ∞[′]_[(] _[D]_[)] _[ >]_[ 0][for] _[D][>][ D]_[.][Thus] _[J][∞]_[is][uniquely] minimized at _D_ = _D_ , implying 

**==> picture [278 x 11] intentionally omitted <==**

**Approach from below and linear growth of** _N[⋆]_ ( _T_ ) **.** By Theorem 30, under the complementarity and diminishing-returns assumptions, the compute-optimal training set size _D[⋆]_ ( _T_ ) is strictly increasing in _T_ . Combined with the convergence _D[⋆]_ ( _T_ ) _→D_ , this yields _D[⋆]_ ( _T_ ) _↑D_ , i.e., _D[⋆]_ ( _T_ ) approaches _D_ from below. Finally, since _N[⋆]_ ( _T_ ) = _NT_ ( _D[⋆]_ ( _T_ )), 

**==> picture [285 x 23] intentionally omitted <==**

so the compute-optimal model size grows linearly with _T_ in the large-compute regime. 

> 7. This limit provably exists under _µ_ P, but is a reasonable assumption in general as it simply asserts diminishing returns in scaling model size without increasing data. 

57 

## **Appendix C. Experiment Details** 

Unless otherwise stated, we use the GPT-2 (Radford et al., 2019) transformer architecture trained with Adam optimizer. In experiments where we vary the model size, we tune the base learning rate on a small model and transfer it to larger models using using _µ_ P (Yang et al., 2022) and CompleteP (Dey et al., 2025). In _µ_ P, the per-layer learning rate is base learning rate divided by the input dimension, so our reported base learning rate is larger than typical learning rates used for Adam. The hyperparameters presented below are shared between the teacher and the student for requential coding (width, depth, learning rate, EMA time scale, etc.). As described in Section B.1, the EMA for the teacher is used only for producing the distillation target and does not alter the raw teacher training dynamics, while the EMA for the student model does alter its training dynamics and is used to replace a decaying learning rate schedule. 

## **C.1 ECA** 

In Figure 3, we train the transformer to predict _Y_ given _X_ where _X_ is the initial state with a state size of 64 cells and _Y_ is obtained by evolving _X_ for 48 steps. We apply a burnin period of 1000 steps for sampling the initial state _X_ to eliminate the less uninteresting transient dynamics from random initialization. That is _X_ is obtained by evolving the ECA on _Z_ for 1000 steps where _Z_ is a uniform random initial state. For each rule, we train models with width (embedding dimension) _∈{_ 16 _,_ 32 _,_ 64 _,_ 128 _,_ 256 _,_ 512 _}_ and depth (number of transformer blocks) _∈{_ 1 _,_ 2 _,_ 4 _,_ 6 _,_ 9 _}_ . We train both teacher and student using batches of 1536 sequences (each an ( _X, Y_ ) pair), a base learning rate of 0.03 with 100 warmup steps, and an EMA time scale of 50 steps (half-life divided by ln(2)). We did not set a max teacher-student KL as the student smoothly trackes the teacher throughout training. The epiplexity and time-bounded entropy is estimated for a test set of size _D_ = 100M tokens (counting _Y_ only). 

## **C.2 Easy induction** 

For this task, we use a sequence length of _n_ = 512 (as described in Section 5.3.1). The model has 3 layers and a width of 128, and is trained with a learning rate of 0.03 and a batch size of 384 sequences for 3000 steps with 15 warmup steps and an EMA time scale of 50 steps. We found further increasing the model size led to negligible improvement in the loss, and Figure 5c shows that the model has nearly converged by the end of training to the theoretical minimum loss, so there is no need to further increase the training data. As a result, we expect the epiplexity S _T_ ( _X_ ) to stabilize as _T_ and _D_ = _|X|_ increases (in the relevant regime where _T_ is still much less than what is required for implementing the brute-force solution that enumerates all possible combinations of hidden entries in the transition matrix), and our estimated epiplexity approximates this stabilized value. 

## **C.3 Hard induction** 

We modify the ECA experiment in Section C.1 to remove the first _h ∈{_ 0 _,_ 1 _, . . . ,_ 5 _}_ bits in _X_ when fed to the model as input. We use a state size of 32, batch size of 1536 sequences, learning of 0.03, EMA time scale of 100 steps. We set the max KL threshold between the teacher and student as 0.03 (nats per token). To construct a forward function that is hard to invert, we use rule 30 iterated for 4 steps. We train models with 3 layers and width 256 for 20000. Further increasing model size or training data led to no improvement in the loss. As Figure 5b shows, the models converge by the end of training (the loss curves shown are for the student models, but the teacher models also converge) to the theoretical minimum values. Therefore, like the case for Section C.2, we expect the epiplexity 

58 

S _T_ ( _X_ ) to stabilize as _T_ and _D_ = _|X|_ increases, at least in the relevant regime where _T_ is still much less than what is required for implementing the brute-force solution that enumerates all possible combinations of hidden bits, and our estimated epiplexity approximates this stabilized value. 

## **C.4 Chess** 

We train models of varying sizes from 1M to 160M parameters with depth between 3 and 24 layers. The base learning rate is set to 2 and the batch size is 256, with a sequence length of 512. We set the EMA time scale to 50 steps and max KL to 0.1 nats per token. We use character-level tokenization. The teacher models are trained for 5B tokens in total, and the student models are trained for slightly more due to hitting the max KL threshold during training. The test set size is set to 5B tokens. 

**Pre-Training Data.** We use the Lichess dataset available on Hugging Face at `https://huggingface. co/datasets/Lichess/standard-chess-games` as pre-training data, formatted as either "<board>|<moves>" or "<moves>|<board>", where moves are in algebraic chess notation and board is the final board state in FEN notation. We use a slightly more concise version of the algebraic notation to further compress the move sequence. An example input where the board appears last is: 

```
e4,e5;Nf3,Nc6;Bb5,a6;Ba4,Nf6;O-O,Be7;Re1,b5;Bb3,d6;c3,O-O;h3,Nb8;d4,Nbd7;
|r1bq1rk1/2pnbppp/p2p1n2/1p2p3/3PP3/1BP2N1P/PP3PP1/RNBQR1K1w--010
```

For downstream evaluation, we evaluate performance on the following two datasets after fine-tuning on 50k examples for a 10M-parameter model with depth 24. We report accuracy under greedy decoding at zero temperature. 

**Chess Puzzles.** We use puzzles from the Lichess puzzle database available at `https://huggingface. co/datasets/EleutherAI/lichess-puzzles` , filtering for puzzles with difficulty rating above 2000. The task is to predict the correct move sequence given the game context. Puzzles are formatted as move sequences where the model must predict the next optimal move, following (Burns et al., 2023), with only the target moves included in the loss computation via masking. This tests the model’s ability to recognize tactical patterns and calculate forced sequences. 

**Centipawn Evaluation.** We evaluate position understanding using the Lichess chess position evaluations dataset at `https://huggingface.co/datasets/Lichess/chess-position-evaluations` , where models classify positions into 9 evaluation buckets based on Stockfish centipawn (cp) scores: class 0 ( _≤−_ 800cp), class 1 ( _−_ 800 to _−_ 400cp), class 2 ( _−_ 400 to _−_ 200cp), class 3 ( _−_ 200 to _−_ 50cp), class 4 ( _−_ 50 to +50cp), class 5 (+50 to +200cp), class 6 (+200 to +400cp), class 7 (+400 to +800cp), and class 8 ( _≥_ +800cp). Examples are formatted as "<board>|<class>" where the model predicts the evaluation class, with mate positions assigned to the extreme classes (0 or 8). Loss during fine-tuning is computed only for predicting the class. 

## **C.5 OpenWebText** 

We use the OpenWebText dataset at `https://huggingface.co/datasets/Skylion007/openwebtext` , keeping only documents containing only 96 common alphanumeric symbols, and apply character-level tokenization. The setup is otherwise identical to the chess experiment (Section C.4). 

59 

## **C.6 CIFAR-5M** 

We use the CIFAR-5M dataset at `https://github.com/preetum/cifar5m` . We convert the 32 _×_ 32 _×_ 3 images to greyscale and flatten to a 1D sequence of 1024 in raster-scan order. The vocabulary is the set of pixel intensities _{_ 0 _, . . . ,_ 255 _}_ . The setup is otherwise identical to the chess experiment (Section C.4). 

## **C.7 Prequential vs Requential Comparison** 

**ECA.** The ECA experiment include rules _{_ 0 _,_ 32 _,_ 4 _,_ 15 _,_ 22 _,_ 30 _,_ 41 _,_ 54 _,_ 106 _,_ 110 _},_ covering all 4 classes. We train models with width _∈{_ 16 _,_ 32 _,_ 64 _,_ 128 _}_ and depth _∈{_ 1 _,_ 2 _,_ 3 _}_ up to 10000 steps. We use a base learning rate of 0.03 and batch size of 384. Other hyperparameters are identical to Section C.1. We set _D_ = 250M tokens. For each rule, we report the maximum epiplexity over the resulting compute range. 

**Induction.** Both the easy and hard induction results directly come from the experiments in Section 5.3.1. As explained in Section C.2 and Section C.3, the compute budget _T_ and test set size _D_ need not be precisely specified for these two tasks as the epiplexity stabilizes as _T_ and _D_ increase due to the convergent training dynamics. 

**Natural data.** We report the estimated epiplexity on each dataset at the maximum tested compute budget as described in Section C.4, Section C.5, and Section C.6. 

## **C.8 ECA Emergence** 

We modify the setup in Section C.1 to include models that predict intermediate states and the final state rather than the final state directly. Let _X_[(0)] denote the initial ECA state, and _X_[(] _[s]_[)] denote it evolved for _s_ steps. For an _ℓ_ -loop model, we train the model to predict ( _X_[(∆)] _, X_[(2∆)] _, . . . , X_[(] _[t]_[)] ) instead of _X_[(] _[t]_[)] only, where ∆= _t/ℓ._ Its marginal probability on the final state is lower-bounded by its joint probability on the ground truth trajectory: 

**==> picture [333 x 25] intentionally omitted <==**

So we upper-bound its NLL as 

**==> picture [337 x 58] intentionally omitted <==**

We account for the intermediate tokens when computing the time bound and the code length (they contribute to the model code length as well as the data entropy code length). In the experiment, we set the ECA steps to _t_ = 64 _._ We train models with width _{_ 16 _,_ 32 _,_ 64 _,_ 128 _},_ depth _∈{_ 1 _,_ 2 _,_ 4 _,_ 8 _,_ 16 _,_ 32 _},_ and number of loops _ℓ ∈{_ 1 _,_ 2 _,_ 4 _,_ 8 _,_ 16 _}._ We found _ℓ ∈{_ 2 _,_ 4 _,_ 8 _}_ has no advantage over the non-looped model ( _ℓ_ = 1) in terms of the two-part code, only _ℓ_ = 16 does. We therefore refer to _ℓ_ = 1 as non-looped and _ℓ_ = 16 as looped. The fact that a small _ℓ>_ 1 is not helpful is likely because the overhead of encoding and generating intermediate states exceeds the savings from only slightly simplifying each prediction step, as the per-step prediction horizon is still significant. We train all models with a base learning rate of 0.06, batch size of 147456 tokens, warmup of 100 steps, and EMA time scale of 50 steps. We did not set a max teacher-student KL. The test set size is set to _D_ = 100M final state tokens. 

60 

## **C.9 Scaling Laws** 

We estimate epiplexity and time-bounded entropy using the expressions derived in Section B.3 for prequential coding using existing scaling laws for _L_ ( _N, D_ ). We solve for the optimal training tokens _D[⋆]_ ( _T_ ) as a function of compute using root finding for Equation (56). For language, we use the Chinchilla scaling laws from Hoffmann et al. (2022), which were fit to total parameter counts. For all other modalities (images and video), we use the scaling laws from Henighan et al. (2020), which follow the methodology of Kaplan et al. (2020) and report non-embedding parameter counts. We correct these to use total parameters following Pearce and Song (2024), as described below. 

**Correcting for embedding parameters.** The scaling laws in Kaplan et al. (2020) and Henighan et al. (2020) are reported in terms of non-embedding parameters _N\E_ and non-embedding compute _C\E_ , excluding embedding and unembedding parameters. As shown by Pearce and Song (2024), this choice—combined with smaller model scales—accounts for much of the discrepancy between the Kaplan and Chinchilla scaling laws. Following their approach, we relate total parameters _N_ to non-embedding parameters via 

**==> picture [326 x 28] intentionally omitted <==**

where _V_ is the vocabulary size, _L_ ctx is the context length, and _A_ is the aspect ratio (width _/_ depth). We use _A_ = 5 as Henighan et al. (2020) showed the optimal aspect ratio is around this value for non-language datasets. We generate points ( _C\E, N\E, L_ ) from the original scaling laws, convert to ( _C, N, L_ ) using this relation (with total compute as _C_ = _C\E · N/N\E_ ), and refit the power-law exponents and the irreducible loss. 

**Parameterization conversion.** The scaling laws in Henighan et al. (2020) are reported in compute-centric form, expressing the optimal loss _L[⋆]_ ( _C_ ) = ( _C/C_ 0) _[−][γ]_ + _E_ and optimal model size _N[⋆]_ ( _C_ ) = ( _C/C_[ˆ] ) _[δ]_ as functions of compute budget _C_ . We convert these to the ( _N, D_ ) parameterization used in this work: 

**==> picture [302 x 28] intentionally omitted <==**

where _D_ 0 = _C_ 6ˆthe _[N]_ 0 _[ α/β]_ exponents( _β/α_ ) _[−]_[1] _[/β]_ transform. as _α_ = _γ/δ_ and _β_ = _γ/_ (1 _− δ_ ), and the token scale is given by 

**Corrected parameters.** Table 1 presents the corrected scaling law parameters used in our final calculations. 

Table 1: Final scaling law parameters used. Image and video domains from Henighan et al. (2020) are corrected for embedding parameters using aspect ratio _A_ = 5 following (Pearce and Song, 2024); Chinchilla (language) from Hoffmann et al. (2022) was originally fit to total parameter counts and requires no correction. _D_ 0 is measured in tokens and _E_ is measured in nats. 

|Domain|_α_|_β_|_N_0|_D_0|_E_|
|---|---|---|---|---|---|
|Image 8_×_8|0.331|0.566|8_._0_×_101|2_._66_×_106|3.14|
|Image 16_×_16|0.307|0.820|2_._8_×_102|8_._94_×_107|2.68|
|Image 32_×_32|0.258|0.399|6_._3_×_101|1_._95_×_106|2.30|
|Image VQ 16_×_16|0.322|0.441|2_._7_×_104|4_._44_×_107|4.23|
|Image VQ 32_×_32|0.287|0.560|1_._9_×_104|1_._63_×_108|3.32|
|Video VQ 163|0.428|0.718|3_._7_×_104|1_._79_×_108|1.15|
|Language (Chinchilla)|0.339|0.285|4_._91_×_107|1_._49_×_109|1.69|



61 

## **Appendix D. RASP-L for Elementary Cellular Automata** 

Below we provide RASP-L code (Zhou et al., 2023) demonstrating how the evolution rule of an ECA can be implemented, providing evidence that the solution can be expressed within an autoregressive transformer model. 

Listing 1: RASPL implementation of a cellular automaton evolution step 

```
fromnp_raspimport*
defint2bits(x,bits =8):#returnsLSBfirst
"""Helperfunctiontogeneratefixedbitstringrepresentinganumber.
NotRASP -L,canbeassumedconstant."""
bits_str=bin(x)[2:]. zfill(bits)
returnnp.array(list(map(int ,bits_str [:: -1])),dtype=np.uint8)
sep=-1
sep2=-2
defevolve_ca(x,rule):
"""FunctiontoautoregressivelyoutputproducetheoutputofonestepoftheECA
rule.Problemencodedasx=--inputstate --,sep ,sep2 ,--outputstate --.
Rule:int(specifyingtheECA)"""
lookup=int2bits(rule ,8)
in_input=1-has_seen(x,full(x,sep))
in_input2=1-has_seen(x,full(x,sep2))
width=cumsum(in_input)#onlyvalidaftersep
idx=indices(x)
circ_x=where(in_input ,x,index_select (x,idx-width))
prev=shift_right (x,1)
cprev=where(in_input2 ,prev ,index_select (prev ,idx-width))
prev2=shift_right(x,2)
nbhd=(prev2<<2)+(cprev<<1)+circ_x
shifted_nextstate=lookup[nbhd]
to_select_idx=idx-width
to_select_idx=where( to_select_idx<3,idx ,to_select_idx )
outstate=index_select (shifted_nextstate ,to_select_idx )
returnoutstate
```

## **Appendix E. Cellular Automata and Game of Life** 

**Elementary cellular automata** Elementary cellular automata (ECA) (Wolfram and Gad-el Hak, 2003) are one-dimensional cellular automata defined on a finite or infinite line of cells, each in one of two states: 0 or 1. The system evolves in discrete time steps according to local rules: a cell’s next state depends only on its current state and those of its two immediate neighbors, yielding 2[3] = 8 possible neighborhood configurations. Since each configuration can map to either 0 or 1, there are 2[8] = 256 possible rules, conventionally numbered 0–255 using Wolfram’s notation, where the rule number’s binary representation specifies the output for each neighborhood. Despite their simplicity, ECAs exhibit diverse behaviors ranging from trivial (e.g., Rule 0) to complex and chaotic (e.g., Rule 30), with Rule 54 proven to be Turing-complete. These systems serve as minimal models for studying emergence, computation, and the relationship between local rules and global behavior. 

**Conways Game of Life** Conway’s Game of Life (Gardner, 1970) is a cellular automaton defined on an infinite two-dimensional grid of cells, each in one of two states: alive (1) or dead (0). The system evolves in discrete time steps according to deterministic local rules: a cell’s next state depends only on its current state and those of its eight neighbors. Specifically, a live cell survives if it has exactly 2 or 3 live neighbors (otherwise it dies), while a dead cell becomes alive if it has exactly 3 live neighbors (otherwise it remains dead). Despite the simplicity of these rules, the Game of Life exhibits 

62 

**==> picture [433 x 161] intentionally omitted <==**

**----- Start of picture text -----**<br>
LLM modeled Distribution Invariant Measure<br>(a) (b)<br>**----- End of picture text -----**<br>


Figure 11: **LLMs can learn the invariant measure of chaotic systems despite unpredictable trajectories.** ( **a** ) Chaotic systems like the Lorenz equations display sensitive dependence on initial conditions. Tiny perturbations to the initial conditions (orange) diverge exponentially, making long-term predictions impossible when simulating with limited computation and precision on a computer. ( **b** ) 3000 sampled points from the distribution modeled by the LLM (left) and from the invariant measure of the Lorenz system (right). Color denotes kernel density estimation of each density. 

remarkably complex emergent behavior, including stable structures (blocks), periodic oscillators (blinkers), mobile patterns (gliders), and structures that generate infinite streams of gliders (glider guns). The system also happens to be Turing-complete, with a specific initial configuration specifying the program, it is capable of universal computation. 

## **Appendix F. Emergence** 

**Lorenz System and Chaotic Dynamics** For the Lorenz system, a canonical example of a chaotic ODE, we can observe a different kind of emergence (Type-0 in Carroll and Parola (2024)). There exists a canonical invariant measure in dynamical systems (under some regularity conditions) known as the SRB measure(Metzger, 2000). States evolved for a long time in the Lorenz system will converge this measure. As the Lorenz system is chaotic, tiny perturbations are exponentially amplified through time at a rate related to the largest Lyapunov exponent _λ_ 1 _≈_ 0 _._ 9. There is a precise sense in which entropy is created in this system at a rate of _λ_ 1 log2( _e_ ) bits per second, formalized through Pesin’s theorem (Pesin, 1977), despite the fact that it is a purely deterministic process. Intuitively one can see this picture when simulating the system using fixed precision numbers, and seeing log2( _e_ ) bits of that description replaced with unpredictable random content after every Lyapunov time 1 _/λ_ 1. On the one hand randomness is produced, but it is not uniformly random. Rather, there is a stationary measure in the shape of a butterfly, and an observer who has lost track of all previous bits due to chaos can still learn the shape of the butterfly. Moreover, the shape of the stationary measure is not immediately obvious from the ODE, it is emergent and cannot easily be understood without intensive numerical simulation of the system (hence why most of chaos theory was developed after computers). 

To demonstrate this interplay, we train a language model to predict the first _B_ = 10 bits of the future state Φ _t_ ( _X_ ) from an initial state sampled uniformly from the box _X ∼ U_ [ _−_ 20 _,_ 20][3] + 20[0 _,_ 0 _,_ 1] quantized to _B_ bits, in comparison to directly modeling Φ _t_ ( _X_ ). For both we set the time _t_ to be 30 Lyapunov times into the future, _t_ = 30 _/λ_ 1. The resulting model has a nearly identical loss and estimated epiplexity in the two settings. Despite being unable to distinguish the initial conditions, the LLM learns the invariant (SRB) measure to a reasonable approximation as shown in Figure 11b. 

63 

With very limited compute the stationary measure is not predictable apriori from the dynamics, but with more compute it is merely a consequence. The epiplexity of the attractor for limited compute may be larger than a description of the dynamics S _T_ (Φ _t_ ( _X_ )) _>_ S _T_ (Φ _, t_ ). 

**Chess: AlphaZero and Minimax** A qualitatively different kind of example can be had by considering the models produced by AlphaZero (Silver et al., 2018) and the theoretically optimal minimax solution for these two player zero sum perfect information games (von Neumann, 1928; Shannon, 1950). The minimax strategy can be implemented by a short program, and with sufficient compute (exponential in the size of the board (Fraenkel and Lichtenstein, 1981)) the optimal strategy can be found. On the other hand the CNN policy and value network produced by AlphaZero contain 10s of millions of parameters. Given that the rules of chess can be encoded in just a few hundred bytes, and the algorithm used to train the model can be simply described and also implemented by a short program, one may wonder _where does this information come from?_ With the other examples of emergent phenomena in mind, we can make sense of this information being produced by the computational process of the AlphaZero system. In contrast, with unbounded compute, the best strategy contains little information. 

To summarize, due to the existence of emergent phenomena, even systems that have simple generating processes or simple descriptions can lead to large amounts of structural information to be learned by computationally constrained observers. 

## **Appendix G. Induction is Not Specific to Autoregressive Factorization** 

One might get the impression that key constraint that leads to this induction phenomenon is the autoregressive factorization, as it is intuitive to see how such a model needs to perform induction in-context to achieve minimum loss. However, we argue this phenomenon takes place with other classes of generative models trained as long as they are trained with Maximum Likelihood Estimation (MLE) or its approximations. 

In MLE, a generative model allowing explicit likelihood evaluation is trained to maximize the likelihood of the data. Computing the likelihood can be significantly more computationally challenging than sampling from the distribution _P._ This distinction is particularly clear in the examples we gave where the ground-truth _P_ is a mixture distribution represented by a latent variable model with the CA initial state or Markov chain transition matrix acting as the latent variable _Z_ . Given access to _PX|Z_ (equivalent to some easy to implement forward function _F_ ), sampling is easy as long as _PZ_ is a simple, but computing _PX_ ( _x_ ) for some input _x_ requires evaluating an intractable integral _PX_ ( _x_ ) = � _PX|Z_ ( _x|z_ ) _PZ_ ( _z_ ) _dz_ due to the high-dimensionality of _Z._ As such, a model given a limited compute-budget is forced to learn a cheaper but more sophisticated algorithm for computing _PX_ ( _x_ ) _,_ often involving approximating the inverse _PZ|X_ either explicitly as done in expectation–maximizationtype algorithms and Variational Autoencoders (Kingma et al., 2013), or implicitly as we illustrated for the autoregressive transformer. 

## **Appendix H. Minimum Description Legnth** 

Intuitively, _L_ ( _H_ ) can be interpreted as the structural information, and _−_ log _P_ ( _x | H_ ) can be understood as the remaining random information that cannot be predicted by the best model in _H_ . A main problem with the crude two-part code is that it does not prescribe how one should design the code for _H_ (i.e., a procedure for describing _H_ within _H_ ). The description of a particular _H_ can be short under one code but very large under another, which could require additional knowledge to resolve. To circumvent this issue, one can use a more refined one-part code that describes the data 

64 

with the entire model class _H_ rather than any single model _H_ . One of the most important one-part codes is the normalized maximum likelihood code. 

**Definition 31 (Normalized maximum likelhood code (Grünwald, 2007))** _The NML distribution PH_[NML] : _{_ 0 _,_ 1 _}[n][×][d] →_ [0 _,_ 1] _of a probablistic model class H is:_ 

**==> picture [166 x 31] intentionally omitted <==**

_where H_[�] ( _x_ ) = arg max _H∈H P_ ( _x | H_ ) _is the maximum likelihood estimator for x._ 

Crucially, notice that the NML code only depends on _H_ rather than any particular _H ∈H_ , so we do not have to design a particular code for _H_ . Unfortunately, the NML code requires integrating over the maximum likelihood estimator for all possible data, which is intractable for most practical models such as deep neural networks. We can instead use a more tractable variant of one-part code based on sequential prediction called prequential coding. 

**Definition 32 (Prequential code (Grünwald, 2007))** _The prequential distribution PH_[PREQ] : _{_ 0 _,_ 1 _}[n][×][d] →_ [0 _,_ 1] _of a probabilistic model class H is:_ 

**==> picture [146 x 29] intentionally omitted <==**

_where H_[�] ( _x_ 1: _k_ ) = arg max _H∈H P_ ( _x_ 1: _k | H_ ) _is the MLE for the first k elements of x._ 

This definition above uses the MLE for updating _H_[�] but there are in fact no constraints on how the update is performed. We may use any update method of our choice to produce the next model in the sequence, so long as it only depends on the previous data. This means that we can naturally adapt it for deep learning, where we use stochastic gradient descent to update the model sequentially. 

A code cannot be optimal simultaneously for all possible data _x_ unless it has knowledge of the particular _x_ . Therefore, it is useful to characterize how close a given code is to the optimal model, which can be formalized via the notion of _regret_ . 

**Definition 33 (Regret (Grünwald, 2007))** _The regret of a code Q relative to H for x is the additional number of bits needed to encode x using Q compared to the best model in hindsight,_ 

**==> picture [220 x 15] intentionally omitted <==**

Under this notion of penalty, the NML is optimal in the sense that it achieves the minimax regret. The regret provides a way to compare different codes. Consider the two-part regret of the crude two-part code _P_[2P] ( _·_ ) with minimizer _H[⋆]_ and associated predictive distribution _P_ ( _· | H[⋆]_ ), 

**==> picture [250 x 25] intentionally omitted <==**

This means that for a two-part code, the regret is an upper bound on the description length of the model. For sufficiently large _n_ , the last two terms become close to each other and Reg( _P_[2P] _, H, x_ ) _≈ L_ �( _H[⋆]_ ). In the case of NML, the regret is the minimax regret that Reg( _PH_[NML] _, H, x_ ) = log[�] _y∈{_ 0 _,_ 1 _}[n][ P]_[(] _[y][|] H_ ( _y_ )). This quantity is independent of _x_ , which is also called _parametric complexity_ of _H_ , because it measures how expressive the entire _model class_ is by counting the total amount of possible data sequences the model class can model well. 

65 

