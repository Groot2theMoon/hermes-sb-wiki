---
title: "Almost-Orthogonal Layers for Efficient General-Purpose Lipschitz Networks"
arxiv: "2208.03160"
authors: ["Bernd Prach", "Christoph H. Lampert"]
year: 2022
source: paper
ingested: 2026-05-02
sha256: 1eb135120685330415d92831e58c7f398bd011120e33ab0071145a9e40d15c87
conversion: pymupdf4llm
---

# ALMOST-ORTHOGONAL LAYERS FOR EFFICIENT GENERAL-PURPOSE LIPSCHITZ NETWORKS 

**Bernd Prach, Christoph H. Lampert** 

Institute of Science and Technology Austria (ISTA) 

```
{bprach,chl}@ist.ac.at
```

## **ABSTRACT** 

It is a highly desirable property for deep networks to be robust against small input changes. One popular way to achieve this property is by designing networks with a small Lipschitz constant. In this work, we propose a new technique for constructing such _Lipschitz networks_ that has a number of desirable properties: it can be applied to any linear network layer (fully-connected or convolutional), it provides formal guarantees on the Lipschitz constant, it is easy to implement and efficient to run, and it can be combined with any training objective and optimization method. In fact, our technique is the first one in the literature that achieves all of these properties simultaneously. 

Our main contribution is a rescaling-based weight matrix parametrization that guarantees each network layer to have a Lipschitz constant of at most 1 and results in the learned weight matrices to be close to orthogonal. Hence we call such layers _almost-orthogonal Lipschitz (AOL)_ . 

Experiments and ablation studies in the context of image classification with certified robust accuracy confirm that AOL layers achieve results that are on par with most existing methods. Yet, they are simpler to implement and more broadly applicable, because they do not require computationally expensive matrix orthogonalization or inversion steps as part of the network architecture. 

We provide code at `https://github.com/berndprach/AOL` . 

_**K**_ **eywords** Lipschitz networks, orthogonality, robustness 

## **1 Introduction** 

Deep networks are often the undisputed state of the art when it comes to solving computer vision tasks with high accuracy. However, the resulting systems tend to be not very _robust_ , e.g., against small changes in the input data. This makes them untrustworthy for safety-critical high-stakes tasks, such as autonomous driving or medical diagnosis. 

A typical example of this phenomenon are _adversarial examples_ [1]: imperceptibly small changes to an image can drastically change the outputs of a deep learning classifier when chosen in an adversarial way. Since their discovery, numerous methods were developed to make networks more robust against adversarial examples. However, in response a comparable number of new attack forms were found, leading to an ongoing cat-and-mouse game. For surveys on the state of research, see, e.g., [2, 3, 4]. 

A more principled alternative is to create deep networks that are robust by design, for example, by restricting the class of functions they can represent. Specifically, if one can ensure that a network has a small _Lipschitz constant_ , then one knows that small changes to the input data will not result in large changes to the output, even if the changes are chosen adversarially. 

A number of methods for designing such _Lipschitz networks_ have been proposed in the literature, which we discuss in Section 3. However, all of them have individual limitations. In this work, we introduce the AOL (for _almost-orthogonal Lipschitz_ ) method. It is the first method for constructing Lipschitz networks that simultaneously meets all of the following desirable criteria: 

Almost-Orthogonal Layers for Efficient General-Purpose Lipschitz Networks 

**Generality.** AOL is applicable to a wide range of network architectures, in particular most kinds of fully-connected and convolutional layers. In contrast, many recent methods work only for a restricted set of layer types, such as only fully-connected layers or only convolutional layers with non-overlapping receptive fields. 

**Formal guarantees.** AOL provably guarantees a Lipschitz constant 1. This is in contrast to methods that only encourage small Lipschitz constants, e.g., by regularization. 

**Efficiency.** AOL causes only a small computational overhead at training time and none at all at prediction time. This is in contrast to methods that embed expensive iterative operations such as matrix orthogonalization or inversion steps into the network layers. 

**Modularity.** AOL can be treated as a black-box module and combined with arbitrary training objective functions and optimizers. This is in contrast to methods that achieve the Lipschitz property only when combined with, e.g., specific loss-rescaling or projection steps during training. 

AOL’s name stems from the fact that the weight matrices it learns are approximately orthogonal. In contrast to prior work, this property is not enforced explicitly, which would incur a computational cost. Instead, almost-orthogonal weight matrices emerge organically during network training. The reason is that AOL’s rescaling step relies on an upper bound to the Lipschitz constant that is tight for parameter matrices with orthogonal columns. During training, matrices without that property are put at the disadvantage of resulting in outputs of smaller dynamic range. As a consequence, orthogonal matrices are able to achieve smaller values of the loss and are therefore preferred by the optimizer. 

## **2 Notation and Background** 

A function _f_ : R _[n] →_ R _[m]_ is called _L-Lipschitz continuous_ with respect to norms _∥.∥_ R _n_ and _∥.∥_ R _m_ , if it fulfills 

**==> picture [305 x 11] intentionally omitted <==**

for all _x_ and _y_ , where _L_ is called the _Lipschitz constant_ . In this work we only consider Lipschitz-continuity with respect to the Euclidean norm, _∥.∥_ 2, and mainly for _L_ = 1. For conciseness of notation, we refer to such 1-Lipschitz continuous functions simply as _Lipschitz functions_ . 

For any linear (actually affine) function _f_ , the Lipschitz property can be verified by checking if the function’s Jacobian matrix, _Jf_ , has _spectral norm ∥Jf ∥_ spec less or equal to 1, where 

**==> picture [344 x 24] intentionally omitted <==**

The spectral norm of a matrix _M_ can in fact be computed numerically as it is identical to the largest singular value of the matrix. This, however, typically requires iterative algorithms that are computationally expensive in high-dimensional settings. An exception is if _M_ is an orthogonal matrix, i.e. _M[⊤] M_ = _I_ , for _I_ the identity matrix. In that case we know that all its singular values are 1 and _∥Mv∥_ 2 = _∥v∥_ 2 for all _v_ , so the corresponding linear transformation is Lipschitz. 

Throughout this work we consider a deep neural network as a concatenation of linear layers (fully-connected or convolutional) alternating with non-linear activation functions. We then study the problem how to ensure that the resulting network function is Lipschitz. 

It is known that computing the exact Lipschitz constant of a neural network is an NP-hard problem [5]. However, upper bounds can be computed more efficiently, e.g., by multiplying the individual Lipschitz constants of all layers. 

## **3 Related work** 

The first attempts to train deep networks with small Lipschitz constant used ad-hoc techniques, such as weight clipping [6] or regularizing either the network gradients [7] or the individual layers’ spectral norms [8]. However, these techniques do not formally guarantee bounds on the Lipschitz constant of the trained network. Formal guarantees are provided by constructions that ensure that each individual network layer is Lipschitz. Combined with Lipschitz activation functions, such as ReLU, MaxMin or tanh, this ensures that the overall network function is Lipschitz. 

In the following, we discuss a number of prior methods for obtaining Lipschitz networks. A structured overview of their properties can be found in Table 1. 

2 

Almost-Orthogonal Layers for Efficient General-Purpose Lipschitz Networks 

Table 1: Overview of the properties of different methods for learning Lipschitz networks. Columns indicate: _E (efficiency)_ : no internal iterative procedure required, scales well with the input size. _F (formal guarantees)_ : provides a guarantee about the Lipschitz constant of the trained network. _G (generality)_ : can be applied to fully-connected as well as convolutional layers. _M (modularity)_ : can be used with any training objective and optimization method. _∼_ symbols indicate that a property is partially fulfilled. Superscripts provide further explanations:[1] requires a regularization loss.[2] internal methods would have to be run to convergence.[3] iterative procedure that can be split between training steps.[4] requires matrix orthogonalization.[5] requires inversion of an input-sized matrix.[6] requires circular padding and full-image kernel size.[7] requires large kernel sizes to ensure orthogonality. 

|Method<br>E<br>F<br>G<br>M<br>Methodology|Method<br>E<br>F<br>G<br>M<br>Methodology|
|---|---|
|||
|WGAN [6]<br>WGAN-GP [7]<br>Parseval Networks [9]<br>OCNN [10]<br>SN [8]<br>LCC [11]<br>LMT [12]<br>GloRo [13]<br>BCOP [14]<br>GroupSort[15]<br>ONI [16]<br>Cayley Convs [17]<br>SOP [18]<br>ECO [19]<br>AOL(proposed)|✓<br>✓<br>✓<br>✗<br>weight clipping<br>✓<br>✗<br>✓<br>_∼_1<br>regularization<br>✓<br>✗<br>✓<br>_∼_1<br>regularization<br>✓<br>✗<br>✓<br>_∼_1<br>regularization<br>✗<br>_∼_2<br>✓<br>✓<br>parameter rescaling<br>✗<br>_∼_2<br>✓<br>✗<br>parameter rescaling<br>_∼_3<br>✗<br>✓<br>✗<br>loss rescaling<br>_∼_3<br>_∼_2<br>✓<br>✗<br>loss rescaling<br>✗4<br>✓<br>✓<br>✓<br>explicit orthogonalization<br>✗4<br>_∼_2<br>✗<br>✓<br>explicit orthogonalization<br>✗<br>_∼_2<br>✓<br>✓<br>explicit orthogonalization<br>_∼_5<br>✓<br>_∼_6<br>✓<br>explicit orthogonalization<br>✗<br>_∼_2<br>_∼_7<br>✓<br>explicit orthogonalization<br>✗4<br>✓<br>_∼_6<br>✓<br>explicit orthogonalization<br>✓<br>✓<br>✓<br>✓<br>parameter rescaling|



## **3.1 Bound-based methods** 

The Lipschitz property of a network layer could be achieved trivially: one simply computes the layer’s Lipschitz constant, or an upper bound, and divides the layer weights by that value. Applying such a step after training, however, does not lead to satisfactory results in practice, because the dynamic range of the network outputs is reduced by the product of the scale factors. This can be seen as a reduction of network capacity that prevents the network from fitting the training data well. Instead, it makes sense to incorporate the Lipschitz condition already at training time, such that the optimization can attempt to find weight matrices that lead to a network that is not only Lipschitz but also able to fit the data well. 

The _Lipschitz Constant Constraint (LCC)_ method [11] identifies all weight matrices with spectral norm above a threshold _λ_ after each weight update and rescales those matrices to have a spectral norm of exactly _λ_ . _Lipschitz Margin Training (LMT)_ [12] and _Globally-Robust Neural Networks (GloRo)_ [13] approximate the overall Lipschitz constant from numeric estimates of the largest singular values of the layers’ weight matrices. They integrate this value as a scale factor into their respective loss functions. 

In the context of deep learning, controlling only the Lipschitz constant of each layer separately has some drawbacks. In particular, the product of the individual Lipschitz constants might grossly overestimate the network’s actual Lipschitz constant. The reason is that the Lipschitz constant of a layer is determined by a single vector direction of maximal expansion. When concatenating multiple layers, their directions of maximal expansion will typically not be aligned, especially with in between nonlinear activations. As a consequence, the actual maximal amount of expansion will be smaller than the product of the per-layer maximal expansions. This causes the variance of the activations to shrink during the forward pass through the network, even though in principle a sequence of 1-Lipschitz operations could perfectly preserve it. Analogously, the magnitude of the gradient signal shrinks with each layer during the backwards pass of backpropagation training, which can lead to vanishing gradient problems. 

## **3.2 Orthogonality-based method** 

A way to address the problems of variance-loss and vanishing gradients is to use network layers that encode _orthogonal_ linear operations. These are 1-Lipschitz, so the overall network will also have that property. However, they are also _isotropic_ , in the sense that they preserve data variance and gradient magnitude in all directions, not just a single one. 

3 

Almost-Orthogonal Layers for Efficient General-Purpose Lipschitz Networks 

For fully-connected layers, it suffices to ensure that the weight matrices themselves are orthogonal. The _GroupSort_ [15] architecture achieves this using classic results from numeric analysis [20]. The authors parameterize an orthogonal weight matrix as a specific matrix power series, which they embed in truncated form into the network architecture. _Orthogonalization by Newton’s Iterations (ONI)_ [16] parameterizes orthogonal weight matrices as � _V V[⊤]_[�] _[−]_[1] _[/]_[2] _V_ for a general parameter matrix _V_ . As an approximate representation of the inverse operation the authors embed a number of steps of Newton’s method into the network. Both methods, GroupSort and ONI, have the shortcoming that their orthogonalization schemes require the application of iterative computation schemes which incur a trade-off between the approximation quality and the computational cost. 

For convolutional layers, more involved constructions are required to ensure that the resulting linear transformations are orthogonal. In particular, enforcing orthogonal kernel matrices is not sufficient in general to ensure a Lipschitz constant of 1 when the convolutions have overlapping receptive fields. 

_Skew Orthogonal Convolutions (SOC)_ [18] parameterize orthogonal matrices as the matrix exponentials of skewsymmetric matrices. They embed a truncation of the exponential’s power series into the network and bound the resulting error. However, SOC requires a rather large number of iterations to yield good approximation quality, which leads to high computational cost. 

_Block Convolutional Orthogonal Parameterization (BCOP)_ [14] relies on a matrix decomposition approach to address the problem of orthogonalizing convolutional layers. The authors parameterize each convolution kernel of size _k × k_ by a set of 2 _k −_ 1 convolutional matrices of size 1 _×_ 2 or 2 _×_ 1. These are combined with a final pointwise convolution with orthogonal kernel. However, BCOP also incurs high computation cost, because each of the smaller transforms requires orthogonalizing a corresponding parameter matrix. 

_Cayley Layers_ parameterize orthogonal matrices using the Cayley transform [21]. Naively, this requires the inversion of a matrix of size quadratic in the input dimensions. However, in [17] the author demonstrate that in certain situations, namely for full image size convolutions with circular padding, the computations can be performed more efficiently. 

_Explicitly Constructed Orthogonal Convolutions_ (ECO) [19] rely on a theorem that relates the singular values of the Jacobian of a circular convolution to the singular values of a set of much smaller matrices [22]. The authors derive a rather efficient parameterization that, however, is restricted to full-size dilated convolutions with non-overlapping receptive fields. 

The main shortcomings of Cayley layers and ECO are their restriction to certain full-size convolutions. Those are incompatible with most well-performing network architectures for high-dimensional data, which use local kernel convolutions, such as 3 _×_ 3, and overlapping receptive fields. 

## **3.3 Relation to AOL** 

The AOL method that we detail in Section 4 can be seen as a hybrid of bound-based and orthogonality-based approaches. It mathematically guarantees the Lipschitz property of each network layer by rescaling the corresponding parameter matrix (column-wise for fully-connected layers, channel-wise for convolutions). In contrast to other bound-based approaches it does not use a computationally expensive iterative approach to estimate the Lipschitz constant as precisely as possible, but it relies on a closed-form upper bound. The bound is tight for matrices with orthogonal columns. During training this has the effect that orthogonal parameter matrices are implicitly preferred by the optimizer, because they allow fitting the data, and therefore minimizing the loss, the best. Consequently, AOL benefits from the advantages of orthogonality-based approaches, such as preserving the variance of the activations and the gradient magnitude, without the other methods’ shortcomings of requiring difficult parameterizations and being restricted to specific layer types. 

## **4 Almost-Orthogonal Lipschitz (AOL) Layers** 

In this section, we introduce our main contribution, almost-orthogonal Lipschitz (AOL) layers, which combine the advantages of rescaling and orthogonalization approaches. Specifically, we introduce a weight-dependent rescaling technique for the weights of a linear neural network layer that guarantees the layer to be 1-Lipschitz. It can be easily computed in closed form and is applicable to fully-connected as well as convolutional layers. 

The main ingredient is the following theorem, which provides an elementary formula for controlling the spectral norm of a matrix by rescaling its columns. 

_−_ 1 _/_ 2 **Theorem 1.** _For any matrix P ∈_ R _[n][×][m] , define D ∈_ R _[m][×][m] as the diagonal matrix with Dii_ = �� _j_ �� _P ⊤P_ �� _ij_ � _if the expression in the brackets is non-zero, or Dii_ = 0 _otherwise. Then the spectral norm of PD is bounded by_ 1 _._ 

4 

Almost-Orthogonal Layers for Efficient General-Purpose Lipschitz Networks 

_Proof._ The upper bound of the spectral norm of _PD_ follows from an elementary computation. By definition of the spectral norm, we have 

**==> picture [345 x 19] intentionally omitted <==**

We observe that for any symmetric matrix _M ∈_ R _[n][×][n]_ and any _w ∈_ R _[n]_ : 

**==> picture [396 x 29] intentionally omitted <==**

where the second inequality follows from the general relation 2 _ab ≤ a_[2] + _b_[2] . Evaluating (4) for _M_ = _P[⊤] P_ and _⃗w_ = _D⃗v_ , we obtain for all _⃗v_ with _∥⃗v∥_ 2 = 1 

**==> picture [359 x 29] intentionally omitted <==**

which proves the bound. 

Note that when _P_ has orthogonal columns of full rank, we have that _P[⊤] P_ is diagonal and _D_ = ( _P[⊤] P_ ) _[−]_[1] _[/]_[2] , so _D[⊤] P[⊤] PD_ = _I_ , for _I_ the identity matrix. Consequently, (5) holds with equality and the bound in Theorem 1 is tight. 

In the rest of this section, we demonstrate how Theorem 1 allows us to control the Lipschitz constant of any linear layer in a neural network. 

## **4.1 Fully-Connected Lipschitz Layers** 

We first discuss the case of fully-connected layers. 

**Lemma 1** (Fully-Connected AOL Layers) **.** _Let P ∈_ R _[n][×][m] be an arbitrary parameter matrix. Then, the fully-connected network layer_ 

**==> picture [268 x 11] intentionally omitted <==**

_is guaranteed to be 1-Lipschitz, when W_ = _PD for D defined as in Theorem 1._ 

_Proof._ The Lemma follows from Theorem 1, because the Lipschitz constant of _f_ is bounded by the spectral norm of its Jacobian matrix, which is simply _W_ . 

**Discussion.** Despite its simplicity, there are a number aspects of Lemma 1 that are worth a closer look. First, we observe that a layer of the form _f_ ( _x_ ) = _PDx_ + _b_ can be interpreted in two ways, depending on how we (mentally) put brackets into the linear term. In the form _f_ ( _x_ ) = _P_ ( _Dx_ ) + _b_ , we apply an arbitrary weight matrix to a suitably rescaled input vector. In the form _f_ ( _x_ ) = ( _PD_ ) _x_ + _b_ , we apply a column-rescaling operation to the weight matrix before applying it to the unchanged input. The two views highlight different aspects of AOL. The first view reflects the flexibility and high capacity of learning with an arbitrary parameter matrix, with only an intermediate rescaling operation to prevent the growth of the Lipschitz constant. The second view shows that AOL layers can be implemented without any overhead at prediction time, because the rescaling factors can be absorbed in the parameter matrix itself, even preserving potential structural properties such as sparsity patterns. 

As a second insight from Lemma 1 we obtain how AOL relates to prior methods that rely on orthogonal weight matrices. As derived after Theorem 1, if the parameter matrix, _P_ , has orthogonal columns of full rank, then _W_ = _PD_ is an orthogonal weight matrix. In particular, when _P_ is already an orthonormal matrix, then _D_ will be the identity matrix, and _W_ will be equal to _P_ . Therefore, our method can express any linear map based on an orthonormal matrix, but it can also express other linear maps. If the columns of _P_ are approximately orthogonal, in the sense that _P[⊤] P_ is approximately diagonal, then the entries of _D_ are dominated by the diagonal entries of the product. The multiplication by _D_ acts mostly as a normalization of the length of the columns of _P_ , and the resulting _W_ is an almost-orthogonal matrix. 

Finally, observe that Lemma 1 does not put any specific numeric or structural constraints on the parameter matrix. Consequently, there are no restrictions on the optimizer or objective function when training AOL-networks. 

5 

Almost-Orthogonal Layers for Efficient General-Purpose Lipschitz Networks 

## **4.2 Convolutional Lipschitz Layers** 

An analog of Lemma 1 for convolutional layers can, in principle, be obtained by applying the same construction as above: convolutions are linear operations, so we could compute their Jacobian matrix and determine an appropriate rescaling matrix from it. However, this naive approach would be inefficient, because it would require working with matrices that are of a size quadratic in the number of input dimensions and channels. Instead, by a more refined analysis, we obtain the following result. 

**Lemma 2** (Convolutional AOL Layers) **.** _Let P ∈_ R _[k][×][k][×][c][I][×][c][O] , be a convolution kernel matrix, where k × k is the_ kernel size _and cI and cO are the number of input and output channels, respectively. Then, the convolutional layer_ 

**==> picture [279 x 11] intentionally omitted <==**

_is guaranteed to be 1-Lipschitz, where R_ ( _x_ ) _is a channel-wise rescaling that multiplies each channel c ∈{_ 1 _, . . . , cI } of the input by_ 

**==> picture [326 x 30] intentionally omitted <==**

_We can equivalently write f as f_ ( _x_ ) = _W ∗ x_ + _b, where W_ = _P ∗ D with D ∈_ R[1] _[×]_[1] _[×][c][I][×][c][I] given by D_ 1[(] _[c,c] ,_ 1[)] = _dc, and D_ 1[(] _[c] ,_ 1[1] _[,c]_[2][)] = 0 _for c_ 1 = _c_ 2 _._ 

The proof consists of an explicit derivation of the Jacobian of the convolution operation as a linear map, followed by an application of Theorem 1. The main step is the explicit demonstration that the diagonal rescaling matrix can in fact be bounded by a per-channel multiplication with the result of a self-convolution of the convolution kernel. The details can be found in the appendix. 

**Discussion.** We now discuss some favorable properties of Lemma 2. First, as in the fully-connected case, the rescaling operation again can be viewed either as acting on the inputs, or as acting on the parameter matrix. Therefore, the convolutional layer also combines the properties of high capacity and no overhead at prediction time. In fact, for 1 _×_ 1 convolutions, the construction of Lemma 2 reduces to the fully-connected situation of Lemma 1. 

Second, computing the scaling factors is efficient, because the necessary operations scale only with the size of the convolution kernel regardless of the image size. The rescaling preserves the structure of the convolution kernel, e.g. sparsity patterns. In particular, this means that constructs such as dilated convolutions are automatically covered by Lemma 2 as well, as these can be expressed as ordinary convolutions with specific zero entries. 

Furthermore, Lemma 2 requires no strong assumption on the padding type, and works as long as the padding itself is 1-Lipschitz. Also, the computation of the scale factors is easy to implement in all common deep learning frameworks using batch-convolution operations with the input channel dimension taking the role of the batch dimension. 

## **5 Experiments** 

We compare our method to related work in the context of _certified robust accuracy_ , where the goal is to solve an image classification task in a way that provably prevents _adversarial examples_ [1]. Specifically, we consider an input _x_ as _certifiably robustly classified_ by a model under input perturbations up to size _ϵ_ , if _x_ + _δ_ is correctly classified for all _δ_ with _∥δ∥≤ ϵ_ . Then the _certified robust accuracy_ of a classifier is the proportion of the test set that is certifiably robustly classified. 

Consider a function _f_ that generates a score for each class. Define the _margin_ of _f_ at input _x_ with correct label _y_ as 

**==> picture [368 x 18] intentionally omitted <==**

Then the induced classifier, _Cf_ ( _x_ ) = argmax _i f_ ( _x_ ) _i_ , certifiably robustly classifies an input _x_ if _Mf_ ( _x_ ) _> √_ 2 _Lϵ_ , where _L_ is the Lipschitz constant _L_ of _f_ . This relation can be used to efficiently determine (a lower bound to) the certified robust accuracy of Lipschitz networks [12]. 

Following prior work in the field, we conduct experiments that evaluate the certified robust accuracy for different thresholds, _ϵ_ , on the CIFAR-10 as well as the CIFAR-100 dataset. We also provide ablation studies that illustrate that AOL can be used in a variety of network architectures, and that it indeed learns matrices that are approximately orthogonal. In the following we describe our experimental setup. Further details can be found in the appendix. All hyperparameters were determined on validation sets. 

6 

Almost-Orthogonal Layers for Efficient General-Purpose Lipschitz Networks 

Table 2: Patchwise architecture. For all layers we use zero padding to keep the size the same. For AOL-Small we set _w_ to 16, and we choose _w_ = 32 and _w_ = 48 for AOL-Medium and AOL-Large. Furthermore, _l_ is the number of classes, and _l_ = 10 for CIFAR-10 and _l_ = 100 for CIFAR-100. _Concatenation Pooling_ stacks all the inputs into a single vector, and _First channels_ just selects the first channels and ignores the rest. 

|Layer name|Kernel size|Stride|Activation|Output size|Amount|
|---|---|---|---|---|---|
|Concatenation Pooling|4_×_4|4_×_4|-|8_×_8_×_48|1|
|AOL Conv|1_×_1|1_×_1|MaxMin|8_×_8_×_192|1|
|AOL Conv|3_×_3|1_×_1|MaxMin|8_×_8_×_192|12|
|AOL Conv|1_×_1|1_×_1|None|8_×_8_×_192|1|
|First Channels|-|-|-|8_×_8_× w_|1|
|Flatten|-|-|-|64_w_|1|
|AOL FC|-|-|MaxMin|64_w_|13|
|AOL FC|-|-|None|64_w_|1|
|First Channels|-|-|-|_l_|1|



_Architecture:_ Our main model architecture is loosely inspired by the _ConvMixer_ architecture [23]: we first subdivide the input image into 4 _×_ 4 patches, which are processed by 14 convolutional layers, most of kernel size 3 _×_ 3. This is followed by 14 fully connected layers. We report results for three different model sizes, we will refer to the models as AOL-Small, AOL-Medium and AOL-Large. We use the MaxMin activation function [24, 15]. The full architectural details can be found in Table 2. 

Other network architectures are discussed in an ablation study in Section 6.1. 

_Initialization:_ In order to ensure stable training we initialize the parameter matrices so that our bound is tight. In particular, for layers preserving the size between input and output (e.g. the 3 _×_ 3 convolutions) we initialize the parameter matrix so that the Jacobian is the identity matrix. For any other layers we initialize the parameter matrix so that it has random orthogonal columns. 

_Loss function:_ In order to train the network to achieve good certified robust accuracy we want the score of the correct class to be bigger than any other score by a margin. We use a loss function similar to the one proposed for _Lipschitzmargin training_ [12] with a temperature parameter that helps encouraging a margin during training. Our loss function takes as input the model’s logit vector, _⃗s_ , as well as a one-hot encoding _⃗y_ of the true label as input, and is given by 

**==> picture [337 x 21] intentionally omitted <==**

for some offset _u_ and some temperature _t_ . For our experiments, we use _u_ = _√_ 2, which encourages the model to learn to classify the training data certifiably robustly to perturbations of norm 1. Furthermore we use temperature _t_ = 1 _/_ 4, which causes the gradient magnitude to stay close to 1 as long as a training example is classified with margin less than 1 _/_ 2. 

_Optimization:_ We minimize the loss function (10) using SGD with Nesterov momentum of 0.9 for 1000 epochs. The batch size is 250. The learning rate starts at 10 _[−]_[3] and is reduced by a factor of 10 at epochs 900 _,_ 990 and 999. As data augmentation we use spatial transformations (rotations and flipping) as well as some color transformation. The details are provided in the appendix. For all AOL layers we also use weight decay with coefficient 5 _×_ 10 _[−]_[4] . 

## **6 Results** 

The main results can be found in Table 3 and Table 4, where we compare the certified robust accuracy of our method to those reported in previous works on orthogonal networks and other networks with bounded Lipschitz constant. For methods that are presented in multiple variants, such as different networks depths, we include the variant for which the authors list results for large values of _ϵ_ . 

The table shows that our proposed method achieves results comparable with the current state-of-the-art. For small robustness thresholds, it achieves certified robust accuracy slightly higher than published earlier methods, and compareable to the one reported in a concurrent preprint [25]. Focusing on (more realistic) medium or higher robustness thresholds, AOL achieves certified robust accuracy comparable to or even higher than all other methods. As a reference 

7 

Almost-Orthogonal Layers for Efficient General-Purpose Lipschitz Networks 

Table 3: Experimental results: robust image classification on CIFAR-10 for AOL and methods from the literature. We report the standard accuracy on the test set as well as the certified robust accuracy under input perturbations up to size _ϵ_ for different values of _ϵ_ . Results for concurrent unpublished works (ECO and SOC with Householder activations) are printed in italics. _Standard CNN_ refers to our implementation of a simple convolutional network trained without enforcing any robustness, for details see the appendix. 

|Method|Standard|Certifed|Certifed|Robust Accuracy|Robust Accuracy|Robust Accuracy|
|---|---|---|---|---|---|---|
||Accuracy|_ϵ_=<br>36<br>255|_ϵ_=|72<br>255|_ϵ_= 108<br>255|_ϵ_= 1|
|Standard CNN|83.4%|0%|0%||0%|0%|
|BCOP Large [14]|72.2%|58.3%|-||-|-|
|GloRo 6C2F [13]|77.0%|58.4%|-||-|-|
|Cayley Large [17]|75.3%|59.2%|-||-|-|
|SOC-20 [18]|76.4%|61.9%|-||-|-|
|_ECO-30 [19]_|_72.5%_|_55.5%_|-||-|-|
|_SOC-15 + CR [25]_|_76.4%_|_63.0%_|_48.5%_||_35.5%_|-|
|AOL-Small|69.8%|62.0%|54.4%||47.1%|21.8%|
|AOL-Medium|71.1%|63.8%|56.1%||48.6%|23.2%|
|AOL-Large|71.6%|64.0%|56.4%||49.0%|23.7%|



Table 4: Experimental results: robust image classification on CIFAR-100 for AOL and methods from the literature. We report the standard accuracy on the test set as well as the certified robust accuracy under input perturbations up to size _ϵ_ for different values of _ϵ_ . Results for concurrent unpublished works (ECO and SOC with Householder activations) are printed in italics. 

|Method|Standard|Certifed Robust Accuracy|Certifed Robust Accuracy|Certifed Robust Accuracy|Certifed Robust Accuracy|
|---|---|---|---|---|---|
||Accuracy|_ϵ_=<br>36<br>255|_ϵ_=<br>72<br>255|_ϵ_= 108<br>255|_ϵ_= 1|
|SOC-30 [18]|43.1%|29.2%|-|-|-|
|_ECO-30 [19]_|_40.0%_|_25.4%_|-|-|-|
|_SOC+CR [25]_|_47.8%_|_34.8%_|_23.7%_|_15.8%_|-|
|AOL-Small|42.4%|32.5%|24.8%|19.2%|6.7%|
|AOL-Medium|43.2%|33.7%|26.0%|20.2%|7.2%|
|AOL-Large|43.7%|33.7%|26.3%|20.7%|7.8%|



for future work, we also report values for an even higher robustness threshold than what appeared in the literature so far, _ϵ_ = 1. 

Another observation is that on the CIFAR-10 dataset the clean accuracy of AOL is somewhat below other methods. We attribute this to the fact that we mainly focused our training towards high robustness. The accuracy-robustness trade-off can in fact be influenced by the choice of margin at training time, see our ablation study in Section 6.1. 

## **6.1 Ablation Studies** 

In this section we report on a number of ablation studies that shed light on specific aspect of AOL. 

_Generality:_ One of the main advantages of AOL is that it is not restricted to a specific architecture or a specific layer type. To demonstrate this, we present additional experiments for a broad range of other architectures. AOL-FC consists simply of 9 fully connected layers. AOL-STD resembles a standard convolutional architecture, where the number of channels doubles whenever the resolution is reduced. AOL-ALT is another convolutional architecture that keeps the number of activations constant wherever possible in the network. AOL-DIL resembles the architectures used in [19] in that it uses large dilated convolutions instead of small local ones. It also uses circular padding. The details of the architectures are provided in the appendix. 

The results (shown in the appendix) confirm that for any of these architectures, we can train AOL-based Lipschitz networks and achieve certified robust accuracy comparable to the results of earlier specialized methods. 

8 

Almost-Orthogonal Layers for Efficient General-Purpose Lipschitz Networks 

**==> picture [458 x 132] intentionally omitted <==**

**----- Start of picture text -----**<br>
AOL - Center crop AOL - Zoom 1 AOL - Zoom 2<br> 2e-07<br>Zoom 1 0.8 0.8<br> 1e-07<br>0.6 0.6<br>Zoom 2<br> 0<br>0.4 0.4<br>0.2 0.2  -1e-07<br>0.0 0.0<br>**----- End of picture text -----**<br>


Figure 1: Evaluation of the orthogonality of the trained model. We consider the third layer of the AOL-Small model. It is a 3 _×_ 3 convolutions with input size 8 _×_ 8 _×_ 192. We show a center crop of _J[⊤] J_ , for _J_ the Jacobian, as well as two further crops. Note that most diagonal elements are close to 1, and most off-diagonal elements are very close to 0 (note the different color scale in the third subplot). This confirms that AOL did indeed learn an almost-orthogonal weight matrix. Best viewed in color and zoomed in. 

Table 5: Experimental results for AOL-Small for different value of _u_ and _t_ in the loss function in Equation (10). We report the standard accuracy on the test set as well as the certified robust accuracy under input perturbations up to size _ϵ_ for different values of _ϵ_ . 

|_u_|_t_|Standard|Certifed robust accuracy|Certifed robust accuracy|Certifed robust accuracy|Certifed robust accuracy|
|---|---|---|---|---|---|---|
|||Accuracy|_ϵ_=<br>36<br>255|_ϵ_=<br>72<br>255|_ϵ_= 108<br>255|_ϵ_= 1|
|~~_√_~~<br>2_/_16|1_/_64|79.8%|45.3%|16.7%|3.3%|0.0%|
|_√_<br>2_/_4|1_/_16|77.4%|63.0%|47.6%|33.0%|2.5%|
|_√_<br>2|1_/_4|70.4%|62.6%|55.0%|47.9%|22.2%|
|4<br>_√_<br>2|1|59.8%|55.5%|50.9%|46.5%|30.8%|
|16<br>_√_<br>2|4|48.2%|45.2%|42.2%|39.4%|28.6%|



_Approximate Orthogonality:_ As a second ablation study, we demonstrate that AOL indeed learns almost-orthogonal weight matrices, thereby justifying its name. In order to do that, we evaluate _J[⊤] J_ for _J_ the Jacobian of an AOL convolution, and visualize it in Figure 1. More detailed results including a comparison to standard training are provided in the appendix. 

_Accuracy-Robustness Tradeoff:_ The loss function in Equation (10) allows trading off between clean accuracy and certified robust accuracy by changing the size of the enforced margin. We demonstrate this by an ablation study that varies the offset parameter _u_ in the loss function, and also scales _t_ proportional to _u_ . 

The results can be found in Table 5. One can see that using a small margin allows us to train an AOL Network with high clean accuracy, but decreases the certified robust accuracy for larger input perturbations, whereas choosing a higher offset allows us to reach state-of-the-art accuracy for larger input perturbations. Therefore, varying this offset gives us an easy way to prioritize the measure that is important for a specific problem. 

## **7 Conclusion** 

In this work, we proposed AOL, a method for constructing deep networks that have Lipschitz constant of at most 1 and therefore are robust against small changes in the input data. Our main contribution is a rescaling technique for network layers that ensures them to be 1-Lipschitz. It can be computed and trained efficiently, and is applicable to fully-connected and various types of convolutional layers. Training with the rescaled layers leads to weight matrices that are almost orthogonal without the need for a special parametrization and computationally costly orthogonalization schemes. We present experiments and ablation studies in the context of image classification with certified robustness. They show that AOL-networks achieve results comparable with methods that explicitly enforce orthogonalization, while offering the simplicity and flexibility of earlier bound-based approaches. 

9 

Almost-Orthogonal Layers for Efficient General-Purpose Lipschitz Networks 

## **References** 

- [1] Christian Szegedy, Wojciech Zaremba, Ilya Sutskever, Joan Bruna, Dumitru Erhan, Ian J. Goodfellow, and Rob Fergus. Intriguing properties of neural networks. In _International Conference on Learning Representations (ICLR)_ , 2014. 

- [2] Anirban Chakraborty, Manaar Alam, Vishal Dey, Anupam Chattopadhyay, and Debdeep Mukhopadhyay. Adversarial attacks and defences: A survey. _arXiv preprint arXiv:1810.00069_ , 2018. 

- [3] Alex Serban, Erik Poll, and Joost Visser. Adversarial examples on object recognition: A comprehensive survey. _ACM Computing Surveys (CSUR)_ , 53(3):1–38, 2020. 

- [4] Han Xu, Yao Ma, Hao-Chen Liu, Debayan Deb, Hui Liu, Ji-Liang Tang, and Anil K Jain. Adversarial attacks and defenses in images, graphs and text: A review. _International Journal of Automation and Computing_ , 17(2):151–178, 2020. 

- [5] Aladin Virmaux and Kevin Scaman. Lipschitz regularity of deep neural networks: analysis and efficient estimation. In _Conference on Neural Information Processing Systems (NeurIPS)_ , 2018. 

- [6] Martin Arjovsky, Soumith Chintala, and Léon Bottou. Wasserstein generative adversarial networks. In _International Conference on Machine Learing (ICML)_ , 2017. 

- [7] Ishaan Gulrajani, Faruk Ahmed, Martin Arjovsky, Vincent Dumoulin, and Aaron C Courville. Improved training of Wasserstein GANs. In _Conference on Neural Information Processing Systems (NeurIPS)_ , 2017. 

- [8] Takeru Miyato, Toshiki Kataoka, Masanori Koyama, and Yuichi Yoshida. Spectral normalization for generative adversarial networks. In _International Conference on Learning Representations (ICLR)_ , 2018. 

- [9] Moustapha Cissé, Piotr Bojanowski, Edouard Grave, Yann N. Dauphin, and Nicolas Usunier. Parseval networks: Improving robustness to adversarial examples. In _International Conference on Machine Learing (ICML)_ , 2017. 

- [10] Jiayun Wang, Yubei Chen, Rudrasis Chakraborty, and Stella X. Yu. Orthogonal convolutional neural networks. In _Conference on Computer Vision and Pattern Recognition (CVPR)_ , 2020. 

- [11] Henry Gouk, Eibe Frank, Bernhard Pfahringer, and Michael J Cree. Regularisation of neural networks by enforcing Lipschitz continuity. _Machine Learning_ , 110(2):393–416, 2021. 

- [12] Yusuke Tsuzuku, Issei Sato, and Masashi Sugiyama. Lipschitz-margin training: Scalable certification of perturbation invariance for deep neural networks. In _Conference on Neural Information Processing Systems (NeurIPS)_ , 2018. 

- [13] Klas Leino, Zifan Wang, and Matt Fredrikson. Globally-robust neural networks. In _International Conference on Machine Learing (ICML)_ , 2021. 

- [14] Bai Li, Changyou Chen, Wenlin Wang, and Lawrence Carin. Certified adversarial robustness with additive noise. In _Conference on Neural Information Processing Systems (NeurIPS)_ , 2019. 

- [15] Cem Anil, James Lucas, and Roger B. Grosse. Sorting out Lipschitz function approximation. In _International Conference on Machine Learing (ICML)_ , 2019. 

- [16] Lei Huang, Li Liu, Fan Zhu, Diwen Wan, Zehuan Yuan, Bo Li, and Ling Shao. Controllable orthogonalization in training DNNs. In _Conference on Computer Vision and Pattern Recognition (CVPR)_ , 2020. 

- [17] Asher Trockman and J. Zico Kolter. Orthogonalizing convolutional layers with the Cayley transform. In _International Conference on Learning Representations (ICLR)_ , 2021. 

- [18] Sahil Singla and Soheil Feizi. Skew orthogonal convolutions. In _International Conference on Machine Learing (ICML)_ , 2021. 

- [19] Tan Yu, Jun Li, YUNFENG CAI, and Ping Li. Constructing orthogonal convolutions in an explicit manner. In _International Conference on Learning Representations (ICLR)_ , 2022. (to appear). 

- [20] Å. Björck and C. Bowie. An iterative algorithm for computing the best estimate of an orthogonal matrix. _SIAM Journal on Numerical Analysis_ , 1971. 

- [21] Arthur Cayley. About the algebraic structure of the orthogonal group and the other classical groups in a field of characteristic zero or a prime characteristic. _Journal für die reine und angewandte Mathematik_ , 1846. 

- [22] Hanie Sedghi, Vineet Gupta, and Philip M. Long. The singular values of convolutional layers. In _International Conference on Learning Representations (ICLR)_ , 2019. 

- [23] Asher Trockman and J Zico Kolter. Patches are all you need? _arXiv preprint arXiv:2201.09792_ , 2022. 

10 

Almost-Orthogonal Layers for Efficient General-Purpose Lipschitz Networks 

- [24] Artem N. Chernodub and Dimitri Nowicki. Norm-preserving orthogonal permutation linear unit activation functions (oplu). _CoRR_ , 2016. 

- [25] Sahil Singla, Surbhi Singla, and Soheil Feizi. Improved deterministic _l_ 2 robustness on CIFAR-10 and CIFAR-100. In _International Conference on Learning Representations (ICLR)_ , 2022. (to appear). 

11 

Almost-Orthogonal Layers for Efficient General-Purpose Lipschitz Networks 

## **A Appendix** 

## **A.1 Proof of Lemma 2** 

We will proof the Lemma 2 here. Recall 

**Lemma 2** (Convolutional AOL Layers) **.** _Let P ∈_ R _[k][×][k][×][c][I][×][c][O] , be a convolution kernel matrix, where k × k is the_ kernel size _and cI and cO are the number of input and output channels, respectively. Then, the convolutional layer_ 

**==> picture [279 x 11] intentionally omitted <==**

_is guaranteed to be 1-Lipschitz, where R_ ( _x_ ) _is a channel-wise rescaling that multiplies each channel c ∈{_ 1 _, . . . , cI } of the input by_ 

**==> picture [326 x 30] intentionally omitted <==**

_We can equivalently write f as f_ ( _x_ ) = _W ∗ x_ + _b, where W_ = _P ∗ D with D ∈_ R[1] _[×]_[1] _[×][c][I][×][c][I] given by D_ 1[(] _[c,c] ,_ 1[)] = _dc, and D_ 1[(] _[c] ,_ 1[1] _[,c]_[2][)] = 0 _for c_ 1 = _c_ 2 _._ 

_Proof._ For the proof we will assume _maximal_ padding of the input: We pad an input _x ∈_ R _[n][×][n][×][c]_[I] (with values independent of _x_ ) to a size of ( _n_ + 2 _k −_ 2) _×_ ( _n_ + 2 _k −_ 2) _× c_ I, and then apply the convolution to the padded input. Then we obtain an output of size ( _n_ + _k −_ 1) _×_ ( _n_ + _k −_ 1) _× c_ O. We will derive a rescaling of the input that ensures this convolution has a Lipschitz constant of 1. Then, any convolution with a different kind of padding (such as _same_ size or _valid_ ) can be considered as first doing a maximally padded convolution, followed by a center cropping operation. Since a cropping operation also has a Lipschitz constant of 1, this also shows that convolutional layers with a different kind of padding have a Lipschitz constant of 1. 

Denote by _x_ ˜ the padded version of input _x_ , with _x_ ˜ _i_ + _k−_ 1 _,j_ + _k−_ 1 = _xi,j_ . Then, the multi-channel, maximally padded convolution with a convolutional kernel _P ∈_ R _[k][×][k][×][c][I][×][c][O]_ is given by 

**==> picture [317 x 31] intentionally omitted <==**

for 1 _≤ i, j ≤ n_ + _k −_ 1 and 1 _≤ b ≤ c_ O. 

We now consider the Jacobian _J_ of the linear map (from unpadded input to output) defined by Equation 11. It is a matrix of size ( _n_ + _k −_ 1)[2] _c_ O _× n_[2] _c_ I, with entries given by 

**==> picture [322 x 16] intentionally omitted <==**

for 1 _≤ i_ 1 _, i_ 2 _≤ n_ , 1 _≤ i_ 2 _, j_ 2 _≤ n_ + _k −_ 1, 1 _≤ a ≤ c_ I and 1 _≤ b ≤ c_ O. Here, we define _Pp,q_[(] _[a,b]_[)] = 0 unless 0 _≤ p < n_ and 0 _≤ q < n_ . 

We can use that to obtain an expression for _J[⊤] J_ (writing _m_ = _n_ + _k −_ 1): 

**==> picture [372 x 159] intentionally omitted <==**

12 

Almost-Orthogonal Layers for Efficient General-Purpose Lipschitz Networks 

We can now apply Theorem 1 (from the main paper) with _P_ = _J_ together with Equation (17) in order to obtain the necessary rescaling: In order to guarantee the convolution to have Lipschitz constant 1, we need to multiply input _xi_[(] 2 _[c]_[)] _,j_ 2 by 

**==> picture [348 x 40] intentionally omitted <==**

A lower bound of this expression (that is tight for most values of _i_ 2 and _j_ 2) is given by 

**==> picture [340 x 39] intentionally omitted <==**

This value is independent of both _i_ 2 and _j_ 2, so this completes our proof for maximally padded convolutions. This also implies that convolutions with less padding have a Lipschitz constant of 1 when the input is rescaled as described. 

Note that this proof requires padding independent of the input. However, for example for cyclic padding, the Jacobian is a doubly circuland matrix, and a very similar proof shows that our rescaling still works. 

Also note that a result similar to equation (17), relating _J[⊤] J_ to a self-convolution, has been observed before by [10]. 

## **A.2 Comparison of the orthogonality** 

We will present a comparison of _J[⊤] J_ for _J_ the Jacobian of different layers. We consider three architectures: A standard convolutional architecture with standard convolutions (see Section A.4.1), the same architectures with AOL convolutions and (theoretically) an architecture with perfectly orthogonal Jacobian. We pick the third layer of this architecture. It is a convolution with kernel of size 3 _×_ 3 _×_ 32 _×_ 32, and input as well as output of size 32 _×_ 32 _×_ 32. This results in a Jacobian _J_ of size 32 768 _×_ 32 768, and we calculate and visualize the values of a center crop of size 288 _×_ 288 of the matrix _J[⊤] J_ . (See Figure 2.) 

One can see that for our AOL-STD architecture most off-diagonal elements are very close to 0, whereas for the standard architecture they are not. Interestingly, for our architecture there are some off-diagonal elements that are clearly non-zero. This shows that the learning resulted in a few column pairs not being orthogonal, in line with our claim of almost-orthogonality. 

## **A.3 Accuracies of different architectures** 

The results for different architectures using our proposed AOL layers are in Table 6. 

Table 6: Experimental results for different architectures using AOL on CIFAR-10. We report the standard accuracy on the test set as well as the certified robust accuracy under input perturbations up to size _ϵ_ for different values of _ϵ_ . 

|Method|Standard|Certifed Robust Accuracy|Certifed Robust Accuracy|Certifed Robust Accuracy|Certifed Robust Accuracy|
|---|---|---|---|---|---|
||Accuracy|_ϵ_=<br>36<br>255|_ϵ_=<br>72<br>255|_ϵ_= 108<br>255|_ϵ_= 1|
|AOL-FC|67.9%|59.1%|51.1%|43.1%|17.6%|
|AOL-STD|65.0%|56.4%|48.2%|39.9%|15.8%|
|AOL-ALT|68.4%|60.3%|52.4%|44.8%|19.9%|
|AOL-DIL|62.7%|54.2%|46.0%|38.3%|14.9%|



## **A.4 Further Architectures** 

We present the other architectures here that were used in the ablation studies. 

## **A.4.1 Standard CNN:** 

In this Architecture the number of channels doubles whenever the spatial size is decreased. For details see Table 7. 

13 

Almost-Orthogonal Layers for Efficient General-Purpose Lipschitz Networks 

**==> picture [368 x 302] intentionally omitted <==**

**----- Start of picture text -----**<br>
STD - Center crop AOL - Center crop ORTH - Center crop<br>1.0<br>Zoom 1 1.5 Zoom 1 0.75 Zoom 1 0.8<br>Zoom 2 1.0 Zoom 2 0.50 Zoom 2 0.6<br>0.25<br>0.5 0.4<br>0.00<br>0.2<br>0.0 0.25<br>0.0<br>STD - Zoom 1 AOL - Zoom 1 ORTH - Zoom 1<br>1.0<br>1.5 0.75 0.8<br>0.50<br>1.0 0.6<br>0.25<br>0.5 0.4<br>0.00<br>0.2<br>0.0 0.25<br>0.0<br>STD - Zoom 2 AOL - Zoom 2 ORTH - Zoom 2<br> 0.2  0.1<br> 1e-06<br> 0.1  0.05<br> 5e-07<br> 0<br> 0<br> -0.1  0<br> -0.05<br> -0.2  -5e-07<br> -0.1<br>**----- End of picture text -----**<br>


Figure 2: Evaluation of orthogonality of trained models. The first row shows a center crop of _J[⊤] J_ , where _J_ is the Jacobian of the layer, as well as the location of the other two crops. Those are shown in the second and third row. **Left column:** Standard convolutional layer (STD). **Center column:** AOL-STD (AOL), **Right column:** (Perfectly) orthogonal layer (ORTH). Note the different color scales of different subplots. Best viewed in color and zoomed in. 

## **A.4.2 AOL-FC:** 

Architecture consisting of 9 fully connected layers. For details see Table 8. 

## **A.4.3 AOL-STD:** 

This architecture is identical to the one in Table 7, only with standard convolutions replaced by AOL convolutions. 

## **A.4.4 AOL-ALT:** 

Architecture that quadruples the number of channels whenever the spatial size is decreased in order to keep the number of activations constant for the first few layers. This is done until there are 1024 channels, then the number of channels is kept at this value. For details see Table 9. 

## **A.4.5 AOL-DIL** 

We use an architecture similar to the one used by ECO. For that, we just replace each 3 _×_ 3 convolution in the architecture in Table 7 with a strided AOL convolution. 

## **A.5 Data augmentation** 

We use data augmentation in all our experiments. We first do some color augmentation of the images, followed by some spatial transformations. For the color augmentation, we first adjust the hue of the image (by a random factor with delta in [ _−_ 0 _._ 02 _,_ 0 _._ 02]), then we adjust the saturation of the image (by a factor in [ _._ 3 _,_ 2]), then we adjust the brightness of the image (by a random factor with delta in [ _−_ 0 _._ 1 _,_ 0 _._ 1]), and finally we adjust the contrast of the image (by a factor 

14 

Almost-Orthogonal Layers for Efficient General-Purpose Lipschitz Networks 

Table 7: A relatively standard convolutional architecture for CIFAR-10. For all layers we use zero padding to keep the size the same. _First channels_ just selects the first channels and ignores the rest. 

|Layer name<br>Filters<br>Kernel size<br>Stride<br>Activation<br>Output size<br>Amount|Layer name<br>Filters<br>Kernel size<br>Stride<br>Activation<br>Output size<br>Amount|Layer name<br>Filters<br>Kernel size<br>Stride<br>Activation<br>Output size<br>Amount|Layer name<br>Filters<br>Kernel size<br>Stride<br>Activation<br>Output size<br>Amount|Layer name<br>Filters<br>Kernel size<br>Stride<br>Activation<br>Output size<br>Amount|Layer name<br>Filters<br>Kernel size<br>Stride<br>Activation<br>Output size<br>Amount|Layer name<br>Filters<br>Kernel size<br>Stride<br>Activation<br>Output size<br>Amount|
|---|---|---|---|---|---|---|
||||||||
|Conv<br>Conv<br>Conv<br>Conv<br>Conv<br>Conv<br>Conv<br>Conv<br>Conv<br>Conv<br>Conv<br>First Channels<br>Flatten|32<br>64<br>64<br>128<br>128<br>256<br>256<br>512<br>512<br>1024<br>1024<br>-<br>-|3_×_3<br>2_×_2<br>3_×_3<br>2_×_2<br>3_×_3<br>2_×_2<br>3_×_3<br>2_×_2<br>3_×_3<br>2_×_2<br>1_×_1<br>-<br>-|1_×_1<br>2_×_2<br>1_×_1<br>2_×_2<br>1_×_1<br>2_×_2<br>1_×_1<br>2_×_2<br>1_×_1<br>2_×_2<br>1_×_1<br>-<br>-|MaxMin<br>None<br>MaxMin<br>None<br>MaxMin<br>None<br>MaxMin<br>None<br>MaxMin<br>None<br>None<br>-<br>-|32_×_32_×_32<br>16_×_16_×_64<br>16_×_16_×_64<br>8_×_8_×_128<br>8_×_8_×_128<br>4_×_4_×_256<br>4_×_4_×_256<br>2_×_2_×_512<br>2_×_2_×_512<br>1_×_1_×_1024<br>1_×_1_×_1024<br>1_×_1_×_10<br>10|4<br>1<br>4<br>1<br>4<br>1<br>4<br>1<br>4<br>1<br>1<br>1<br>1|



Table 8: Fully Connected Architecture. _First channels_ just selects the first channels and ignores the rest. 

|Layer name<br>Activation<br>Output size<br>Amount|Layer name<br>Activation<br>Output size<br>Amount|Layer name<br>Activation<br>Output size<br>Amount|Layer name<br>Activation<br>Output size<br>Amount|
|---|---|---|---|
|||||
|Flatten<br>AOL FC<br>AOL FC<br>First Channels|-<br>MaxMin<br>None<br>-|3072<br>4096<br>4096<br>10|1<br>8<br>1<br>1|



Table 9: Convolutional architecture. For all layers we use zero padding to keep the size the same. _First channels_ just selects the first channels and ignores the rest. 

|Layer name<br>Filters<br>Kernel size<br>Stride<br>Activation<br>Output size<br>Amount|Layer name<br>Filters<br>Kernel size<br>Stride<br>Activation<br>Output size<br>Amount|Layer name<br>Filters<br>Kernel size<br>Stride<br>Activation<br>Output size<br>Amount|Layer name<br>Filters<br>Kernel size<br>Stride<br>Activation<br>Output size<br>Amount|Layer name<br>Filters<br>Kernel size<br>Stride<br>Activation<br>Output size<br>Amount|Layer name<br>Filters<br>Kernel size<br>Stride<br>Activation<br>Output size<br>Amount|Layer name<br>Filters<br>Kernel size<br>Stride<br>Activation<br>Output size<br>Amount|
|---|---|---|---|---|---|---|
||||||||
|AOL Conv<br>AOL Conv<br>AOL Conv<br>AOL Conv<br>AOL Conv<br>AOL Conv<br>AOL Conv<br>AOL Conv<br>AOL Conv<br>First Channels<br>AOL Conv<br>AOL Conv<br>AOL Conv<br>First Channels<br>Flatten|16<br>16<br>64<br>64<br>256<br>256<br>1024<br>1024<br>1024<br>256<br>1024<br>1024<br>1024<br>10<br>-|2_×_2<br>3_×_3<br>2_×_2<br>3_×_3<br>2_×_2<br>3_×_3<br>2_×_2<br>1_×_1<br>1_×_1<br>-<br>2_×_2<br>1_×_1<br>1_×_1<br>-<br>-|2_×_2<br>1_×_1<br>2_×_2<br>1_×_1<br>2_×_2<br>1_×_1<br>2_×_2<br>1_×_1<br>1_×_1<br>-<br>2_×_2<br>1_×_1<br>1_×_1<br>-<br>-|MaxMin<br>MaxMin<br>MaxMin<br>MaxMin<br>MaxMin<br>MaxMin<br>MaxMin<br>MaxMin<br>None<br>-<br>MaxMin<br>MaxMin<br>None<br>-<br>-|16_×_16_×_16<br>16_×_16_×_16<br>8_×_8_×_64<br>8_×_8_×_64<br>4_×_4_×_256<br>4_×_4_×_256<br>2_×_2_×_1024<br>2_×_2_×_1024<br>2_×_2_×_1024<br>2_×_2_×_256<br>1_×_1_×_1024<br>1_×_1_×_1024<br>1_×_1_×_1024<br>1_×_1_×_10<br>10|1<br>4<br>1<br>4<br>1<br>4<br>1<br>4<br>1<br>1<br>1<br>4<br>1<br>1<br>1|



15 

Almost-Orthogonal Layers for Efficient General-Purpose Lipschitz Networks 

in [ _._ 5 _,_ 2]). After this we clip the pixel values so they are in [0 _.,_ 1 _._ ]. For the spatial transformations, we first apply a random rotation, with a maximal rotation of 5 degrees. Then we apply a random shift of up to 10% of the image size, and finally we flip the image with a probability of 50%. We rely on the tensorflow layers _RandomRotation_ and _RandomTranslation_ for the spatial transformations, and leave all hyperparameters such as the fill mode as the default values. All hyperparameters specifying the amount of augmentation were chosen based on visual inspection of the augmented training images. 

16 

