---
title: "Set Transformer: A Framework for Attention-based Permutation-Invariant Neural Networks"
arxiv: "1810.0082"
authors: ["Juho Lee", "Yoonho Lee", "Jungtaek Kim", "Adam Kosiorek", "Seungjin Choi", "Yee Whye Teh"]
year: 2018
source: paper
ingested: 2026-05-06
sha256: 36b5dc3056b24a2221aebf1d80dc48a81eed49339cb349386472251eb64de91f
conversion: pymupdf4llm
---

# **Set Transformer: A Framework for Attention-based Permutation-Invariant Neural Networks** 

**Juho Lee**[1 2] **Yoonho Lee**[3] **Jungtaek Kim**[4] **Adam R. Kosiorek**[1 5] **Seungjin Choi**[4] **Yee Whye Teh**[1] 

## **Abstract** 

Many machine learning tasks such as multiple instance learning, 3D shape recognition and fewshot image classification are defined on sets of instances. Since solutions to such problems do not depend on the order of elements of the set, models used to address them should be _permutation invariant_ . We present an attention-based neural network module, the _Set Transformer_ , specifically designed to model interactions among elements in the input set. The model consists of an encoder and a decoder, both of which rely on attention mechanisms. In an effort to reduce computational complexity, we introduce an attention scheme inspired by inducing point methods from sparse Gaussian process literature. It reduces computation time of self-attention from quadratic to linear in the number of elements in the set. We show that our model is theoretically attractive and we evaluate it on a range of tasks, demonstrating increased performance compared to recent methods for set-structured data. 

## **1. Introduction** 

Learning representations has proven to be an essential problem for deep learning and its many success stories. The majority of problems tackled by deep learning are _instancebased_ and take the form of mapping a fixed-dimensional input tensor to its corresponding target value (Krizhevsky et al., 2012; Graves et al., 2013). 

For some applications, we are required to process _setstructured data_ . Multiple instance learning (Dietterich et al., 

1Department of Statistics, University of Oxford, United Kingdom[2] AITRICS, Republic of Korea[3] Kakao Corporation, Republic of Korea[4] Department of Computer Science and Engineering, POSTECH, Republic of Korea[5] Oxford Robotics Institute, University of Oxford, United Kingdom. Correspondence to: Juho Lee _<_ juho.lee@stats.ox.ac.uk _>_ . 

_Proceedings of the 36[th] International Conference on Machine Learning_ , Long Beach, California, PMLR 97, 2019. Copyright 2019 by the author(s). 

1997; Maron & Lozano-Perez´ , 1998) is an example of such a _set-input_ problem, where a set of instances is given as an input and the corresponding target is a label for the entire set. Other problems such as 3D shape recognition (Wu et al., 2015; Shi et al., 2015; Su et al., 2015; Charles et al., 2017), sequence ordering (Vinyals et al., 2016), and various set operations (Muandet et al., 2012; Oliva et al., 2013; Edwards & Storkey, 2017; Zaheer et al., 2017) can also be viewed as the set-input problems. Moreover, many meta-learning (Thrun & Pratt, 1998; Schmidhuber, 1987) problems which learn using different, but related tasks may also be treated as setinput tasks where an input set corresponds to the training dataset of a single task. For example, few-shot image classification (Finn et al., 2017; Snell et al., 2017; Lee & Choi, 2018) operates by building a classifier using a support set of images, which is evaluated with query images. 

A model for _set-input_ problems should satisfy two critical requirements. First, it should be _permutation invariant_ — the output of the model should not change under any permutation of the elements in the input set. Second, such a model should be able to process input sets of any size. While these requirements stem from the definition of a set, they are not easily satisfied in neural-network-based models: classical feed-forward neural networks violate both requirements, and RNNs are sensitive to input order. 

Recently, Edwards & Storkey (2017) and Zaheer et al. (2017) propose neural network architectures which meet both criteria, which we call _set pooling_ methods. In this model, each element in a set is first independently fed into a feed-forward neural network that takes fixed-size inputs. Resulting feature-space embeddings are then aggregated using a _pooling_ operation (mean, sum, max or similar). The final output is obtained by further non-linear processing of the aggregated embedding. This remarkably simple architecture satisfies both aforementioned requirements, and more importantly, is proven to be a universal approximator for any set function (Zaheer et al., 2017). Thanks to this property, it is possible to learn a complex mapping between input sets and their target outputs in a black-box fashion, much like with feed-forward or recurrent neural networks. 

Even though this set pooling approach is theoretically attractive, it remains unclear whether we can approximate 

**Set Transformer** 

complex mappings well using only instance-based feature extractors and simple pooling operations. Since every element in a set is processed independently in a set pooling operation, some information regarding interactions between elements has to be necessarily discarded. This can make some problems unnecessarily difficult to solve. 

Consider the problem of _amortized clustering_ , where we would like to learn a parametric mapping from an input set of points to the centers of clusters of points inside the set. Even for a toy dataset in 2D space, this is not an easy problem. The main difficulty is that the parametric mapping must assign each point to its corresponding cluster while modelling the explaining away pattern such that the resulting clusters do not attempt to explain overlapping subsets of the input set. Due to this innate difficulty, clustering is typically solved via iterative algorithms that refine randomly initialized clusters until convergence. Even though a neural network with a set poling operation can approximate such an amortized mapping by learning to quantize space, a crucial shortcoming is that this quantization cannot depend on the contents of the set. This limits the quality of the solution and also may make optimization of such a model more difficult; we show empirically in Section 5 that such pooling architectures suffer from under-fitting. 

In this paper, we propose a novel set-input deep neural network architecture called the _Set Transformer_ , ( _cf. Transformer_ , (Vaswani et al., 2017)). The novelty of the Set Transformer is in three important design choices: 

## **2. Background** 

## **2.1. Pooling Architecture for Sets** 

Problems involving a set of objects have the _permutation invariance_ property: the target value for a given set is the same regardless of the order of objects in the set. A simple example of a permutation invariant model is a network that performs pooling over embeddings extracted from the elements of a set. More formally, 

**==> picture [229 x 11] intentionally omitted <==**

Zaheer et al. (2017) have proven that all permutation invariant functions can be represented as (1) when pool is the sum operator and _ρ, φ_ any continuous functions, thus justifying the use of this architecture for set-input problems. 

Note that we can deconstruct (1) into two parts: an _encoder_ ( _φ_ ) which independently acts on each element of a set of _n_ items, and a _decoder_ ( _ρ_ (pool( _·_ ))) which aggregates these encoded features and produces our desired output. Most network architectures for set-structured data follow this encoder-decoder structure. 

Zaheer et al. (2017) additionally observed that the model remains permutation invariant even if the encoder is a stack of permutation-equivariant layers: 

**Definition 1.** _Let Sn be the set of all permutations of indices {_ 1 _, . . . , n}. A function f_ : _X[n] → Y[n] is permutation equivariant iff for any permutation π ∈ Sn, f_ ( _πx_ ) = _πf_ ( _x_ ) _._ 

An example of a permutation-equivariant layer is 

1. We use a self-attention mechanism to process every element in an input set, which allows our approach to naturally encode pairwise- or higher-order interactions between elements in the set. 

2. We propose a method to reduce the _O_ ( _n_[2] ) computation time of full self-attention (e.g. the Transformer) to _O_ ( _nm_ ) where _m_ is a fixed hyperparameter, allowing our method to scale to large input sets. 

3. We use a self-attention mechanism to aggregate features, which is especially beneficial when the problem requires multiple outputs which depend on each other, such as the problem of meta-clustering, where the meaning of each cluster center heavily depends its location relative to the other clusters. 

We apply the Set Transformer to several set-input problems and empirically demonstrate the importance and effectiveness of these design choices, and show that we can achieve the state-of-the-art performances for the most of the tasks. 

**==> picture [227 x 22] intentionally omitted <==**

where pool is the pooling operation, _λ, γ_ are learnable scalar variables, and _σ_ ( _·_ ) is a nonlinear activation function. 

## **2.2. Attention** 

Assume we have _n_ query vectors (corresponding to a set with _n_ elements) each with dimension _dq_ : _Q ∈_ R _[n][×][d][q]_ . An attention function Att( _Q, K, V_ ) is a function that maps queries _Q_ to outputs using _nv_ key-value pairs _K ∈_ R _[n][v][×][d][q] , V ∈_ R _[n][v][×][d][v]_ . 

**==> picture [184 x 14] intentionally omitted <==**

The pairwise dot product _QK[⊤] ∈_ R _[n][×][n][v]_ measures how similar each pair of query and key vectors is, with weights computed with an activation function _ω_ . The output _ω_ ( _QK[⊤]_ ) _V_ is a weighted sum of _V_ where a value gets more weight if its corresponding key has larger dot product with the query. 

_Multi-head attention_ , originally introduced in Vaswani et al. (2017), is an extension of the previous attention 

**Set Transformer** 

**==> picture [127 x 57] intentionally omitted <==**

**==> picture [81 x 54] intentionally omitted <==**

**==> picture [81 x 54] intentionally omitted <==**

**==> picture [81 x 54] intentionally omitted <==**

**==> picture [397 x 9] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) Our model (b) MAB (c) SAB (d) ISAB<br>**----- End of picture text -----**<br>


_Figure 1._ Diagrams of our attention-based set operations. 

scheme. Instead of computing a single attention function, this method first projects _Q, K, V_ onto _h_ different _d[M] q[, d][M] q[, d][M] v_[-dimensional vectors,][respectively.][An atten-] tion function (Att( _·_ ; _ωj_ )) is applied to each of these _h_ projections. The output is a linear transformation of the concatenation of all attention outputs: 

**==> picture [231 x 25] intentionally omitted <==**

**==> picture [212 x 15] intentionally omitted <==**

Note that Multihead( _·, ·, ·_ ; _λ_ ) has learnable parameters _λ_ = _{Wj[Q][, W] j[ K][, W] j[ V][}][h] j_ =1[,][where] _[W][ Q] j[, W] j[ K] ∈_ R _[d][q][×][d] q[M]_ , _Wj[V][∈]_[R] _[d][v][×][d] v[M]_ , _W[O] ∈_ R _[hd] v[M][×][d]_ . A typical choice for the dimension hyperparameters is _d[M] q_ = _dq/h_ , _d[M] v_ = _dv/h_ , _d_ = _dq_ . For brevity, we set _dq_ = _dv_ = _d_ , _d[M] q_[=] _[ d][M] v_[=] _[ d/h]_ throughout the rest of the paper. Unless otherwise specified, we use a scaled softmax _ωj_ ( _·_ ) = softmax( _·/√d_ ), which our experiments were worked robustly in most settings. 

## **3. Set Transformer** 

In this section, we motivate and describe the _Set Transformer_ : an attention-based neural network that is designed to process sets of data. Similar to other architectures, a Set Transformer consists of an encoder followed by a decoder ( _cf._ Section 2.1), but a distinguishing feature is that each layer in the encoder and decoder attends to their inputs to produce activations. Additionally, instead of a fixed pooling operation such as mean, our aggregating function pool( _·_ ) is parameterized and can thus adapt to the problem at hand. 

## **3.1. Permutation Equivariant (Induced) Set Attention Blocks** 

We begin by defining our attention-based set operations, which we call SAB and ISAB. While existing pooling methods for sets obtain instance features independently of other instances, we use self-attention to concurrently encode the whole set. This gives the Set Transformer the ability to compute pairwise as well as higher-order interactions among instances during the encoding process. For this purpose, we adapt the multihead attention mechanism used in Transformer. We emphasize that all blocks introduced here are 

neural network blocks with their own parameters, and not 

Given matrices _X, Y ∈_ R _[n][×][d]_ which represent two sets of _d_ -dimensional vectors, we define the Multihead Attention Block (MAB) with parameters _ω_ as follows: 

**==> picture [232 x 37] intentionally omitted <==**

> rFF is any row-wise feedforward layer (i.e., it processes each instance independently and identically), and LayerNorm is layer normalization (Ba et al., 2016). The MAB is an adaptation of the encoder block of the Transformer (Vaswani et al., 2017) without positional encoding and dropout. Using the MAB, we define the Set Attention Block (SAB) as 

**==> picture [172 x 10] intentionally omitted <==**

In other words, an SAB takes a set and performs selfattention between the elements in the set, resulting in a set of equal size. Since the output of SAB contains information about pairwise interactions among the elements in the input set _X_ , we can stack multiple SABs to encode higher order interactions. Note that while the SAB (8) involves a multihead attention operation (7), where _Q_ = _K_ = _V_ = _X_ , it could reduce to applying a residual block on _X_ . In practice, it learns more complicated functions due to linear projections of _X_ inside attention heads, (3) and (5). 

A potential problem with using SABs for set-structured data is the quadratic time complexity _O_ ( _n_[2] ), which may be too expensive for large sets ( _n ≫_ 1). We thus introduce the _Induced Set Attention Block_ (ISAB), which bypasses this problem. Along with the set _X ∈_ R _[n][×][d]_ , additionally define _m d_ -dimensional vectors _I ∈_ R _[m][×][d]_ , which we call _inducing points_ . Inducing points _I_ are part of the ISAB itself, and they are _trainable parameters_ which we train along with other parameters of the network. An ISAB with _m_ inducing points _I_ is defined as: 

**==> picture [194 x 29] intentionally omitted <==**

The ISAB first transforms _I_ into _H_ by attending to the input set. The set of transformed inducing points _H_ , which 

**Set Transformer** 

contains information about the input set _X_ , is again attended to by the input set _X_ to finally produce a set of _n_ elements. This is analogous to low-rank projection or autoencoder models, where inputs ( _X_ ) are first projected onto a lowdimensional object ( _H_ ) and then reconstructed to produce outputs. The difference is that the goal of these methods is reconstruction whereas ISAB aims to obtain good features for the final task. We expect the learned inducing points to encode some global structure which helps explain the inputs _X_ . For example, in the amortized clustering problem on a 2D plane, the inducing points could be appropriately distributed points on the 2D plane so that the encoder can compare elements in the query dataset indirectly through their proximity to these grid points. 

Note that in (9) and (10), attention was computed between a set of size _m_ and a set of size _n_ . Therefore, the time complexity of ISAB _m_ ( _X_ ; _λ_ ) is _O_ ( _nm_ ) where _m_ is a (typically small) hyperparameter — an improvement over the quadratic complexity of the SAB. We also emphasize that both of our set operations (SAB and ISAB) are _permutation equivariant_ (definition in Section 2.1): 

**Property 1.** _Both_ SAB( _X_ ) _and_ ISAB _m_ ( _X_ ) _are permutation equivariant._ 

## **3.2. Pooling by Multihead Attention** 

A common aggregation scheme in permutation invariant networks is a dimension-wise average or maximum of the feature vectors ( _cf._ Section 1). We instead propose to aggregate features by applying multihead attention on a learnable set of _k_ seed vectors _S ∈_ R _[k][×][d]_ . Let _Z ∈_ R _[n][×][d]_ be the set of features constructed from an encoder. _Pooling by Multihead Attention_ (PMA) with _k_ seed vectors is defined as 

**==> picture [185 x 11] intentionally omitted <==**

Note that the output of PMA _k_ is a set of _k_ items. We use one seed vector ( _k_ = 1) in most cases, but for problems such as amortized clustering which requires _k_ correlated outputs, the natural thing to do is to use _k_ seed vectors. To further model the interactions among the _k_ outputs, we apply an SAB afterwards: 

**==> picture [166 x 11] intentionally omitted <==**

We later empirically show that such self-attention after pooling helps in modeling explaining-away (e.g., among clusters in an amortized clustering problem). 

Intuitively, feature aggregation using attention should be beneficial because the influence of each instance on the target is not necessarily equal. For example, consider a problem where the target value is the maximum value of a set of real numbers. Since the target can be recovered using only a single instance (the largest), finding and attending to that instance during aggregation will be advantageous. 

## **3.3. Overall Architecture** 

Using the ingredients explained above, we describe how we would construct a set transformer consists of an encoder and a decoder. The encoder Encoder : _X �→ Z ∈_ R _[n][×][d]_ is a stack of SABs or ISABs, for example: 

**==> picture [196 x 26] intentionally omitted <==**

We point out again that the time complexity for _ℓ_ stacks of SABs and ISABs are _O_ ( _ℓn_[2] ) and _O_ ( _ℓnm_ ), respectively. This can result in much lower processing times when using ISAB (as compared to SAB), while still maintaining high representational power. After the encoder transforms data _X ∈_ R _[n][×][d][x]_ into features _Z ∈_ R _[n][×][d]_ , the decoder aggregates them into a single or a set of vectors which is fed into a feed-forward network to get final outputs. Note that PMA with _k >_ 1 seed vectors should be followed by SABs to model the correlation between _k_ outputs. 

**==> picture [229 x 29] intentionally omitted <==**

## **3.4. Analysis** 

Since the blocks used to construct the encoder (i.e., SAB, ISAB) are permutation equivariant, the mapping of the encoder _X → Z_ is permutation equivariant as well. Combined with the fact that the PMA in the decoder is a permutation invariant transformation, we have the following: 

**Proposition 1.** _The Set Transformer is permutation invariant._ 

Being able to approximate any function is a desirable property, especially for black-box models such as deep neural networks. Building on previous results about the universal approximation of permutation invariant functions, we prove the universality of Set Transformers: 

**Proposition 2.** _The Set Transformer is a universal approximator of permutation invariant functions._ 

## _Proof._ See supplementary material. 

## **4. Related Works** 

**Pooling architectures for permutation invariant mappings** Pooling architectures for sets have been used in various problems such as 3D shape recognition (Shi et al., 2015; Su et al., 2015), discovering causality (Lopez-Paz et al., 2017), learning the statistics of a set (Edwards & Storkey, 2017), few-shot image classification (Snell et al., 2017), and conditional regression and classification (Garnelo et al., 2018). Zaheer et al. (2017) discuss the structure 

**Set Transformer** 

in general and provides a partial proof of the universality of the pooling architecture, and Wagstaff et al. (2019) further discuss the limitation of pooling architectures. BloemReddy & Teh (2019) provides a link between probabilistic exchangeability and pooling architectures. 

**Attention-based approaches for sets** Several recent works have highlighted the competency of attention mechanisms in modeling sets. Vinyals et al. (2016) pool elements in a set by a weighted average with weights computed using an attention mechanism. Yang et al. (2018) propose AttSets for multi-view 3D reconstruction, where dot-product attention is applied to compute the weights used to pool the encoded features via weighted sums. Similarly, Ilse et al. (2018) use attention-based weighted sum-pooling for multiple instance learning. Compared to these approaches, ours use multihead attention in aggregation, and more importantly, we propose to apply self-attention after pooling to model correlation among multiple outputs. PMA with _k_ = 1 seed vector and single-head attention roughly corresponds to these previous approaches. Although not permutation invariant, Mishra et al. (2018) has attention as one of its core components to meta-learn to solve various tasks using sequences of inputs. Kim et al. (2019) proposed attentionbased conditional regression, where self-attention is applied to the query sets. 

**Modeling interactions between elements in sets** An important reason to use the Transformer is to explicitly model higher-order interactions among the elements in a set. Santoro et al. (2017) propose the relational network, a simple architecture that sum-pools all pairwise interactions of elements in a given set, but not higher-order interactions. Similarly to our work, Ma et al. (2018) use the Transformer to model interactions between the objects in a video. They use mean-pooling to obtain aggregated features which they fed into an LSTM. 

**Inducing point methods** The idea of letting trainable vectors _I_ directly interact with data points is loosely based on the inducing point methods used in sparse Gaussian processes (Snelson & Ghahramani, 2005) and the Nystrom¨ method for matrix decomposition (Fowlkes et al., 2004). _m_ trainable inducing points can also be seen as _m_ independent memory cells accessed with an attention mechanism. The differential neural dictionary (Pritzel et al., 2017) stores previous experience as key-value pairs and uses this to process queries. One can view the ISAB is the inversion of this idea, where queries _I_ are stored and the input features are used as key-value pairs. 

## **5. Experiments** 

To evaluate the Set Transformer, we apply it to a suite of tasks involving sets of data points. We repeat all experi- 

_Table 1._ Mean absolute errors on the max regression task. 

|Architecture|MAE|
|---|---|
|rFF + Pooling (mean)|2.133_±_0.190|
|rFF + Pooling (sum)|1.902_±_0.137|
|rFF + Pooling (max)|**0.1355**_±_**0.0074**|
|SAB + PMA (ours)|0.2085_±_0.0127|



on corresponding test datasets. Along with baselines, we compared various architectures arising from the combination of the choices of having attention in encoders and decoders. Unless specified otherwise, “simple pooling” means average pooling. 

- rFF + Pooling (Zaheer et al., 2017): rFF layers in encoder and simple pooling + rFF layers in decoder. 

- rFFp-mean/rFFp-max + Pooling (Zaheer et al., 2017): rFF layers with permutation equivariant variants in encoder (Zaheer et al., 2017, (4)) and simple pooling + rFF layers in decoder. 

- rFF + Dotprod (Yang et al., 2018; Ilse et al., 2018): rFF layers in encoder and dot product attention based weighted sum pooling + rFF layers in decoder. 

- SAB (ISAB) + Pooling (ours): Stack of SABs (ISABs) in encoder and simple pooling + rFF layers in decoder. 

- rFF + PMA (ours): rFF layers in encoder and PMA (followed by stack of SABs) in decoder. 

- SAB (ISAB) + PMA (ours): Stack of SABs (ISABs) in encoder and PMA (followed by stack of SABs) in decoder. 

## **5.1. Toy Problem: Maximum Value Regression** 

To demonstrate the advantage of attention-based set aggregation over simple pooling operations, we consider a toy problem: regression to the maximum value of a given set. Given a set of real numbers _{x_ 1 _, . . . , xn}_ , the goal is to return max( _x_ 1 _, · · · , xn_ ). Given prediction _p_ , we use the mean absolute error _|p −_ max( _x_ 1 _, · · · , xn_ ) _|_ as the loss function. We constructed simple pooling architectures with three different pooling operations: max, mean, and sum. We report loss values after training in Table 1. Mean- and sumpooling architectures result in a high mean absolute error (MAE). The model with max-pooling can predict the output perfectly by learning its encoder to be an identity function, and thus achieves the highest performance. Notably, the Set Transformer achieves performance comparable to the max-pooling model, which underlines the importance of additional flexibility granted by attention mechanisms — it 

**Set Transformer** 

**==> picture [235 x 48] intentionally omitted <==**

_Figure 2._ Counting unique characters: this is a randomly sampled set of 20 images from the Omniglot dataset. There are 14 different characters inside this set. 

**==> picture [206 x 127] intentionally omitted <==**

**----- Start of picture text -----**<br>
ISAB(n)+PMA<br>SAB+PMA<br>SAB + Pooling<br>rFF + PMA<br>rFF + Pooling<br>1 2 3 4 5 6 7 8 9 10 11<br>Number of Inducing Points (n)<br>060 .<br>055 .<br>050 .<br>045 .<br>Accuracy<br>**----- End of picture text -----**<br>


_Table 2._ Accuracy on the unique character counting task. 

|Architecture|Accuracy|
|---|---|
|rFF + Pooling|0.4382_±_0.0072|
|rFFp-mean + Pooling|0.4617_±_0.0076|
|rFFp-max + Pooling|0.4359_±_0.0077|
|rFF + Dotprod|0.4471_±_0.0076|
|rFF + PMA (ours)|0.4572_±_0.0076|
|SAB + Pooling (ours)|0.5659_±_0.0077|
|SAB + PMA (ours)|**0.6037**_±_**0.0075**|



## **5.2. Counting Unique Characters** 

In order to test the ability of modelling interactions between objects in a set, we introduce a new task of counting unique elements in an input set. We use the Omniglot (Lake et al., 2015) dataset, which consists of 1,623 different handwritten characters from various alphabets, where each character is represented by 20 different images. 

We split all characters (and corresponding images) into train, validation, and test sets and only train using images from the train character classes. We generate input sets by sampling between 6 and 10 images and we train the model to predict the number of different characters inside the set. We used a Poisson regression model to predict this number, with the rate _λ_ given as the output of a neural network. We maximized the log likelihood of this model using stochastic gradient ascent. 

We evaluated model performance using sets of images sampled from the test set of characters. Table 2 reports accuracy, measured as the frequency at which the mode of the Poisson distribution chosen by the network is equal to the number of characters inside the input set. 

We additionally performed experiments to see how the number of incuding points affects performance. We trained ISAB _n_ + PMA on this task while varying the number of inducing points ( _n_ ). Accuracies are shown in Figure 3, where other architectures are shown as horizontal lines for comparison. Note first that even the accuracy of ISAB1 + PMA surpasses that of both rFF+Pooling and rFF+PMA, and that performance tends to increase as we increase _n_ . 

_Figure 3._ Accuracy of ISAB _n_ + PMA on the unique character counting task. x-axis is _n_ and y-axis is accuracy. 

## **5.3. Amortized Clustering with Mixture of Gaussians** 

We applied the set-input networks to the task of maximum likelihood of mixture of Gaussians (MoGs). The log-likelihood of a dataset _X_ = _{x_ 1 _, . . . , xn}_ generated from an MoG with _k_ components is 

**==> picture [227 x 32] intentionally omitted <==**

The goal is to learn the optimal parameters _θ[∗]_ ( _X_ ) = arg max _θ_ log _p_ ( _X_ ; _θ_ ). The typical approach to this problem is to run an iterative algorithm such as ExpectationMaximisation (EM) until convergence. Instead, we aim to learn a generic meta-algorithm that directly maps the input set _X_ to _θ[∗]_ ( _X_ ). One can also view this as amortized maximum likelihood learning. Specifically, given a dataset _X_ , we train a neural network to output parameters _f_ ( _X_ ; _λ_ ) = _{π_ ( _X_ ) _, {µj_ ( _X_ ) _, σj_ ( _X_ ) _}[k] j_ =1 _[}]_[ which maximize] 

**==> picture [228 x 33] intentionally omitted <==**

We structured _f_ ( _·_ ; _λ_ ) as a set-input neural network and learned its parameters _λ_ using stochastic gradient ascent, where we approximate gradients using minibatches of _datasets_ . 

We tested Set Transformers along with other set-input networks on two datasets. We used four seed vectors for the PMA ( _S ∈_ R[4] _[×][d]_ ) so that each seed vector generates the parameters of a cluster. 

**Synthetic 2D mixtures of Gaussians** : Each dataset contains _n ∈_ [100 _,_ 500] points on a 2D plane, each sampled from one of four Gaussians. 

**CIFAR-100** : Each dataset contains _n ∈_ [100 _,_ 500] images sampled from four random classes in the CIFAR-100 dataset. Each image is represented by a 512-dim vector obtained from a pretrained VGG network (Simonyan & Zisserman, 2014). 

**Set Transformer** 

_Table 3._ Meta clustering results. The number inside parenthesis indicates the number of inducing points used in ISABs of encoders. We show average likelihood per data for the synthetic dataset and the adjusted rand index (ARI) for the CIFAR-100 experiment. LL1/data, ARI1 are the evaluation metrics after a single EM update step. The oracle for the synthetic dataset is the log likelihood of the actual parameters used to generate the set, and the CIFAR oracle was computed by running EM until convergence. 

|Architecture|Synthetic<br>CIFAR-100|
|---|---|
||LL0/data<br>LL1/data<br>ARI0<br>ARI1|
|Oracle<br>rFF + Pooling<br>rFFp-mean + Pooling<br>rFFp-max + Pooling<br>rFF + Dotprod|-1.4726<br>0.9150<br>-2.0006_±_0.0123<br>-1.6186_±_0.0042<br>0.5593_±_0.0149<br>0.5693_±_0.0171<br>-1.7606_±_0.0213<br>-1.5191_±_0.0026<br>0.5673_±_0.0053<br>0.5798_±_0.0058<br>-1.7692_±_0.0130<br>-1.5103_±_0.0035<br>0.5369_±_0.0154<br>0.5536_±_0.0186<br>-1.8549_±_0.0128<br>-1.5621_±_0.0046<br>0.5666_±_0.0221<br>0.5763_±_0.0212|
|SAB + Pooling (ours)<br>ISAB (16) + Pooling (ours)<br>rFF + PMA (ours)<br>SAB + PMA (ours)<br>ISAB (16) + PMA (ours)|-1.6772_±_0.0066<br>-1.5070_±_0.0115<br>0.5831_±_0.0341<br>0.5943_±_0.0337<br>-1.6955_±_0.0730<br>-1.4742_±_0.0158<br>0.5672_±_0.0124<br>0.5805_±_0.0122<br>-1.6680_±_0.0040<br>-1.5409_±_0.0037<br>0.7612_±_0.0237<br>0.7670_±_0.0231<br>-1.5145_±_0.0046<br>-1.4619_±_0.0048<br>0.9015_±_0.0097<br>0.9024_±_0.0097<br>**-1.5009**_±_**0.0068**<br>**-1.4530**_±_**0.0037**<br>**0.9210**_±_**0.0055**<br>**0.9223**_±_**0.0056**|



**==> picture [394 x 163] intentionally omitted <==**

_Figure 4._ Clustering results for 10 test datasets, along with centers and covariance matrices. rFF+Pooling (top-left), SAB+Pooling (top-right), rFF+PMA (bottom-left), Set Transformer (bottom-right). Best viewed magnified in color. 

We report the performance of the oracle along with the setinput neural networks in Table 3. We additionally report scores of all models after a single EM update. Overall, the Set Transformer found accurate parameters and even outperformed the oracles after a single EM update. This may be due to the relatively small size of the input sets; some clusters have fewer than 10 points. In this regime, sample statistics can differ substantially from population statistics, which limits the performance of the oracle while the Set Transformer can adapt accordingly. Notably, the Set Transformer with only 16 inducing points showed the best performance, even outperforming the full Set Transformer. We believe this is due to the knowledge transfer and regularization via inducing points, helping the network to learn global structures. Our results also imply that the improvement from using the PMA is more significant than that of the SAB, supporting our claim of the importance of attention-based decoders. We provide detailed genera- 

tive processes, network architectures, and training schemes along with additional experiments with various numbers of inducing points in the supplementary material. 

## **5.4. Set Anomaly Detection** 

We evaluate our methods on the task of meta-anomaly detection within a set using the CelebA dataset. The dataset consists of 202,599 images with the total of 40 attributes. We randomly sample 1,000 sets of images. For every set, we select two attributes at random and construct the set by selecting seven images containing both attributes and one image with neither. The goal of this task is to find the image that does not belong to the set. We give a detailed description of the experimental setup in the supplementary material. We report the area under receiver operating characteristic curve (AUROC) and area under precision-recall curve (AUPR) in Table 5. Set Transformers outperformed all other methods by a significant margin. 

**Set Transformer** 

_Table 4._ 100 _,_ 1000 _,_ 5000 points. 

|Architecture|100 pts|1000 pts|5000 pts|
|---|---|---|---|
|rFF + Pooling (Zaheer et al.,2017)|-|0.83_±_0.01|-|
|rFFp-max + Pooling (Zaheer et al.,2017)|0.82_±_0.02|0.87_±_0.01|**0.90**_±_**0.003**|
|rFF + Pooling|0.7951_±_0.0166|0.8551_±_0.0142|0.8933_±_0.0156|
|rFF + PMA (ours)|0.8076_±_0.0160|0.8534_±_0.0152|0.8628_±_0.0136|
|ISAB (16) + Pooling (ours)|0.8273_±_0.0159|**0.8915**_±_**0.0144**|**0.9040**_±_**0.0173**|
|ISAB (16) + PMA (ours)|**0.8454**_±_**0.0144**|0.8662_±_0.0149|0.8779_±_0.0122|



**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

**==> picture [18 x 22] intentionally omitted <==**

_Figure 5._ Sampled datasets. Each row is a dataset, consisting of 7 normal images and 1 anomaly (red box). In each subsampled dataset, a normal image has two attributes (rightmost column) which anomalies do not. 

_Table 5._ Meta set anomaly results. Each architecture is evaluated using average of test AUROC and test AUPR. 

|Architecture|Test AUROC|Test AUPR|
|---|---|---|
|Random guess|0.5|0.125|
|rFF + Pooling|0.5643_±_0.0139|0.4126_±_0.0108|
|rFFp-mean + Pooling|0.5687_±_0.0061|0.4125_±_0.0127|
|rFFp-max + Pooling|0.5717_±_0.0117|0.4135_±_0.0162|
|rFF + Dotprod|0.5671_±_0.0139|0.4155_±_0.0115|
|SAB + Pooling (ours)|0.5757_±_0.0143|0.4189_±_0.0167|
|rFF + PMA (ours)|0.5756_±_0.0130|0.4227_±_0.0127|
|SAB + PMA (ours)|**0.5941**_±_**0.0170**|**0.4386**_±_**0.0089**|



## 

We evaluated Set Transformers on a classification task using the ModelNet40 (Chang et al., 2015) dataset[1] , which contains three-dimensional objects in 40 different categories. Each object is represented as a point cloud, which we treat as a set of _n_ vectors in R[3] . We performed experiments with input sets of size _n ∈{_ 100 _,_ 1000 _,_ 5000 _}_ . Because of the large set sizes, MABs are prohibitively time-consuming due to their _O_ ( _n_[2] ) time complexity. 

Table 4 shows classification accuracies. We point out that Zaheer et al. (2017) used significantly more engineering for the 5000 point experiment. For this experiment only, 

> 1The point-cloud dataset used in this experiment was obtained directly from the authors of Zaheer et al. (2017). 

they augmented data (scaling, rotation) and used a different optimizer (Adamax) and learning rate schedule. Set Transformers were superior when given small sets, but were outperformed by ISAB (16) + Pooling on larger sets. First note that classification is harder when given fewer points. We think Set Transformers were outperformed in the problems with large sets because such sets already had sufficient information for classification, diminishing the need to model complex interactions among points. We point out that PMA outperformed simple pooling in all other experiments. 

## **6. Conclusion** 

In this paper, we introduced the Set Transformer, an attention-based set-input neural network architecture. Our proposed method uses attention mechanisms for both encoding and aggregating features, and we have empirically validated that both of them are necessary for modelling complicated interactions among elements of a set. We also proposed an inducing point method for self-attention, which makes our approach scalable to large sets. We also showed useful theoretical properties of our model, including the fact that it is a universal approximator for permutation invariant functions. An interesting future work would be to apply Set Transformers to meta-learning problems. In particular, using Set Transformers to meta-learn posterior inference in Bayesian models seems like a promising line of research. Another exciting extension of our work would be to model the uncertainty in set functions by injecting noise variables into Set Transformers in a principled way. 

**Acknowledgments** JL and YWT’s research leading to these results has received funding from the European Research Council under the European Union’s Seventh Framework Programme (FP7/2007-2013) ERC grant agreement no. 617071. JL has also received funding from EPSRC under grant EP/P026753/1. JL acknowledges support from IITP grant funded by the Korea government(MSIT) (No.20170-01779, XAI) and Samsung Research Funding & Incubation Center of Samsung Electronics under Project Number SRFC-IT1702-15. 

**Set Transformer** 

## **References** 

- Ba, J. L., Kiros, J. R., and Hinton, G. E. Layer normalization. _arXiv e-prints_ , arXiv:1607.06450, 2016. 

- Bloem-Reddy, B. and Teh, Y.-W. Probabilistic symmetry and invariant neural networks. _arXiv e-prints_ , arXiv:1901.06082, 2019. 

- Chang, A. X., Funkhouser, T., Guibas, L., Hanrahan, P., Huang, Q., Li, Z., Savarese, S., Savva, M., Song, S., Su, H., Xiao, J., Yi, L., and Yu, F. ShapeNet: An information-rich 3D model repository. _arXiv e-prints_ , arXiv:1512.03012, 2015. 

- Charles, R. Q., Su, H., Kaichun, M., and Guibas, L. J. PointNet: Deep learning on point sets for 3D classification and segmentation. In _Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition (CVPR)_ , 2017. 

- Dietterich, T. G., Lathrop Richard, H., and Lozano-Perez, T.´ Solving the multiple instance problem with axis-parallel rectangles. _Artificial intelligence_ , 89(1-2):31–71, 1997. 

- Edwards, H. and Storkey, A. Towards a neural statistician. In _Proceedings of the International Conference on Learning Representations (ICLR)_ , 2017. 

- Finn, C., Abbeel, P., and Levine, S. Model-agnostic metalearning for fast adaptation of deep networks. In _Proceedings of the International Conference on Machine Learning (ICML)_ , 2017. 

- Fowlkes, C., Belongie, S., Chung, F., and Malik, J. Spectral grouping using the Nystrom method.¨ _IEEE Transactions on Pattern Analysis and Machine Intelligence_ , 25(2):215– 225, 2004. 

- Garnelo, M., Rosenbaum, D., Maddison, C. J., Ramalho, T., Saxton, D., Shanahan, M., Teh, Y. W., Rezende, D. J., and Eslami, S. M. A. Conditional neural processes. In _Proceedings of the International Conference on Machine Learning (ICML)_ , 2018. 

- Graves, A., Mohamed, A.-r., and Hinton, G. E. Speech recognition with deep recurrent neural networks. In _Proceedings of the IEEE International Conference on Acoustics, Speech, and Signal Processing (ICASSP)_ , 2013. 

- Ilse, M., Tomczak, J. M., and Welling, M. Attention-based deep multiple instance learning. In _Proceedings of the International Conference on Machine Learning (ICML)_ , 2018. 

- Kim, H., Mnih, A., Schwarz, J., Garnelo, M., Eslami, A., Rosenbaum, D., Vinyals, O., and Teh, Y. W. Attentive neural processes. In _Proceedings of International Conference on Learning Representations_ , 2019. 

- Krizhevsky, A., Sutskever, I., and Hinton, G. E. ImageNet classification with deep convolutional neural networks. In _Advances in Neural Information Processing Systems (NeurIPS)_ , 2012. 

- Lake, B. M., Salakhutdinov, R., and Tenenbaum, J. B. Human-level concept learning through probabilistic program induction. _Science_ , 350(6266):1332–1338, 2015. 

- Lee, Y. and Choi, S. Gradient-based meta-learning with learned layerwise metric and subspace. In _Proceedings of the International Conference on Machine Learning (ICML)_ , 2018. 

- Lopez-Paz, D., Nishihara, R., Chintala, S., Scholkopf, B.,¨ and Bottou, L. Discovering causal signals in images. In _Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition (CVPR)_ , 2017. 

- Ma, C.-Y., Kadav, A., Melvin, I., Kira, Z., AlRegib, G., and Peter Graf, H. Attend and interact: higher-order object interactions for video understanding. In _Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition (CVPR)_ , 2018. 

- Maron, O. and Lozano-Perez, T.´ A framework for multipleinstance learning. In _Advances in Neural Information Processing Systems (NeurIPS)_ , 1998. 

- Mishra, N., Rohaninejad, M., Chen, X., and Abbeel, P. A simple neural attentive meta-learner. In _Proceedings of the International Conference on Machine Learning (ICML)_ , 2018. 

- Muandet, K., Fukumizu, K., Dinuzzo, F., and Scholkopf,¨ B. Learning from distributions via support measure machines. In _Advances in Neural Information Processing Systems (NeurIPS)_ , 2012. 

- Oliva, J., Poczos, B., and Schneider, J.´ Distribution to distribution regression. In _Proceedings of the International Conference on Machine Learning (ICML)_ , 2013. 

- Pritzel, A., Uria, B., Srinivasan, S., Puigdomenech, A., Vinyals, O., Hassabis, D., Wierstra, D., and Blundell, C. Neural episodic control. In _Proceedings of the International Conference on Machine Learning (ICML)_ , 2017. 

- Santoro, A., Raposo, D., Barret, D. G. T., Malinowski, M., Pascanu, R., and Battaglia, P. A simple neural network module for relational reasoning. In _Advances in Neural Information Processing Systems (NeurIPS)_ , 2017. 

- Schmidhuber, J. _Evolutionary Principles in Self-Referential Learning_ . PhD thesis, Technical University of Munich, 1987. 

**Set Transformer** 

- Shi, B., Bai, S., Zhou, Z., and Bai, X. DeepPano: deep panoramic representation for 3-D shape recognition. _IEEE Signal Processing Letters_ , 22(12):2339–2343, 2015. 

- Simonyan, K. and Zisserman, A. Very deep convolutional networks for large-scale image recognition. _arXiv e- prints_ , arXiv:1409.1556, 2014. 

- Snell, J., Swersky, K., and Zemel, R. Prototypical networks for few-shot learning. In _Advances in Neural Information Processing Systems (NeurIPS)_ , 2017. 

- Snelson, E. and Ghahramani, Z. Sparse Gaussian processes using pseudo-inputs. In _Advances in Neural Information Processing Systems (NeurIPS)_ , 2005. 

- Su, H., Maji, S., Kalogerakis, E., and Learned-Miller, E. Multi-view convolutional neural networks for 3D shape recognition. In _Proceedings of the IEEE International Conference on Computer Vision (ICCV)_ , 2015. 

- Thrun, S. and Pratt, L. _Learning to Learn_ . Kluwer Academic Publishers, 1998. 

- Vaswani, A., Shazeer, N., Parmar, N., Uszkoreit, J., Jones, L., Gomez, A. N., Kaiser, Ł., and Polosukhin, I. Attention is all you need. In _Advances in Neural Information Processing Systems (NeurIPS)_ , 2017. 

- Vinyals, O., Bengio, S., and Kudlur, M. Order matters: sequence to sequence for sets. In _Proceedings of the International Conference on Learning Representations (ICLR)_ , 2016. 

- Wagstaff, E., Fuchs, F. B., Engelcke, M., Posner, I., and Osborne, M. On the limitations of representing functions on sets. _arXiv:1901.09006_ , 2019. 

- Wu, Z., Song, S., Khosla, A., Yu, F., Zhang, L., Tang, X., and Xiao, J. 3D ShapeNets: a deep representation for volumetric shapes. In _Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition (CVPR)_ , 2015. 

- Yang, B., Wang, S., Markham, A., and Trigoni, N. Attentional aggregation of deep feature sets for multi-view 3D reconstruction. _arXiv e-prints_ , arXiv:1808.00758, 2018. 

- Zaheer, M., Kottur, S., Ravanbakhsh, S., Poczos, B., Salakhutdinov, R. R., and Smola, A. J. Deep sets. In _Advances in Neural Information Processing Systems (NeurIPS)_ , 2017. 

## **Supplementary Material for Set Transformer** 

**Juho Lee**[1 2] **Yoonho Lee**[3] **Jungtaek Kim**[4] **Adam R. Kosiorek**[1 5] **Seungjin Choi**[4] **Yee Whye Teh**[1] 

## **1. Proofs** 

**Lemma 1.** _The mean operator_ mean( _{x_ 1 _, . . . , xn}_ ) = _n_[1] � _ni_ =1 _[x][i][is a special case of dot-product attention with softmax.]_ 

_Proof._ Let _s_ = **0** _∈_ R _[d]_ and _X ∈_ R _[n][×][d]_ . 

**==> picture [239 x 28] intentionally omitted <==**

**Lemma 2.** _The decoder of a Set Transformer, given enough nodes, can express any element-wise function of the form_ � _n_ 1 � _ni_ =1 _[z] i[p]_ � _p_[1] _._ 

_Proof._ 

**==> picture [326 x 26] intentionally omitted <==**

We focus on _H_ in (2). 1 the feed-forward layers in front and back of the MAB encode the element-wise functions _z → z[p]_ and _z → z p_ , respectively. We let _h_ = _d_ , so the number of heads is the same as the dimensionality of the inputs, and each head is one-dimensional. Let the projection matrices in multi-head attention ( _Wj[Q][, W] j[ K][, W] j[ V]_[) represent projections onto the jth dimension and the output] matrix ( _W[O]_ ) the identity matrix. Since the mean operator is a special case of dot-product attention, by simple composition, we see that an MAB can express any dimension-wise function of the form 

**==> picture [314 x 34] intentionally omitted <==**

**Lemma 3.** _A PMA, given enough nodes, can express sum pooling_ ([�] _[n] i_ =1 _[z][i]_[)] _[.]_ 

## _Proof._ We prove this by construction. 

Set the seed _s_ to a zero vector and let _ω_ ( _·_ ) = 1 + _f_ ( _·_ ), where _f_ is any activation function such that _f_ (0) = 0. The identiy, sigmoid, or relu functions are suitable choices for _f_ . The output of the multihead attention is then simply a sum of the values, which is _Z_ in this case. 

We additionally have the following universality theorem for pooling architectures: 

**Theorem 1.** _Models of the form_ rFF(sum(rFF( _·_ ))) _are universal function approximators in the space of permutation invariant functions._ 

_Proof._ See Appendix A of **?** . 

**Supplementary Material for Set Transformer** 

By Lemma 3, we know that decoder( _Z_ ) can express any function of the form rFF(sum( _Z_ )). Using this fact along with Theorem 1, we can prove the universality of Set Transformers: 

**Proposition 1.** _The Set Transformer is a universal function approximator in the space of permutation invariant functions._ 

> _Proof._ By setting the matrix _W[O]_ to a zero matrix in every SAB and ISAB, we can ignore all pairwise interaction terms in the encoder. Therefore, the encoder( _X_ ) can express any instance-wise feed-forward network ( _Z_ = rFF( _X_ )). Directly invoking Theorem 1 concludes this proof. 

While this proof required us to ignore the pairwise interaction terms inside the SABs and ISABs to prove that Set Transformers are universal function approximators, our experiments indicated that self-attention in the encoder was crucial for good performance. 

## **2. Experiment Details** 

In all implementations, we omit the feed-forward layer in the beginning of the decoder (rFF( _Z_ )) because the end of the previous block contains a feed-forward layer. All MABs (inside SAB, ISAB and PMA) use fully-connected layers with ReLU activations for rFF layers. 

In the architecture descriptions, FC( _d, f_ ) denotes the fully-connected layer with _d_ units and activation function _f_ . SAB( _d, h_ ) denotes the SAB with _d_ units and _h_ heads. ISAB _m_ ( _d, h_ ) denotes the ISAB with _d_ units, _h_ heads and _m_ inducing points. PMA _k_ ( _d, h_ ) denotes the PMA with _d_ units, _h_ heads and _k_ vectors. All MABs used in SAB and PMA uses FC layers with ReLU activations for FF layers. 

## **2.1. Max Regression** 

Given a set of real numbers _{x_ 1 _, . . . , xn}_ , the goal of this task is to return the maximum value in the set max( _x_ 1 _, · · · , xn_ ). We construct training data as follows. We first sample a dataset size _n_ uniformly from the set of integers _{_ 1 _, · · · ,_ 10 _}_ . We then sample real numbers _xi_ independently from the interval [0 _,_ 100]. Given the network’s prediction _p_ , we use the actual maximum value max( _x_ 1 _, · · · , xn_ ) to compute the mean absolute error _|p −_ max( _x_ 1 _, · · · , xn_ ) _|_ . We don’t explicitly consider splits of train and test data, since we sample a new set _{x_ 1 _, . . . , xn}_ at each time step. 

_Table 1._ Detailed architectures used in the max regression experiments. 

||Encoder<br>FF<br>SAB|Decoder<br>Pooling<br>PMA|
|---|---|---|
|FC(64_,_ReLU)<br>SAB(64_,_4)<br>FC(64_,_ReLU)<br>SAB(64_,_4)<br>FC(64_,_ReLU)<br>FC(64_, −_)||mean_,_sum_,_max<br>PMA1(64_,_4)<br>FC(64_,_ReLU)<br>FC(1_, −_)<br>FC(1_, −_)|



We show the detailed architectures used for the experiments in Table 1. We trained all networks using the Adam optimizer ( **?** ) with a constant learning rate of 10 _[−]_[3] and a batch size of 128 for 20,000 batches, after which loss converged for all architectures. 

## **2.2. Counting Unique Characters** 

The task generation procedure is as follows. We first sample a set size _n_ uniformly from the set of integers _{_ 6 _, . . . ,_ 10 _}_ . We then sample the number of characters _c_ uniformly from _{_ 1 _, . . . , n}_ . We sample _c_ characters from the training set of characters, and randomly sample instances of each character so that the total number of instances sums to _n_ and each set of characters has at least one instance in the resulting set. 

We show the detailed architectures used for the experiments in Table 3. For both architectures, the resulting 1-dimensional output is passed through a softplus activation to produce the Poisson parameter _γ_ . The role of softplus is to ensure that _γ_ is always positive. 

**Supplementary Material for Set Transformer** 

_Table 2._ Detailed results for the unique character counting experiment. 

|Architecture|Accuracy|
|---|---|
|rFF + Pooling|0.4366_±_0.0071|
|rFF + PMA|0.4617_±_0.0073|
|rFFp-mean + Pooling|0.4617_±_0.0076|
|rFFp-max + Pooling|0.4359_±_0.0077|
|rFF + Dotprod|0.4471_±_0.0076|
|SAB + Pooling|0.5659_±_0.0067|
|SAB + Dotprod|0.5888_±_0.0072|
|SAB + PMA (1)|**0.6037**_±_**0.0072**|
|SAB + PMA (2)|0.5806_±_0.0075|
|SAB + PMA (4)|0.5945_±_0.0072|
|SAB + PMA (8)|0.6001_±_0.0078|



_Table 3._ Detailed architectures used in the unique character counting experiments. 

||Encoder<br>rFF<br>SAB|Decoder<br>Pooling<br>PMA|
|---|---|---|
|Conv(64_,_3_,_2_,_BN_,_ReLU)<br>Conv(64_,_3_,_2_,_BN_,_ReLU)<br>Conv(64_,_3_,_2_,_BN_,_ReLU)<br>Conv(64_,_3_,_2_,_BN_,_ReLU)<br>Conv(64_,_3_,_2_,_BN_,_ReLU)<br>Conv(64_,_3_,_2_,_BN_,_ReLU)<br>Conv(64_,_3_,_2_,_BN_,_ReLU)<br>Conv(64_,_3_,_2_,_BN_,_ReLU)<br>FC(64_,_ReLU)<br>SAB(64_,_4)<br>FC(64_,_ReLU)<br>SAB(64_,_4)<br>FC(64_,_ReLU)<br>FC(64_, −_)||mean<br>PMA1(8_,_8)<br>FC(64_,_ReLU)<br>FC(1_,_softplus)<br>FC(1_,_softplus)|



The loss function we optimize, as previously mentioned, is the log likelihood log _p_ ( _x|γ_ ) = _x_ log( _γ_ ) _− γ −_ log( _x_ !). We chose this loss function over mean squared error or mean absolute error because it seemed like the more logical choice when trying to make a real number match a target integer. Early experiments showed that directly optimizing for mean absolute error had roughly the same result as optimizing _γ_ in this way and measuring _|γ − x|_ . We train using the Adam optimizer with a constant learning rate of 10 _[−]_[4] for 200,000 batches each with batch size 32. 

## **2.3. Solving maximum likelihood problems for mixture of Gaussians** 

## 2.3.1. DETAILS FOR 2D SYNTHETIC MIXTURES OF GAUSSIANS EXPERIMENT 

We generated the datasets according to the following generative process. 

1. Generate the number of data points, _n ∼_ Unif(100 _,_ 500). 

2. Generate _k_ centers. 

**==> picture [328 x 11] intentionally omitted <==**

3. Generate cluster labels. 

**==> picture [348 x 13] intentionally omitted <==**

4. Generate data from spherical Gaussian. 

**==> picture [279 x 12] intentionally omitted <==**

**Supplementary Material for Set Transformer** 

Table 4 summarizes the architectures used for the experiments. For all architectures, at each training step, we generate 10 random datasets according to the above generative process, and updated the parameters via Adam optimizer with initial learning rate 10 _[−]_[3] . We trained all the algorithms for 50 _k_ steps, and decayed the learning rate to 10 _[−]_[4] after 35 _k_ steps. Table 5 summarizes the detailed results with various number of inducing points in the ISAB. Figure **??** shows the actual clustering results based on the predicted parameters. 

_Table 4._ Detailed architectures used in 2D synthetic experiments. 

||Encoder<br>rFF<br>SAB<br>ISAB|Decoder<br>Pooling<br>PMA|
|---|---|---|
|FC(128_,_ReLU)<br>SAB(128_,_4)<br>ISAB_m_(128_,_4)<br>FC(128_,_ReLU)<br>SAB(128_,_4)<br>ISAB_m_(128_,_4)<br>FC(128_,_ReLU)<br>FC(128_,_ReLU)||mean<br>PMA4(128_,_4)<br>FC(128_,_ReLU)<br>SAB(128_,_4)<br>FC(128_,_ReLU)<br>FC(4_·_(1 + 2_·_2)_, −_)<br>FC(128_,_ReLU)<br>FC(4_·_(1 + 2_·_2)_, −_)|



_Table 5._ Average log-likelihood/data (LL0/data) and average log-likelihood/data after single EM iteration (LL1/data) the clustering experiment. The number inside parenthesis indicates the number of inducing points used in the SABs of encoder. For all PMAs, four seed vectors were used. 

|Architecture|LL0/data|LL1/data|
|---|---|---|
|Oracle|-1.4726||
|rFF + Pooling|-2.0006_±_0.0123|-1.6186_±_0.0042|
|rFFp-mean + Pooling|-1.7606_±_0.0213|-1.5191_±_0.0026|
|rFFp-max + Pooling|-1.7692_±_0.0130|-1.5103_±_0.0035|
|rFF+Dotprod|-1.8549_±_0.0128|-1.5621_±_0.0046|
|SAB + Pooling|-1.6772_±_0.0066|-1.5070_±_0.0115|
|ISAB (16) + Pooling|-1.6955_±_0.0730|-1.4742_±_0.0158|
|ISAB (32) + Pooling|-1.6353_±_0.0182|-1.4681_±_0.0038|
|ISAB (64) + Pooling|-1.6349_±_0.0429|-1.4664_±_0.0080|
|rFF + PMA|-1.6680_±_0.0040|-1.5409_±_0.0037|
|SAB + PMA|-1.5145_±_0.0046|-1.4619_±_0.0048|
|ISAB (16) + PMA|-1.5009_±_0.0068|-1.4530_±_0.0037|
|ISAB (32) + PMA|**-1.4963**_±_**0.0064**|**-1.4524**_±_**0.0044**|
|ISAB (64) + PMA|-1.5042_±_0.0158|-1.4535_±_0.0053|



## 2.3.2. 2D SYNTHETIC MIXTURES OF GAUSSIANS EXPERIMENT ON LARGE-SCALE DATA 

To show the scalability of the set transformer, we conducted additional experiments on large-scale 2D synthetic clustering dataset. We generated the synthetic data as before, except that we sample the number of data points _n_ Unif(1000 _,_ 5000) and set _k_ = 6. We report the clustering accuracy of a subset of comparing methods in Table 6. The set transformer with only 32 inducing points works extremely well, demonstrating its scalability and efficiency. 

## 2.3.3. DETAILS FOR CIFAR-100 AMORTIZED CLUTERING EXPERIMENT 

We pretrained VGG net ( **?** ) with CIFAR-100, and obtained the test accuracy 68.54%. Then, we extracted feature vectors of 50k training images of CIFAR-100 from the 512-dimensional hidden layers of the VGG net (the layer just before the last layer). Given these feature vectors, the generative process of datasets is as follows. 

1. Generate the number of data points, _n ∼_ Unif(100 _,_ 500). 

2. Uniformly sample four classes among 100 classes. 

3. Uniformly sample _n_ data points among four sampled classes. 

**Supplementary Material for Set Transformer** 

_Table 6._ Average log-likelihood/data (LL0/data) and average log-likelihood/data after single EM iteration (LL1/data) the clustering experiment on large-scale data. The number inside parenthesis indicates the number of inducing points used in the SABs of encoder. For all PMAs, six seed vectors were used. 

|used.|||
|---|---|---|
|Architecture|LL0/data|LL1/data|
|Oracle|-1.8202||
|rFF + Pooling|-2.5195_±_0.0105|-2.0709_±_0.0062|
|rFFp-mean + Pooling|-2.3126_±_0.0154|-1.9749_±_0.0062|
|rFF + PMA (6)|-2.0515_±_0.0067|-1.9424_±_0.0047|
|SAB (32) + PMA (6)|**-1.8928**_±_**0.0076**|**-1.8549**_±_**0.0024**|



_Table 7._ Detailed architectures used in CIFAR-100 meta clustering experiments. 

||Encoder<br>rFF<br>SAB<br>ISAB|Decoder<br>rFF<br>PMA|
|---|---|---|
|FC(256_,_ReLU)<br>SAB(256_,_4)<br>ISAB_m_(256_,_4)<br>FC(256_,_ReLU)<br>SAB(256_,_4)<br>ISAB_m_(256_,_4)<br>FC(256_,_ReLU)<br>SAB(256_,_4)<br>ISAB_m_(256_,_4)<br>FC(256_,_ReLU)<br>FC(256_,_ReLU)<br>FC(256_, −_)||mean<br>PMA4(128_,_4)<br>FC(256_,_ReLU)<br>SAB(256_,_4)<br>FC(256_,_ReLU)<br>SAB(256_,_4)<br>FC(256_,_ReLU))<br>FC(4_·_(1 + 2_·_512)_, −_)<br>FC(256_,_ReLU)<br>FC(256_,_ReLU)<br>FC(4_·_(1 + 2_·_512)_, −_)|



Table 7 summarizes the architectures used for the experiments. For all architectures, at each training step, we generate 10 random datasets according to the above generative process, and updated the parameters via Adam optimizer with initial learning rate 10 _[−]_[4] . We trained all the algorithms for 50 _k_ steps, and decayed the learning rate to 10 _[−]_[5] after 35 _k_ steps. Table 8 summarizes the detailed results with various number of inducing points in the ISAB. 

## **2.4. Set Anomaly Detection** 

Table 9 describes the architecture for meta set anomaly experiments. We trained all models via Adam optimizer with learning rate 10 _[−]_[4] and exponential decay of learning rate for 1,000 iterations. 1,000 datasets subsampled from CelebA dataset (see Figure **??** ) are used to train and test all the methods. We split 800 training datasets and 200 test datasets for the subsampled datasets. 

## 

We used the ModelNet40 dataset for our point cloud classification experiments. This dataset consists of a three-dimensional representation of 9,843 training and 2,468 test data which each belong to one of 40 object classes. As input to our architectures, we produce point clouds with _n_ = 100 _,_ 1000 _,_ 5000 points each (each point is represented by ( _x, y, z_ ) coordinates). For generalization, we randomly rotate and scale each set during training. 

We show results our architectures in Table 10 and additional experiments which used _n_ = 100 _,_ 5000 points in Table **??** . We trained using the Adam optimizer with an initial learning rate of 10 _[−]_[3] which we decayed by a factor of 0 _._ 3 every 20,000 steps. For the experiment with 5,000 points (Table **??** ), we increased the dimension of the attention blocks (ISAB16(512 _,_ 4) instead of ISAB16(128 _,_ 4)) and also decayed the weights by a factor of 10 _[−]_[7] . We also only used one ISAB block in the encoder because using two lead to overfitting in this setting. 

## **3. Additional Experiments** 

## **3.1. Runtime of SAB and ISAB** 

We measured the runtime of SAB and ISAB on a simple benchmark (Figure 1). We used a single GPU (Tesla P40) for this experiment. The input data was a constant (zero) tensor of _n_ three-dimensional vectors. We report the number of seconds it 

**Supplementary Material for Set Transformer** 

_Table 8._ Average clustering accuracies measured by Adjusted Rand Index (ARI) for CIFAR100 clustering experiments. The number inside parenthesis indicates the number of inducing points used in the SABs of encoder. For all PMAs, four seed vectors were used. 

|Architecture|ARI0|ARI1|
|---|---|---|
|Oracle|0.9151||
|rFF + Pooling|0.5593_±_0.0149|0.5693_±_0.0171|
|rFFp-mean + Pooling|0.5673_±_0.0053|0.5798_±_0.0058|
|rFFp-max + Pooling|0.5369_±_0.0154|0.5536_±_0.0186|
|rFF+Dotprod|0.5666_±_0.0221|0.5763_±_0.0212|
|SAB + Pooling|0.5831_±_0.0341|0.5943_±_0.0337|
|ISAB (16) + Pooling|0.5672_±_0.0124|0.5805_±_0.0122|
|ISAB (32) + Pooling|0.5587_±_0.0104|0.5700_±_0.0134|
|ISAB (64) + Pooling|0.5586_±_0.0205|0.5708_±_0.0183|
|rFF + PMA|0.7612_±_0.0237|0.7670_±_0.0231|
|SAB + PMA|0.9015_±_0.0097|0.9024_±_0.0097|
|ISAB (16) + PMA|**0.9210**_±_**0.0055**|**0.9223**_±_**0.0056**|
|ISAB (32) + PMA|0.9103_±_0.0061|0.9119_±_0.0052|
|ISAB (64) + PMA|0.9141_±_0.0040|0.9153_±_0.0041|



_Table 9._ Detailed architectures used in CelebA meta set anomaly experiments. Conv( _d, k, s, r, f_ ) is a convolutional layer with _d_ output channels, _k_ kernel size, _s_ stride size, _r_ regularization method, and activation function _f_ . If _d_ is a list, each element in the list is distributed. FC( _d, f, r_ ) denotes a fully-connected layer with _d_ units, activation function _f_ and _r_ regularization method. If _d_ is a list, each element in the list is distributed. SAB( _d, h_ ) denotes the SAB with _d_ units and _h_ heads. PMA( _d, h, n_ seed) denotes the PMA with _d_ units, _h_ heads and _n_ seed vectors. All MABs used in SAB and PMA uses FC layers with ReLU activations for rFF layers. 

||Encoder<br>rFF<br>SAB|Decoder<br>Pooling<br>PMA|
|---|---|---|
|Conv([32_,_64_,_128]_,_3_,_2_,_Dropout_,_ReLU)<br>FC([1024_,_512_,_256]_, −,_Dropout)<br>FC(256_, −, −_)<br>FC([128_,_128_,_128]_,_ReLU_, −_)<br>SAB(128_,_4)<br>FC([128_,_128_,_128]_,_ReLU_, −_)<br>SAB(128_,_4)<br>FC(128_,_ReLU_, −_)<br>SAB(128_,_4)<br>FC(128_, −, −_)<br>SAB(128_,_4)||mean<br>PMA4(128_,_4)<br>FC(128_,_ReLU_, −_)<br>SAB(128_,_4)<br>FC(128_,_ReLU_, −_)<br>FC(256_·_8_, −, −_)<br>FC(128_,_ReLU_, −_)<br>FC(256_·_8_, −, −_)|



took to process 10,000 sets of each size. The maximum set size we report for SAB is 2,000 because the computation graph of bigger sets could not fit on our GPU. The specific attention blocks used are ISAB4(64 _,_ 8) and SAB(64 _,_ 8). 

**Supplementary Material for Set Transformer** 

_Table 10._ 

||Encoder<br>rFF<br>ISAB|Decoder<br>Pooling<br>PMA|
|---|---|---|
|FC(256_,_ReLU)<br>ISAB(256_,_4)<br>FC(256_,_ReLU)<br>ISAB(256_,_4)<br>FC(256_,_ReLU)<br>FC(256_, −_)||max<br>Dropout(0_._5)<br>Dropout(0_._5)<br>PMA1(256_,_4)<br>FC(256_,_ReLU)<br>Dropout(0_._5)<br>Dropout(0_._5)<br>FC(40_, −_)<br>FC(40_, −_)|



**==> picture [390 x 293] intentionally omitted <==**

_Figure 1._ Runtime of a single SAB/ISAB block on dummy data. x axis is the size of the input set and y axis is time (seconds). Note that the x-axis is log-scale. 

