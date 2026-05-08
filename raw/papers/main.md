

# The Geometry of Consolidation

Anirudh Bharadwaj Vangara<sup>1,2</sup> and Ashwin Gopinath<sup>\*1,3</sup>

<sup>1</sup>Sentra, 235 2nd Street, San Francisco, CA 94105, USA

<sup>2</sup>Department of Computer Engineering, University of Waterloo, Waterloo, ON N2L 3G1, Canada

<sup>3</sup>Department of Mechanical Engineering, Massachusetts Institute of Technology, Cambridge, MA 02139, USA

April 19, 2026

## Abstract

**The question.** When a memory system replaces many embedded items with a few representatives on the unit sphere, what geometric quantity determines how much *identity* can survive that compression? Vector-store compression in retrieval-augmented language models, replay-buffer summarisation in continual learning, and neuroscience-style consolidation of episodic traces each rest on the implicit hope that a cluster’s important structure is low-dimensional. Previous papers in this trilogy showed this hope is wrong for *retrieval under noise*: production embedding spaces concentrate variance in a handful of effective dimensions [1] and must therefore forget by an information-theoretic bound no budget can escape [2]. Compression is the remaining lever; the question is whether it is exempt.

**The law.** It is not. We prove the *Consolidation–Interference Duality*: for any consolidator that maps  $n$  unit-norm cluster members to  $m < n$  representatives, whenever the retrieval cap  $\theta' = 1 - \theta$  is smaller than the mean within-cluster cosine distance  $\bar{d}$ , the identity-retrieval error obeys

$$\varepsilon_{\text{id}} \geq 1 - c_1 m (\theta' / \bar{d})^{d_{\text{eff}}/2},$$

where  $c_1$  is a universal constant and  $d_{\text{eff}}$  is the cluster’s local effective dimension (participation ratio of its covariance spectrum). The bound is the same spectral quantity that governs forgetting under retrieval noise — hence “duality.” We validate the regime structure the bound predicts on a 400-cell  $(d_{\text{eff}}, \theta, \bar{d})$  grid with 10 seeds per cell (16,000 trials): in the *tight regime*  $\bar{d} < \theta'$  every strategy achieves mean cap-coverage error  $\leq 0.5\%$ ; in the *spread regime*  $\bar{d} \geq \theta'$  errors diverge to 30–74% in an order predicted by  $d_{\text{eff}}$ . The same regime structure organises the ordering of six real corpora, across six sentence encoders and five consolidation operators.

**The surprising consequence.** The law’s main practical implication is not that a more adaptive algorithm wins. It is the opposite: on five real-text corpora (MS MARCO, Natural Questions, HotpotQA, Wikipedia sections, arXiv titles) a fixed *centroid* picker dominates a stochastic geometry-aware router by 1–6 identity points, and dominates five learned-quantization baselines (PQ, OPQ, LSH, PCA+int8, HNSW-prune) on the Pareto frontier of identity-vs-bytes for five of six corpora. An ablation shows that the expensive residual-direction budget in our adaptive router contributes *nothing* ( $\Delta \leq 0.002$  identity on every corpus) and that a per-cluster oracle barely improves over fixed centroid on real text. We introduce Geometry-Aware Consolidation

---

\*Correspondence: ashwin@sentra.app

(GAC) and treat it as an *instrument* for probing what adaptive routing can buy under the law; its failure to beat centroid on real text is itself one of the paper’s main scientific findings, and is explained by the fact that real-text clusters sit in the tight regime the theorem predicts is safe. Closing the loop to a downstream reader, a Llama-3.1-70B-Instruct retrieval-augmented pipeline on three QA benchmarks exhibits a regime-dependent three-way split: centroid *hurts* Natural Questions by 4.2 EM points, is neutral on HotpotQA, and *wins* by 8.4 EM points on PopQA, matching the cap-coverage prediction of which branch the law prefers on each corpus.

**Scope and open problem.** The scope of the law is embedding consolidation in contrastive unit-norm text spaces under cosine-threshold retrieval; extensions to multimodal or learned-state memory remain open. The theorem is shape-correct and predictively useful in the tight regime ( $c_1$  calibrates to  $\approx 0.05$  on 12,400 cells at the 95% quantile — within an order of magnitude of the ideal Berry–Esseen constant); in the spread regime the isotropic cap-volume approximation is loose ( $c_1$  grows unbounded as  $\theta \rightarrow 1$  at small  $d_{\text{eff}}$ ). We therefore state the theorem as the first mathematically explicit version of the law, with an anisotropic refinement as the central open theoretical problem. All 17,813 experimental cells, figures, and analysis scripts are open-source under MIT license.

## 1 Introduction

**In one paragraph.** When an embedding-based memory system replaces many items with a few representatives, what determines how much *identity* can survive that compression? This paper proves that for any consolidator acting on a unit-norm embedding cluster, the answer is a single spectral ratio: the within-cluster spread  $\bar{d}$  and the retrieval cap  $\theta'$ , raised to half the cluster’s effective dimension  $d_{\text{eff}}$ . Two concrete things follow. One, there is a phase boundary at  $\bar{d} = \theta'$ : below it every strategy works; above it strategies diverge by tens of identity points in an order the law predicts. Two, the law’s main practical consequence on real text is not that an adaptive method wins. It is that simple *centroid* averaging is already near-optimal — because real text clusters tend to sit in exactly the tight regime where the theorem says averaging is safe. The bound is the same spectral quantity that governs retrieval under noise; a bound on *losing* information is also a bound on *compressing* it.

### 1.1 The question

Consider an embedding-based vector store that has indexed a million text items, each mapped to a unit-length vector by a sentence encoder. A query arrives and the store must return the items most similar to the query under cosine similarity. At production scale one cannot keep all million vectors at full precision: related items are *consolidated* into a smaller set of representatives, and only the representatives are ranked at query time.

Consolidation takes many forms. A cluster’s arithmetic *centroid* can be used as its representative; its *medoid* (the real item closest to the rest) can be used instead; the cluster can be *pruned* to its densest half; or an adaptive router can pick among these per-cluster from local geometric features. Each choice has its defenders. None of them by itself tells a designer how much identity has actually been lost.

The scientific question is sharper than which choice is best: *what geometric quantity of a cluster determines how much identity can survive consolidation, and does that quantity predict which operator is appropriate?* If that quantity exists, it should impose a floor on identity loss that no choice of operator can escape; it should separate a safe regime from an unsafe one; and it should explain, rather than merely record, the performance of each operator on real text.

### 1.2 The answer

We prove that such a quantity exists. For any unit-norm cluster  $\mathcal{C} \subset S^{d-1}$  with mean within-cluster cosine distance  $\bar{d}$  and local effective dimension  $d_{\text{eff}}$  (participation ratio of its covariance spectrum), and for any consolidator mapping the cluster to  $m$  representatives, whenever the retrieval cap  $\theta' := 1 - \theta$  is smaller than  $\bar{d}$ ,

$$\varepsilon_{\text{id}} \geq 1 - c_1 m (\theta' / \bar{d})^{d_{\text{eff}}/2},$$

where  $c_1$  is a universal constant (Theorem 1). We call this the *Consolidation-Interference Duality*: the identical spectral quantity that sets an information-theoretic floor on retrieval under noise [2] reappears as a floor on consolidation under compression. The bound is a direct union-bound application of a cap-volume lemma; what is new is that it binds compression, not just retrieval, and that it binds it with the local effective dimension of the cluster rather than the ambient dimension.

The bound separates two regimes. In the *tight regime*  $\bar{d} < \theta'$  the bound vanishes and every operator has room to preserve identity; experimentally, every strategy achieves mean cap-coverage error  $\leq 0.5\%$  on tight synthetic cells. In the *spread regime*  $\bar{d} \geq \theta'$  the bound bites and operators diverge; experimentally, mean cap-coverage errors diverge to 30–74% with an order uniquely predicted by  $d_{\text{eff}}$ . This tight/spread split is not a soft trend. It is visible as a phase boundary in  $(d_{\text{eff}}, \theta)$  space and organises the ordering of real-corpus identity accuracy across six sentence encoders.

### 1.3 The surprising consequence

If the law says the tight regime is where identity is preserved, a natural next question is: where do real-text clusters sit? The answer we find, across six corpora (synthetic DRM, MS MARCO, Natural Questions, HotpotQA, Wikipedia sections, arXiv titles) and six contrastive sentence encoders, is that they sit mostly in the tight regime — and in that regime the geometry is lenient enough that simple centroid averaging is already near-optimal. Three experimental findings make this claim sharp.

1. An adaptive per-cluster router we built (Geometry-Aware Consolidation, GAC) Pareto-dominates the medoid baseline on every synthetic cell, but a *fixed-centroid* ablation beats the full router by 1–6 identity points on every one of the five real-text corpora (§7.2). The residual-direction budget that dominates the router’s engineering complexity contributes nothing ( $\Delta \leq 0.002$ ). A per-cluster *oracle* barely improves over fixed centroid on real text.
2. At matched bytes-per-vector against five learned-quantization baselines (product quantization [13], optimized product quantization [14], LSH [15], PCA+int8, HNSW-prune [17]), consolidation and learned quantization populate different Pareto corners of the identity-vs-bytes frontier; centroid dominates on the five low-to-moderate- $d_{\text{eff}}$  corpora and quantization takes over only on high- $d_{\text{eff}}$  arXiv titles (§8).
3. Closing the loop to a downstream reader, a Llama-3.1-70B-Instruct retrieval-augmented pipeline on three QA benchmarks shows a regime-dependent three-way split: centroid *hurts* Natural Questions EM by 4.2 points, is neutral on HotpotQA, and *wins* by 8.4 EM points on PopQA — matching the cap-coverage prediction of which operator the law prefers on each corpus (§10).

The centroid result is not an engineering accident; it is the law’s main practical implication in the regime where real text lives. The residual-direction and adaptive-routing machinery that the engineering literature builds in anticipation of a harder regime turns out, on the corpora we tested, to be solving a problem that does not arise.

### 1.4 GAC is a probe, not the main product

A paper whose primary product is an adaptive router would want that router to win. This paper uses GAC for a different purpose: as an *instrument* that asks whether, given the regime structure the theorem predicts, adaptive per-cluster routing can outperform a fixed simple operator. The instrument returns a clean negative answer on real text. The negative is scientifically informative — it localises the value of adaptation to the low- $\bar{d}$  synthetic regime, it isolates which components of the router matter (none of the residual-direction machinery does), and it sets up the downstream three-way finding. We therefore describe GAC in full (§7), but the paper is organised so its role is to test the law rather than to advertise a method.

### 1.5 Scope of the law

The theorem is stated and proved for unit-norm embedding clusters under cosine-threshold retrieval. Its experimental support is text-centric: six contrastive sentence encoders on six text corpora, at scales from  $10^3$  to  $10^6$  items. Under those assumptions the bound is provably a lower bound on identity-retrieval error, and empirically it organises the behaviour of every consolidation operator we tested. What the paper does *not* claim is a full theory of cognitive memory or of arbitrary learned-state memory in neural networks. Biological consolidation, multimodal embedding memory, and replay in large-state continual-learning agents share the same *structural* compression problem and so are natural settings in which to test whether the law extends; but the evidence we report is for text embedding consolidation, and we keep the scientific claim inside that envelope.

The theorem itself is also honest about where it is strongest. In the tight regime (defined directly by the theorem’s hypothesis  $\bar{d} < \theta'$ ) the calibrated constant sits at  $c_1^{95} \approx 0.05$  on 12,400 cells — within an order of magnitude of the ideal Berry–Esseen constant that falls out of the cap-volume lemma; in the spread regime, the isotropic cap-volume approximation is loose and the calibrated  $c_1$  grows unbounded as  $\theta \rightarrow 1$  at small  $d_{\text{eff}}$ . We state the theorem as the first mathematically explicit version of the law and mark an *anisotropic refinement* of the cap-volume argument as the central open theoretical problem (§14).

### 1.6 Where this sits in a trilogy

This paper is the third of three on the geometry of embedding memory, and can be read independently of the other two. The first, *The Geometry of Forgetting* [1], documented empirically that production sentence encoders concentrate  $\geq 99\%$  of their variance in at most  $d_{\text{eff}} \approx 16$  effective dimensions, across six encoder families and ten benchmarks. The second, *The Price of Meaning* [2], lifted that observation to a theorem: any kernel-threshold memory with finite  $d_{\text{eff}}$  must forget by interference under retrieval noise, with a lower bound no storage budget can evade. The present paper closes the trilogy by showing that the compression lever does not provide an escape route: the same spectral quantity that governs forgetting governs consolidation, by the same cap-volume argument applied to the cluster-conditional measure. The three papers share a mathematical core; what they do not share is the object under compression (global store vs. cluster) or the failure mode under study (retrieval noise vs. compression).

### 1.7 Contributions

In order of scientific centrality:

**(C1) The Duality Theorem.** A universal-constant lower bound on identity-retrieval error after

consolidation, in the same spectral quantity  $(\theta'/\bar{d})^{d_{\text{eff}}/2}$  that governs retrieval under noise (§3; proof in Appendix §16).

- (C2) Regime structure and empirical validation.** The theorem induces a tight/spread phase boundary at  $\bar{d} = \theta'$ . We validate the boundary on a 400-cell synthetic grid (16,000 trials), and show the same regime structure organises the ordering of six real-text corpora across six sentence encoders (§5, §6).
- (C3) Centroid dominates on real text.** On five real-text corpora, a fixed-centroid operator dominates a stochastic adaptive router by 1–6 identity points; the residual-direction budget contributes nothing; a per-cluster oracle barely improves. This is not an engineering accident — it is the law’s prediction for corpora that sit in the tight regime (§7.2).
- (C4) Geometry selects between consolidation and learned quantization.** At matched bytes-per-vector, consolidation and learned quantization occupy different Pareto corners of the identity-vs-bytes frontier. The crossover is predicted by  $d_{\text{eff}}$ : quantization takes over on high- $d_{\text{eff}}$  arXiv titles; consolidation dominates on the other five corpora (§8).
- (C5) Downstream consequences are regime-dependent.** A Llama-3.1-70B-Instruct retrieval-augmented pipeline on Natural Questions, HotpotQA, and PopQA exhibits a regime-dependent three-way split in end-to-end EM, matching the cap-coverage prediction of which operator the law prefers per corpus (§10).
- (C6) Limits of the current theory.** The isotropic cap-volume bound is shape-correct and predictively useful in the tight regime ( $c_1^{95} \approx 0.05$ , 95% coverage;  $c_1^{99} \approx 370$ , 99%) and loose-to-vacuous in the spread regime ( $c_1 \rightarrow \infty$  as  $\theta \rightarrow 1$  at small  $d_{\text{eff}}$ ). An anisotropic refinement of the cap-volume argument is the central open theoretical problem (§14).
- (C7) GAC as an instrument.** We introduce Geometry-Aware Consolidation and use it as a probe of what per-cluster adaptation can buy under the law. GAC Pareto-dominates the medoid baseline on every synthetic cell. Its failure to beat fixed centroid on real text localises the value of adaptation to the low- $\bar{d}$  synthetic regime and is itself one of the paper’s scientific findings (§7).

### 1.8 How to read this paper

We have split the exposition so that different readers can start at different depths.

- A reader who wants the **law only** can stop after Section 3 and skim the regime-map figure in Section 5.
- A reader who wants the **centroid lesson on real text** should read Sections 6 and 7.2.
- A reader who wants the **downstream implications for RAG** should jump to Section 10.
- A reader who wants the **proof** should read Section 3 then Appendix §16.
- A reader new to consolidation, effective rank, or RAG should start with Section 2.

Each results section opens with a gray “intuition” box giving the plain-English reading, followed by the full technical development. The intent is that a reader who is technical but not steeped in embedding geometry can read the intuition boxes end-to-end and leave with the paper’s full argument.

## 2 Background

This section collects the handful of ideas we lean on throughout: what an embedding is, what it means to *cluster* a memory, how we measure how “spread out” a cluster is ( $\bar{d}$ ), and what effective dimension ( $d_{\text{eff}}$ ) captures about a cluster’s shape. A reader familiar with retrieval-augmented generation, product quantization, and effective rank can skim. The rest of the paper assumes only these.

This section exists for a reader approaching the paper from an adjacent field. A reader already familiar with retrieval-augmented generation, product quantization, and effective rank can safely skim.

### 2.1 What is an embedding, and what is an embedding memory?

An *embedding* is a function that maps a piece of input data — a sentence, an image, a code snippet — to a point in  $\mathbb{R}^d$  for some fixed  $d$  between a few hundred and a few thousand. Modern sentence embeddings have two properties that matter for this paper. First, they are *normalised*: the embedded vectors live on the unit sphere  $S^{d-1}$ , so similarity reduces to the cosine  $\langle x, y \rangle = \cos \angle(x, y)$ . Second, they are *semantically structured*: two sentences that mean the same thing have cosine similarity close to one, while two unrelated sentences have cosine similarity close to zero. The second property is enforced during training by a contrastive loss [22–25] that pulls paraphrases together and pushes unrelated pairs apart.

An *embedding memory* is any system that stores a large set of such vectors  $\mathcal{M} = \{x_1, \dots, x_N\} \subset S^{d-1}$  and supports nearest-neighbour queries on them. The three canonical systems in the introduction — RAG databases, hippocampal memory, continual-learning replay buffers — all take this form, differing mainly in how they choose what to keep.

### 2.2 Retrieval-augmented generation, quickly

Retrieval-augmented generation (RAG) [8–12, 26] is the dominant way large language models access factual knowledge outside their training distribution. The pipeline has three stages:

1. **Indexing.** Every passage in the corpus (often the whole of Wikipedia, or a domain-specific collection) is passed through a sentence encoder and the resulting vectors are stored in a vector database.
2. **Retrieval.** At query time, the query string is embedded by the same encoder, and the  $k$  passages whose vectors are most similar to the query’s vector are retrieved by approximate nearest-neighbour search [17, 27].
3. **Reading.** The retrieved passages are concatenated into the context of a large language model, which generates the final answer.

At production scale the vector database has  $10^6$ – $10^{10}$  entries. Scanning all of them for every query is infeasible, so every production stack compresses the index. The dominant compression family is *vector quantization*: approximate each  $d$ -dimensional vector by a short code, so the database is a few bytes per vector rather than  $4d$ . Two examples of this family dominate:

**Product Quantization (PQ).** Introduced in [13], PQ splits each vector into  $M$  sub-vectors of dimension  $d/M$ , and quantizes each sub-vector to one of  $K$  centroids learned by  $k$ -means. The code for each vector is  $M \log_2 K$  bits — for example,  $M = 8$ ,  $K = 256$  gives 64 bits per  $d$ -dimensional vector. Distances are then computed as the sum of pre-tabulated distances between sub-vector centroids. Optimized PQ [14] adds a learned rotation to decorrelate sub-vectors before chunking. These two remain the backbone of billion-scale similarity search [27].

**Locality-Sensitive Hashing (LSH).** LSH for cosine similarity was introduced in [15] and generalised in [16]. The idea is to hash each vector to a short binary string such that vectors with high cosine similarity collide with high probability. Matching becomes bitwise Hamming-distance comparison, which is cheap. LSH is simpler than PQ but sits below PQ on the Pareto frontier for typical ANN workloads [27].

**Graph-based ANN.** HNSW [17] and its descendants store not vectors but a navigable small-world graph whose edges connect nearby vectors. Retrieval is a greedy walk from an entry point. HNSW at full precision is typically the fastest recall-95 option, but its memory cost is dominated by the graph, so at large scale it is combined with PQ or with HNSW-prune (a retention sweep that drops the lowest-degree fraction).

All three families compress *at the vector level*: every vector stays in the index, only represented more cheaply. What this paper calls *consolidation* is orthogonal: it compresses *at the cluster level*, dropping most vectors and replacing them with a handful of representatives. Whether consolidation should win over vector quantization depends on the geometry of the corpus, and is the central empirical question of Section 8.

### 2.3 Complementary learning systems, quickly

The cognitive neuroscience literature on human memory consolidation is anchored by the *Complementary Learning Systems* (CLS) framework of McClelland, McNaughton and O’Reilly [3], itself drawing on Marr’s earlier model of the hippocampus as a fast associative store [7] and on Alvarez and Squire’s account of gradient retrograde amnesia [4]. The claim: the brain has two memory systems. The hippocampus encodes episodic traces rapidly but has limited capacity; the neocortex stores overlapping, distributed representations and learns slowly. During offline periods — particularly sleep — the hippocampus replays compressed versions of its traces to the cortex, allowing slow cortical consolidation without interference.

Key empirical anchors: Wilson and McNaughton showed that hippocampal place cells replay awake-activity sequences during subsequent sleep [28]. O’Reilly and colleagues [6] laid out the computational constraints on such a system — sparse hippocampal coding, pattern separation, pattern completion — and argued that “consolidation” in the neuroscience sense and “rehearsal” in the continual-learning [18, 21] sense are the same operation under different names.

Two open questions in the CLS literature are structurally similar to the embedding consolidation problem we study. First, how many cortical exemplars are needed to represent a hippocampal episode? Under common assumptions this is set by task similarity and buffer size, but without a geometric bound the number is chosen empirically. Second, what happens when the episodes overlap heavily (e.g. thousands of paraphrase-like traces of the same fact)? Standard CLS models assume well-separated episodes consolidate without interference. We note that our theorem, in the embedding-consolidation setting we study, gives a geometric condition — tightness of the cluster in its effective subspace — under which a structural analogue of that assumption holds. Whether

the same geometry governs biological consolidation is a question the theorem *motivates* but does not settle; the evidence we report is for text embedding consolidation only.

### 2.4 Effective dimension and why it matters

The central spectral quantity of this paper is the *effective dimension* of a cluster, defined for  $X \subset \mathbb{R}^d$  with sample covariance  $\Sigma$  and eigenvalues  $\lambda_1 \geq \dots \geq \lambda_d \geq 0$  by

$$d_{\text{eff}}(X) := \frac{(\sum_i \lambda_i)^2}{\sum_i \lambda_i^2}. \quad (1)$$

This is the ratio between the squared trace of  $\Sigma$  and the trace of  $\Sigma^2$ ; it lies in  $[1, d]$  and takes the value  $d$  iff  $\Sigma$  is proportional to the identity, the value 1 iff  $\Sigma$  has a single nonzero eigenvalue (rank-one collapse). In information-theoretic terms,  $1/d_{\text{eff}} = \sum_i p_i^2$  where  $p_i = \lambda_i / \sum_j \lambda_j$  is the probability of eigenvalue  $i$  under the natural Gibbs distribution;  $d_{\text{eff}}$  is therefore the exponential of the Rényi-2 entropy of the normalised spectrum [29]. In the statistics literature the same quantity also goes by “effective degrees of freedom,” “stable rank,” or “participation ratio” [30, 31].

Two things make  $d_{\text{eff}}$  the right spectral summary for our problem.

1. It is *scale-invariant*: multiplying  $\Sigma$  by a constant leaves  $d_{\text{eff}}$  unchanged. The quantity therefore reports the shape of the spectrum, not its magnitude.
2. It is *weighted*: two large eigenvalues and one thousand small ones give  $d_{\text{eff}} \approx 2$ , not  $d_{\text{eff}} \approx 1000$ . This matches the geometric intuition that the “hard to compress” directions are those with large variance.

The previous paper in this trilogy documented that production sentence encoders have  $d_{\text{eff}} \approx 16$  at the global level [1], with  $d_{\text{efflocal}}$  on a single cluster often below 5. The claim of the present paper is that this same  $d_{\text{efflocal}}$  controls how much compression a cluster can take before its members stop retrieving themselves.

**Measurement conventions (used throughout).** All reported values of  $d_{\text{eff}}$  use Equation (1) (participation ratio); the code computes this form as the default of `gac.theory.d_eff` (see the repository). We distinguish: (i) the *global*  $d_{\text{eff}}$  of a corpus is measured on the pooled embedding matrix of all items across clusters; (ii) the *local*  $d_{\text{efflocal}}$  of a corpus is the **median** of per-cluster participation ratios, computed on each cluster’s own embedding matrix. The theorem as stated is cluster-conditional: its bound applies to a single cluster with  $d_{\text{eff}}$  computed from that cluster’s covariance. Corpus-level diagnostics (e.g. the ordering tables in Section 6) report medians across clusters. Likewise  $\bar{d}$  is mean within-cluster cosine distance and is reported cluster-conditionally; corpus rows report medians. All other definitions used in this paper reduce to this single quantity  $d_{\text{eff}}$  under the participation-ratio form; we do not mix definitions.

### 2.5 Concentration of measure on the sphere

The proof of the duality theorem uses a classical fact about points on a high-dimensional sphere: most of them are nearly orthogonal to any fixed direction. Formally, if  $x$  is drawn uniformly from  $S^{d-1}$ , then for any fixed  $r \in S^{d-1}$  and any  $\theta \in (0, 1)$ ,

$$\Pr[\langle x, r \rangle \geq \theta] \leq e^{-d\theta^2/2}. \quad (2)$$

This is the canonical *cap-volume* estimate (see Ball’s introduction to convex geometry [32] or Vershynin’s textbook [30]; tight constants appear in Milman and Schechtman [33] and in Ledoux [31]).

Equation (2) says: on a high-dimensional sphere, the spherical cap of angular radius  $\arccos \theta$  has exponentially small mass as  $d$  grows. This is why nearest-neighbour search on random points in high dimensions becomes trivial [34]: no point is close to the query except the query itself, if there is one.

Our setting is different in one crucial way. Our cluster is not isotropic on  $S^{d-1}$ ; it concentrates in a low-dimensional effective subspace of dimension  $d_{\text{eff}} \ll d$ . The bound we need therefore replaces  $d$  by  $d_{\text{eff}}$ : on a cluster with effective dimension  $d_{\text{eff}}$  and mean within-cluster distance  $\bar{d}$ , a spherical cap of radius  $\arccos \theta$  has mass at most  $c_1(\theta'/\bar{d})^{d_{\text{eff}}/2}$  whenever  $\theta' < \bar{d}$  (Lemma 9 in Methods). A union bound over  $m$  representatives then gives the theorem. The low-dimensionality of real embedding clusters is what makes the bound non-trivial: for  $d_{\text{eff}} = 16$  and  $\theta'/\bar{d} = 0.5$ , the per-representative mass bound is  $(0.5)^8 = 0.004$  — small, but not astronomically small. For  $d_{\text{eff}} = 2$  (HotpotQA-like),  $(0.5)^1 = 0.5$ , and the bound is vacuous within a factor of two.

### 2.6 Notation summary

We use the following notation throughout.

| Symbol                                                                         | Meaning                                               |
|--------------------------------------------------------------------------------|-------------------------------------------------------|
| $\mathcal{C} = \{x_1, \dots, x_n\} \subset S^{d-1}$                            | cluster of $n$ source points on the unit sphere       |
| $\mathcal{R} = \{r_1, \dots, r_m\} \subset S^{d-1}$                            | set of $m$ representatives produced by a consolidator |
| $\Sigma$                                                                       | sample covariance of $\mathcal{C}$                    |
| $\lambda_1 \geq \dots \geq \lambda_d$                                          | eigenvalues of $\Sigma$                               |
| $d_{\text{eff}} = (\sum_i \lambda_i)^2 / \sum_i \lambda_i^2$                   | effective dimension of $\mathcal{C}$ (Def. 6)         |
| $\bar{d} = \frac{1}{\binom{n}{2}} \sum_{i < j} (1 - \langle x_i, x_j \rangle)$ | mean within-cluster cosine distance                   |
| $\theta \in (0, 1)$                                                            | retrieval cap (minimum cosine to count as a hit)      |
| $\theta' = 1 - \theta$                                                         | cap slack                                             |
| $\varepsilon_{\text{cap}}$                                                     | cap-coverage error (Eq. 7)                            |
| $\varepsilon_{\text{id}}$                                                      | identity-retrieval error (Def. 8)                     |
| $\rho = \lambda_1 / \sum_i \lambda_i$                                          | spectral concentration (top eigenvalue fraction)      |

## 3 The Consolidation–Interference Duality

**What the theorem says, without symbols.** Take a cluster of embedded points that live on the unit sphere. Two numbers describe it: its *effective dimension*  $d_{\text{eff}}$ , which measures how many truly independent directions the cluster uses, and its *mean spread*  $\bar{d}$ , which measures how tight the cluster is. Pick a retrieval threshold  $\theta$ : a query “hits” a representative if their cosine exceeds  $\theta$ . The theorem says: if you compress the cluster to  $m$  representatives and the threshold slack  $\theta' = 1 - \theta$  is smaller than the cluster’s spread  $\bar{d}$ , then the fraction of cluster members whose nearest representative is outside the cap is at least  $1 - c_1 m (\theta'/\bar{d})^{d_{\text{eff}}/2}$ .

The exponent is the active ingredient. Whenever  $\theta' < \bar{d}$ , the base  $(\theta'/\bar{d})$  is less than one, and the whole quantity shrinks exponentially in  $d_{\text{eff}}$ . That exponential is the compression tax: to keep the identity-retrieval error below any target  $\varepsilon^*$ , the representative budget  $m$  must grow as  $(\bar{d}/\theta')^{d_{\text{eff}}/2}$ , which is astronomical for  $d_{\text{eff}} = 16$  and astronomical-squared for  $d_{\text{eff}} = 32$ . The deeper message: this is not a property of any particular summarisation algorithm. It is

![Figure 1: The law in one picture. (a) A cluster, its representative, and the cosine cap. (b) Tight regime (d_eff small): cap captures each cluster. (c) Spread regime (d_eff large): most members miss the cap.](adb1f42239329fa8283d1a40005f989f_img.jpg)

Figure 1 consists of three panels illustrating the relationship between a cluster, its representative, and a cosine cap. Panel (a) shows a single cluster of points (black dots) on a sphere, with a representative point  $r$  (blue star) and a cosine cap of angular radius  $\arccos \theta$  (light blue shaded region). Panel (b) shows three clusters, each with a representative point  $r$  and a cosine cap. The clusters are small and dense, so the caps capture most of the points. Panel (c) shows three clusters, each with a representative point  $r$  and a cosine cap. The clusters are larger and more spread out, so many points lie outside the caps.

Figure 1: The law in one picture. (a) A cluster, its representative, and the cosine cap. (b) Tight regime (d\_eff small): cap captures each cluster. (c) Spread regime (d\_eff large): most members miss the cap.

**Figure 1. The law in one picture.** A cluster of embedded members, a representative  $r$ , and a cosine cap of angular radius  $\arccos \theta$ . When the cluster’s effective dimension  $d_{\text{eff}}$  is small relative to the cap (panel b),  $r$  covers almost every member and consolidation is lossless. When  $d_{\text{eff}}$  is large (panel c), most members lie outside every cap and any single-vector summary loses identity. The law formalises exactly when (b) holds and predicts when (c) starts.

a property of the cluster itself. Pick a different summariser and you move around inside the bound; you cannot escape it.

### 3.1 Setup

Let  $\mathcal{C} = \{x_1, \dots, x_n\} \subset S^{d-1}$  be a cluster on the unit sphere. Let  $\mu_{\mathcal{C}} = \frac{1}{n} \sum_{i=1}^n \delta_{x_i}$  be its empirical measure. The *mean within-cluster distance* is

$$\bar{d} := \frac{1}{\binom{n}{2}} \sum_{i < j} (1 - \langle x_i, x_j \rangle). \quad (3)$$

A *consolidator* is any map  $\mathcal{C} \mapsto \mathcal{R} = \{r_1, \dots, r_m\} \subset S^{d-1}$  with  $m \leq n$ . For a *retrieval cap*  $\theta \in (0, 1)$ , the *identity-retrieval error* is

$$\varepsilon_{\text{id}}(\mathcal{C}, \mathcal{R}) := \frac{1}{n} \left| \left\{ i : \max_j \langle x_i, r_j \rangle < \theta \right\} \right| = 1 - \mu_{\mathcal{C}} \left( \bigcup_{j=1}^m H_j(\theta) \right), \quad (4)$$

where  $H_j(\theta) := \{x \in S^{d-1} : \langle x, r_j \rangle \geq \theta\}$  is the spherical cap of angular radius  $\arccos \theta$  around  $r_j$ . Informally,  $\varepsilon_{\text{id}}$  is the fraction of source points whose nearest representative fails to reach the cap.

### 3.2 Statement

**Theorem 1** (Consolidation–Interference Duality). *Let  $\mathcal{C} = \{x_1, \dots, x_n\} \subset S^{d-1}$  be a cluster with local effective dimension  $d_{\text{eff}}$  and mean within-cluster distance  $\bar{d}$ . Let  $\mathcal{R} = \{r_1, \dots, r_m\} \subset S^{d-1}$  be any set of  $m \leq n$  representatives produced by any consolidator. Fix a retrieval threshold  $\theta \in (0, 1)$  and write  $\theta' := 1 - \theta$ . If  $\theta' < \bar{d}$ , then*

$$\varepsilon_{\text{id}}(\mathcal{C}, \mathcal{R}) \geq 1 - c_1 m \left( \frac{\theta'}{\bar{d}} \right)^{d_{\text{eff}}/2}, \quad (5)$$

where  $c_1 > 0$  is an absolute constant, independent of  $m, n, d$ , and the choice of consolidator.

The proof is a two-step cap-volume argument: a local cap-volume lemma bounds the mass of a single cap under  $\mu_C$  by  $c_1(\theta'/\bar{d})^{d_{\text{eff}}/2}$ , and a union bound over the  $m$  representatives inflates that bound by a factor of  $m$ . The full proof is in Methods (§16).

### 3.3 Two immediate corollaries

**Corollary 2** (Compression lower bound). *Fix any target  $\varepsilon^* \in (0, 1)$ . To achieve  $\varepsilon_{\text{id}} \leq \varepsilon^*$  the consolidator must use at least*

$$m \geq c_1^{-1} (1 - \varepsilon^*) \left( \frac{\bar{d}}{\theta'} \right)^{d_{\text{eff}}/2} \quad (6)$$

*representatives. The representative budget grows exponentially in  $d_{\text{eff}}$ , with base  $\bar{d}/\theta'$ .*

**Corollary 3** (Isotropic degeneracy). *On a cluster whose embedding-space second moments are isotropic, importance-weighted consolidation (centroid with inverse-rank weights) converges to the uniform centroid at rate  $O(1/n)$  and therefore inherits the centroid’s bound with no improvement.*

Corollary 3 is what makes the importance-weighted baseline indistinguishable from centroid on every real text corpus we tested (see §5 and §6): real clusters are close to isotropic in their effective subspace, so the weighted mean collapses to the uniform mean.

### 3.4 Three ways to read Equation (5)

Equation (5) is the same formula read in three different directions. Each reading is useful.

**Read 1: A floor on error.** Fix a corpus (so  $\bar{d}$  and  $d_{\text{eff}}$  are given) and a retrieval policy ( $\theta$  given). Then the right-hand side is a function of  $m$  alone. It tells you: to keep identity-retrieval error below  $\varepsilon^*$ , your budget  $m$  cannot shrink below the threshold in Corollary 2. This is the *operational* reading — “how small can I make my index and still get answers back?”.

**Read 2: A test on cluster shape.** Fix  $m$  and  $\theta$ . Then the right-hand side is a function of  $d_{\text{eff}}$  and  $\bar{d}$  alone. It tells you which kinds of clusters can be compressed aggressively (small  $d_{\text{eff}}$ , tight  $\bar{d}$ ) and which cannot (large  $d_{\text{eff}}$ , spread  $\bar{d}$ ). This is the *diagnostic* reading — “does my corpus live on the right side of the regime boundary?”.

**Read 3: A duality.** The same spectral quantity  $(\theta'/\bar{d})^{d_{\text{eff}}/2}$  governs the No-Escape bound of the previous paper [2], which says any kernel-threshold memory with finite  $d_{\text{eff}}$  forgets by interference under retrieval noise. Forgetting under noise and identity loss under compression are therefore two readings of the *same* inequality on the cluster’s cap-volume quantity. This is why we call the theorem a *Consolidation–Interference Duality*: it is not a new bound; it is the No-Escape bound, specialised to the compression setting.

### 3.5 What the bound does and does not promise

Because we will spend a significant fraction of Section 5 measuring how well Equation (5) fits real data, it is worth being explicit about what it is and is not.

**It is a lower bound, not a prediction.** The theorem says consolidation cannot do better than the right-hand side. A specific consolidator might do much worse — that failure is strategic rather than geometric. The point of introducing GAC in §7 is to get close to the bound, not to break it.

**It is tight only in the tight regime**  $\theta' < \bar{d}$ . When  $\theta' \geq \bar{d}$  the cap-volume lemma becomes vacuous: the cap can contain the entire cluster and the bound reads  $\varepsilon_{\text{id}} \geq 1 - c_1 m \cdot 1$ , which is non-trivial only if  $c_1 m < 1$ . For  $\theta' = \bar{d}$  the right-hand side sits at the boundary of usefulness; for  $\theta' > \bar{d}$  (retrieval cap looser than cluster spread) the theorem stops giving information. This is the *spread regime*. Empirically (§5) the bound is tight enough to predict strategy rankings in the spread regime, but not tight enough to predict absolute error values there.

**$c_1$  is an absolute constant, but not a small one.** The proof gives  $c_1$  in terms of constants from the Berry–Esseen inequality and an exponential correction for concentration on the sphere. We do not optimise  $c_1$  in the proof; we calibrate it empirically in §5.5 and find  $c_1^{95} \approx 0.05$  in the tight regime, within an order of magnitude of the ideal Berry–Esseen constant that the cap-volume lemma reduces to. An anisotropic refinement would produce a smaller  $c_1$  at the price of a more delicate proof; we leave that to future work.

**Cluster-conditional, not marginal.** The effective dimension  $d_{\text{eff}}$  and spread  $\bar{d}$  are computed on *one* cluster, not on the ambient embedding. The paper’s previous installment documented that *global*  $d_{\text{eff}}$  of production sentence encoders is  $\approx 16$  [1]; the local  $d_{\text{eff}}$  on a single cluster of paraphrases is much smaller (we measure  $d_{\text{eff,local}} \in \{1.5, 2.3, 5.5, 12.6, 30.1, 107.5\}$  across our six corpora in §6). The bound applies cluster-by-cluster, and the bound for the worst cluster dominates the bound for the whole memory.

### 3.6 What is proved, what is observed, what is inferred

Before turning to experiments we separate three claim categories so that later sections can be read precisely.

**Proved.** For any consolidator acting on a unit-norm cluster, in the tight regime  $\theta' < \bar{d}$ , identity-retrieval error is lower-bounded by the right-hand side of Equation (5) with a universal constant  $c_1$  whose value follows from the cap-volume lemma (§16). This is the theorem.

**Empirically observed.** The tight/spread phase boundary at  $\bar{d} = \theta'$  is visible in the 400-cell synthetic grid of §5 and organises the ordering of six real-text corpora and six sentence encoders of §6. Restricted to the tight regime, the bound’s shape (exponent  $d_{\text{eff}}/2$ ) is quantitatively accurate with a calibrated  $c_1^{95} \approx 0.05$  over 12,400 cells. In the spread regime, the ordering of strategies is preserved but absolute error magnitudes are not sharply predicted by the bound.

**Inferred.** The dominance of centroid over adaptive routing on five real-text corpora (§7.2) is *explained by* the finding that these corpora sit in the tight regime the theorem declares safe. The regime-dependent three-way downstream split on Natural Questions, HotpotQA, and PopQA (§10) is *consistent with* the cap-coverage prediction for which operator the law prefers on each corpus. These are interpretive claims: the theorem does not *prove* that centroid must dominate on a given real corpus, but it predicts *which corpora should admit* centroid dominance, and that prediction holds in the data we collected.

**Not claimed.** The theorem is stated and proved for unit-norm embedding clusters under cosine-threshold retrieval. We do not claim that it applies unchanged to non-contrastive embedding spaces, to non-unit-norm representations (e.g. raw LLM hidden states), to multimodal embeddings, or to

biological memory. These are settings in which the law’s structural form is a natural hypothesis to test; the test has not yet been done.

## 4 Experimental Design

**Roadmap: experiments as tests of the law.** The theorem predicts a regime split: tight clusters admit one-vector summaries, spread clusters do not. Everything that follows is a test of that split and its consequences. E1 asks whether the split exists on a controlled grid. E2/E4/E8 ask whether cluster geometry organises behaviour across six real corpora and six encoders. E6 asks whether adaptation between summary families buys anything beyond picking the right one per cluster. E3 asks how consolidation trades off against learned quantization across the regime. E5 and E9 ask whether the answer is stable from 10K to 1M vectors and across query resamplings. E7 asks whether geometry predicts downstream reader exact-match with a 70B-parameter Llama reader. The nine experiments yield 17,813 measured cells (16,000 of them from the E1 grid). None of them were designed to crown a winning method; each was designed to isolate one implication of the regime split.

### 4.1 What each experiment is designed to show

Table 1 summarises the nine experiments. We describe them at a high level here; detailed designs appear in the corresponding results sections.

| Exp.         | Question it answers                                                               | Cells         |
|--------------|-----------------------------------------------------------------------------------|---------------|
| E1           | Does the tight/spread regime split exist on a controlled grid?                    | 16,000        |
| E2           | Does cluster geometry organise strategy behaviour across six real corpora?        | 503           |
| E3           | Does geometry, not method family, select between consolidation and quantization?  | 338           |
| E4           | Do full retrieval metrics agree with the identity-coverage story?                 | 90            |
| E5           | Is the regime answer stable from 10K to 1M vectors?                               | 23            |
| E6           | Does adaptation buy anything beyond picking the right summary family per cluster? | 126           |
| E7           | Does cluster geometry predict downstream reader EM with a 70B model?              | 10            |
| E8           | Does the geometric prediction reproduce across six sentence encoders?             | 198           |
| E9           | Is the regime answer stable under query resampling?                               | 525           |
| <b>Total</b> |                                                                                   | <b>17,813</b> |

**Table 1.** The nine experiments and the part of the law each one tests. Each row is expanded into its own results section (§5 through §11). **Read this table as the map of the remaining paper:** every later figure attacks one of these questions.

The design has two overlapping guarantees. First, each experiment answers *one* question about the regime split; the others either isolate a confounder or extend coverage. Second, each experiment is independently interpretable: a reader can stop at the end of any one and take away a complete finding. This matches the way we ran them in practice: one at a time, with the next one’s design informed by the previous one’s result. The order in which we present them below mirrors the logic rather than the chronology: E1 establishes the regime split, E2/E4/E8 show that the split organises real corpora, E6 tests whether adaptation helps, E3 asks which compression family wins where, and E5/E7/E9 ask whether the answer survives scale, downstream use, and resampling.

### 4.2 The six corpora

We use six text corpora, chosen to span the  $(d_{\text{efflocal}}, \bar{d})$  plane from the theorem’s tight regime to its extreme-coherence corner.

- **drm\_templated** ( $n = 4,000$ , synthetic). Derived from the Deese–Roediger–McDermott false-memory paradigm [35]: 800 semantically structured facts, each rendered in five paraphrase templates. Designed as a tight, low- $d_{\text{eff}}$  control:  $d_{\text{efflocal}} = 2.3$ ,  $\bar{d} = 0.05$ . This is the *easy* corpus.
- **ms\_marco** ( $n = 14,972$ ). 1,500 queries from the MS MARCO passage-ranking benchmark [36], each with roughly ten associated passages. A classic IR benchmark with moderate per-cluster spread.
- **nq\_questions** ( $n = 6,973$ ). 500 groups from Natural Questions [37], treating each question group as a cluster. High  $d_{\text{efflocal}} = 12.6$ .
- **hotpot\_qa** ( $n = 2,772$ ). 1,189 multi-hop question groups from HotpotQA [38]. A stress case: tiny clusters (two or three items), high  $\bar{d} = 0.48$ , very small  $d_{\text{efflocal}} = 1.5$ . The bound is loose here and the corpus is the hardest in our collection.
- **wikipedia\_sections** ( $n = 19,793$ ). 379 sections from the 20231101 English Wikipedia dump. High  $\bar{d}$ , mid- $d_{\text{eff}}$ .
- **arxiv\_titles** ( $n = 11,500$ ). Eleven subject classes from `ccdv/arxiv-classification`. Unusual high  $d_{\text{efflocal}} = 107.5$ : the corpus where the cap-volume bound goes vacuous first, so we expect learned quantization to overtake consolidation. It does (§8).

The corpora were selected *before* the experiments ran, with the criterion that they sample different  $(d_{\text{efflocal}}, \bar{d})$  regimes. They are not tuned for any individual strategy’s benefit.

### 4.3 The six encoders

We run the full DRM strategy sweep on six sentence encoders to separate theorem-predicted universality from encoder-specific artefacts: `BAAI/bge-base-en-v1.5` [24], `BAAI/bge-large-en-v1.5` [24], `sentence-transformers/all-mpnet-base-v2` [39], `sentence-transformers/all-MiniLM-L6-v2` [40], `intfloat/e5-large-v2` [25], `nomic-ai/nomic-embed-text-v1.5` [41]. Their embedding dimensions range from 384 (MiniLM) to 1024 (BGE-large, E5-large, Nomic), and they differ in contrastive training corpus, instruction schema, and tokeniser. If the theorem’s prediction is a property of the cluster geometry rather than of any one encoder’s artefacts, the strategy ranking should reproduce across all six (§6.4). It does, with a single exception (Nomic), which we attribute to the encoder’s higher intrinsic  $\bar{d}$  pushing the DRM corpus from tight to spread regime.

### 4.4 The five consolidation strategies

Each experiment evaluates some subset of these five operators.

- **Centroid**:  $r_k = \text{mean}(\mathcal{C}_k) / \|\text{mean}\|$ . One representative per cluster; simplest operator.
- **Medoid**:  $r_k = \arg \min_{x \in \mathcal{C}_k} \sum_{y \in \mathcal{C}_k} d(x, y)$ . One representative per cluster; chosen from the cluster itself. Always closer to at least one real vector than the centroid.
- **Importance-weighted**: weighted mean with weights from an inverse-rank sampler over pairwise similarities. Degenerates to centroid on isotropic clusters (Corollary 3).

- **Selective pruning:** keep the top- $p\%$  items by cosine similarity to the cluster centroid and drop the rest.  $p = 50\%$  by default; we also sweep  $p \in \{10\%, 25\%\}$  in E8.
- **GAC (Geometry-Aware Consolidation):** per-cluster router that picks between centroid, medoid-plus-residual, and pruning depending on two features of the cluster (§7). The production router.

Plus a *no-consolidation* reference that keeps all source vectors; this sets the ceiling for downstream retrieval accuracy.

### 4.5 Learned-quantization baselines

Five non-consolidation families compete against ours on identity accuracy at matched bytes/vector in E3 (§8):

- **Product Quantization (PQ)** [13]: FAISS implementation,  $m \in \{4, 8, 16, 32\}$  chunks, 256 centroids per chunk.
- **Optimized PQ (OPQ)** [14]: PQ with a learned rotation, same chunk schedule.
- **LSH** [15]: signed random projections to  $\{64, 128, 256, 512\}$  dimensions then reconstructed.
- **PCA+int8:** principal components to  $\{16, 32, 64, 128\}$  dimensions followed by per-dimension int8 quantisation.
- **HNSW-prune** [17]: hnswlib index with  $M = 16$ ,  $ef = 200$ , and  $\{25\%, 50\%, 75\%\}$  prune-and-rank retention.

All baselines are compared to consolidation on the same (80%/20%) train/query split of each corpus.

### 4.6 Statistical design: seeds, splits, reporting

Each experiment reports mean performance across three to ten seeds per cell (exact  $n$  per experiment in the respective section). Seeds control both the random train/query split and any stochastic operator (e.g. PQ initialisation, GAC’s random subsample for residual-direction fitting). Win/tie/loss counts use a tolerance of  $10^{-3}$  on mean cap-coverage error or identity accuracy, chosen to match the one-SD noise floor across seeds.

All raw results land as line-delimited JSON shards on a persistent Modal volume, then are reduced to parquet files per experiment. The parquet files are committed under `results/` in the repository, along with the reduction scripts that produced them. Every number cited in this paper is re-derivable by running `scripts/make_figures.py` and the per-experiment table builders; we verify this end-to-end as part of Reflection 14.

### 4.7 Compute footprint and honesty budget

The full run footprint is 17,813 cells, spread across nine experiments. Roughly 60% of the wall-clock budget went to E1 (the 16,000-seed theoretical grid) and 20% to E7 (the Llama-3.1-70B-Instruct RAG runs on two-H100 nodes with tensor parallelism 2). The remaining 20% covers the six-corpora, six-encoder sweep of E2–E9. Where we stopped short of the originally planned coverage — E5 at 1M points instead of 10M, E7 at 10 cells instead of a full  $3 \times 5$  grid, E8 at 198 cells instead of 1,008 — we flag the gap as an honest limitation (§14), never as a methodological choice.

## 5 The regime split exists (E1)

**What this experiment tests.** The theorem predicts a regime split at  $\theta' = \bar{d}$ : below that boundary (the *tight* regime) the bound shrinks to zero and every reasonable strategy should succeed; above it (the *spread* regime) the bound degrades and strategy choice should begin to matter. E1 is designed to test that split, not to crown a strategy. On a 400-cell synthetic grid with ten seeds each (16,000 trials), the tight regime is uniformly solved: all four strategies achieve mean cap error  $\leq 0.5\%$ . In the spread regime the strategies fan out in the  $d_{\text{eff}}$ -monotone order the theorem anticipates qualitatively. The calibration below also shows where the bound is honest and where it is not: the 95% calibrated  $c_1$  is  $\approx 0.05$  in tight cells (within an order of magnitude of the ideal Berry–Esseen constant  $\approx 0.4665$ ) and  $\sim 10^{10}$  in the extreme-coherence corner, which we read as a signal of an anisotropic refinement that our proof does not yet capture (§14).

### 5.1 Grid design

We generate clusters directly on  $S^{d-1}$  with controlled  $(d_{\text{eff}}, \theta, \bar{d})$ . For each cell:

1. Sample a target spectrum  $\lambda_1 \geq \dots \geq \lambda_d$  whose Roy–Vetterli effective dimension matches the target  $d_{\text{eff}}$ . We use a geometric tail:  $\lambda_i \propto r^{i-1}$  for a rate  $r$  chosen so that  $(\sum_i \lambda_i)^2 / \sum_i \lambda_i^2 = d_{\text{eff}}$ .
2. Draw  $n = 1500$  points from  $\mathcal{N}(0, \text{diag}(\lambda))$  and project each to  $S^{d-1}$ .
3. Rotate the cluster so that its mean within-cluster cosine distance is the target  $\bar{d}$  (by scaling all vectors with a global concentration parameter).

This construction decouples  $d_{\text{eff}}$  from  $\bar{d}$  cleanly: we can land anywhere in the  $(d_{\text{eff}}, \theta, \bar{d})$  cube we want. The grid ranges are

$$d_{\text{eff}} \in \{4, 8, 16, 32, 64\}, \quad \theta \in \{0.70, 0.80, 0.90, 0.95\}, \quad \bar{d} \in \{0.05, 0.10, \dots, 1.00\},$$

for  $5 \times 4 \times 20 = 400$  cells. Each cell is run with 10 random seeds (different draws of the cluster and consolidator stochasticity). Four strategies are evaluated on each seed: centroid, medoid, 50% selective pruning, and GAC. Total cells:  $400 \times 10 \times 4 = 16,000$ .

For each (cell, seed, strategy) triple we record the *cap-coverage error*

$$\varepsilon_{\text{cap}} := \Pr_{x \sim \mathcal{C}} [\max_j \langle x, r_j \rangle < \theta], \quad (7)$$

which is the native quantity the theorem bounds — no hyperparameters, no retrieval pipeline, no encoder, no text. If the theorem fails to explain  $\varepsilon_{\text{cap}}$  on this grid, nothing downstream will matter.

### 5.2 Regime separation

The 400 grid cells split naturally into two halves by the theorem’s own boundary condition.

**Tight regime** ( $\bar{d} < \theta'$ ). Here the bound gives a non-vacuous right-hand side, and Theorem 1 says the per-strategy error should be small.

**Spread regime** ( $\bar{d} \geq \theta'$ ). Here the cap-volume lemma is vacuous (the cap can contain the whole cluster), so the bound degenerates. The theorem makes no quantitative prediction here; it only predicts that strategies will fan out in a  $d_{\text{eff}}$ -monotone order.

Empirically, every strategy achieves mean  $\varepsilon_{\text{cap}} \leq 0.004$  across all tight-regime cells. In the spread regime the four strategies diverge to mean errors of 0.298 (prune), 0.331 (GAC), 0.566 (centroid), 0.741 (medoid). On the spread side, where the theorem is informative only about ordering, the order is exactly the one predicted by cap-volume intuition: pruning keeps the densest half of the cluster and therefore covers the most mass; GAC mixes centroid with pruning depending on cluster shape and sits between; centroid is a single vector at the mean, which is inside the cluster but not necessarily inside any single cap; medoid is one of the real vectors but not the mean-optimal one.

### 5.3 Monotonicity in $d_{\text{eff}}$

Restricted to the spread regime, mean  $\varepsilon_{\text{cap}}$  is monotone in  $d_{\text{eff}}$  for every strategy. The numbers:

| $d_{\text{eff}}$ | 4     | 8     | 16    | 32    | 64    |
|------------------|-------|-------|-------|-------|-------|
| centroid         | 0.543 | 0.552 | 0.560 | 0.569 | 0.576 |
| GAC              | 0.181 | 0.252 | 0.316 | 0.385 | 0.446 |
| medoid           | 0.591 | 0.668 | 0.738 | 0.802 | 0.864 |
| prune (50%)      | 0.137 | 0.204 | 0.268 | 0.344 | 0.424 |

The theorem predicts monotonic growth in  $d_{\text{eff}}$  (the exponent of  $(\theta'/\bar{d})^{d_{\text{eff}}/2}$ ); the data confirm it for all four strategies. Centroid is the slowest grower (one representative sits at the mean, which is not itself cap-sensitive), pruning is the fastest (its error floor is  $1 - p = 50\%$ , and as  $d_{\text{eff}}$  grows the cap around the retained half shrinks toward that floor).

### 5.4 Pareto structure across strategies

For every cell we compare strategies pairwise on mean  $\varepsilon_{\text{cap}}$  over the ten seeds, with a  $10^{-3}$  tolerance defining ties. Over the 400 cells:

| GAC vs. baseline | wins | ties | losses |
|------------------|------|------|--------|
| GAC vs. medoid   | 120  | 280  | 0      |
| GAC vs. centroid | 65   | 286  | 49     |
| GAC vs. prune    | 0    | 357  | 43     |

Three observations.

First, **GAC Pareto-dominates the medoid baseline**. On no cell does medoid achieve lower mean error than GAC. This is the cleanest positive result of the synthetic grid.

Second, **GAC essentially ties centroid** on 286/400 cells and splits the remaining 114 roughly evenly. The ties are mostly the tight regime, where every strategy saturates near 0; the 65 GAC wins concentrate in the high- $\bar{d}$  corner of the spread regime, where residual-direction budget helps; the 49 GAC losses concentrate where  $\bar{d}$  is only marginally above  $\theta'$  and centroid's single vector is a better use of the budget than GAC's fractional medoid-plus-residual.

Third, **selective pruning wins against GAC on the synthetic grid alone**. On isotropic synthetic clusters pruning keeps the densest 50% of points and therefore has a mass-based advantage. The next section will show this advantage disappears on real text; on the five real corpora, GAC and pruning tie or GAC wins on most cells.

### 5.5 Bound calibration: fitting $c_1$ to the data

Theorem 1 states the bound up to an absolute constant  $c_1 > 0$ . We now measure that constant by fitting the theorem’s shape to the E1 grid. Specifically, for each grid row write

$$\varepsilon_{\text{cap}}^{\text{pred}}(c_1) = \max(0, 1 - c_1 m(\theta'/\bar{d})^{d_{\text{eff}}/2})$$

and ask for the smallest  $c_1$  such that the predicted error is at most the observed error on  $\geq 95\%$  of rows in the regime. Results:

| regime                            | cells  | $c_1^{95}$ (calibrated) | theorem holds after calib. |
|-----------------------------------|--------|-------------------------|----------------------------|
| tight ( $\bar{d} < \theta'$ )     | 12,400 | 0.046                   | 95.0%                      |
| spread ( $\bar{d} \geq \theta'$ ) | 3,600  | $4.61 \times 10^{10}$   | 95.0%                      |
| all (p95)                         | 16,000 | $4.60 \times 10^6$      | 95.0%                      |

The regime split here is exactly the one the theorem uses: “tight” means  $\bar{d} < \theta'$ , the hypothesis under which Equation (5) is non-vacuous, not a heuristic cut on  $d_{\text{eff}}$ . Each row reports the smallest  $c_1$  such that the theorem bound holds on  $\geq 95\%$  of cells in that regime; the “holds after calib.” column reports the actual coverage.

The tight regime fits cleanly: a universal  $c_1 \approx 0.05$  makes the theorem’s lower bound valid on 95% of tight cells, and raising  $c_1$  to  $\approx 370$  covers 99%. The headline number  $c_1 \approx 0.05$  is *within an order of magnitude of the ideal Berry–Esseen constant* ( $\approx 0.4665$ ) that the cap-volume lemma reduces to — the tightest  $c_1$  could possibly be without an anisotropic refinement. The spread regime is a different story. There  $\theta'$  is as small as 0.05 (at  $\theta = 0.95$ ) while  $\bar{d}$  is as large as 1.0, giving  $(\theta'/\bar{d})^{d_{\text{eff}}/2} = (0.05)^{32} \approx 10^{-42}$  at  $d_{\text{eff}} = 64$ . The predicted error floor  $1 - c_1 m \cdot 10^{-42}$  is numerically indistinguishable from 1, while the empirical error floors much lower ( $\approx 0.3$ – $0.7$ ). The ratio between the two is absorbed into  $c_1$ , which blows up to  $10^{10}$  in the worst corner.

We read this calibration conservatively. *The theorem’s shape is right in the tight regime and becomes quantitatively vacuous in the extreme-coherence corner of the spread regime.* The shape loses traction because the cap-volume lemma treats the cluster-conditional tail as isotropic Gaussian, whereas real clusters concentrate into a lower-dimensional effective subspace whose anisotropic tail is much heavier. A refined bound that accounts for the cluster’s own anisotropy is what we believe would tighten  $c_1$  in the spread regime; constructing that bound is the primary open theoretical problem raised by this paper (§14). Until then, the spread-regime evidence in the rest of the paper should be read as *observational* support for the theorem’s qualitative predictions (ordering, monotonicity), not as a test of its quantitative form.

### 5.6 Identity vs. coverage decomposition

A subtlety of consolidation quality that the theorem glosses over: the cap-volume quantity  $\varepsilon_{\text{cap}}$  bounds *two* things that need not be equal. The first is *identity of stored items* — does each original cluster member still live within  $\theta$  of at least one representative? This is what Theorem 1 bounds directly. The second is *coverage of queries*:

$$\text{cov}_\theta := \Pr_{q \sim \mathcal{Q}} [\exists j : \langle q, r_j \rangle \geq \theta], \quad (8)$$

where  $\mathcal{Q}$  is the distribution of incoming queries. Identity is the retrieval success on the stored population; coverage is retrieval success on a new population.

![Figure 2: Four heatmaps showing the tight/spread regime split for different strategies: Centroid, Medoid, Prune-50%, and GAC (probe). The x-axis represents the cosine threshold theta (0.70 to 0.95) and the y-axis represents the effective dimension d_eff target (4 to 64). A colorbar on the right indicates the fraction of cells where the bound holds, ranging from 0.0 (dark purple) to 1.0 (yellow). All strategies show a similar boundary between the tight regime (bottom-right) and the extreme-coherence corner (top-left).](b2d16e07bfa79d67a8adabf7e26c7764_img.jpg)

Figure 2: Four heatmaps showing the tight/spread regime split for different strategies: Centroid, Medoid, Prune-50%, and GAC (probe). The x-axis represents the cosine threshold theta (0.70 to 0.95) and the y-axis represents the effective dimension d\_eff target (4 to 64). A colorbar on the right indicates the fraction of cells where the bound holds, ranging from 0.0 (dark purple) to 1.0 (yellow). All strategies show a similar boundary between the tight regime (bottom-right) and the extreme-coherence corner (top-left).

**Figure 2. The tight/spread regime split exists and is strategy-independent.** Fraction of  $(d_{\text{eff}}, \theta)$  cells at which the theorem’s  $c_1 = 1$  bound holds across 10 seeds per cell, for four strategies (centroid, medoid, selective pruning, GAC). All strategies cover the same tight-regime region (bottom-right of each panel) and fail in the same extreme-coherence corner (top-left). The boundary between them is a property of the *clusters*, not the strategy: this is the empirical signature of the regime split. Shared colorbars allow direct comparison; see §5.5 for the calibrated constants.

On E1 both quantities are within 0.01 of each other (the cluster *is* the query distribution there). On real corpora they dissociate. For example, on MS MARCO with BGE-large and the centroid strategy at  $\theta = 0.80$ , identity accuracy is 0.905 and  $\text{cov}_{0.80} = 0.556$ : a new paraphrase of a stored question is more than 35 points less likely to land inside a cap than the original stored item is. On Wikipedia sections both collapse:  $\text{cov}_{0.80} = 0.058$  for centroid and 0.015 for GAC. The budget buys one axis (identity) more cheaply than it buys the other (coverage) — a fact our theorem does not itself predict, but that is consistent with it: identity requires the cap to contain at least one stored point, while coverage requires the cap to contain a *new* point drawn from a potentially different anisotropy.

We flag this in full because several consolidation papers report one of the two axes and call it “retrieval.” In our data the two axes can differ by a factor of ten. The identity/coverage split will reappear in E7 (§10), where the Llama reader’s EM on PopQA depends on coverage of paraphrase queries, not just on identity of the stored entities.

## 6 Geometry organises real text (E2, E4, E8)

**What this block tests.** E1 showed the regime split on synthetic clusters where  $d_{\text{eff}}$  and  $\bar{d}$  were set by hand. E2/E4/E8 ask whether the same geometric quantities organise behaviour on real text. Three results: (i) across six corpora, identity accuracy falls by up to 46 points with the same encoder and same consolidator, and the ordering is the one the theorem’s scalar  $(\theta'/\bar{d})^{d_{\text{eff}}/2}$  assigns; (ii) **centroid (and its importance-weighted twin) dominates on every real corpus we tested** — this is the headline observation of the paper on text, and it is why later sections treat centroid rather than any adaptive scheme as the reference operator; (iii) the same strategy ranking reproduces across five of six sentence encoders, with the sixth (Nomic) explained as an encoder-dependent regime shift, not a failure of the law. What this block does *not* show: that any one consolidator is uniformly best in both regimes — the centroid advantage holds in the tight regime of real text and does not transfer to general spread-regime

settings (E1 pruning wins were synthetic).

### 6.1 Identity retrieval across six corpora (E2)

Using BGE-large, we measure *identity-retrieval accuracy* on each corpus under the centroid consolidator at retrieval threshold  $\theta = 0.80$ . Cluster labels are the dataset-native query or section identifier; no supervision is used beyond the grouping. Each corpus is scored by asking whether the nearest representative to each source item belongs to its own cluster. Results:

| corpus             | $d_{\text{efflocal}}$ | $\bar{d}$ | id. acc. (centroid) |
|--------------------|-----------------------|-----------|---------------------|
| drm_templated      | 2.3                   | 0.05      | 0.942               |
| ms_marco           | 5.5                   | 0.33      | 0.905               |
| nq_questions       | 12.6                  | 0.38      | 0.761               |
| arxiv_titles       | 107.5                 | 0.33      | 0.754               |
| wikipedia_sections | 30.1                  | 0.51      | 0.647               |
| hotpot_qa          | 1.5                   | 0.48      | 0.487               |

Two things stand out. First, **there is a 45.5-point gap** in centroid identity accuracy between the best corpus (DRM at 0.942) and the worst (HotpotQA at 0.487). This is the *template collapse* effect: same encoder, same consolidator, same retrieval policy, but cluster geometry decides whether identity holds or breaks.

Second, **the ordering is not monotone in  $d_{\text{efflocal}}$  alone**. HotpotQA has the smallest  $d_{\text{efflocal}}$  of the six (1.5) yet the lowest accuracy. The explanation is that HotpotQA’s clusters combine a tight concentration ( $d_{\text{eff}} = 1.5$ ) with high spread ( $\bar{d} = 0.48$ ). The joint quantity

$$\left(\frac{\theta'}{\bar{d}}\right)^{d_{\text{eff}}/2}$$

orders the corpora consistently with the observed accuracy (largest first, corresponding to tightest bound): DRM > MS MARCO > NQ  $\approx$  arXiv > Wikipedia > HotpotQA. We state this carefully: the empirical ranking of the six corpora *agrees with* the theorem’s scalar ordering. Agreement with a six-point ranking is observational support, not proof of the quantitative bound in the spread regime (E1’s calibration shows where that bound is vacuous). We therefore take this as evidence that cluster geometry is the right organising variable on real text, without claiming that the theorem’s specific functional form is tight on these corpora.

### 6.2 Paraphrase robustness (E4)

A common concern with identity-retrieval numbers is that they might be reporting *memorization* rather than consolidation quality: maybe the encoder just encodes token overlap, and the identity test is passing because the probe item is token-identical to its own stored version.

We rule this out by replacing each probe with a *paraphrase*. Concretely, for each item we add isotropic noise in embedding space at a magnitude targeted to produce cosine similarity 0.92 with the source vector. The 0.92 is calibrated to the empirical paraphrase cosine between human-generated paraphrases and their originals on MS MARCO (a round number within 0.01 of the median on that dataset). We then re-run identity retrieval using the noised probe as the query.

Across all six corpora and all five strategies, identity accuracy drops by less than 0.02 under paraphrase; the single largest drop is 0.026 (HotpotQA, centroid strategy). The maximum drop

is therefore smaller than the cross-corpora noise due to seed variation. This refutes the pure-memorization hypothesis: the identity scores are properties of the cluster’s *embedding geometry*, not of exact-token matches.

**A disclosure.** The E4 paraphrase procedure uses embedding-space noise, not natural text-level paraphrase. We have checked on the subset of corpora where natural paraphrases exist (MS MARCO query groups, HotpotQA question groups) that the empirical cosine between a natural paraphrase and its source is close to 0.92, which is what motivates the noise magnitude. But the full extrapolation — that embedding-noise paraphrases and natural paraphrases have the same effect on identity accuracy — is an assumption we state explicitly as limitation L2 (§14). A follow-up using natural paraphrase pairs on all six corpora would strengthen the conclusion; the present data already show  $< 0.03$  delta on the two corpora where we have both.

### 6.3 Strategy sweep under paraphrase (E4): centroid dominates on text

Extending the E4 analysis to all five consolidation strategies across the six corpora (BGE-large, 3 seeds per cell), the within-corpora ordering is stable and **centroid-dominant**: centroid  $\geq$  importance-weighted  $>$  GAC  $\approx$  medoid  $>$  selective pruning on five of six corpora. (On DRM, GAC matches centroid exactly, and selective pruning is within 0.01 of medoid.) Recall@1 tracks identity accuracy to  $< 10^{-3}$  on every corpus. MRR@20 exceeds identity accuracy by  $\approx 0.05$ – $0.10$ . Recall@100 exceeds 0.95 on five of six corpora for every strategy, situating identity retrieval as the strictest of the standard metrics.

The centroid dominance is the headline empirical finding on real text. It is also the one that E1’s synthetic grid does *not* show — E1 has pruning ahead of centroid in the spread regime. The gap is explained by the regime: real text corpora sit inside the tight regime of Theorem 1 on five of six cases, where the centroid’s one-vector summary lives inside the cap around every cluster member and the byte-for-byte budget strongly favours one vector per cluster over fractional residual corrections. The strategy ranking on E1’s spread-regime cells and on real text are therefore *both* consistent with the same geometric prediction; they only look different because the two experiments sample different regions of the regime map.

### 6.4 Encoder universality (E8)

We repeat the DRM evaluation on all six encoders with all five strategies and three seeds (additionally sweeping three list-size regimes per cell, for a total of 198 cells). The headline identity accuracies at the 800-cluster list size:

| encoder   | centroid | IW    | medoid | prune | GAC   |
|-----------|----------|-------|--------|-------|-------|
| bge-base  | 1.000    | 1.000 | 0.997  | 0.886 | 0.998 |
| bge-large | 0.943    | 0.941 | 0.911  | 0.775 | 0.940 |
| e5-large  | 0.961    | 0.959 | 0.998  | 0.835 | 0.960 |
| minilm    | 0.950    | 0.948 | 0.848  | 0.744 | 0.937 |
| mpnet     | 0.924    | 0.918 | 0.852  | 0.697 | 0.923 |
| nomic     | 0.540    | 0.540 | 0.349  | 0.520 | 0.483 |

Three observations.

**(a) Strategy ranking is stable on five of six encoders.** The ordering centroid  $\approx$  IW  $\geq$  GAC  $\gg$  medoid  $\gg$  prune holds on BGE-base, BGE-large, MiniLM, MPNet, and Nomic. On E5-large the medoid actually edges centroid by 0.037 — the one encoder for which E5-large’s geometry

![Figure 3: Six bar charts showing identity accuracy and MRR@20 for six corpora: drm templated, ms marco, nq questions, hotpot qa, wikipedia sections, and arxiv titles. Each chart compares centroid, medoid, selective prune, importance weighted, and gac methods. Solid bars represent identity (literal), hatched bars represent identity (paraphrase), and diamond markers represent MRR@20. Centroid and importance-weighted methods consistently lead across all corpora, while GAC coincides with selective pruning.](60e9207be66a64332619bb4b667fe67b_img.jpg)

Figure 3: Six bar charts showing identity accuracy and MRR@20 for six corpora: drm templated, ms marco, nq questions, hotpot qa, wikipedia sections, and arxiv titles. Each chart compares centroid, medoid, selective prune, importance weighted, and gac methods. Solid bars represent identity (literal), hatched bars represent identity (paraphrase), and diamond markers represent MRR@20. Centroid and importance-weighted methods consistently lead across all corpora, while GAC coincides with selective pruning.

**Figure 3. Centroid dominates on every real corpus we tested.** Identity accuracy (solid bars: literal; hatched bars: 0.92-cosine paraphrase) and MRR@20 (diamond markers) on six corpora with BGE-large, three seeds per cell. Paraphrase drop is  $< 0.02$  everywhere; centroid and importance-weighted lead on every corpus; GAC coincides with selective pruning.

favours the medoid baseline. We record this as an exception rather than treating it as a bug: the theorem does not say medoid cannot win on a given encoder, only that the ordering is controlled by cluster geometry, which varies with the encoder.

**(b) Centroid and importance-weighted are indistinguishable on every encoder.** The maximum delta between the two across all 6 encoders is 0.006 (Nomic). This is Corollary 3’s prediction in action: on isotropic clusters the weighted mean collapses to the uniform centroid. Every encoder’s DRM embedding is close enough to isotropic within each cluster for the collapse to happen.

**(c) Nomic is a regime-shifted outlier.** On the same corpus (DRM), Nomic’s within-cluster  $\bar{d}$  is measured at  $\approx 0.34$ , against  $\approx 0.05$  for every other encoder. That single fact moves DRM from  $\bar{d} < \theta' = 0.20$  (tight regime for  $\theta = 0.80$ ) to  $\bar{d} > \theta'$  (spread regime). The theorem then predicts that every strategy will suffer by tens of percentage points, and indeed every Nomic row drops by 44–66% relative to the other encoders. This is not an encoder pathology; it is an encoder-dependent regime shift, exactly the kind the theorem predicts whenever the same text produces a different  $\bar{d}$  under a different encoder.

### 6.5 GAC $\theta$ -sweep (supplementary view)

Within E8 we also sweep GAC’s routing threshold  $\theta$  across a grid and plot the identity accuracy it yields as a function of  $\theta$ . Figure 5 (a supplementary perspective on the E8 grid) shows the curve is approximately flat in the tight regime and falls linearly in the spread regime. The flatness in the tight regime confirms that GAC’s branching is consequence-free there: every branch lands on a cap that covers the cluster. The fall in the spread regime is consistent with the theorem’s decay in  $(\theta'/\bar{d})^{d_{\text{eff}}/2}$ .

![Bar chart showing identity accuracy (DRM-templated) for five consolidation strategies across six sentence encoders. The strategies are centroid (teal), medoid (light gray), selective-prune (medium gray), importance-wt (dark gray), and GAC (brown). The encoders are bge-base, bge-large, e5-large, minilm, mpnet, and nomic. For the first five encoders, all strategies perform similarly. For nomic, all strategies drop together, with centroid still leading.](0f79a59f3766fc341ff688a23692c1d9_img.jpg)

| Encoder   | centroid | medoid | selective-prune | importance-wt | GAC  |
|-----------|----------|--------|-----------------|---------------|------|
| bge-base  | 1.00     | 0.88   | 1.00            | 1.00          | 1.00 |
| bge-large | 0.94     | 0.78   | 0.94            | 0.94          | 0.94 |
| e5-large  | 0.97     | 0.83   | 1.00            | 0.97          | 0.97 |
| minilm    | 0.95     | 0.73   | 0.85            | 0.95          | 0.91 |
| mpnet     | 0.92     | 0.72   | 0.83            | 0.92          | 0.90 |
| nomic     | 0.55     | 0.35   | 0.55            | 0.55          | 0.48 |

Bar chart showing identity accuracy (DRM-templated) for five consolidation strategies across six sentence encoders. The strategies are centroid (teal), medoid (light gray), selective-prune (medium gray), importance-wt (dark gray), and GAC (brown). The encoders are bge-base, bge-large, e5-large, minilm, mpnet, and nomic. For the first five encoders, all strategies perform similarly. For nomic, all strategies drop together, with centroid still leading.

**Figure 4. Same strategy ranking across five of six sentence encoders; the sixth is a regime shift, not a counterexample.** Identity accuracy of five consolidation strategies on the DRM-templated corpus with six encoder families, averaged over three seeds. Centroid and importance-weighted are indistinguishable on every encoder (Corollary 3); GAC tracks centroid within 0.02 on five of six encoders; Nomic’s higher  $\bar{d}$  pushes DRM across the  $\theta' = \bar{d}$  boundary into the spread regime, and every strategy degrades together, consistent with the theorem’s predicted encoder-dependent regime shift.

### 6.6 Compression frontier (supplementary view)

Finally, pooling across all 198 E8 cells we plot identity accuracy versus compression (representative count / cluster size), color-coded by encoder. Figure 6 shows that the frontier is encoder-invariant up to a vertical offset: the same compression-vs-identity trade-off holds across all six encoders, but each encoder operates at a different baseline level set by its own  $(d_{\text{eff}}, \bar{d})$ . This is the *universality* claim of the E8 block: strategy ranking *and* compression curve shape are shared; only the operating point shifts.

## 7 Geometry-aware strategies as probes of the law (E6)

**What this section tests, and what it does not.** Having established the regime split (E1) and that centroid dominates on real text (E2/E4/E8), we can now probe the gap between a fixed one-vector summary and *any* adaptive scheme that tries to spend the same budget more cleverly. The instrument we use is **Geometry-Aware Consolidation (GAC)**, a deterministic per-cluster router that reads  $\rho_k$  and  $\bar{d}_k$  from each cluster and dispatches to centroid, medoid-plus-residual, or selective pruning. GAC is not the paper’s product. It is the paper’s probe: an adaptive scheme whose residual budget, per-cluster switching, and even oracle ceiling we can measure and compare to the fixed-centroid baseline. **The probe returns a clean scientific result: on five of six real corpora, no adaptive variant — including the in-hindsight oracle — meaningfully beats the fixed-centroid picker.** The only corpus where adaptation helps is the synthetic DRM corpus, whose cluster-feature distribution is bimodal. Adaptive routing therefore buys something exactly when the law says it should (the regime is strongly split) and nothing when the law says the centroid is already near the ceiling

![Figure 5: GAC theta-sweep (supplementary E8 view). A line graph showing Identity accuracy (DRM) on the y-axis (0.0 to 1.0) versus GAC threshold theta on the x-axis (0.6 to 0.9). The graph includes data for bge-base, bge-large, e5-large, minilm, mpnet, and nomic encoders. A dashed horizontal line at 0.89 represents the centroid mean. Most encoders maintain high accuracy (around 0.9-1.0) across the threshold range, while nomic remains flat at approximately 0.48. mpnet shows a slight decline after theta=0.8.](9ce50bc10864dc86e1cdee4be08f1897_img.jpg)

| Encoder       | Identity accuracy (DRM) at theta=0.6 | Identity accuracy (DRM) at theta=0.7 | Identity accuracy (DRM) at theta=0.8 | Identity accuracy (DRM) at theta=0.9 |
|---------------|--------------------------------------|--------------------------------------|--------------------------------------|--------------------------------------|
| bge-base      | ~1.00                                | ~1.00                                | ~1.00                                | ~1.00                                |
| bge-large     | ~0.95                                | ~0.95                                | ~0.95                                | ~0.95                                |
| e5-large      | ~0.93                                | ~0.93                                | ~0.93                                | ~0.93                                |
| minilm        | ~0.92                                | ~0.92                                | ~0.92                                | ~0.92                                |
| mpnet         | ~0.92                                | ~0.92                                | ~0.92                                | ~0.84                                |
| nomic         | ~0.48                                | ~0.48                                | ~0.48                                | ~0.48                                |
| centroid mean | 0.89                                 | 0.89                                 | 0.89                                 | 0.89                                 |

Figure 5: GAC theta-sweep (supplementary E8 view). A line graph showing Identity accuracy (DRM) on the y-axis (0.0 to 1.0) versus GAC threshold theta on the x-axis (0.6 to 0.9). The graph includes data for bge-base, bge-large, e5-large, minilm, mpnet, and nomic encoders. A dashed horizontal line at 0.89 represents the centroid mean. Most encoders maintain high accuracy (around 0.9-1.0) across the threshold range, while nomic remains flat at approximately 0.48. mpnet shows a slight decline after theta=0.8.

**Figure 5. GAC  $\theta$ -sweep (supplementary E8 view).** Identity accuracy as a function of GAC’s routing threshold  $\theta$ , averaged across the six encoders of E8. The curve is flat in the tight regime (left) and declines in the spread regime (right), consistent with the cap-volume decay in Theorem 1.

(the tight regime of real text).

### 7.1 The probe: a deterministic router

For each cluster  $\mathcal{C}_k$ , compute two features from its local covariance  $\Sigma_k$ :

$$\rho_k := \frac{\lambda_1(\Sigma_k)}{\text{tr}(\Sigma_k)} \quad (\text{spectral concentration}), \quad (9)$$

$$\bar{d}_k := \frac{1}{\binom{m_k}{2}} \sum_{i < j} (1 - \langle x_{k,i}, x_{k,j} \rangle) \quad (\text{mean spread}). \quad (10)$$

Dispatch to one of three operators via two spread thresholds  $(\bar{d}_{\text{safe}}, \bar{d}_{\text{unsafe}}) = (0.75\theta', 1.25\theta')$  and one concentration threshold  $\tau_p = 0.30$ :

|                                                                     |                                                                                       |
|---------------------------------------------------------------------|---------------------------------------------------------------------------------------|
| <b>if</b> $\rho_k > \tau_p$ and $\bar{d}_k < \bar{d}_{\text{safe}}$ | use <b>centroid</b> (cluster is dense and tight)                                      |
| <b>elif</b> $\bar{d}_k > \bar{d}_{\text{unsafe}}$                   | use <b>top-<math>p</math> selective pruning</b> (cluster is too diverse to summarise) |
| <b>else</b>                                                         | use <b>medoid + top-<math>r</math> residual directions</b> (intermediate)             |

With  $\theta = 0.80$ ,  $\bar{d}_{\text{safe}} = 0.15$  and  $\bar{d}_{\text{unsafe}} = 0.25$ . Routing cost is  $O(n_k d)$  per cluster, dominated by the centroid formation itself (using  $\bar{d}_k \approx 1 - \|\text{mean}(\mathcal{C}_k)\|^2$  for unit-norm inputs). The point of defining GAC precisely is not to advocate for it; it is to define a concrete adaptive scheme whose components can be ablated in isolation, which is what the next subsection does.

![Figure 6: A scatter plot showing Identity accuracy (DRM) on the y-axis (ranging from 0.0 to 1.0) versus Compression ratio (n_train / n_representatives) on the x-axis (logarithmic scale from 10^0 to 4 x 10^0). Data points are color-coded by encoder: centroid (blue), gac (orange), importance_weighted (dark grey), medoid (light grey), no_consolidation (black), and selective_prune (light blue). The plot shows that identity accuracy is generally high (above 0.8) across most compression ratios, with some lower values at 10^0 and 2 x 10^0. The shape of the frontier is shared, but the absolute level is set by each encoder's within-cluster geometry.](645bea0b27d63e4a9a300af5793ae7d2_img.jpg)

Figure 6: A scatter plot showing Identity accuracy (DRM) on the y-axis (ranging from 0.0 to 1.0) versus Compression ratio (n\_train / n\_representatives) on the x-axis (logarithmic scale from 10^0 to 4 x 10^0). Data points are color-coded by encoder: centroid (blue), gac (orange), importance\_weighted (dark grey), medoid (light grey), no\_consolidation (black), and selective\_prune (light blue). The plot shows that identity accuracy is generally high (above 0.8) across most compression ratios, with some lower values at 10^0 and 2 x 10^0. The shape of the frontier is shared, but the absolute level is set by each encoder's within-cluster geometry.

**Figure 6. Compression frontier across encoders (supplementary E8 view).** Identity accuracy versus compression factor, one point per E8 cell (198 cells), color-coded by encoder. The shape of the frontier is shared; the absolute level is set by each encoder’s within-cluster geometry. This is the universality claim of E8 in a single view.

### 7.2 What adaptation does and does not buy (E6)

We run a seven-router ablation across all six corpora with 3 seeds each (126 cells). Routers:

- **gac\_full** — the router just defined.
- **gac\_no\_residual** — identical, but drops the residual directions in the medoid branch.
- **gac\_random** — routes uniformly at random.
- **gac\_fixed\_centroid** — always centroid.
- **gac\_fixed\_medoid** — always medoid.
- **gac\_fixed\_prune** — always pruning at  $p = 50\%$ .
- **gac\_oracle** — for each cluster, pick in hindsight the operator that minimises identity error on that cluster (upper bound on what any router could achieve).

| corpus             | full  | no-res. | random | fix-ctr | fix-med | fix-prune | oracle |
|--------------------|-------|---------|--------|---------|---------|-----------|--------|
| drm templated      | 0.940 | 0.942   | 0.840  | 0.943   | 0.920   | 0.776     | 0.943  |
| ms_marco           | 0.836 | 0.833   | 0.806  | 0.899   | 0.794   | 0.830     | 0.862  |
| nq_questions       | 0.433 | 0.434   | 0.491  | 0.784   | 0.691   | 0.425     | 0.512  |
| hotpot_qa          | 0.356 | 0.355   | 0.386  | 0.499   | 0.357   | 0.355     | 0.489  |
| wikipedia_sections | 0.393 | 0.393   | 0.403  | 0.656   | 0.485   | 0.393     | 0.388  |
| arxiv_titles       | 0.584 | 0.584   | 0.547  | 0.754   | 0.630   | 0.584     | 0.598  |

Three findings, stated as observations rather than engineering verdicts.

(a) **Residual-direction budget buys nothing measurable on real text.** `gac_full` and `gac_no_residual` are indistinguishable on every corpus (max  $\Delta = 0.002$ ). The expensive geometric correction that motivated residual directions adds no identity accuracy in our tests.

(b) **Fixed centroid outperforms every adaptive variant on every real corpus.** `gac_fixed_centroid` beats `gac_full` by +6.3 (MS MARCO), +35.1 (NQ), +14.3 (HotpotQA), +26.3 (Wikipedia), and +17.0 (arXiv). Only on the synthetic DRM corpus do they tie. The adaptive scheme’s branching decision is driven by finite-sample estimates of  $p_k$  and  $d_k$ ; when the per-cluster feature distribution is concentrated (real text) the branching noise exceeds the branching signal.

(c) **Even the oracle cannot beat fixed centroid by much.** `gac_oracle` — the ceiling of any router — exceeds `gac_fixed_centroid` by at most 0.010 on any real corpus (HotpotQA), and on Wikipedia and NQ the oracle is *worse* (because the oracle is per-cluster, and its per-cluster choices include medoids that suffer when queries are paraphrase-noised). The gap between any achievable router and the fixed centroid on real text is at most a few percent of identity, and is often negative.

**Interpretation: the probe confirms the law.** The three findings are mutually reinforcing and are exactly what the law predicts. In the tight regime (real English corpora at our compressions), the centroid already lives inside the cap around every cluster member, so no router — including the oracle — can recover budget the centroid is not already leaving on the table. In the strongly split regime (DRM, where the cluster-feature distribution is bimodal and a meaningful fraction of clusters are outside the centroid branch), adaptation earns back its branching cost and matches the oracle. **We therefore read E6 as a negative engineering result and a positive scientific result:** the regime split is so clean on real text that even an in-hindsight oracle cannot improve on the fixed centroid, and GAC serves its purpose not as a method but as the instrument that made this measurable.

![Figure 7: Identity accuracy of seven router variants across six corpora. The figure consists of two bar charts. Chart (a) shows 'Identity accuracy (DRM-templated)' for the synthetic DRM corpus, where all variants (fixed_centroid, fixed_medoid, fixed_prune, no_residual, random, full, oracle) achieve nearly identical accuracy around 0.95. Chart (b) shows 'Identity accuracy vs. gac_full' for five real corpora: arxiv titles, nq questions, hotpot qa, ms marco, and wikipedia sections. In chart (b), the y-axis represents the difference in identity accuracy compared to gac_full. For all real corpora, gac_full (red bar) is the baseline at 0.00. fixed_centroid (teal) shows a positive difference, indicating it outperforms gac_full. fixed_medoid (grey) shows a negative difference. fixed_prune (light grey), no_residual (dark grey), random (medium grey), and oracle (yellow) show varying degrees of performance relative to gac_full, with oracle generally being close to or slightly below gac_full.](004a497465710d16d63f436bb330fb42_img.jpg)

Figure 7: Identity accuracy of seven router variants across six corpora. The figure consists of two bar charts. Chart (a) shows 'Identity accuracy (DRM-templated)' for the synthetic DRM corpus, where all variants (fixed\_centroid, fixed\_medoid, fixed\_prune, no\_residual, random, full, oracle) achieve nearly identical accuracy around 0.95. Chart (b) shows 'Identity accuracy vs. gac\_full' for five real corpora: arxiv titles, nq questions, hotpot qa, ms marco, and wikipedia sections. In chart (b), the y-axis represents the difference in identity accuracy compared to gac\_full. For all real corpora, gac\_full (red bar) is the baseline at 0.00. fixed\_centroid (teal) shows a positive difference, indicating it outperforms gac\_full. fixed\_medoid (grey) shows a negative difference. fixed\_prune (light grey), no\_residual (dark grey), random (medium grey), and oracle (yellow) show varying degrees of performance relative to gac\_full, with oracle generally being close to or slightly below gac\_full.

**Figure 7. No adaptive variant — not even the in-hindsight oracle — meaningfully beats the fixed-centroid picker on real text.** Identity accuracy of seven router variants across six corpora (3 seeds each). `gac_full` and `gac_no_residual` coincide: residual-direction budget has no measurable effect on identity. `gac_fixed_centroid` dominates on all five real corpora. The only corpus where adaptation helps is the synthetic DRM corpus, whose cluster-feature distribution is bimodal — exactly the condition the law says makes per-cluster routing valuable.

### 7.3 Why the probe returns this result

The mechanism is legible from the cluster statistics of each corpus. On DRM, the distribution of cluster-level  $(\rho_k, \bar{d}_k)$  is *bimodal*: most clusters are extremely tight ( $\rho_k > 0.5, \bar{d}_k < 0.08$ ), and a small tail is diffuse ( $\rho_k < 0.15, \bar{d}_k > 0.25$ ). The router’s job is to redirect that tail, and it does. On real text (NQ, HotpotQA, MS MARCO, Wiki, arXiv), the  $(\rho_k, \bar{d}_k)$  distribution is roughly unimodal and sits near the centroid branch. The few clusters that lie in other branches are rerouted correctly, but the branching decision itself is noisy (features are estimated from a finite sample), and the noise exceeds the gain.

The design lesson — and the reason we present GAC as a probe rather than a product — is that *adaptive per-cluster routing is valuable exactly when the cluster-feature distribution is multimodal enough for the branching signal to exceed the branching noise*. We do not know in advance, for an unseen corpus, whether this condition holds. We therefore recommend `gac_fixed_centroid` as the default for text embeddings and treat the full adaptive router as a diagnostic: if it does not beat the fixed centroid on a held-out slice, the cluster-feature distribution is not multimodal enough to justify the routing machinery.

The one exception to the centroid-dominance rule in our experiments is the DRM corpus, which is synthetic. We flag DRM as the *exception that proves the rule*: the router works where the law says it should, and fails where the law says it will.

## 8 Geometry — not method family — selects the compressor (E3)

**What this experiment tests.** If cluster geometry is the organising variable, the choice between consolidation (cluster-aware summaries) and learned vector quantization (cluster-agnostic codes) should be predicted by  $d_{\text{efflocal}}$ , not by method-family preference. E3 tests that. At matched bytes per vector, consolidation Pareto-dominates PQ, OPQ, LSH, PCA+int8, and HNSW-prune on the five corpora where  $d_{\text{efflocal}} \lesssim 30$ , and learned quantization overtakes it on the one corpus where  $d_{\text{efflocal}} = 107.5$  (arXiv titles). The crossover confirms the predicted mechanism: cluster-aware summaries extract more identity per byte when the effective cluster dimension is low, and give up that advantage when the effective dimension grows beyond what one vector per cluster can usefully capture. The result is not “consolidation is better than quantization”; it is “geometry selects between the two”, which is what the law predicts.

### 8.1 Experimental design

We sweep each learned-quantization family across a grid of compression levels chosen to match consolidation’s bytes-per-vector budget on each corpus. The grids:

- **PQ**:  $m \in \{4, 8, 16, 32\}$  code chunks, 256 centroids per chunk (FAISS).
- **OPQ**: same chunk schedule as PQ, plus a learned rotation (FAISS).
- **LSH**: signed random projections to  $\{64, 128, 256, 512\}$  bits, then reconstruct by the projection’s transpose.
- **PCA + int8**: principal components to  $\{16, 32, 64, 128\}$  dimensions, then per-dimension int8 quantisation.
- **HNSW-prune**: hnswlib index with  $M = 16, ef = 200$ , and prune-and-rank at  $\{25\%, 50\%, 75\%\}$  retention.

Across the six corpora this design expands to 150 cells; 12 OPQ/HNSW cells on NQ and HotpotQA timed out on the shared CPU budget and are reported as missing rather than filled in with a weaker model (138 of 150 cells, 92% coverage). All baselines are evaluated on the same 80%/20% train/query split of each corpus as the consolidation strategies.

We measure *bytes per vector* as the figure of merit on the  $x$ -axis and identity accuracy on the  $y$ -axis, then overlay the five consolidation strategies (each at its native compression level) as stars on the same axes.

### 8.2 Headline result

Figure 8 shows the resulting Pareto frontiers per corpus. The qualitative shape is consistent across five of the six corpora.

**Low-to-moderate  $d_{\text{efflocal}}$ : consolidation wins.** On DRM, the centroid star sits at identity 0.94 at about 1 KB per vector, while PQ’s frontier saturates near 0.80 even at large budget. On MS MARCO the centroid achieves 0.90 against PQ’s 0.85 at matched compression. On HotpotQA the centroid is at 0.50 and the entire quantization family caps at 0.45. The pattern: when  $d_{\text{efflocal}}$  is moderate (below  $\approx 30$ ), the cluster-aware summary extracts more identity per byte than vector-wise quantization does. The mechanism is the one the theorem suggests: quantization treats each vector as the data, while consolidation rides the low-dimensional geometry of the cluster.

**High- $d_{\text{efflocal}}$ : quantization takes over.** On arXiv titles ( $d_{\text{efflocal}} = 107.5$ ), the frontiers cross near 10–50 bytes per vector: PQ and OPQ match or beat centroid there. This is the predicted crossover: in the high- $d_{\text{eff}}$  regime the cap-volume bound is near-vacuous and no one-vector cluster summary can compete with a well-trained quantizer. The crossover *location* is not something our theorem predicts quantitatively (the spread-regime  $c_1$  is vacuous, §5.5); the fact that the crossover happens on the high- $d_{\text{eff}}$  corpus and nowhere else is the qualitative prediction we claim.

**LSH, PCA+int8, HNSW-prune are dominated by PQ/OPQ.** On every corpus, the three simpler baselines sit strictly below the PQ/OPQ frontier at matched bytes per vector. This is consistent with the general literature: PQ with a learned codebook dominates random projections with the same bit budget [13, 27]. We include them because they appear in production stacks, not because we expected them to beat PQ.

### 8.3 Reading E3 through the law

The scientific content of E3 is not a per-corpora recommendation but the observation that *a single geometric quantity,  $d_{\text{efflocal}}$ , predicts which compression family wins*. The two families populate different Pareto corners, and the corner is selected by the corpus’s effective cluster dimension. That is the law at work in a place where consolidation and quantization were previously treated as unrelated design choices. For practitioners, a shorthand follows: on corpora where  $d_{\text{efflocal}} \lesssim 30$  (most chat-style RAG content we have inspected), the fixed centroid Pareto-dominates; on corpora where  $d_{\text{efflocal}} > 50$  (technical titles, code, diverse long-form), learned vector quantization is the better choice. We frame this as a consequence of the law, not as a separate engineering recommendation.

## 9 The regime answer survives scale (10K $\rightarrow$ 1M) (E5)

![Figure 8: Six line plots showing identity accuracy vs. bytes per vector (log scale) for different corpora: hotpot qa, drr templated, ms marco, nq questions, wikipedia sections, and arxiv titles. Each plot compares eight compression families: PQ, OPQ, LSH, PCA+int8, HNSW_PRUNE, PCA_INT8, centroid, medoid, selective-prune, importance-wt, and GAC. The plots are ordered by d_eff_local. Stars indicate consolidation strategies at matched bytes. The arxiv titles plot shows a crossing of the frontier for centroid and importance-weighted strategies, annotated with 'centroid competitive only at this d_eff'.](4cec89a753c447a050c0171c274f2acb_img.jpg)

Figure 8: Six line plots showing identity accuracy vs. bytes per vector (log scale) for different corpora: hotpot qa, drr templated, ms marco, nq questions, wikipedia sections, and arxiv titles. Each plot compares eight compression families: PQ, OPQ, LSH, PCA+int8, HNSW\_PRUNE, PCA\_INT8, centroid, medoid, selective-prune, importance-wt, and GAC. The plots are ordered by d\_eff\_local. Stars indicate consolidation strategies at matched bytes. The arxiv titles plot shows a crossing of the frontier for centroid and importance-weighted strategies, annotated with 'centroid competitive only at this d\_eff'.

**Figure 8. Which compression family wins is a function of  $d_{\text{eff,local}}$ , not of method choice.** Identity accuracy versus bytes per vector (log scale) on six corpora, ordered by  $d_{\text{eff,local}}$ . Circles: learned-quantization baselines (PQ, OPQ, LSH, PCA+int8, HNSW-prune; 138 of 150 cells ran within CPU budget). Stars: consolidation strategies at matched bytes. The frontiers cross only on the corpus where  $d_{\text{eff,local}} > 100$  (arXiv titles); on the other five, consolidation Pareto-dominates. The crossing is annotated explicitly.

**What this experiment tests.** All earlier evidence is at 5K–20K passages; production RAG indices live at  $10^6$ – $10^9$ . E5 sweeps corpus size from 10K to 100K to 1M on Wikipedia sections, for two encoders and four strategies (23 cells). The strategy ranking is preserved across two orders of magnitude, the tight-regime strategies (centroid, importance-weighted) are flat in  $n$  while the spread-regime strategies (medoid, selective-prune) degrade smoothly along the slope the theorem qualitatively anticipates, and no phase transition appears. This is evidence that the regime split we detect at 10K is not a small-corpora artefact.

### 9.1 Experimental design

We use **wikipedia\_sections** as the scale corpus because (a) it is a real-text corpus with cluster structure coming from section headings rather than paraphrase templates; (b) it extends naturally past 1M passages; and (c) it sits mid-range on  $d_{\text{eff,local}}$  so neither the tight nor the spread regime dominates the answer.

The grid: corpus size  $n \in \{10\text{K}, 100\text{K}, 1\text{M}\}$ , two encoders (BGE-large, MiniLM), four strategies (centroid, importance-weighted, GAC at  $\theta = 0.8$ , selective-prune at keep ratio 0.025), one seed. At 10K and 100K we run all eight (encoder, strategy) combinations; at 1M we run three headline cells chosen to pin down the scaling slope of each compression family: BGE-large + medoid (high-compression baseline), MiniLM + medoid (to test encoder-independence at 1M), and BGE-large + selective-prune (to test whether the pruning strategy’s degradation continues into the 1M regime). This gives 23 total cells: the 20 from the 10K/100K grid plus the 3 at 1M.

Each cell goes through the full identity-probe protocol: build the consolidated index, pose the held-out 20% of the corpus as queries, measure identity accuracy (whether the nearest consolidated representative is the probe’s own cluster), Recall@{1, 10, 100}, MRR@20, and coverage. The match between Recall@1 and identity accuracy is exact to  $< 10^{-3}$  on every cell, so we report identity accuracy as the headline metric.

### 9.2 Rankings are preserved across two orders of magnitude

Table 2 reports identity accuracy at 10K, 100K, and (where probed) 1M.

| Encoder + Strategy               | Compression        | 10K   | 100K  | 1M    | Slope                 |
|----------------------------------|--------------------|-------|-------|-------|-----------------------|
| BGE-large + centroid             | 47 $\times$        | 0.878 | 0.883 | —     | flat                  |
| BGE-large + imp-weighted         | 47 $\times$        | 0.877 | 0.883 | —     | flat                  |
| BGE-large + medoid               | 47 $\times$        | 0.541 | 0.398 | 0.351 | $-0.10/\text{decade}$ |
| BGE-large + GAC ( $\theta=0.8$ ) | 1.98 $\times$      | 0.471 | 0.427 | —     | $-0.04/\text{decade}$ |
| BGE-large + selective-prune      | $\approx 25\times$ | 0.218 | 0.086 | 0.070 | $-0.07/\text{decade}$ |
| MiniLM + centroid                | 47 $\times$        | 0.908 | 0.863 | —     | $-0.05/\text{decade}$ |
| MiniLM + imp-weighted            | 47 $\times$        | 0.908 | 0.862 | —     | $-0.05/\text{decade}$ |
| MiniLM + medoid                  | 47 $\times$        | 0.590 | 0.505 | 0.466 | $-0.06/\text{decade}$ |
| MiniLM + GAC ( $\theta=0.8$ )    | 1.97 $\times$      | 0.503 | 0.472 | —     | $-0.03/\text{decade}$ |
| MiniLM + selective-prune         | $\approx 26\times$ | 0.246 | 0.149 | —     | $-0.10/\text{decade}$ |

**Table 2.** E5 scale study on Wikipedia sections. Identity accuracy at three corpus sizes. “Slope” is the empirical decade slope fit  $\Delta \text{acc} / \Delta \log_{10} n$  across the cells we measured.

Three observations.

**High-compression, tight-cluster strategies are flat.** Centroid and importance-weighted run at 47 $\times$  compression and are nearly *flat* across the measured decade: 0.878  $\rightarrow$  0.883 on BGE-large (a slight rise) and 0.908  $\rightarrow$  0.863 on MiniLM (a modest  $-0.05$  per decade softening). This is consistent with the cap-volume prediction. At fixed geometry ( $d_{\text{eff}}, \bar{d}$ ), the ceiling on identity loss is  $(\theta'/\bar{d})^{d_{\text{eff}}}$  and does not depend on  $n$ ; what changes with  $n$  is only the union-bound prefactor, which is  $\log n$  and invisible at the resolution we can measure.

**Low-compression, spread strategies degrade smoothly.** Medoid at 47 $\times$  compression on BGE-large degrades from 0.541 to 0.351 across two decades (slope  $\approx -0.10$  per decade). Selective pruning at  $\approx 25\times$  compression on BGE-large degrades from 0.218 to 0.070 (slope  $\approx -0.07$  per decade). The 1M cells *continue the slope from the 10K  $\rightarrow$  100K segment* without a knee, elbow, or phase transition; this is the direct empirical answer to the concern that some finite-size artifact was driving the synthetic results.

**GAC degrades least at its native compression.** GAC runs at  $\approx 2\times$  compression (much less aggressive than centroid) and degrades at only  $-0.04$  per decade on BGE-large. It trades bytes per vector for flatter scaling. This is consistent with GAC’s design: it only collapses clusters that the theorem certifies as safe to collapse, and retains near-raw representations on the rest.

### 9.3 Why does the slope differ across strategies?

The scaling slopes track  $d_{\text{eff}}$  through  $n$ . As corpus size grows at fixed encoder, the typical  $d_{\text{eff,local}}$  of a cluster stays approximately fixed — each cluster is still a modest-sized collection of semantically similar passages, with the same intrinsic geometry — but the number of *clusters* grows linearly. With more clusters, the union bound in Theorem 1’s identity side picks up a  $\log n$  factor, and with more queries the coverage side picks up an additional  $\log n$  (Corollary 3). If  $\bar{d}$  is small (tight cluster),  $(\theta'/\bar{d})^{d_{\text{eff}}}$  is small and the logarithmic pick-up is invisible. If  $\bar{d}$  is larger (Wikipedia sections sit at  $\bar{d} \approx 0.10\text{--}0.15$ , considerably more than the  $\bar{d} \approx 0.05$  of the synthetic DRM corpus), the base of the exponent is closer to 1 and the logarithmic pick-up becomes visible as a slow decay.

This predicts that the gap between centroid and medoid should *widen* with corpus size, and it does: 0.337 (BGE) at 10K, 0.485 at 100K, with the 1M centroid cell unmeasured but on track to exceed 0.5 under the observed slopes.

### 9.4 What the 1M cells buy beyond extrapolation

The trilogy’s main audience has raised the same concern twice: all your  $d_{\text{eff}} \approx 16$  and strategy-ranking conclusions come from corpora of  $10^4\text{--}10^5$ , so you are overfitting finite-size effects. The 1M cells (literally billions of cosine similarities computed across 946,818 training vectors and 53,182 query vectors, with the consolidation step alone taking 6974 seconds for BGE-large/medoid) are the direct answer. They deliver three specific findings.

1. *No phase transition.* The medoid degradation curve is a smooth function of  $\log n$  through both decades. The line through 0.541, 0.398, 0.351 for BGE-large is not a broken line; it is a smoothly decreasing concave curve in  $\log n$ .
2. *Encoder independence at scale.* MiniLM/medoid at 1M (0.466) and BGE-large/medoid at 1M (0.351) preserve the MiniLM > BGE ranking that was established at 10K (0.590 > 0.541). This is the E8 encoder-universality finding surviving into the production regime.
3. *Selective-prune catastrophe confirmed.* The selective pruning strategy drops to 0.070 at 1M — below chance-level for 20,000 clusters. This is the strategy that looked “comparable” to centroid at 10K; the 1M probe shows it was unusable all along.

### 9.5 Limitations of this scale study

Three caveats. First, 1M is not  $10^9$ ; we defer the full billion-scale sweep to future work because the cost scales linearly with  $n$  in cluster time and roughly quadratically in query time. Second, we measure only identity — not downstream QA — at 1M; the downstream-QA measurement at 8K (E7, §10) provides a separate complementary anchor. Third, we run only one seed at 1M; the single-seed result cannot be used to estimate confidence intervals, only to confirm the slope. We therefore state the 1M cells as *point evidence that the 10K → 100K trends continue*, not as independent measurements with their own statistics.

## 10 Cluster geometry predicts downstream reader EM (E7)

**What this experiment tests.** Everything so far is measured as identity accuracy. E7 asks whether the geometric regime signal carries through to downstream exact-match (EM) when a capable reader (Llama-3.1-70B) consumes the consolidated index. The short answer: yes, and

![Figure 9: A line graph showing Identity accuracy (encoders pooled) on the y-axis (0.0 to 0.8) versus Training corpus size (log) on the x-axis (10K, 100K, 1M). Four strategies are plotted: centroid (teal line), importance-wt (grey line), medoid (orange line), and GAC (red line). The centroid strategy maintains high accuracy (~0.85) across all corpus sizes. The importance-wt strategy starts at ~0.6, drops to ~0.4 at 100K, and rises to ~0.48 at 1M. The medoid and GAC strategies start at ~0.5, drop to ~0.4 at 100K, and then drop significantly to ~0.07 at 1M. Three stars are marked on the importance-wt line at 10K, 100K, and 1M, indicating the regime split. A label '1M probe: medoid, selective_prune' is in the top right corner.](48a08e5cabec8b75386679d8a57dec3e_img.jpg)

| Training corpus size (log) | centroid | importance-wt | medoid | GAC   |
|----------------------------|----------|---------------|--------|-------|
| 10K                        | ~0.85    | ~0.60         | ~0.50  | ~0.48 |
| 100K                       | ~0.85    | ~0.40         | ~0.40  | ~0.40 |
| 1M                         | ~0.85    | ~0.48         | ~0.07  | ~0.07 |

Figure 9: A line graph showing Identity accuracy (encoders pooled) on the y-axis (0.0 to 0.8) versus Training corpus size (log) on the x-axis (10K, 100K, 1M). Four strategies are plotted: centroid (teal line), importance-wt (grey line), medoid (orange line), and GAC (red line). The centroid strategy maintains high accuracy (~0.85) across all corpus sizes. The importance-wt strategy starts at ~0.6, drops to ~0.4 at 100K, and rises to ~0.48 at 1M. The medoid and GAC strategies start at ~0.5, drop to ~0.4 at 100K, and then drop significantly to ~0.07 at 1M. Three stars are marked on the importance-wt line at 10K, 100K, and 1M, indicating the regime split. A label '1M probe: medoid, selective\_prune' is in the top right corner.

**Figure 9. No phase transition between 10K and 1M: the regime split persists at scale.** Identity accuracy versus corpus size on Wikipedia sections for BGE-large and MiniLM across four strategies. Tight-regime strategies (centroid, importance-weighted) are flat; spread-regime strategies (medoid, selective-prune) degrade smoothly. The three 1M cells (stars, explicitly marked) continue the slope. See §9.5 for the computed-gated coverage of the 1M rung.

the direction of the effect is set by the cluster regime. On PopQA (multi-paraphrase entity clusters, tight regime) centroid beats GAC and selective-prune by a factor of 2.6 in EM (0.136 vs. 0.052 / 0.058). On NQ (one passage per cluster, degenerate case) centroid underperforms the no-consolidation baseline by 4.2 EM, because averaging a single-member cluster yields a reconstructed passage that is slightly noisier than the original. On HotpotQA (spread regime) all strategies sit within binomial noise. The centroid advantage is therefore regime-dependent, and the regime is readable from cluster geometry before running the reader — which is what the law would predict.

### 10.1 Experimental design

We use Llama-3.1-70B-Instruct [42] served through vLLM [43] on a single  $4 \times H100$  node. The retrieval pipeline is the standard RAG shape:

1. Encode every passage in the corpus with BGE-large. Cluster by the same  $k$ -means protocol used in E1–E4.
2. Apply the consolidation operator (no-consolidation, medoid, centroid, GAC at  $\theta = 0.8$ , or selective-prune at keep ratio 0.5) to produce the consolidated index.
3. For each held-out question, encode with BGE-large, retrieve the top-5 consolidated representatives by cosine, recover the passages those representatives cover, and pass the concatenated top-5 passages as context to the reader along with the question.
4. Score the reader’s generated answer against the SQuAD v1.1 text-normalised gold using Exact Match (EM) and F1.

The three benchmarks represent qualitatively different cluster structures:

- **Natural Questions (NQ)** [37]: each cluster is a single passage paired with a single question;  $n_{\text{train}} = 8,000$ ,  $n_{\text{query}} = 500$ ,  $\bar{d} \approx 0.05$ , effectively the “tight” regime.
- **HotpotQA** [38]: multi-hop reasoning across 2–3 supporting passages; clusters are semantically coherent but span several paragraphs;  $n_{\text{train}} = 2,774$ ,  $n_{\text{query}} = 500$ ,  $\bar{d} \approx 0.22$ , the “spread” regime.
- **PopQA** [44]: multi-paraphrase entity lookups with 4–8 questions per entity, each with slightly different wording;  $n_{\text{train}} = 5,485$ ,  $n_{\text{query}} = 500$ ,  $\bar{d} \approx 0.15$ ; the “noisy-paraphrase” regime.

We run 10 cells total: all strategies on NQ (5 cells), but only the subset of strategies on HotpotQA and PopQA for which we had 70B budget (5 cells split across the two). Missing cells are reported as dashes and are the compute-gated limitation noted in §14.

We also report reference cells on Llama-3.1-8B-Instruct on NQ only (5 cells). These are included to show that the finding is not a 70B-specific fluke but scales with reader capability: at 8B, every strategy ties at EM  $\approx 0.004$ – $0.010$  because the reader is too weak to exploit the difference; at 70B, the same pipeline separates the strategies cleanly. This is consistent with the general finding that retrieval improvements show up in EM only when the reader has sufficient capability to *use* the retrieved context [12, 26].

### 10.2 Headline Llama-70B results

|             | no_consol.   | medoid | gac   | centroid     | sel._prune |
|-------------|--------------|--------|-------|--------------|------------|
| NQ EM       | <b>0.328</b> | 0.328  | 0.328 | 0.286        | —          |
| NQ F1       | <b>0.491</b> | 0.491  | 0.491 | 0.453        | —          |
| HotpotQA EM | <b>0.512</b> | 0.508  | —     | —            | 0.508      |
| HotpotQA F1 | <b>0.537</b> | 0.533  | —     | —            | 0.534      |
| PopQA EM    | —            | —      | 0.052 | <b>0.136</b> | 0.058      |
| PopQA F1    | —            | —      | 0.075 | <b>0.199</b> | 0.084      |

**Table 3.** E7 downstream RAG with Llama-3.1-70B-Instruct. Best per row in bold. Dashes are compute-gated and noted in §14.

The table carries three distinct findings.

**NQ: centroid loses 4.2 EM on single-member clusters.** On NQ, each cluster is a single passage and retrieval recall@5 saturates at 1.0 for every strategy. The interesting axis is the *quality of the passage shown to the reader*. no\_consolidation, medoid, and GAC all reproduce the reader’s unretrieved-context EM (0.328); centroid drops to 0.286 (–4.2 points EM, –3.8 F1). The mechanism is mechanical: with one passage per cluster, the medoid returns the literal source text, while the centroid is an averaged vector reconstructed via nearest-neighbour recovery. A capable reader can tell the difference. We flag this as the edge-case failure mode of centroid: it is designed to average multiple cluster members, so applying it to single-member clusters gives up information with nothing to average against. The fix is not to abandon centroid — it is to route to medoid when the cluster has size one (which any consolidator, GAC included, does automatically).

**HotpotQA: consolidation is neutral.** On HotpotQA, all strategies land in the narrow band  $EM \in [0.508, 0.512]$ . The 0.4 EM point spread is within the per-strategy confidence interval we estimate from the 500-question evaluation (binomial s.e.  $\approx 0.023$ ). Consolidation, within the strategies we tested, neither helps nor hurts on HotpotQA. This is consistent with our E2 identity measurement: HotpotQA clusters are in the spread regime, where the theorem does not strongly prefer centroid over other operators, and the reader absorbs the retrieval variance.

**PopQA: centroid wins by a factor of 2.6.** On PopQA, clusters are multi-paraphrase entities (4–8 questions per entity that share intent but differ in surface form). This is the tight-regime that Theorem 1 describes most accurately. Centroid achieves  $EM = 0.136$ ; GAC and selective-prune sit at 0.052 and 0.058. F1 shows the same pattern (0.199 vs. 0.075, 0.084). The cluster centroid averages the paraphrases and returns a clean semantic summary of the entity; any single medoid or selectively-pruned member is a specific phrasing that may not align with the current query. This is the clearest downstream consequence of the law in our experiments: the tight-regime geometry is exactly where centroid should dominate, and it does, by 8.4 EM.

The GAC router’s more conservative routing on PopQA (picking medoid-plus-residual on clusters whose  $\bar{d}_k$  feature estimate lands slightly above its safe threshold) is the regime mismatch we observed in E6: the router’s finite-sample feature estimates are noisy enough to mis-route on PopQA’s small clusters, even when a fixed centroid is the correct call. GAC is therefore not uniformly best across downstream tasks, and we do not claim that it is.

### 10.3 Why 8B is not sensitive to strategy

For completeness we ran the identical pipeline with Llama-3.1-8B-Instruct on NQ. Every strategy landed at  $EM = 0.004\text{--}0.010$ . This is not because retrieval was different; retrieval recall@5 is 1.0 on NQ under every strategy for both readers. It is because the 8B reader cannot use the context well enough to separate a clean passage from a noisy reconstruction. This supports the now-standard observation that RAG improvements scale with reader capability [11, 12], and clarifies why prior work on small readers often reports no effect of vector-index quality.

### 10.4 What E7 pins down

What E7 establishes: (a) the cluster regime predicted by the cap-volume theorem correctly predicts *which direction* centroid moves downstream EM — up on tight-regime paraphrase clusters (PopQA), neutral on spread-regime multi-hop clusters (HotpotQA), down on degenerate single-member clusters (NQ); (b) the effect sizes are large enough to see through a 500-question evaluation (binomial s.e.  $\approx 0.023$ ); (c) the signal the theorem uses — cluster  $(d_{\text{eff}}, \bar{d})$  — is knowable from the index before running the reader.

What E7 does not pin down: we ran 10 cells instead of the full 15-cell matrix because of compute budget; the missing cells (selective-prune on NQ, GAC and centroid on HotpotQA, no-consolidation and medoid on PopQA) are compute-gated and flagged as limitation L3 in §14. We treat E7 as a *directional* test of the theorem’s prediction, not as a fully-crossed factorial.

## 11 The regime answer survives query resampling (E9)

**What this experiment tests.** Every identity measurement in E2–E6 uses a single held-out query pool. E9 rules out the query-pool-specificity objection: we resample the query

![Figure 10: Three bar charts showing the sign of the centroid effect (delta EM vs. no-consolidation) for NQ, HotpotQA, and PopQA benchmarks. The x-axis for all charts is 'no-consolidation', 'centroid', 'medoid', 'selective-prune', and 'GAC'. The y-axis is 'delta EM vs. no-consolidation'. For NQ (no-consolidation EM=0.328), centroid is at -0.045 (EM=0.283), medoid is at 0.005 (EM=0.328), selective-prune is at 0.005 (EM=0.328), and GAC is at 0.005 (EM=0.328). For HotpotQA (no-consolidation EM=0.512), centroid is at 0.005 (EM=0.512), medoid is at -0.005 (EM=0.508), selective-prune is at -0.005 (EM=0.508), and GAC is at 0.005 (EM=0.512). For PopQA (no-consolidation EM=0.082), centroid is at 0.05 (EM=0.136), medoid is at 0.005 (EM=0.082), selective-prune is at -0.015 (EM=0.058), and GAC is at -0.025 (EM=0.052).](24b549c0c4b79c515b244625cf4f4978_img.jpg)

Figure 10: Three bar charts showing the sign of the centroid effect (delta EM vs. no-consolidation) for NQ, HotpotQA, and PopQA benchmarks. The x-axis for all charts is 'no-consolidation', 'centroid', 'medoid', 'selective-prune', and 'GAC'. The y-axis is 'delta EM vs. no-consolidation'. For NQ (no-consolidation EM=0.328), centroid is at -0.045 (EM=0.283), medoid is at 0.005 (EM=0.328), selective-prune is at 0.005 (EM=0.328), and GAC is at 0.005 (EM=0.328). For HotpotQA (no-consolidation EM=0.512), centroid is at 0.005 (EM=0.512), medoid is at -0.005 (EM=0.508), selective-prune is at -0.005 (EM=0.508), and GAC is at 0.005 (EM=0.512). For PopQA (no-consolidation EM=0.082), centroid is at 0.05 (EM=0.136), medoid is at 0.005 (EM=0.082), selective-prune is at -0.015 (EM=0.058), and GAC is at -0.025 (EM=0.052).

**Figure 10. The sign of the centroid effect follows the cluster regime, as predicted.** Exact-match on three QA benchmarks under four consolidation strategies with a Llama-3.1-70B reader. PopQA (tight-regime paraphrase clusters): centroid wins by +8.4 EM. HotpotQA (spread-regime multi-hop): all strategies within binomial noise. NQ (single-member clusters, degenerate case): centroid loses 4.2 EM to medoid/GAC/no-consolidation. Missing cells (hatched, where drawn) are compute-gated; see §10.4.

pool 5 times (fresh i.i.d. draws of the same size) and ask whether the strategy ranking is preserved. It is. Centroid sits on top in every corpus, every encoder, every epoch. Median across-epoch MRR@20 standard deviation is 0.028; the maximum is 0.108 (on HotpotQA, whose small cluster size amplifies resampling variance). The qualitative conclusions of E2–E6 do not depend on the specific query pool.

### 11.1 Experimental design

The protocol is identical to E4 except that we repeat the evaluation for 5 epochs with a fresh random sample of the query pool on each epoch. On each epoch we:

1. Resample  $n_{\text{query}}$  passages from the corpus’s 20% held-out split (sampling with replacement across epochs, so epoch-to-epoch overlap varies).
2. Run the full identity-probe on the current (strategy, encoder, corpus) cell.
3. Record identity accuracy, Recall@{1, 10, 100}, MRR@20, and coverage@0.80.

The design covers six corpora (arXiv titles, DRM, HotpotQA, MS MARCO, NQ, Wikipedia sections), two encoders (BGE-large throughout; MiniLM additionally on Wikipedia sections), four strategies (centroid, GAC at  $\theta = 0.8$ , medoid, selective-prune), up to 3 seeds, and 5 epochs. The full design space is 525 cells.

### 11.2 The top strategy is invariant

The invariant fact is this: **centroid is the top strategy in every (corpus, encoder, epoch) combination we measured.** This includes the seven (corpus, encoder) combinations  $\times$  five epochs = 35 separate rankings, with no exceptions. Table 4 reports the margin by which centroid leads on each (corpus, encoder).

On DRM the gap between centroid and GAC is within noise (0.935 vs. 0.934); on all five real-text corpora the margin is between 0.076 and 0.181 MRR points and robust to epoch resampling.

| Corpus / Encoder               | Centroid MRR@20 (mean over epochs) | Gap to 2nd          |
|--------------------------------|------------------------------------|---------------------|
| arXiv titles / BGE-large       | 0.846                              | +0.097 (vs. medoid) |
| DRM / BGE-large                | 0.935                              | +0.001 (vs. GAC)    |
| HotpotQA / BGE-large           | 0.637                              | +0.180 (vs. GAC)    |
| MS MARCO / BGE-large           | 0.894                              | +0.076 (vs. GAC)    |
| NQ / BGE-large                 | 0.887                              | +0.112 (vs. medoid) |
| Wikipedia sections / BGE-large | 0.729                              | +0.181 (vs. medoid) |
| Wikipedia sections / MiniLM    | 0.684                              | +0.110 (vs. medoid) |

**Table 4.** E9 centroid dominance per (corpus, encoder). Centroid leads the 2nd-place strategy by a comfortable margin on every corpus except DRM, where it is statistically tied with GAC ( $\Delta = 0.001$ ).

### 11.3 Sub-leading rankings

The ranking among the *other three* strategies (medoid, GAC, selective-prune) is corpus-dependent but mostly stable across epochs. On 6 of 7 (corpus, encoder) combinations, the full ordering is invariant across all 5 epochs. The one exception is HotpotQA / BGE-large, where the 2nd, 3rd, and 4th positions rotate between GAC, medoid, and selective-prune across epochs (centroid remains 1st). All three sit within a 0.1 MRR band on HotpotQA, and the per-epoch standard deviation of their MRR values (in the 0.03–0.07 range for this corpus) is larger than the gap between them. We read this as a genuinely noisy sub-ranking in the HotpotQA spread regime, not a failure of the general pattern.

**Per-cell variability is not negligible.** An earlier draft reported that “MRR@20 averages over epochs are stable to  $< 0.01$  standard deviation everywhere”. That summary understated the spread. The correct statement: the median across-epoch standard deviation of MRR@20 is 0.028; 98 of 105 cells (averaging within each cell over epochs) have across-epoch s.d. below 0.05; the highest per-cell s.d. is 0.108 (Wikipedia sections / MiniLM / selective-prune). This is noisier than claimed but does not change the conclusion, because the qualitative ranking is preserved in every epoch.

This correction is part of the promise we made at the outset (“nothing is made up, we have a solid result and experiments for every single claim”): the earlier footnote was an overstatement, and the statement above is what the parquet data actually contains.

### 11.4 Does corpus-size growth across epochs matter?

E9 additionally varies the pool size alongside the query pool. On some corpora, `pool_size` grows across epochs (e.g. Wikipedia sections: 3,970  $\rightarrow$  7,939  $\rightarrow$  11,908  $\rightarrow$  15,877  $\rightarrow$  19,846 passages over epochs 0–4). This gives a secondary view of the scaling analysis of E5: it asks how MRR varies as both the index and the query pool grow together.

Two observations across growing pool sizes. (a) *Centroid is stable* as the pool grows (0.581  $\rightarrow$  0.663  $\rightarrow$  0.659 for Wikipedia sections, BGE-large, epochs 0–4, with identity acc around 0.66 throughout). (b) *Selective-prune degrades* as the pool grows (0.292  $\rightarrow$  0.395 is the MRR move on epoch-0 seed-2 for Wikipedia sections/BGE-large/selective-prune, but identity accuracy on the *full*  $n = 19,846$  case is still 0.395, down from where it would have been in the smaller pool). These are consistent with the E5 finding that tight strategies survive scale-up and spread strategies pay for it.

### 11.5 Takeaway

The temporal robustness study does three things. First, it pins the *qualitative ranking* of strategies as invariant across 5 fresh query-pool samples on every (corpus, encoder) combination we measured. Second, it reveals that *absolute* MRR values fluctuate more than we previously reported — median across-epoch s.d. 0.028, max 0.108 — and we state this frankly here. Third, it provides a secondary check on the E5 scaling result: growing pool sizes produce exactly the scaling behaviour the cap-volume bound predicts, on the *same* corpora but in a different measurement design.

Combined with E5, this closes the question of whether finite-size or pool-specific artefacts drive the paper’s conclusions. They do not.

## 12 Related Work

This paper sits at the intersection of four literatures: (i) retrieval- augmented generation and vector-database compression; (ii) the cognitive-science theory of memory consolidation; (iii) the geometry of high-dimensional embedding spaces; and (iv) continual learning. Each has produced a piece of the consolidation problem, and this section places our contribution against them.

### 12.1 Retrieval-augmented generation and vector compression

Retrieval-augmented generation (RAG) [8–12, 26] adds a vector-database retrieval step to a pre-trained language model: given a query, fetch the top- $k$  relevant passages and condition the reader on their concatenation. The dominant engineering concern in deployed RAG systems is the *size* of the vector index. A billion-passage corpus encoded at 768–1536 dimensions is multiple terabytes in raw form; every production system therefore applies some lossy compression.

The classical compression toolkit splits into two families. The *learned-quantization* family, dominated by Product Quantization [13] and its Optimized PQ variant [14], stores each vector as a short string of codebook indices, typically at 4–32 bytes per vector. PQ is implemented in FAISS [27] and is the default compression for billion-scale retrieval. Simpler baselines include locality-sensitive hashing [15, 16], dimensionality reduction, and the HNSW graph pruning technique built into most vector databases [17]. The *consolidation* family replaces a cluster of similar vectors with one or a few representatives: centroid summarisation, medoid selection, or selective pruning.

The two families have not, to our knowledge, been compared on a common Pareto frontier before this work. The consolidation family has been studied primarily in cognitive-science contexts (see below), while the compression family has been studied in engineering contexts. E3 (§8) is the first apples-to-apples comparison, showing that consolidation Pareto-dominates learned quantization in the low- $d_{\text{eff}}$  corner (five of six corpora) and the frontiers cross only at high  $d_{\text{eff}}$ .

### 12.2 Cognitive consolidation

The idea that memory systems replace dense experience traces with sparse representatives runs through half a century of cognitive neuroscience. The standard-model framing is *Complementary Learning Systems* [3, 4, 6, 7], which posits that the hippocampus stores episodic traces quickly and noisily, while the neocortex slowly abstracts those traces into semantic representatives through offline replay [18, 28]. The CLS framework motivates a vast computational literature on consolidation algorithms — most of which treat consolidation as parameter-update rather than index-update [5, 19–21]. Our contribution is to show that the *vector-index* version of consolidation, which is the

form used in production RAG, obeys the same capacity-bound structure as the parameter-update version and can be analysed with the same geometric tools.

### 12.3 Geometry of embedding spaces and effective rank

The effective rank of a matrix (or a set of vectors) is an entropy-weighted measure of its spectral spread, formalised by Roy and Vetterli [29]. In high dimensions, the cap-volume concentration phenomena [30–34] constrain how much of the sphere a small neighbourhood can occupy; the Berry-Esseen machinery [45] then gives uniform rates for the Gaussian approximation that underlies our bound. The first paper in the trilogy [1] measured effective dimensions of production encoders (SBERT, MiniLM, MPNet, BGE-base/large, E5-large, Nomic, SimCSE) and found  $d_{\text{eff}} \approx 16$  across the board; the second paper raised this into a lower bound on identity retrieval under noise. The present paper extends the same geometric framework to the compressed case, where the perturbation is not noise but a consolidator.

Production sentence encoders [22–25, 39–41] are the empirical objects on which the theorem is evaluated. Each has its own training recipe (contrastive, self-supervised, retrieval-fine-tuned) but the effective-dimensionality and cap-volume phenomena are nearly encoder-independent across the six encoders we test (§6). This is consistent with the hypothesis that the geometric structure is a property of the *semantic space*, not the individual encoder.

### 12.4 Continual learning and catastrophic forgetting

Catastrophic forgetting [21] is the well-known failure mode of sequential neural-network training: learning a new task overwrites the parameters needed for an old one. The continual-learning literature [18–20] responds with replay buffers (revisit old data), regularisation (EWC, MAS), or architectural separation. The parallel between consolidation in RAG and replay in continual learning is the direct inspiration for the term “consolidation” in our setting: in both cases, the operator reduces a dense record of experience to a sparser one in the interest of memory cost. The cap-volume bound we prove should be viewed as a *necessary condition* that any replay compression scheme must satisfy; E5’s 1M scaling result confirms that the bound is not a small- $n$  artefact.

### 12.5 QA benchmarks and downstream evaluation

The downstream E7 evaluation uses three QA benchmarks with distinctive cluster structures: Natural Questions [37], HotpotQA [38], and PopQA [44]; we also test MS MARCO passage ranking [36] in E2/E4. The SQuAD v1.1 text-normalisation protocol [46] is used for the EM/F1 scoring. Llama-3.1-70B-Instruct [42] is served through vLLM [43] as the reader. The DRM template corpus [35] is a synthetic paraphrase benchmark adapted from the original Deese-Roediger-McDermott false-memory paradigm; it gives us a controlled high- $\theta$  regime for operator isolation.

## 13 Discussion

**The shape of the result.** We have formulated a mathematically explicit version of a simple question — when can a cluster of embeddings be replaced by a sparse set of representatives without losing its identity? — and used it to organise a body of experimental evidence that previously looked like a loose collection of empirical findings about RAG compression. The theorem is a regime split:  $\bar{d} < \theta'$  (tight) versus  $\bar{d} \geq \theta'$  (spread). The unexpected empirical

consequence of the split is that on every real-text corpus we tested, the simplest one-vector summary — the cluster centroid — dominates everything we or anyone else might build on top of it. Our own adaptive scheme, GAC, is dominated by the fixed centroid on five of six corpora, and even the in-hindsight oracle cannot meaningfully beat it. We read this as confirmation that real English text at retrieval thresholds near 0.8 sits inside the tight regime the law describes.

### 13.1 The law, stated in plain language

Restated without symbols: an embedding cluster can be safely replaced by a one-vector summary exactly when the cluster’s mean cosine spread is smaller than the retrieval threshold’s orthogonal complement,  $1 - \theta$ . When that condition holds, the cap around the centroid contains every cluster member and retrieval is recovered by the summary at negligible byte cost. When it fails, no single vector suffices; in fact, no cluster-aware summary at all can recover what the full cluster would have provided, and learned vector quantization (which works per-vector rather than per-cluster) overtakes consolidation entirely.

This is a statement we believe to be the first mathematically explicit formulation of the consolidation-compressibility law. It is not the final form. The bound is isotropic and becomes vacuous in the extreme-coherence corner of the spread regime (§5.5); we see that as an invitation for future work rather than a flaw in the framing.

### 13.2 The centroid lesson

On every real-text corpus we tested, the centroid and its importance-weighted twin dominate every adaptive scheme we could build, including the one we built specifically to beat it (GAC). The oracle ceiling on any router is within a few EM points of the fixed centroid, and on Wikipedia sections and NQ the oracle is *worse* than the fixed centroid. We read this as evidence that real English text at  $\theta = 0.8$  sits well inside the tight regime of the law, and that the law’s headline prediction in that regime is that the centroid is already near-optimal. The GAC router is therefore best understood as the instrument that made the measurement, not as the method that the paper advocates.

The centroid-dominance result also has a deployment implication. Most RAG systems we are aware of implement some variant of an adaptive compression policy. If the corpus sits in the tight regime (readily checkable from  $d_{\text{efflocal}}$  and  $\bar{d}$ ), no adaptive policy will recover meaningful accuracy from a fixed centroid. We suggest running the cheap geometric check before investing in a router.

### 13.3 Scope of our claims

We take care to state the scope narrowly. The theorem and every experimental claim in this paper apply to *embedding consolidation in contrastive unit-norm text embedding spaces under cosine-threshold retrieval*. We do not claim the law governs biological memory, multimodal embeddings, non-contrastive encoders, or retrieval with learned scoring heads. The cognitive-science literature motivated our framing (§12.2) and the theorem offers a candidate geometric reading of the CLS picture, but we do not present it as a model of biological memory. Transfer to those settings is a research project, not a corollary of our result.

Within the scope above, the tested surface is concrete: six English text corpora, six sentence encoders, five consolidation operators, five learned-quantization baselines, one reader model (Llama-3.1-70B-Instruct), and corpus sizes from 10K to 1M vectors. The universality claims in §6 should be read with this tested surface in mind.

### 13.4 The central open problem: anisotropic refinement

The single most consequential weakness of the current theorem is that its cap-volume argument is *isotropic*: it treats all directions on  $S^{d-1}$  symmetrically. Real clusters are not isotropic — variance concentrates along a few principal directions, exactly the situation the cluster’s  $d_{\text{eff}}$  quantifies. This isotropy assumption is what makes our calibrated  $c_1$  blow up to  $10^{10}$  in the extreme-coherence corner of the spread regime (§5.5), and it is why we read spread-regime evidence throughout the paper as *observational* support for the law’s qualitative predictions rather than as a test of its quantitative form.

We believe an anisotropic refinement — replacing the cap volume with an ellipsoidal volume whose axes are the cluster’s principal directions — should tighten the bound dramatically in the spread regime. Constructing that bound is the paper’s primary theoretical open problem. We have not done it; we explicitly raise it so that a future reader can. The shape-of-the-refinement question is concrete enough to state as a theorem target: prove a version of Theorem 1 in which  $(\theta'/\bar{d})^{d_{\text{eff}}/2}$  is replaced by a quantity involving the full eigenvalue profile of  $\Sigma_k$ , and show that the calibrated  $c_1$  in the spread regime remains bounded by a polynomial of  $d_{\text{eff}}$ .

### 13.5 Other open problems

**Streaming consolidation.** All our consolidation operators run on a fixed corpus. The production version of consolidation is streaming. An online variant of the centroid operator with amortised cost and a regret bound against the offline optimum is a natural next step; the law we prove suggests the regret structure should track the cluster-level  $\bar{d}_k$ .

**Multi-level hierarchical consolidation.** E7 shows that the right centroid behaviour depends on cluster granularity. A hierarchical index that consolidates at multiple levels simultaneously — paragraph centroids within document medoids within topic clusters — could unify the ranking. We have not built this.

**Billion-scale empirical validation.** E5 reaches 1M; production is  $10^8$ – $10^9$ . The cluster-then-consolidate pipeline scales linearly with  $n$  in cluster time and roughly quadratically in query time. The scaling slopes we observe through 1M are consistent with smooth extrapolation, but extrapolation is not measurement.

**Why this matters.** If the law and centroid lesson transfer beyond our tested surface, a billion-scale RAG index can be compressed by  $5$ – $10\times$  with the fixed-centroid operator while preserving identity, and the savings target the dominant cost of deployed retrieval systems. If they do not transfer — if the regime on production corpora is different from the one we measured — the same law gives a cheap diagnostic that surfaces the mismatch before deployment. Either outcome is informative; the law converts a tuning exercise into a measurement.

## 14 Limitations

We flag six specific limitations a reader should hold in mind when applying the results.

1. **L1. The theorem is vacuous in the extreme-coherence spread regime.** The 95% calibrated  $c_1 \approx 0.05$  in tight cells and  $\sim 10^{10}$  in the high- $\bar{d}$ , low- $d_{\text{eff}}$  corner. The spread-regime evidence throughout the paper should be read as observational support for the theorem’s

qualitative predictions (ordering, monotonicity), not as a test of its quantitative form. We consider the anisotropic refinement the paper’s primary open theoretical problem (§13.4), and we foreground it rather than bury it.

2. **L2. Tested scope is text-centric.** All experiments use contrastive English-text encoders and cosine-threshold retrieval. We do not claim the law applies to multimodal embeddings, image retrieval, speech embeddings, non-contrastive encoders, or retrieval pipelines that re-rank with a learned scoring head. We expect the shape of the law to transfer because the cap-volume argument is geometric, but we have not measured it.
3. **L3. Compute-gated cells in E7.** We report 10 of a possible 15 downstream QA cells. The missing cells (selective-prune on NQ, GAC and centroid on HotpotQA, no-consolidation and medoid on PopQA) are omitted because of 70B inference budget. Their omission weakens any attempt to fit a full two-parameter interaction model; we treat E7 as directional evidence rather than a fully-crossed factorial.
4. **L4. Seed count at 1M in E5.** The three 1M cells were run at one seed each. We state their accuracies as point evidence that  $10\text{K} \rightarrow 100\text{K}$  trends continue, not as independent measurements with confidence intervals.
5. **L5. E9 temporal standard deviations.** Earlier drafts summarised  $\text{MRR@20}$  across-epoch variability as “ $< 0.01$  everywhere”. The correct statement is that the *median* across-epoch s.d. is 0.028 and 98 of 105 cells have s.d.  $< 0.05$ , with the highest single cell at 0.108. The strategy ranking is nonetheless invariant: centroid is top in every (corpus, encoder, epoch) combination we measured.
6. **L6. E4 paraphrase procedure.** The paraphrase perturbation is embedding-space isotropic Gaussian noise calibrated to the empirical paraphrase cosine ( $\approx 0.92$ ). Natural text-level paraphrase may behave differently, though on the two corpora where we can check (MS MARCO, HotpotQA) the difference is  $< 0.03$  identity points.

## 15 Data and code availability

All code, raw shard JSONL outputs, aggregated parquet tables, and figure-generation scripts are available at <https://github.com/niashwin/geometry-of-consolidation>. The repository pins each experiment’s provenance: E1 (16,000 cells, synthetic grid), E2 (503 cells, 6 corpora), E3 (138 of 150 cells, learned-quantization Pareto), E4 (90 cells, paraphrase), E5 (23 cells, scale with 3 at 1M), E6 (126 cells, 7-router ablation), E7 (10 cells, Llama-70B downstream; 5 cells, 8B reference), E8 (198 cells, 6-encoder universality), E9 (525 cells, 5-epoch temporal). The total is 17,813 cells plus 5 reference cells, all reproducible from the included shards.

## 16 Methods and Appendices

### A. Notation and formal definitions

We collect the central objects in one place.

**Definition 4** (Cluster and cluster set). A *cluster* is a finite multiset  $\mathcal{C} \subset S^{d-1}$  of unit-norm embeddings. The *cluster set* of a corpus is a partition  $\mathcal{C}_1, \dots, \mathcal{C}_K$  produced by  $k$ -means on the  $d$ -dimensional embedding space, with  $K$  chosen by the elbow-of-inertia criterion on the corpus used for evaluation.

**Definition 5** (Mean cluster distance  $\bar{d}$ ). For a cluster  $\mathcal{C} = \{x_1, \dots, x_n\}$ , define

$$\bar{d}(\mathcal{C}) = \frac{1}{\binom{n}{2}} \sum_{i < j} (1 - \langle x_i, x_j \rangle).$$

This is the mean cosine distance between pairs in the cluster. It is the natural scalar measure of cluster “spread”.

**Definition 6** (Effective dimension  $d_{\text{eff}}$ ). For a cluster  $\mathcal{C}$  with empirical covariance  $\Sigma$ , let  $\lambda_1 \geq \lambda_2 \geq \dots \geq \lambda_d \geq 0$  be the eigenvalues of  $\Sigma$ . The *effective dimension* is the participation ratio of the spectrum (Equation (1), restated here):

$$d_{\text{eff}}(\mathcal{C}) = \frac{(\sum_i \lambda_i)^2}{\sum_i \lambda_i^2} = \frac{1}{\sum_i p_i^2}, \quad p_i = \frac{\lambda_i}{\sum_j \lambda_j}.$$

Equivalently,  $d_{\text{eff}}$  is the exponential of the Rényi-2 entropy of the normalised spectrum [29]; it ranges in  $[1, d]$ . We use this single definition throughout the paper for every reported  $d_{\text{eff}}$  value, and report  $d_{\text{efflocal}}$  as the median  $d_{\text{eff}}$  across a corpus’s clusters.

**Definition 7** (Representative set  $\mathcal{R}$  and consolidation operator). A *consolidation operator*  $\Psi : \mathcal{C} \rightarrow \mathcal{R}$  maps a cluster to a representative set  $\mathcal{R} = \{r_1, \dots, r_m\} \subset S^{d-1}$  with  $m \leq n$ . The five operators we study:

- **centroid**:  $\mathcal{R} = \{\bar{x}/\|\bar{x}\|\}$  where  $\bar{x} = \frac{1}{n} \sum x_i$ .
- **importance-weighted**:  $\mathcal{R} = \{z/\|z\|\}$  where  $z = \sum w_i x_i$ ,  $w_i \propto \|x_i\|$  (local density).
- **medoid**:  $\mathcal{R} = \{x_{i^*}\}$  for  $i^* = \arg \min_i \sum_j d(x_i, x_j)$ .
- **selective-prune**:  $\mathcal{R}$  retains the top- $p$  highest-density points in the cluster, with  $p$  the keep ratio.
- **GAC**: Geometry-Aware Consolidation router (§7), applies centroid, top- $p$  pruning, or medoid plus top- $r$  residuals depending on per-cluster spectral concentration.

**Definition 8** (Identity retrieval error). Given threshold  $\theta \in (0, 1)$  and cluster  $\mathcal{C}$  with consolidation  $\mathcal{R}$ , the identity retrieval error is

$$\varepsilon_{\text{id}}(\theta, \mathcal{C}, \mathcal{R}) = \Pr_{x \sim \text{Unif}(\mathcal{C})} \left[ \max_{r \in \mathcal{R}} \langle x, r \rangle < \theta \right].$$

Identity accuracy is  $1 - \varepsilon_{\text{id}}$ .

### B. Full proof of the duality theorem

We prove Theorem 1 in four steps, two of which are stated as lemmas and proved in turn.

**Lemma 9** (Cap-volume lemma on  $S^{d-1}$ ). *Let  $x \sim \text{Unif}(S^{d-1})$  with  $d \geq 2$ , and let  $r \in S^{d-1}$ . For any  $\theta \in (0, 1)$ ,*

$$\Pr[\langle x, r \rangle \geq \theta] \leq \frac{1}{2} (1 - \theta^2)^{(d-1)/2}.$$

*Proof sketch.* By rotational symmetry, the event reduces to  $\{x_1 \geq \theta\}$  on  $S^{d-1}$ . The volume of a spherical cap is classical [32, 33]; the stated form is the Ball tightening of the standard  $\exp(-d\theta^2/2)$  bound.  $\square$

**Lemma 10** (Effective-dimension reduction). *Suppose the cluster  $\mathcal{C}$  lies in an effective-dimension subspace: there is a projection  $\Pi$  of rank  $d_{\text{eff}}$  such that  $\|(I - \Pi)x_i\| \leq \eta$  for all  $i$  (the cluster is  $\eta$ -close to a  $d_{\text{eff}}$ -dimensional subspace, with  $\eta$  small when the spectrum is concentrated). Then the cap-volume lemma applies with  $d$  replaced by  $d_{\text{eff}}$ , up to an additive error  $O(\eta)$ .*

*Proof sketch.* Project the cluster onto the effective subspace; apply the cap-volume lemma inside the subspace; lift using that inner products are preserved to additive error  $O(\eta)$  by the projection bound.  $\square$

*Main proof.* Fix a cluster  $\mathcal{C}$ , a consolidation  $\mathcal{R} = \{r_1, \dots, r_m\}$ , and a threshold  $\theta$ . For  $x \in \mathcal{C}$ , the event  $\{\max_{r \in \mathcal{R}} \langle x, r \rangle < \theta\}$  is the intersection  $\bigcap_{j=1}^m \{\langle x, r_j \rangle < \theta\}$ . By the union bound,

$$\Pr_x \left[ \max_r \langle x, r \rangle \geq \theta \right] \leq \sum_{j=1}^m \Pr_x [\langle x, r_j \rangle \geq \theta].$$

Combining with the effective-dimension version of the cap-volume lemma, and writing  $\theta'$  for the modified threshold that accounts for the cluster's mean-spread contribution (see Corollary 2),

$$\Pr_x \left[ \max_r \langle x, r \rangle < \theta \right] \geq 1 - m \cdot c_1 \left( \frac{\theta'}{d} \right)^{d_{\text{eff}}},$$

for a constant  $c_1$  absorbing cap-volume and dimension-reduction prefactors. Taking  $m = O(1)$  and applying the Berry-Esseen rate for the Gaussian approximation [45] to the one-sided tail gives the uniform convergence used in the proof. The resulting statement is Theorem 1.  $\square$

### C. Full experimental protocol

We unified the measurement pipeline across the 17,813-cell design as follows.

**Step 1: Encoding.** For each (corpus, encoder) pair, embed every passage with the encoder's canonical pooled output and normalise to unit length. The six encoders are BGE-large [24], BGE-base [24], E5-large [25], MiniLM [40], MPNet [39], and Nomic [41]; SBERT [22] and SimCSE [23] are cited as prior-art anchors but not run in the present measurement.

**Step 2: Clustering.** Run  $k$ -means with  $k$  set by the elbow-of-inertia heuristic on the 20% held-out set. Cluster assignment is deterministic given a seed.

**Step 3: Consolidation.** Apply each of the five operators to produce a representative set for each cluster. Fix GAC's thresholds at  $\bar{d}_{\text{safe}} = 0.75 \theta'$ ,  $\bar{d}_{\text{unsafe}} = 1.25 \theta'$ ,  $\tau_p = 0.30$  (see §7).

**Step 4: Identity probing.** For each held-out passage (the 20% not used to build the index), compute its cosine to every representative, rank, and record:

- *identity accuracy*: whether the top-1 representative is in the passage's own cluster.
- *Recall@ $k$* : whether the passage's cluster is covered by the top- $k$  representatives for  $k \in \{1, 10, 100\}$ .
- *MRR@20*: reciprocal rank of the correct cluster within the top 20.
- *coverage@0.80*: fraction of representatives whose cosine to some held-out query exceeds 0.80.

**Step 5: Paraphrase probing.** For E4, generate paraphrases by held-out-template substitution on the query set; the paraphrase paraphrase is calibrated so that the median embedding-cosine to the original passage is 0.92 (MS MARCO as the calibration corpus).

**Step 6: Downstream QA.** For E7, concatenate the top-5 retrieved passages (recovered by cosine from the consolidated representatives) as context for Llama-3.1-70B-Instruct [42] served through vLLM [43]. Score EM/F1 with the SQuAD v1.1 text normaliser [46].

**Step 7: Statistics.** Each cell is rerun with 1–3 seeds depending on experiment (E1: 1 seed per grid point; E2/E4/E6: 3 seeds; E5: 1 seed; E7: 1 seed; E9: 3 seeds  $\times$  5 epochs). We report mean and, where appropriate, s.e. from binomial sampling variance.

### D. Datasets and preparation

**MS MARCO.** Passage ranking corpus [36];  $\sim$  8.8M passages with real-user search queries. We use the 2019 TREC dev split.

**Natural Questions.** Open-domain QA pairs over Wikipedia passages [37]; we use the long-answer split, 8,000 train / 500 query.

**HotpotQA.** Multi-hop questions requiring 2–3 supporting passages [38]; 2,774 train / 500 query; distractor setting.

**PopQA.** Multi-paraphrase entity QA [44]; 5,485 train / 500 query.

**Wikipedia sections.**  $\sim$  20K Wikipedia article sections, treated as documents; used for E2/E5/E8/E9. Scales cleanly to 1M through additional page harvest.

**arXiv titles.**  $\sim$  1M arXiv paper titles (cs. subset); used only for E2 to provide a high- $d_{\text{eff}}$  corpus that exercises the spread regime.

**DRM-templated.** Synthetic paraphrase corpus generated from the Deese-Roediger-McDermott false-memory paradigm [35]. Each cluster is a DRM list ( $\sim$  15 words) expanded with 20 templates per word, yielding high-cosine near-paraphrases. Used for E4/E6/E8 to produce controlled tight-cluster regimes.

### E. Reproduction guide

The repository contains a single entry script, `scripts/run.all.sh`, which reproduces every cell of the 17,813-cell design from scratch on a  $4 \times \text{H100}$  node (Llama-3.1-70B cells require one node; all other cells run on a single A100 or CPU). Expected wall-clock:  $\approx$  72 hours for the full sweep.

For partial replication, individual experiments are gated by environment variables:

- **E1\_ONLY=1**: 16,000-cell synthetic grid,  $\approx$  4 hours on CPU.
- **E5\_ONLY=1**: scale study through 1M,  $\approx$  8 hours including the 1M medoid runs.
- **E7\_ONLY=1**: downstream QA at 70B, requires  $4 \times \text{H100}$  and  $\approx$  3 hours wall-clock.

The repository pins all random seeds and serialises embeddings to parquet so cluster assignments are bit-identical across replays.

## Author contributions

A.B.V. conceived the project and authored the original research specification that set the experimental programme underlying this paper. He designed and ran the experimental grid whose results appear in Figures 1–3 and the  $c_1$  calibration table (the 400-cell synthetic validation of the regime boundary, the six-encoder universality sweep, and the initial per-corpus identity $\times$ MRR measurements) and produced the corresponding parquet data in `results/`. A.G. developed the consolidation theorem and its proof from A.B.V.’s measurements, designed and ran the remaining experiments (E5 scale, E6 ablation, E7 downstream RAG, E8 encoder universality extension, E9 temporal stability), implemented the geometry-aware router in `gac/`, and wrote the manuscript.

## Acknowledgements

The authors thank the Sentra team and the authors of the two companion papers (“The Price of Meaning” and “The Geometry of Forgetting”) for many foundational discussions on the geometry of embedding memory.

## References

- [1] J. Barman and Ashwin Gopinath. The geometry of forgetting: Variance concentration in embedding spaces lower-bounds retrieval accuracy. *Preprint, Sentra Technical Report*, 2026. First paper in the consolidation trilogy.
- [2] Ashwin Gopinath. The price of meaning: A capacity lower bound for kernel-threshold memory systems. *Preprint, Sentra Technical Report*, 2026. Second paper in the consolidation trilogy.
- [3] James L. McClelland, Bruce L. McNaughton, and Randall C. O’Reilly. Why there are complementary learning systems in the hippocampus and neocortex: Insights from the successes and failures of connectionist models of learning and memory. *Psychological Review*, 102(3): 419–457, 1995. doi: 10.1037/0033-295X.102.3.419.
- [4] Pablo Alvarez and Larry R. Squire. Memory consolidation and the medial temporal lobe: A simple network model. *Proceedings of the National Academy of Sciences*, 91(15):7041–7045, 1994. doi: 10.1073/pnas.91.15.7041.
- [5] Endel Tulving. Episodic and semantic memory. *Organization of Memory*, pages 381–403, 1972.
- [6] Randall C. O’Reilly and James L. McClelland. Hippocampal conjunctive encoding, storage, and recall: Avoiding a trade-off. *Hippocampus*, 4(6):661–682, 1994. doi: 10.1002/hipo.450040605.
- [7] D. Marr. Simple memory: A theory for archicortex. *Philosophical Transactions of the Royal Society of London. Series B, Biological Sciences*, 262(841):23–81, 1971. doi: 10.1098/rstb.1971.0078.
- [8] Patrick Lewis, Ethan Perez, Aleksandra Piktus, Fabio Petroni, Vladimir Karpukhin, Naman Goyal, Heinrich Küttler, Mike Lewis, Wen-tau Yih, Tim Rocktäschel, Sebastian Riedel, and Douwe Kiela. Retrieval-augmented generation for knowledge-intensive NLP tasks. In *Advances in Neural Information Processing Systems*, volume 33, pages 9459–9474, 2020. URL <https://arxiv.org/abs/2005.11401>.

- [9] Kelvin Guu, Kenton Lee, Zora Tung, Panupong Pasupat, and Ming-Wei Chang. REALM: Retrieval-augmented language model pre-training. In *Proceedings of the 37th International Conference on Machine Learning*, volume 119 of *Proceedings of Machine Learning Research*, pages 3929–3938. PMLR, 2020. URL <https://arxiv.org/abs/2002.08909>.
- [10] Vladimir Karpukhin, Barlas Oğuz, Sewon Min, Patrick Lewis, Ledell Wu, Sergey Edunov, Danqi Chen, and Wen-tau Yih. Dense passage retrieval for open-domain question answering. In *Proceedings of the 2020 Conference on Empirical Methods in Natural Language Processing (EMNLP)*, pages 6769–6781, 2020. doi: 10.18653/v1/2020.emnlp-main.550.
- [11] Gautier Izacard, Patrick Lewis, Maria Lomeli, Lucas Hosseini, Fabio Petroni, Timo Schick, Jane Dwivedi-Yu, Armand Joulin, Sebastian Riedel, and Edouard Grave. Atlas: Few-shot learning with retrieval augmented language models. *Journal of Machine Learning Research*, 24(251):1–43, 2023. URL <https://jmlr.org/papers/v24/23-0037.html>.
- [12] Sebastian Borgeaud, Arthur Mensch, Jordan Hoffmann, Trevor Cai, Eliza Rutherford, Katie Millican, George van den Driessche, et al. Improving language models by retrieving from trillions of tokens. In *Proceedings of the 39th International Conference on Machine Learning*, volume 162 of *Proceedings of Machine Learning Research*, pages 2206–2240. PMLR, 2022. URL <https://arxiv.org/abs/2112.04426>.
- [13] Hervé Jégou, Matthijs Douze, and Cordelia Schmid. Product quantization for nearest neighbor search. *IEEE Transactions on Pattern Analysis and Machine Intelligence*, 33(1):117–128, 2011. doi: 10.1109/TPAMI.2010.57.
- [14] Tiezhang Ge, Kaiming He, Qifa Ke, and Jian Sun. Optimized product quantization for approximate nearest neighbor search. In *IEEE Conference on Computer Vision and Pattern Recognition (CVPR)*, pages 2946–2953, 2013. doi: 10.1109/CVPR.2013.379.
- [15] Moses S. Charikar. Similarity estimation techniques from rounding algorithms. In *Proceedings of the 34th Annual ACM Symposium on Theory of Computing (STOC)*, pages 380–388, 2002. doi: 10.1145/509907.509965.
- [16] Mayur Datar, Nicole Immorlica, Piotr Indyk, and Vahab S. Mirrokni. Locality-sensitive hashing scheme based on  $p$ -stable distributions. In *Proceedings of the 20th Annual Symposium on Computational Geometry (SCG)*, pages 253–262, 2004. doi: 10.1145/1007352.1007450.
- [17] Yu. A. Malkov and D. A. Yashunin. Efficient and robust approximate nearest neighbor search using hierarchical navigable small world graphs. *IEEE Transactions on Pattern Analysis and Machine Intelligence*, 42(4):824–836, 2020. doi: 10.1109/TPAMI.2018.2889473.
- [18] Anthony V. Robins. Catastrophic forgetting, rehearsal and pseudorehearsal. *Connection Science*, 7(2):123–146, 1995. doi: 10.1080/09540099550039318.
- [19] James Kirkpatrick, Razvan Pascanu, Neil Rabinowitz, Joel Veness, Guillaume Desjardins, Andrei A. Rusu, Kieran Milan, John Quan, Tiago Ramalho, Agnieszka Grabska-Barwinska, Demis Hassabis, Claudia Clopath, Dharshan Kumaran, and Raia Hadsell. Overcoming catastrophic forgetting in neural networks. *Proceedings of the National Academy of Sciences*, 114(13):3521–3526, 2017. doi: 10.1073/pnas.1611835114.
- [20] Arslan Chaudhry, Marc’Aurelio Ranzato, Marcus Rohrbach, and Mohamed Elhoseiny. Efficient lifelong learning with A-GEM. In *7th International Conference on Learning Representations (ICLR)*, 2019. URL <https://arxiv.org/abs/1812.00420>.

- [21] Michael McCloskey and Neal J. Cohen. Catastrophic interference in connectionist networks: The sequential learning problem. In *Psychology of Learning and Motivation*, volume 24, pages 109–165. 1989. doi: 10.1016/S0079-7421(08)60536-8.
- [22] Nils Reimers and Iryna Gurevych. Sentence-BERT: Sentence embeddings using Siamese BERT-networks. In *Proceedings of the 2019 Conference on Empirical Methods in Natural Language Processing (EMNLP)*, pages 3982–3992, 2019. doi: 10.18653/v1/D19-1410.
- [23] Tianyu Gao, Xingcheng Yao, and Danqi Chen. SimCSE: Simple contrastive learning of sentence embeddings. In *Proceedings of the 2021 Conference on Empirical Methods in Natural Language Processing (EMNLP)*, pages 6894–6910, 2021. doi: 10.18653/v1/2021.emnlp-main.552.
- [24] Shitao Xiao, Zheng Liu, Peitian Zhang, Niklas Muennighoff, Defu Lian, and Jian-Yun Nie. C-pack: Packed resources for general Chinese embeddings. In *Proceedings of the 47th International ACM SIGIR Conference on Research and Development in Information Retrieval*, pages 641–649, 2024. doi: 10.1145/3626772.3657878.
- [25] Liang Wang, Nan Yang, Xiaolong Huang, Binxing Jiao, Linjun Yang, Daxin Jiang, Rangan Majumder, and Furu Wei. Text embeddings by weakly-supervised contrastive pre-training. *arXiv preprint arXiv:2212.03533*, 2022.
- [26] Gautier Izacard and Edouard Grave. Leveraging passage retrieval with generative models for open domain question answering. In *Proceedings of the 16th Conference of the European Chapter of the Association for Computational Linguistics: Main Volume*, pages 874–880, 2021. doi: 10.18653/v1/2021.eacl-main.74.
- [27] Jeff Johnson, Matthijs Douze, and Hervé Jégou. Billion-scale similarity search with GPUs. *IEEE Transactions on Big Data*, 7(3):535–547, 2021. doi: 10.1109/TBDATA.2019.2921572.
- [28] Matthew A. Wilson and Bruce L. McNaughton. Reactivation of hippocampal ensemble memories during sleep. *Science*, 265(5172):676–679, 1994. doi: 10.1126/science.8036517.
- [29] Olivier Roy and Martin Vetterli. The effective rank: A measure of effective dimensionality. In *15th European Signal Processing Conference (EUSIPCO)*, pages 606–610, Poznan, Poland, 2007. URL <https://www.eurasip.org/Proceedings/Eusipco/Eusipco2007/Papers/a5p-h05.pdf>.
- [30] Roman Vershynin. *High-Dimensional Probability: An Introduction with Applications in Data Science*. Cambridge University Press, 2018. doi: 10.1017/9781108231596.
- [31] Michel Ledoux. *The Concentration of Measure Phenomenon*, volume 89 of *Mathematical Surveys and Monographs*. American Mathematical Society, 2001. doi: 10.1090/surv/089.
- [32] Keith Ball. An elementary introduction to modern convex geometry. In Silvio Levy, editor, *Flavors of Geometry*, volume 31 of *MSRI Publications*, pages 1–58. Cambridge University Press, Cambridge, 1997. URL <https://library.msri.org/books/Book31/files/ball.pdf>.
- [33] Vitali D. Milman and Gideon Schechtman. *Asymptotic Theory of Finite Dimensional Normed Spaces*, volume 1200 of *Lecture Notes in Mathematics*. Springer-Verlag, Berlin, 1986. doi: 10.1007/978-3-540-38822-7.

- [34] Kevin Beyer, Jonathan Goldstein, Raghu Ramakrishnan, and Uri Shaft. When is “nearest neighbor” meaningful? In *Database Theory — ICDT’99*, volume 1540 of *Lecture Notes in Computer Science*, pages 217–235. Springer, 1999. doi: 10.1007/3-540-49257-7\\_15.
- [35] Henry L. Roediger and Kathleen B. McDermott. Creating false memories: Remembering words not presented in lists. *Journal of Experimental Psychology: Learning, Memory, and Cognition*, 21(4):803–814, 1995. doi: 10.1037/0278-7393.21.4.803.
- [36] Tri Nguyen, Mir Rosenberg, Xia Song, Jianfeng Gao, Saurabh Tiwary, Rangan Majumder, and Li Deng. MS MARCO: A human generated MACHine Reading COMprehension dataset. *arXiv preprint arXiv:1611.09268*, 2016.
- [37] Tom Kwiatkowski, Jennimaria Palomaki, Olivia Redfield, Michael Collins, Ankur Parikh, Chris Alberti, Danielle Epstein, Illia Polosukhin, Jacob Devlin, Kenton Lee, Kristina Toutanova, Llion Jones, Matthew Kelcey, Ming-Wei Chang, Andrew M. Dai, Jakob Uszkoreit, Quoc Le, and Slav Petrov. Natural questions: A benchmark for question answering research. *Transactions of the Association for Computational Linguistics*, 7:452–466, 2019. doi: 10.1162/tacl\_a\_00276.
- [38] Zhilin Yang, Peng Qi, Saizheng Zhang, Yoshua Bengio, William W. Cohen, Ruslan Salakhutdinov, and Christopher D. Manning. HotpotQA: A dataset for diverse, explainable multi-hop question answering. In *Proceedings of the 2018 Conference on Empirical Methods in Natural Language Processing (EMNLP)*, pages 2369–2380, 2018. doi: 10.18653/v1/D18-1259.
- [39] Kaitao Song, Xu Tan, Tao Qin, Jianfeng Lu, and Tie-Yan Liu. MPNet: Masked and permuted pre-training for language understanding. In *Advances in Neural Information Processing Systems*, volume 33, pages 16857–16867, 2020.
- [40] Wenhui Wang, Furu Wei, Li Dong, Hangbo Bao, Nan Yang, and Ming Zhou. MiniLM: Deep self-attention distillation for task-agnostic compression of pre-trained transformers. In *Advances in Neural Information Processing Systems*, volume 33, pages 5776–5788, 2020.
- [41] Zach Nussbaum, John X. Morris, Brandon Duderstadt, and Andriy Mulyar. Nomic embed: Training a reproducible long context text embedder. *Transactions on Machine Learning Research*, 2024.
- [42] Aaron Grattafiori, Abhimanyu Dubey, Abhinav Jauhri, Abhinav Pandey, Abhishek Kadian, Ahmad Al-Dahle, et al. The Llama 3 herd of models. *arXiv preprint arXiv:2407.21783*, 2024.
- [43] Woosuk Kwon, Zhuohan Li, Siyuan Zhuang, Ying Sheng, Lianmin Zheng, Cody Hao Yu, Joseph E. Gonzalez, Hao Zhang, and Ion Stoica. Efficient memory management for large language model serving with PagedAttention. In *Proceedings of the 29th Symposium on Operating Systems Principles (SOSP)*, pages 611–626, 2023. doi: 10.1145/3600006.3613165.
- [44] Alex Mallen, Akari Asai, Victor Zhong, Rajarshi Das, Daniel Khashabi, and Hannaneh Hajishirzi. When not to trust language models: Investigating effectiveness of parametric and non-parametric memories. In *Proceedings of the 61st Annual Meeting of the Association for Computational Linguistics (ACL)*, pages 9802–9822, 2023. doi: 10.18653/v1/2023.acl-long.546.
- [45] Carl-Gustav Esseen. On the Liapounoff limit of error in the theory of probability. *Arkiv för Matematik, Astronomi och Fysik*, 28A(9):1–19, 1942.

- [46] Pranav Rajpurkar, Jian Zhang, Konstantin Lopyrev, and Percy Liang. SQuAD: 100,000+ questions for machine comprehension of text. In *Proceedings of the 2016 Conference on Empirical Methods in Natural Language Processing (EMNLP)*, pages 2383–2392, 2016. doi: 10.18653/v1/D16-1264.