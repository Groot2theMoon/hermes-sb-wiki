---
title: "1-Lipschitz Layers Compared: Memory, Speed, and Certifiable Robustness"
arxiv: "2311.16833"
authors: ["Bernd Prach", "Fabio Brau", "Giorgio Buttazzo", "Christoph H. Lampert"]
year: 2023
source: paper
ingested: 2026-05-02
sha256: 0ec59e67862966a52a32c0548658ca53cd450e5b838f582aa48a474b72800dca
conversion: pymupdf4llm
---

# **1-Lipschitz Layers Compared: Memory, Speed, and Certifiable Robustness** 

Bernd Prach,[1,*] Fabio Brau,[2,*] Giorgio Buttazzo,[2] Christoph H. Lampert[1] 

1 ISTA, Klosterneuburg, Austria 

2 Scuola Superiore Sant’Anna, Pisa, Italy 

_{_ bprach, chl _}_ @ist.ac.at, _{_ fabio.brau, giorgio.buttazzo _}_ @santannapisa.it 

## **Abstract** 

_The robustness of neural networks against input perturbations with bounded magnitude represents a serious concern in the deployment of deep learning models in safety-critical systems. Recently, the scientific community has focused on enhancing certifiable robustness guarantees by crafting_ 1 _- Lipschitz neural networks that leverage Lipschitz bounded dense and convolutional layers. Although different methods have been proposed in the literature to achieve this goal, understanding the performance of such methods is not straightforward, since different metrics can be relevant (e.g., training time, memory usage, accuracy, certifiable robustness) for different applications. For this reason, this work provides a thorough theoretical and empirical comparison between methods by evaluating them in terms of memory usage, speed, and certifiable robust accuracy. The paper also provides some guidelines and recommendations to support the user in selecting the methods that work best depending on the available resources. We provide code at_ github.com/berndprach/1LipschitzLayersCompared. 

## **1. Introduction** 

Modern artificial neural networks achieve high accuracy and sometimes superhuman performance in many different tasks, but it is widely recognized that they are not robust to tiny and imperceptible input perturbations [3, 33] that, if properly crafted, can cause a model to produce the wrong output. Such inputs, known as _Adversarial Examples_ , represent a serious concern for the deployment of machine learning models in safety-critical systems [21]. For this reason, the scientific community is pushing towards _guarantees_ of robustness. Roughly speaking, a model _f_ is said to be _ε_ -robust for a given input _x_ if no perturbation of magnitude bounded by _ε_ can change its prediction. Recently, in the context of image classification, various approaches 

> *[Joined first authors.] 

**==> picture [228 x 383] intentionally omitted <==**

**----- Start of picture text -----**<br>
RA A RA A<br>AOL BCOP<br>IM 1 TT IM 1 TT<br>2 2<br>3 3<br>4 4<br>5 5<br>TM IT TM IT<br>RA A RA A<br>IM CPL 1 TT IM Cayley 1 TT<br>2 2<br>3 3<br>4 4<br>5 5<br>TM IT TM IT<br>RA A RA A<br> LOT  SLL<br>IM 1 TT IM 1 TT<br>2 2<br>3 3<br>4 4<br>5 5<br>TM IT TM IT<br>RA A Legend<br>RA      Robust Accuracy<br>A Accuracy<br>SOC TT Training Time<br>IM 1 TT<br>2 3 IT Inference Time<br>4<br>5<br>TM Train Memory<br>IM Inference Memory<br>TM IT<br>**----- End of picture text -----**<br>


Figure 1. Evaluation of 1-Lipschitz methods on different metrics. Scores are assigned from 1 (worst) to 5 (best) to every method based on the results reported in Sections 3 and 5. 

have been proposed to achieve certifiable robustness, including _Verification, Randomized Smoothing_ , and _Lipschitz bounded Neural Networks_ . 

1 

Verification strategies aim to establish, for any given model, whether all samples contained in a _l_ 2-ball with radius _ε_ and centered in the tested input _x_ are classified with the same class as _x_ . In the exact formulation, verification strategies involve the solution of an NP-hard problem [15]. Nevertheless, even in a relaxed formulation, [38], these strategies require a huge computational effort [37]. 

Randomized smoothing strategies, initially presented in [9], represent an effective way of crafting a certifiablerobust classifier _g_ based on a base classifier _f_ . If combined with an additional denoising step, they can achieve state-ofthe-art levels of robustness, [6]. However, since they require multiple evaluations of the base model (up to 100k evaluations) for the classification of a single input, they cannot be used for real-time applications. 

Finally, Lipschitz Bounded Neural Networks represent a valid alternative to produce certifiable classifiers, since they only require a single forward pass of the model at inference time [5, 8, 19, 22, 24, 28, 34]. Indeed, the difference between the two largest output components of the model directly provides a lower-bound, in Euclidean norm, of the minimal adversarial perturbation capable of fooling the model. Lipschitz-bounded neural networks can be obtained by the composition of 1-Lipschitz layers [1]. The process of parameterizing 1-Lipschitz layers is fairly straightforward for fully connected layers. However, for convolutions — with overlapping kernels — deducing an effective parameterization is a hard problem. Indeed, the Lipschitz condition can be essentially thought of as a condition on the Jacobian of the layer. However, the Jacobian matrix can not be efficiently computed. 

In order to avoid the explicit computation of the Jacobian, various methods have been proposed, including parameterizations that cause the Jacobian to be (very close to) orthogonal [22, 30, 34, 40] and methods that rely on an upper bound on the Jacobian instead [28]. Those different methods differ drastically in training and validation requirements (in particular time and memory) as well as empirical performance. Furthermore, increasing training time or model sizes very often also increases the empirical performance. This makes it hard to judge from the existing literature which methods are the most promising. This becomes even worse when working with specific computation requirements, such as restrictions on the available memory. In this case, it is important to choose the method that better suits the characteristics of the system in terms of evaluation time, memory usage as well and certifiable-robust-accuracy. 

**This works** aims at giving a comprehensive comparison of different strategies for crafting 1-Lipschitz layers from both a theoretical and practical perspective. For the sake of fairness, we consider several metrics such as _Time_ and 

_Memory_ requirements for both training and inference, _Accuracy_ , as well as _Certified Robust Accuracy_ . The main contributions are the following: 

- An empirical comparison of 1-Lipschitz layers based on six different metrics, and three different datasets on four architecture sizes with three time constraints. 

- A theoretical comparison of the runtime complexity and the memory usage of existing methods. 

- A review of the most recent methods in the literature, including implementations with a revised code that we will release publicly for other researchers to build on. 

## **2. Existing Works and Background** 

In recent years, various methods have been proposed for creating artificial neural networks with a bounded Lipschitz constant. The _Lipschitz constant_ of a function _f_ : R _[n] →_ R _[m]_ with respect to the _l_ 2 norm is the smallest _L_ such that for all _x, y ∈_ R _[n]_ 

**==> picture [182 x 11] intentionally omitted <==**

We also extend this definition to networks and layers, by considering the _l_ 2 norms of the flattened input and output tensors in Equation (1). A layer is called 1-Lipschitz if its Lipschitz constant is at most 1. For linear layers, the Lipschitz constant is equal to the _spectral norm_ of the weight matrix that is given as 

**==> picture [164 x 25] intentionally omitted <==**

A particular class of linear 1-Lipschitz layers are ones with an orthogonal Jacobian matrix. The Jacobian matrix of a layer is the matrix of partial derivatives of the flattened outputs with respect to the flattened inputs. A matrix _M_ is orthogonal if _MM[⊤]_ = _I_ , where _I_ is the identity matrix. For layers with an orthogonal Jacobian, Equation (1) always holds with equality and, because of this, a lot of methods aim at constructing such 1-Lipschitz layers. 

All the neural networks analyzed in this paper consist of 1-Lipschitz parameterized layers and 1-Lipschitz activation functions, with no skip connections and no batch normalization. Even though the commonly used ReLU activation function is 1-Lipschitz, Anil _et al_ . [1] showed that it reduces the expressive capability of the model. Hence, we adopt the MaxMin activation proposed by the authors and commonly used in 1-Lipschitz models. Concatenations of 1-Lipschitz functions are 1-Lipschitz, so the networks analyzed are 1- Lipschitz by construction. 

## **2.1. Parameterized** 1 **-Lipschitz Layers** 

This section provides an overview of the existing methods for providing 1-Lipschitz layers. We discuss fundamental 

2 

methods and for estimating the spectral norms of linear and convolutional layers, i.e. _Power Method_ [26] and _Fantistic4_ [29], and for crafting orthogonal matrices, i.e. Bjorck & Bowie [4], in Appendix A. The rest of this section describes 7 methods from the literature that construct 1-Lipschitz convolutions: BCOP, Cayley, SOC, AOL, LOT, CPL, and SLL. Further 1-Lipschitz methods, [14, 36, 41], and the reasons why they were not included in our main comparison can be found in Appendix B. 

**BCOP** _Block Orthogonal Convolution Parameterization (BCOP)_ was introduced by Li _et al_ . in [22] to extend a previous work by Xiao _et al_ . [39] that focused on the importance of orthogonal initialization of the weights. For a _k × k_ convolution, BCOP uses a set of (2 _k −_ 1) parameter matrices. Each of these matrices is orthogonalized using the algorithm by Bjorck & Bowie [4] (see also Appendix A). Then, a _k × k_ kernel is constructed from those matrices to guarantee that the resulting layer is orthogonal. 

**Cayley** Another family of orthogonal convolutional and fully connected layers has been proposed by Trockman and Kolter [34] by leveraging the _Cayley Transform_ [7], which maps a skew-symmetric matrix _A_ into an orthogonal matrix _Q_ using the relation 

**==> picture [169 x 12] intentionally omitted <==**

The transformation can be used to parameterize orthogonal weight matrices for linear layers in a straightforward way. For convolutions, the authors make use of the fact that circular padded convolutions are vector-matrix products in the Fourier domain. As long as all those vector-matrix products have orthogonal matrices, the full convolution will have an orthogonal Jacobian. For _Cayley Convolutions_ , those matrices are orthogonalized using the Cayley transform. 

**SOC** _Skew Orthogonal Convolution_ is an orthogonal convolutional layer presented by Singla _et al_ . [30], obtained by leveraging the exponential convolution [13]. Analogously to the matrix case, given a kernel _L ∈_ R _[c][×][c][×][k][×][k]_ , the exponential convolution can be defined as 

**==> picture [237 x 33] intentionally omitted <==**

where _⋆[k]_ denotes a convolution applied _k_ -times. The authors proved that any exponential convolution has an orthogonal Jacobian matrix as long as _L_ is skew-symmetric, providing a way of parameterizing 1-Lipschitz layers. In their work, the sum of the infinite series is approximated by computing only the first 5 terms during training and the first 12 terms during the inference, and _L_ is normalized to have unitary spectral norm following the method presented in [29] (see Appendix A). 

**AOL** Prach and Lampert [28] introduced _Almost Orthogonal Lipschitz (AOL)_ layers. For any matrix _P_ , they defined a diagonal rescaling matrix _D_ with 

**==> picture [176 x 28] intentionally omitted <==**

and proved that the spectral norm of _PD_ is bounded by 1. This result was used to show that the linear layer given by _l_ ( _x_ ) = _PDx_ + _b_ (where _P_ is the learnable matrix and _D_ is given by Eq. (5)) is 1-Lipschitz. Furthermore, the authors extended the idea so that it can also be efficiently applied to convolutions. This is done by calculating the rescaling in Equation (5) with the Jacobian _J_ of a convolution instead of _P_ . In order to evaluate it efficiently the authors express the elements of _J[⊤] J_ explicitly in terms of the kernel values. 

**LOT** The layer presented by Xu _et al_ . [40] extends the idea of [14] to use the _Inverse Square Root_ of a matrix in order to orthogonalize it. Indeed, for any matrix _V_ , the matrix _Q_ = _V_ ( _V[T] V_ ) _[−]_[1] 2 is orthogonal. Similarly to the _Cayley_ method, for the _layer-wise orthogonal training (LOT)_ the convolution is applied in the Fourier frequency domain. To find the inverse square root, the authors relay on an iterative _Newton Method_ . In details, defining _Y_ 0 = _V[T] V_ , _Z_ 0 = _I_ , and 

**==> picture [232 x 22] intentionally omitted <==**

it can be shown that _Yi_ converges to ( _V[T] V_ ) _[−]_ 2[1] . In their proposed layer, the authors apply 10 iterations of the method for both training and evaluation. 

**CPL** Meunier _et al_ . [25] proposed the _Convex Potential Layer_ . Given a non-decreasing 1-Lipschitz function _σ_ (usually ReLU), the layer is constructed as 

**==> picture [191 x 24] intentionally omitted <==**

which is 1-Lipschitz by design. The spectral norm required to calculate _l_ ( _x_ ) is approximated using the power method (see Appendix A). 

**SLL** The _SDP-based Lipschitz Layers (SLL)_ proposed by Araujo _et al_ . [2] combine the CPL layer with the upper bound on the spectral norm from AOL. The layer can be written as 

**==> picture [198 x 14] intentionally omitted <==**

where _Q_ is a learnable diagonal matrix with positive entries and _D_ is deduced by applying Equation (5) to _P_ = _WQ[−]_[1] . 

3 

**Remark 1.** Both CPL and SLL are non-linear by construction, so they can be used to construct a network without any further use of activation functions. However, carrying out some preliminary experiments, we empirically found that alternating CPL (and SLL) layers with MaxMin activation layers allows achieving a better performance. 

## **3. Theoretical Comparison** 

As illustrated in the last section, various ideas and methods have been proposed to parameterize 1-Lipschitz layers. This causes the different methods to have very different properties and requirements. This section aims at highlighting the properties of the different algorithms, focusing on the algorithmic complexity and the required memory. 

Table 1 provides an overview of the computational complexity and memory requirements for the different layers considered in the previous section. For the sake of clarity, the analysis is performed by considering separately the transformations applied to the input of the layers and those applied to the weights to ensure the 1-Lipschitz constraint. Each of the two sides of the table contains three columns: i) _Operations_ contains the most costly transformations applied to the input as well as to the parameters of different layers; ii) _MACS_ reports the computational complexity expressed in multiply-accumulate operations (MACS) involved in the transformations (only leading terms are presented); iii) _Memory_ reports the memory required by the transformation during the training phase. 

At training time, both input and weight transformations are required, thus the training complexity of the forward pass can be computed as the sum of the two corresponding MACS columns of the table. Similarly, the training memory requirements can be computed as the sum of the two corresponding Memory columns of the table. For the considered operations, the cost of the backward pass during training has the same computational complexity as the forward pass, and therefore increases the overall complexity by a constant factor. At inference time, all the parameter transformations can be computed just once and cached afterward. Therefore, the inference complexity is equal to the complexity due to the input transformation (column 3 in the table). The memory requirements at inference time are much lower than those needed at the training time since intermediate activation values do not need to be stored in memory, hence we do not report them in Table 1. 

Note that all the terms reported in Table 1 depend on the batch size _b_ , the input size _s × s × c_ , the number of inner iterations of a method _t_ , and the kernel size _k × k_ . (Often, _t_ is different at training and inference time.) For the sake of clarity, the MACS of a naive convolution implementation is denoted by _C_ ( _C_ = _bs_[2] _c_[2] _k_[2] ), the number of inputs of a 

layer is denoted by _M_ ( _M_ = _bs_[2] _c_ ), and the size of the kernel of a standard convolution is denoted by _P_ ( _P_ = _c_[2] _k_[2] ). Only the leading terms of the computations are reported in Table 1. In order to simplify some terms, we assume that _c >_ log2( _s_ ) and that rescaling a tensor (by a scalar) as well as adding two tensors does not require any memory in order to do backpropagation. We also assume that each additional activation does require extra memory. All these assumptions have been verified to hold within _PyTorch_ , [27]. Also, when the algorithm described in the paper and the version provided in the supplied code differed, we considered the algorithm implemented in the code. 

The transformations reported in the table are convolutions (CONV), Fast Fourier Transformations (FFT), matrixvector multiplications (MV), matrix-matrix multiplications (MM), matrix inversions (INV), as well as applications of an activation function (ACT). The application of algorithms such as Bjorck & Bowie (BnB), power method, and Fantastic 4 (F4) is also reported (see Appendix A for descriptions). 

## **3.1. Analysis of the computational complexity** 

It is worth noting that the complexity of the input transformations (in Table 1) is similar for all methods. This implies that a similar scaling behaviour is expected at inference time for the models. Cayley and LOT apply an FFT-based convolution and have computational complexity independent of the kernel size. CPL and SLL require two convolutions, which make them slightly more expensive at inference time. Notably, SOC requires multiple convolutions, making this method more expensive at inference time. 

At training time, parameter transformations need to be applied in addition to the input transformations during every forward pass. For SOC and CPL, the input transformations always dominate the parameter transformations in terms of computational complexity. This means the complexity scales like _c_[2] , just like a regular convolution, with a further factor of 2 and 5 respectively. All other methods require parameter transformations that scale like _c_[3] , making them more expensive for larger architectures. In particular, we do expect Cayley and LOT to require long training times for larger models, since the complexity of their parameter transformations further depends on the input size. 

## **3.2. Analysis of the training memory requirements** 

The memory requirements of the different layers are important, since they determine the maximum batch size and the type of models we can train on a particular infrastructure. At training time, typically all intermediate results are kept in memory to perform backpropagation. This includes intermediate results for both input and parameter transformations. The input transformation usually preserves the size, and therefore the memory required is usually of _O_ ( _M_ ). 

4 

Table 1. **Computational complexity and memory requirements of different methods.** We report multiply-accumulate operations (MACS) as well as memory requirements (per layer) for batch size _b_ , image size _s × s × c_ , kernel size _k × k_ and number of inner iterations _t_ . We use _C_ = _bs_[2] _c_[2] _k_[2] , _M_ = _bs_[2] _c_ and _P_ = _c_[2] _k_[2] . For a detailed explanation on what is reported see Section 3. For some explanation on how the entries of this table were derived, see Appendix C. 

|Method||Input|Transformations|||Parameter Transformations|Parameter Transformations|Parameter Transformations|
|---|---|---|---|---|---|---|---|---|
||Operations||MACS_O_(_·_)|Memory|Operations||MACS_O_(_·_)|Memory_O_(_·_)|
|Standard|CONV||_C_|_M_|-||-|_P_|
|AOL|CONV||_C_|_M_|CONV||_c_3_k_4|5_P_|
|BCOP|CONV||_C_|_M_|BnB & MMs||_c_3_kt_+_c_3_k_3|_c_2_kt_+_c_2_k_3|
|Cayley|FFTs &|MVs|_bs_2_c_2|5<br>2_M_|FFTs &|INVs|_s_2_c_3|3<br>2_s_2_c_2|
|CPL|CONVs|& ACT|2_C_|3_M_|power method||_s_2_c_2_k_2|_P_ +_s_2_c_|
|LOT|FFTs &|MVs|_bs_2_c_2|3_M_|FFTs &|MMs|4_s_2_c_3_t_|4_s_2_c_2_t_|
|SLL|CONVs|& ACT|2_C_|3_M_|CONVs||_c_3_k_4|5_P_|
|SOC|CONVs||_Ct_1|_Mt_1|F4||_c_2_k_2_t_2|_P_|



Therefore, for the input transformations, all methods require memory not more than a constant factor worse than standard convolutions, with the worst method being SOC, with a constant _t_ 1, typically equal to 5. 

In addition to the input transformation, we also need to store intermediate results of the parameter transformations in memory in order to evaluate the gradients. Again, most methods approximately preserve the sizes during the parameter transformations, and therefore the memory required is usually of order _O_ ( _P_ ). Exceptions to this rule are Cayley and LOT, which contain a much larger _O_ ( _s_[2] _c_[2] ) term, as well as BCOP. 

## **4. Experimental Setup** 

This section presents an experimental study aimed at comparing the performance of the considered layers with respect to different metrics. Before presenting the results, we first summarize the setup used in our experiments. For a detailed description see Appendix E. To have a fair and meaningful comparison among the various models, all the proposed layers have been evaluated using the same architecture, loss function, and optimizer. Since, according to the data reported in Table 1, different layers may have different throughput, to have a fair comparison with respect to the tested metrics, we limited the total training time instead of fixing the number of training epochs. Results are reported for training times of 2h, 10h, and 24h on one A100 GPU. 

Our architecture is a standard convolutional network that doubles the number of channels whenever the resolution is reduced [5, 34]. For each method, we tested architectures of different sizes. We denoted them as XS, S, M and L, depending on the number of parameters, according to the criteria in Table 7, ranging from 1.5M to 100M parameters. 

Since different methods benefit from different learning rates and weight decay, for each setting (model size, method and dataset), we used the best values resulting from a random search performed on multiple training runs on a validation set composed of 10% of the original training set. More specifically, 16 runs were performed for each configuration of randomly sampled hyperparameters, and we selected the configuration maximizing the certified robust accuracy w.r.t. _ϵ_ = 36 _/_ 255 (see Appendix E.5 for details). 

The evaluation was carried out using three different datasets: CIFAR-10, CIFAR-100 [16], and Tiny ImageNet [18]. Augmentation was used during the training (Random crops and flips on CIFAR-10 and CIFAR-100, and _RandAugment_ [10] on Tiny ImageNet). We use the loss function proposed by [28], with the margin set to 2 _√_ 2 _ϵ_ , and temperature 0 _._ 25. 

## **4.1. Metrics** 

All the considered models were evaluated based on three main metrics: the _throughput_ , the required memory, and the certified robust accuracy. 

**Throughput and epoch time** The _throughput_ of a model is the average number of examples that the model can process per second. It determines how many epochs are processed in a given time frame. The evaluation of the throughput was performed on an 80GB-A100-GPU based on the average time of 100 mini-batches. We measured the inference throughput with cached parameter transformations. 

**Memory required** Layers that require less memory allow for larger batch size, and the memory requirements also determine the type of hardware we can train a model 

5 

on. For each model, we measured and reported the maximal GPU memory occupied by tensors using the function torch.cuda.max memory ~~a~~ llocated() provided by the _PyTorch_ framework. This is not exactly equal to the overall GPU memory requirement but gives a fairly good approximation of it. Note that the model memory measured in this way also includes additional memory required by the optimizer (e.g. to store the momentum term) as well as by the activation layers in the forward pass. However, this additional memory should be at most of order _O_ ( _M_ + _P_ ). As for the throughput, we evaluated and cached all calculations independent of the input at inference time. 

**Certified robust accuracy** In order to evaluate the performance of a 1-Lipschitz network, the standard metric is the _certified robust accuracy_ . An input is classified certifiably robustly with radius _ϵ_ by a model, if no perturbations of the input with norm bounded by _ϵ_ can change the prediction of the model. Certified robust accuracy measures the proportion of examples that are classified correctly as well as certifiably robustly. For 1-Lipschitz models, a lower bound of the certified _ϵ_ -robust accuracy is the ratio of correctly classified inputs such that _Mf_ ( _xi, li_ ) _> ϵ√_ 2 where the _margin Mf_ ( _x, l_ ) of a model _f_ at input _x_ with label _l_ , given as _Mf_ ( _x, l_ ) = _f_ ( _x_ ) _l −_ max _j_ = _l fj_ ( _x_ ), is the difference between target class score and the highest score of a different class. For details, see [35]. 

## **5. Experimental Results** 

This section presents the results of the comparison performed by applying the methodology discussed in Section 4. The results related to the different metrics are discussed in dedicated subsections and the key takeaways are summarized in the radar-plot illustrated in Figure 1. 

## **5.1. Training and inference times** 

Figure 2 plots the training time per epoch of the different models as a function of their size, while Figure 3 plots the 

**==> picture [231 x 115] intentionally omitted <==**

**----- Start of picture text -----**<br>
Training time per epoch<br>8 min AOL<br>4 min BCOP<br>CPL<br>2 min<br>Cayley<br>1 min<br>LOT<br>30 sec SLL<br>15 sec SOC<br>Standard<br>7.5 sec<br>XS S M L<br>Model Size<br>Time<br>**----- End of picture text -----**<br>


Figure 2. **Training time** per epoch (on CIFAR-10) for different methods and different model sizes. 

corresponding inference throughput for the various sizes as described in Section 4. As described in Table 5, the model base width, referred to as _w_ , is doubled from one model size to the next. We expect the training and inference time to scale with _w_ similarly to how individual layers scale with their number of channels, _c_ (in Table 1). This is because the width of each of the 5 blocks of our architecture is a constant multiple of the base width, _w_ . 

**The training time** increases (at most) about linearly with _w_ for standard convolutions, whereas the computational complexity of each single convolution scales like _c_[2] . This suggests that parallelism on the GPU and the overhead from other operations (activations, parameter updates, etc.) are important factors determining the training time. This also explains why CPL (doing two convolutions, with identical kernel parameters) is only slightly slower than a standard convolution, and SOC (doing 5 convolutions) is only about 3 times slower than the standard convolution. The AOL and SLL methods also require times comparable to a standard convolution for small models, although eventually, the _c_[3] term in the computation of the rescaling makes them slower for larger models. Finally, Cayley, LOT, and BCOP methods take much longer training times per epoch. For Cayley and LOT this behavior was expected, as they have a large _O_ ( _s_[2] _c_[3] ) term in their computational complexity. See Table 1 for further details. 

**At inference time** transformations of the weights are cached, therefore some methods (AOL, BCOP) do not have any overhead compared to a standard convolution. As expected, other methods (CPL, SLL, and SOC) that apply additional convolutions to the input suffer from a corresponding overhead. Finally, Cayley and LOT have a slightly different throughput due to their FFT-based convolution. Among them, Cayley is about twice as fast because it involves a real-valued FFT rather than a complex-valued one. 

**==> picture [231 x 122] intentionally omitted <==**

**----- Start of picture text -----**<br>
Inference Throughput per second<br>2 [15]<br>AOL<br>2 [14] BCOP<br>CPL<br>2 [13]<br>Cayley<br>2 [12] LOT<br>2 [11] SLL<br>SOC<br>2 [10] Standard<br>2 [9]<br>XS S M L<br>Model Size<br>Throughput (examples/s)<br>**----- End of picture text -----**<br>


Figure 3. **Inference throughput** for different methods as a function of their size for CIFAR-10 sizes input images. All parameter transformations have been evaluated and cached beforehand 

6 

**==> picture [231 x 240] intentionally omitted <==**

**----- Start of picture text -----**<br>
Memory required training<br>64 GB<br>AOL<br>32 GB<br>BCOP<br>16 GB CPL<br>8 GB Cayley<br>LOT<br>4 GB<br>SLL<br>2 GB SOC<br>Standard<br>1 GB<br>XS S M L<br>Model Size<br>Memory required inference<br>4 GB<br>AOL<br>2 GB BCOP<br>CPL<br>1 GB<br>Cayley<br>500 MB LOT<br>SLL<br>250 MB SOC<br>Standard<br>125 MB<br>XS S M L<br>Model Size<br>Memory (GB)<br>Memory<br>**----- End of picture text -----**<br>


Figure 4. **Memory required** at training and inference time for input size 32 _×_ 32. 

From Figure 3, it can be noted that cached Cayley and CPL have the same inference time, even though CPL uses twice the number of convolutions. We believe this is due to the fact that the conventional FFT-based convolution is quite efficient for large filters, but PyTorch implements a faster algorithm, _i.e_ ., _Winograd_ , [17], that can be up to 2 _._ 5 times faster. 

## **5.2. Training memory requirements** 

The training and inference memory requirements of the various models (measured as described in Section 4.1) are reported in Figure 4 as a function of the model size. The results of the theoretical analysis reported in Table 1 suggest that the training memory requirements always have a term linear in the number of channels, _c_ (usually the activations from the forward pass), as well as a term quadratic in _c_ (usually the weights and all transformations applied to the weights during the forward pass). This behavior can also be observed from Figure 4. For some of the models, the memory required approximately doubles from one model size to the next one, just like the width. This means that the linear term dominates (for those sizes), which makes those models relatively cheap to scale up. For the BCOP, LOT, and Cayley methods, the larger coefficients in the _c_[2] term (for LOT and Cayley the coefficient is even dependent on the input size, _s_[2] ) cause this term to dominate. This makes it much harder to scale those methods to more parameters. Method LOT requires huge amounts of memory, in particular LOT- 

Table 2. Certified robust accuracy for radius _ϵ_ = 36 _/_ 255 on the evaluated datasets. Training is performed for 24 hours. 

|Accuracy [%]<br>Robust Accuracy [%]<br>Methods<br>XS<br>S<br>M<br>L<br>XS<br>S<br>M<br>L|Accuracy [%]<br>Robust Accuracy [%]<br>Methods<br>XS<br>S<br>M<br>L<br>XS<br>S<br>M<br>L|
|---|---|
|**CIFAR-10**||
|**AOL**<br>71.7<br>73.6<br>73.4 73.7<br>59.1<br>60.8 61.0<br>**61.5**<br>**BCOP**<br>71.7<br>73.1<br>74.0 74.6<br>58.5<br>59.3 60.5<br>**61.5**<br>**CPL**<br>74.9<br>76.1<br>76.6 76.8<br>62.5<br>64.2 65.1<br>**65.2**<br>**Cayley**<br>73.1<br>74.2<br>74.4 73.6<br>59.5<br>**61.1**<br>61.0<br>60.1<br>**LOT**<br>75.5<br>76.6<br>72.0<br>-<br>63.4<br>**64.6**<br>58.7<br>-<br>**SLL**<br>73.7<br>74.2<br>75.3 74.3<br>61.0<br>62.0<br>**62.8**<br>62.3<br>**SOC**<br>74.1<br>75.0<br>76.9 76.9<br>61.3<br>62.9<br>**66.3**<br>65.4||
|**CIFAR-100**||
|**AOL**<br>40.3<br>43.4<br>44.3 41.9<br>27.9<br>31.0<br>**31.4**<br>29.7<br>**BCOP**<br>41.4<br>42.8<br>43.7 42.2<br>28.4<br>30.1<br>**31.2**<br>29.2<br>**CPL**<br>42.3<br>-<br>45.2 44.3<br>30.1<br>-<br>**33.2**<br>32.1<br>**Cayley**<br>42.3<br>43.9<br>43.5 42.9<br>29.2<br>**30.5**<br>30.5<br>29.5<br>**LOT**<br>43.5<br>45.2<br>42.8<br>-<br>30.8<br>**32.5**<br>29.6<br>-<br>**SLL**<br>41.4<br>42.8<br>42.4 42.1<br>28.9<br>**30.5**<br>29.9<br>29.6<br>**SOC**<br>43.1<br>45.2<br>47.3 46.2<br>30.6<br>32.6<br>**34.9**<br>33.5||
|**Tiny ImageNet**||
|**AOL**<br>26.6<br>29.3<br>30.3 30.0<br>**BCOP**<br>22.4<br>26.2<br>27.6 27.0<br>**CPL**<br>28.3<br>29.3<br>29.8 30.3<br>**Cayley**<br>27.8<br>29.6<br>30.1 27.2<br>**LOT**<br>30.7<br>32.5<br>28.8<br>-<br>**SLL**<br>25.1<br>27.0<br>26.5 27.9<br>**SOC**<br>28.9<br>28.8<br>32.1 32.1|18.1<br>19.7<br>**21.0**<br>20.6<br>13.8<br>16.9<br>**17.2**<br>16.8<br>18.9<br>19.7<br>**20.3**<br>20.1<br>17.9<br>**19.5**<br>19.3<br>16.7<br>20.8<br>**21.9**<br>18.1<br>-<br>16.6<br>18.4 17.7<br>**18.8**<br>18.9<br>18.8<br>**21.2**<br>21.1|



## L is too large to fit in 80GB GPU memory. 

Note that at test time, the memory requirements are much lower, because the intermediate activation values do not need to be stored, as there is no backward pass. Therefore, at inference time, most methods require a very similar amount of memory as a standard convolution. The Cayley and LOT methods require more memory since perform the calculation in the Fourier space, as they create an intermediate representation of the weight matrices of size _O_ ( _s_[2] _c_[2] ). 

## **5.3. Certified robust accuracy** 

The results related to the accuracy and the certified robust accuracy for the different methods, model sizes, and datasets measured on a 24h training budget are summarized in Table 2. The differences among the various model sizes are also highlighted in Figure 5 by reporting the sorted values of the certified robust accuracy. Further tables and plots relative to different training budgets can be found in Appendix G. The reader can compare our results with the state-of-the-art certified robust accuracy summarized in Ap- 

7 

**==> picture [494 x 220] intentionally omitted <==**

**----- Start of picture text -----**<br>
Robust Accuracy for CIFAR10<br>AOL<br>67.5 BCOP<br>CPL<br>65.0 Cayley<br>62.5 LOT<br>SLL<br>60.0 SOC<br>57.5<br>55.0<br>52.5<br>Model<br>Robust Accuracy for CIFAR100 Robust Accuracy for TinyImageNet<br>36<br>22<br>34<br>21<br>32 20<br>30 19<br>18<br>28<br>Model Model<br>Robust Accuracy [%] SOC - M SOC - L CPL - L CPL - M LOT - S CPL - S LOT - XS SOC - S SLL - M CPL - XS SLL - L SLL - S AOL - L BCOP - L SOC - XS Cayley - S SLL - XS Cayley - M AOL - M AOL - S BCOP - M Cayley - L Cayley - XS BCOP - S AOL - XS LOT - M BCOP - XS<br>SOC - M LOT - S<br>Robust Accuracy [%] SOC - L CPL - M SOC - S LOT - S CPL - L AOL - M BCOP - M AOL - S LOT - XS Robust Accuracy [%] SOC - M SOC - L AOL - M LOT - XS AOL - L CPL - M CPL - L CPL - S AOL - S<br>**----- End of picture text -----**<br>


Figure 5. **Certified robust accuracy** by decreasing order. Note that the axes do not start at 0. For CIFAR-100 and Tiny ImageNet only the 10 best performing models are shown. 

pendix D. However, it is worth noting that, to reach state-ofthe-art performance, authors often carry out experiments using large model sizes and long training times, which makes it hard to compare the methods themselves. On the other hand, the evaluation proposed in this paper allows a fairer comparison among the different methods, since it also considers timing and memory aspects. This restriction based on time, rather than the number of epochs, ensures that merely enlarging the model size does not lead to improved performance, as bigger models typically process fewer epochs of data. Indeed, in our results in Figure 5 it is usually the M (and not the L) model that performs best. To assign a score that combines the performance of the methods over all the three datasets, we sum the number of times that each method is ranked in the first position, in the top-3, and top10 positions. In this way, top-1 methods are counted three times, and top-3 methods are counted twice. The scores in the radar-plot shown in Figure 1 are based on those values. 

Among all methods, SOC achieved a top-1 robust accuracy twice and a top-3 one 6 times, outperforming all the other methods. CPL ranks twice in the top-3 and 9 times in the top-10 positions, showing that it generally has a more stable performance compared with other methods. LOT achieved the best certified robust accuracy on Tiny ImageNet, appearing further 5 times in the top-10. AOL did not perform very well on CIFAR-10, but reached more competitive results on Tiny ImageNet, ending up in the top-10 a total of 5. An opposite effect can be observed for SLL, which performed reasonably well on CIFAR-10, but not so well on the two datasets with more classes, placing in the 

top-10 only once. This result is tied with BCOP, which also has only one model in the top-10. Finally, Cayley is consistently outperformed by the other methods. The very same analysis can be applied to the clean accuracy, whose sorted bar-plots are reported in Appendix G, where the main difference is that Cayley performs slightly better for that metric. Furthermore, it is worth highlighting that CPL is sensitive to weight initialization. We faced numerical errors during the 10h and 24h training of the small model on CIFAR-100. 

## **6. Conclusions and Guidelines** 

This work presented a comparative study of state-of-the-art 1-Lipschitz layers under the lens of different metrics, such as time and memory requirements, accuracy, and certified robust accuracy, all evaluated at training and inference time. A theoretical comparison of the methods in terms of time and memory complexity was also presented and validated by experiments. 

Taking all metrics into account (summarized in Figure 1), the results are in favor of CPL, due to its highest performance and lower consumption of computational resources. When large computational resources are available and the application does not impose stringent timing constraints during inference and training, the SOC layer could be used, due to its slightly better performance. Finally, those applications in which the inference time is crucial may take advantage of AOL or BCOP, which do not introduce additional runtime overhead (during inference) compared to a standard convolution. 

8 

## **References** 

- [1] Cem Anil, James Lucas, and Roger Grosse. Sorting out Lipschitz function approximation. In _International Conference on Machine Learing (ICML)_ , 2019. 2, 11 

- [2] Alexandre Araujo, Aaron J Havens, Blaise Delattre, Alexandre Allauzen, and Bin Hu. A unified algebraic perspective on Lipschitz neural networks. In _International Conference on Learning Representations (ICLR)_ , 2023. 3, 14, 18 

- [3] Battista Biggio, Igino Corona, Davide Maiorca, Blaine Nelson, Nedim Srndi´c,[ˇ] Pavel Laskov, Giorgio Giacinto, and Fabio Roli. Evasion attacks against machine learning at test time. In _Machine Learning and Knowledge Discovery in Databases_ , 2013. 1 

- [4] A. Bj¨orck and C. Bowie.[˚] An iterative algorithm for computing the best estimate of an orthogonal matrix. _SIAM Journal on Numerical Analysis_ , 1971. 3, 11 

- [5] Fabio Brau, Giulio Rossolini, Alessandro Biondi, and Giorgio Buttazzo. Robust-by-design classification via unitarygradient neural networks. _Proceedings of the AAAI Conference on Artificial Intelligence_ , 2023. 2, 5 

- [6] Nicholas Carlini, Florian Tramer, Krishnamurthy Dj Dvijotham, Leslie Rice, Mingjie Sun, and J Zico Kolter. (Certified!!) adversarial robustness for free! In _International Conference on Learning Representations (ICLR)_ , 2023. 2 

- [7] Arthur Cayley. About the algebraic structure of the orthogonal group and the other classical groups in a field of characteristic zero or a prime characteristic. _Journal f¨ur die reine und angewandte Mathematik_ , 1846. 3 

- [8] Moustapha Cisse, Piotr Bojanowski, Edouard Grave, Yann Dauphin, and Nicolas Usunier. Parseval networks: Improving robustness to adversarial examples. In _International conference on machine learning_ , 2017. 2, 11 

- [9] Jeremy Cohen, Elan Rosenfeld, and Zico Kolter. Certified adversarial robustness via randomized smoothing. In _Proceedings of the 36th International Conference on Machine Learning_ , 2019. 2 

- [10] Ekin D Cubuk, Barret Zoph, Jonathon Shlens, and Quoc V Le. Randaugment: Practical automated data augmentation with a reduced search space. In _Proceedings of the IEEE/CVF conference on computer vision and pattern recognition workshops_ , 2020. 5, 16 

- [11] Jia Deng, Wei Dong, Richard Socher, Li-Jia Li, Kai Li, and Li Fei-Fei. Imagenet: A large-scale hierarchical image database. In _Conference on Computer Vision and Pattern Recognition (CVPR)_ , 2009. 16 

- [12] Farzan Farnia, Jesse Zhang, and David Tse. Generalizable adversarial training via spectral normalization. In _International Conference on Learning Representations_ , 2018. 11 

- [13] Emiel Hoogeboom, Victor Garcia Satorras, Jakub Tomczak, and Max Welling. The convolution exponential and generalized Sylvester flows. In _Advances in Neural Information Processing Systems_ , 2020. 3 

- [14] Lei Huang, Li Liu, Fan Zhu, Diwen Wan, Zehuan Yuan, Bo Li, and Ling Shao. Controllable orthogonalization in training DNNs. In _Conference on Computer Vision and Pattern Recognition (CVPR)_ , 2020. 3, 11, 12 

- [15] Guy Katz, Clark Barrett, David L Dill, Kyle Julian, and Mykel J Kochenderfer. Reluplex: An efficient SMT solver for verifying deep neural networks. In _International confer-_ 

_ence on computer aided verification_ , 2017. 2 

- [16] Alex Krizhevsky. Learning multiple layers of features from tiny images. Technical report, 2009. 5, 16 

- [17] Andrew Lavin and Scott Gray. Fast algorithms for convolutional neural networks. In _Proceedings of the IEEE conference on computer vision and pattern recognition_ , 2016. 7 

- [18] Ya Le and Xuan Yang. Tiny imagenet visual recognition challenge. _CS 231N_ , 2015. 5, 16 

- [19] Klas Leino, Zifan Wang, and Matt Fredrikson. Globallyrobust neural networks. In _International Conference on Machine Learning_ , 2021. 2, 11 

- [20] Mario Lezcano-Casado and David Mart´ınez-Rubio. Cheap orthogonal constraints in neural networks: A simple parametrization of the orthogonal and unitary group. In _International Conference on Machine Learing (ICML)_ , 2019. 11 

- [21] Linyi Li, Tao Xie, and Bo Li. Sok: Certified robustness for deep neural networks. In _2023 IEEE Symposium on Security and Privacy (SP)_ , 2023. 1 

- [22] Qiyang Li, Saminul Haque, Cem Anil, James Lucas, Roger B Grosse, and Joern-Henrik Jacobsen. Preventing gradient attenuation in Lipschitz constrained convolutional networks. In _Conference on Neural Information Processing Systems (NeurIPS)_ , 2019. 2, 3, 11, 14 

- [23] Shuai Li, Kui Jia, Yuxin Wen, Tongliang Liu, and Dacheng Tao. Orthogonal deep neural networks. _IEEE Transactions on Pattern Analysis and Machine Intelligence_ , 2021. 11 

- [24] Max Losch, David Stutz, Bernt Schiele, and Mario Fritz. Certified robust models with slack control and large Lipschitz constants. _arXiv preprint arXiv:2309.06166_ , 2023. 2 

- [25] Laurent Meunier, Blaise J Delattre, Alexandre Araujo, and Alexandre Allauzen. A dynamical system perspective for Lipschitz neural networks. In _International Conference on Machine Learing (ICML)_ , 2022. 3, 11, 14, 18 

- [26] Takeru Miyato, Toshiki Kataoka, Masanori Koyama, and Yuichi Yoshida. Spectral normalization for generative adversarial networks. In _International Conference on Learning Representations (ICLR)_ , 2018. 3, 11 

- [27] Adam Paszke, Sam Gross, Francisco Massa, Adam Lerer, James Bradbury, Gregory Chanan, Trevor Killeen, Zeming Lin, Natalia Gimelshein, Luca Antiga, Alban Desmaison, Andreas Kopf, Edward Yang, Zachary DeVito, Martin Raison, Alykhan Tejani, Sasank Chilamkurthy, Benoit Steiner, Lu Fang, Junjie Bai, and Soumith Chintala. Pytorch: An imperative style, high-performance deep learning library. In _Conference on Neural Information Processing Systems (NeurIPS)_ . 2019. 4 

- [28] Bernd Prach and Christoph H Lampert. Almost-orthogonal layers for efficient general-purpose Lipschitz networks. In _European Conference on Computer Vision (ECCV)_ , 2022. 2, 3, 5, 14, 15 

- [29] S Singla and S Feizi. Fantastic four: Differentiable bounds on singular values of convolution layers. In _International Conference on Learning Representations (ICLR)_ , 2021. 3, 11 

- [30] Sahil Singla and Soheil Feizi. Skew orthogonal convolutions. In _International Conference on Machine Learing (ICML)_ , 2021. 2, 3, 14 

- [31] Sahil Singla and Soheil Feizi. Improved techniques for de- 

9 

   - terministic l2 robustness. _Conference on Neural Information Processing Systems (NeurIPS)_ , 2022. 14 

- [32] Leslie N Smith and Nicholay Topin. Super-convergence: Very fast training of neural networks using large learning rates. In _Artificial intelligence and machine learning for multi-domain operations applications_ , 2019. 15 

- [33] Christian Szegedy, Wojciech Zaremba, Ilya Sutskever, Joan Bruna, Dumitru Erhan, Ian Goodfellow, and Rob Fergus. Intriguing properties of neural networks. In _International Conference on Learning Representations (ICLR)_ , 2014. 1 

- [34] Asher Trockman and J Zico Kolter. Orthogonalizing convolutional layers with the Cayley transform. In _International Conference on Learning Representations (ICLR)_ , 2021. 2, 3, 5, 14, 18 

- [35] Yusuke Tsuzuku, Issei Sato, and Masashi Sugiyama. Lipschitz-margin training: Scalable certification of perturbation invariance for deep neural networks. _Conference on Neural Information Processing Systems (NeurIPS)_ , 2018. 6 

- [36] Ruigang Wang and Ian Manchester. Direct parameterization of Lipschitz-bounded deep networks. In _International Conference on Machine Learing (ICML)_ , 2023. 3, 11, 12 

- [37] Lily Weng, Huan Zhang, Hongge Chen, Zhao Song, ChoJui Hsieh, Luca Daniel, Duane Boning, and Inderjit Dhillon. Towards fast computation of certified robustness for relu networks. In _International Conference on Machine Learing (ICML)_ , 2018. 2 

- [38] Eric Wong and Zico Kolter. Provable defenses against adversarial examples via the convex outer adversarial polytope. In _International Conference on Machine Learing (ICML)_ , 2018. 2 

- [39] Lechao Xiao, Yasaman Bahri, Jascha Sohl-Dickstein, Samuel Schoenholz, and Jeffrey Pennington. Dynamical isometry and a mean field theory of CNNs: How to train 10,000-layer vanilla convolutional neural networks. In _International Conference on Machine Learing (ICML)_ , 2018. 3 

- [40] Xiaojun Xu, Linyi Li, and Bo Li. Lot: Layer-wise orthogonal training on improving l2 certified robustness. _Conference on Neural Information Processing Systems (NeurIPS)_ , 2022. 2, 3, 14, 19 

- [41] Tan Yu, Jun Li, Yunfeng Cai, and Ping Li. Constructing orthogonal convolutions in an explicit manner. In _International Conference on Learning Representations (ICLR)_ , 2021. 3, 11, 12 

10 

# **Technical Appendix of “1-Lipschitz Layers Compared: Memory, Speed, and Certifiable Robustness”** 

## **A. Spectral norm and orthogonalization** 

A lot of recently proposed methods do rely on a way of parameterizing orthogonal matrices or parameterizing matrices with bounded spectral norm. We present methods that are frequently used below: 

**Bjorck & Bowie [4]** introduced an iterative algorithm that finds the closest orthogonal matrix to the given input matrix. In the commonly used form, this is achieved by computing a sequence of matrices using 

**==> picture [350 x 25] intentionally omitted <==**

where _A_ 0 = _A_ , is the input matrix. The algorithm is usually truncated after a fixed number of steps, during training often 3 iterations are enough, and for inference more (e.g. 15) iterations are used to ensure a good approximation. Since the algorithm is differentiable, it can be applied to construct 1-Lipschitz networks as proposed initially in [1] or also as an auxiliary method for more complex strategies [22]. 

**Power Method** The _power method_ was used in [26], [19] and [25] in order to bound the spectral norm of matrices. It starts with a random initialized vector **u** 0, and iteratively applies the following: 

**==> picture [337 x 25] intentionally omitted <==**

Then the sequence _σk_ converges to the spectral norm of _W_ , for _σk_ given by 

**==> picture [279 x 12] intentionally omitted <==**

This procedure allows us to obtain the spectral norm of matrices, but it can also be efficiently extended to find the spectral norm of the Jacobian of convolutional layers. This was done for example by [12, 19], using the fact that the transpose of a convolution operation (required to calculate Equation (10)) is a convolution as well, with a kernel that can be constructed from the original one by transposing the channel dimensions and flipping the spatial dimensions of the kernel. 

When the power method is used on a parameter matrix of a layer, we can make it even more efficient with a simple trick. We usually expect the parameter matrix to change only slightly during each training step, so we can store the result **u** _k_ during each training step, and start the power method with this vector as **u** 0 during the following training step. With this trick it is enough to do a single iteration of the power method at each training step. The power method is usually not differentiated through. 

**Fantasic Four** proposed, in [29], allows upper bounding the Lipschitz constant of a convolution. The given bound is generally not tight, so using the method directly does not give good results. Nevertheless, since various methods require a way of bounding the spectral norm to have convergence guarantees, Fantastic Four is often used. 

## **B. Algorithms omitted in the main paper** 

Observe that the strategies presented in [8, 14, 20, 23, 26, 36, 41] have intentionally not been compared for different reasons. In the works presented in [8, 23], the Lipschitz constraint was solely used during training and no guarantees were provided that the resulting layers are 1-Lipschitz. The method proposed in [26] has been extended by Fantastic 4 [29] and, indeed, can only be used as an auxiliary method to upper-bound the Lispchitz constant. The method proposed in [20] only works for linear layers and can be thought of as a special case of SOC (described in Section 2). We will give detailed reasons for the other methods below. 

11 

**ONI** The method ONI [14] proposed the orthogonalization used in LOT. They parameterize orthogonal matrices as ( _V V[⊤]_ ) _[−]_ 2[1] _V_ , and calculate the inverse square root using Newton’s iterations. They use this methods to define 1-Lipschitz linear layers. However, the extension to convolutions only uses a simple unrolling, and does not provide a tight bound in general. Therefore, we did not include the method in the paper. 

**ECO** _Explicitly constructed orthogonal (ECO)_ convolutions [41] also do use properties of the Fourier domain in order to parameterize a convolution. However, they do not actually calculate the convolution in the Fourier domain, but instead parameterize a layer in the Fourier domain, and then use an inverse Fourier transformation to obtain a kernel from this parameterization. We noticed, however, that the implementation provided by the authors does not produce 1-Lipschitz layers (at least with our architecture), as can be seen in Figure 6. There, we report the _batch activation variance_ (defined in Appendix F) as well as the spectral norm of each layer. The _batch activation variance_ should be non-increasing for 1- Lipschitz layers (also see Appendix F), however, for ECO this is not the case. Also, power iteration shows that the Lipschitz constant of individual layers is not 1. Therefore we do not report this method in the main paper. 

**==> picture [449 x 112] intentionally omitted <==**

**----- Start of picture text -----**<br>
2 [8] Activation Variances 2 [14] Cumulative Lipschitz Constant<br>2 [13]<br>2 [7] 2 [12]<br>2 [11]<br>2 [6] 2 [10]<br>2 [9]<br>2 [5] 2 [8]<br>2 [7]<br>2 [4] 22 [6][5]<br>2 [3] 22 [4][3]<br>2 [2] 22 [2][1]<br>2 [0]<br>2 [1]<br>0 10 20 30 40 50 60 0 10 20 30 40 50 60 70<br>Layer Index Layer Index<br>Upper bound<br>Activation Variance<br>**----- End of picture text -----**<br>


Figure 6. **Left:** Variance of a validation batch over the batch dimension. For 1-Lipschitz layers, this property should be non-increasing, as proven in Appendix F. **Right:** Upper bound on the Lipschitz Constant applying the power method to every linear layer, and multiplying the results. Plot for ECO on CIFAR-10, with model S. 

**Sandwich** The authors of [36] introduced the _Sandwich_ layer. It considers a layer of the form 

**==> picture [334 x 19] intentionally omitted <==**

for _σ_ typically the ReLU activation. The authors propose a (simultaneous) parameterization of _A_ and _B_ , based on the Cayley Transform, that guarantees the whole layer to be 1-Lipschitz. They also extend the idea to convolutions. However, for this they require to apply two Fourier transformations as well as two inverse ones. During the training of the models within the Sandwich layers, a severe vanishing gradient phenomena happens. We summarize the Frobenious norm of the gradient, obtained by inspecting the inner blocks during the training, in Table 3. For this reason we did not report the results in the main paper. 

## **C. Computation Complexity and Memory Requirement** 

In this section we give some intuition of the values in Table 1. 

Recall that we consider a layer with input size _s × s × c_ , and kernel size _k × k_ , batch size _b_ , and (for some layers) we will denote the number of inner iterations by _t_ . 

We also use _C_ = _bs_[2] _c_[2] _k_[2] and _M_ = _bs_[2] _c_ and _P_ = _c_[2] _k_[2] . 

**AOL:** In order to compute the rescaling matrix for AOL, we need to convolve the kernel with itself. This operation has complexity _O_ ( _c_[3] _k_[4] ). It outputs a tensor of size _c × c ×_ (2 _k −_ 1) _×_ (2 _k −_ 1), so in total we require memory of about 5 _P_ for the parameter as well as the transformation. 

12 

**BCOP:** For BCOP we only require a single convolution as long as we know the kernel. However, we do require a lot of computation to create the kernel for this convolution. In particular, we require 2 _k −_ 1 matrix orthogonalizations (usually done with Bjorck & Bowie), as well as _O_ ( _k_[3] ) matrix multiplications for building up the kernel. These require about _c_[3] _kt_ + _c_[3] _k_[3] MACS as well as _c_[2] _kt_ + _c_[2] _k_[3] memory. 

**Cayley:** Cayley Convolutions make use of the fact that circular padded convolutions are vector-matrix products in the Fourier domain. Applying the fast Fourier transform to inputs and weights has complexity of _O_ ( _bcs_[2] log( _s_[2] )) and _O_ ( _c_[2] _s_[2] log( _s_[2] )). Then, we need to orthogonalize[1] 2 _[s]_[2][matrices.][Note][that][the][factor][of] 2[1][appears][due][to][the][fact][that] the Fourier transform of a real matrix has certain symmetry properties, and we can use that fact to skip half the computations. Doing the matrix orthogonalization with the Cayley Transform requires taking the inverse of a matrix, as well as matrix multiplication, the whole process has a complexity of about _s_[2] _c_[3] . The final steps consists of doing[1] 2 _[bs]_[2][matrix-vector products,] requiring[1] 2 _[bs]_[2] _[c]_[2][ MACS, as well as another fast Fourier transform .][Note that under our assumption that] _[ c >]_[ log(] _[s]_[2][)][, the fast] Fourier transform operation is dominated by other operations. Cayley Convolutions require padding the kernel from a size of _c × c × k × k_ to a (usually much larger) size of _c × c × s × s_ requiring a lot of extra memory. In particular we need to keep the output of the (real) fast Fourier transform, the matrix inversion as well as the matrix multiplication in memory, requiring about[1] 2 _[s]_[2] _[c]_[2][ memory each.] 

**CPL:** CPL applies two convolutions as well as an activation for each layer. They also use the Power Method (on the full convolution), however, its computational cost is dominated by the application of the convolutions. 

**LOT:** Similar to Cayley, LOT performs the convolution in Fourier space. However, instead of using the Cayley transform, they parameterize orthogonal matrices as _V_ ( _V[T] V_ ) _[−]_ 2[1] . To find the inverse square root, authors relay on an iterative _Newton Method_ . In details, let _Y_ 0 = _V[T] V_ and _Z_ 0 = _I_ , then _Yi_ defined as 

**==> picture [360 x 21] intentionally omitted <==**

converges to ( _V[T] V_ ) _[−]_ 2[1] . Executing this procedure, includes computing 4 _s_[2] _t_ matrix multiplications, requiring about 4 _s_[2] _c_[3] _t_ MACS as well as 4 _s_[2] _c_[2] _t_ memory. 

**SLL:** Similar to CPL, each SLL layer also requires evaluating two convolutions as well as one activation. However, SLL also needs to compute the AOL rescaling, resulting in total computational cost of 2 _C_ + _O_ ( _c_[3] _k_[4] ). 

**SOC:** For each SOC layer we require applying _t_ convolutions. Other required operations (application of Fantastic 4 for an initial bound, as well as parameterizing the kernel such that the Jacobian is skew-symmetric) are cheap in comparison. 

Table 3. **Vanishing Gradient Phenomena of Sandwhich Layer** . ConvNetXS model has been tested with a small batch size (32). Training of deeper layers (i.e., layers that are close to the input of the network) is tough due to the almost zero gradients. 

|Layer name|Output Shape|Gradient Norm|
|---|---|---|
|First Conv (1_×_1kernel size)|(32_,_16_,_32_,_32)|3,36_·_10_−_7|
|Activation|(32_,_16_,_32_,_32)|3,36_·_10_−_7|
|Downsize Block(3)|(32_,_32_,_16_,_16)|3,79_·_10_−_6|
|Downsize Block(3)|(32_,_64_,_8_,_8)|5,56_·_10_−_5|
|Downsize Block(3)|(32_,_128_,_4_,_4)|7,83_·_10_−_4|
|Downsize Block(3)|(32_,_256_,_2_,_2)|8,15_·_10_−_3|
|Downsize Block(1)|(32_,_512_,_1_,_1)|1,04_·_10_−_1|
|Flatten|(32_,_512)|1,04_·_10_−_1|
|Linear|(32_,_512)|1,82_·_10_−_1|
|First Channels|(32_,_10)|1,82_·_10_−_1|



13 

Table 4. **SOTA from the literature on CIFAR-10** sorted by publication date (from older to newer). Readers can note that there is a clear trend of increasing the model dimension to achieve higher robust accuracy. 

|Method<br>Std.Acc [%]|Certifable Accuracy [%]<br>_ε_=<br>36<br>255 _ε_=<br>72<br>255 _ε_= 108<br>255 _ε_= 1|Number of<br>Parameters|
|---|---|---|
||||
|**BCOP Large**[22]<br>72.1<br>**Cayley KW-Large**[34]<br>75.3<br>**SOC LipNet-25**[30]<br>76.4<br>**AOL Large**[28]<br>71.6<br>**LOT LipNet-25**[40]<br>76.8<br>**SOC LipNet-15 + CRC**[31]<br>79.4<br>**CPL XL**[25, Table1]<br>78.5<br>**SLL X-Large**[2]<br>73.3|58.2<br>-<br>-<br>-<br>59.1<br>-<br>-<br>-<br>61.9<br>-<br>-<br>-<br>64.0<br>56.4<br>49.0<br>23.7<br>64.4<br>49.8<br>37.3<br>-<br>67.0<br>52.6<br>38.3<br>-<br>64.4<br>48.0<br>33.0<br>-<br>65.8<br>58.4<br>51.3<br>27.3|2M<br>2M<br>24M<br>136M<br>27M<br>21M<br>236M<br>236M|



Table 5. **Architecture.** It depends on width parameter _w_ , kernel size _k_ ( _k ∈{_ 1 _,_ 3 _}_ ) and the number of classes _c_ . For details of the _Downsize Block_ see Tab. 6. 

|Layer name|Output size|
|---|---|
|Input|32_×_32_×_3|
|Zero Channel Padding|32_×_32_× w_|
|Conv (1_×_1kernel size)|32_×_32_× w_|
|Activation|32_×_32_× w_|
|Downsize Block(_k_)|16_×_16_×_2_w_|
|Downsize Block(_k_)|8_×_8_×_4_w_|
|Downsize Block(_k_)|4_×_4_×_8_w_|
|Downsize Block(_k_)|2_×_2_×_16_w_|
|Downsize Block(1)|1_×_1_×_32_w_|
|Flatten|32_w_|
|Linear|32_w_|
|First Channels(_c_)|_c_|



## **D. Comparison with SOTA** 

In this section, we report state-of-the-art results from the literature. In contrast to our comparison, the runs reported often use larger architectures and longer training times. Find results in Table Tab. 4. 

## **E. Experimental Setup** 

In addition to theoretically analyzing different proposed layers, we also do an empirical comparison of those layers. In order to allow for a fair and meaningful comparison, we try to fix the architecture, loss function and optimizer, and evaluate all proposed layers with the same setting. 

From the data in Table 1 we know that different layers will have very different throughputs. In order to have a fair comparison despite of that, we limit the total training time instead of fixing a certain amount of training epochs. We report results of training for 2h, 10h as well as 24h. 

We describe the chosen setting below. 

## **E.1. Architecture** 

We show the architecture used for our experiments in Tables 5 and 6. It is a standard convolutional architecture, that doubles the number of channels whenever the resolution is reduced. Note that we exclusively use convolutions with the same input and output size as an attempt to make the model less dependent on the initialization used by the convolutional layers. We 

14 

Table 6. Downsize Block( _k_ ) with input size _s × s × t_ : 

|||Layer name|Kernel size|Output size|
|---|---|---|---|---|
|5|_×_|�Conv<br>Activation|_k × k_<br>-|_s × s × t_<br>_s × s × t_|
|||First Channels|-|_s × s × t/_2|
|||Pixel Unshuffe|-|_s/_2_× s/_2_×_2_t_|



Table 7. Number of parameters for different model sizes, as well as the _width parameter w_ such that the architecture in Tab. 5 has the correct size. 

|Size|Parameters (millions)|_w_|
|---|---|---|
|XS|1_< p <_2|16|
|S|4_< p <_8|32|
|M|16_< p <_32|64|
|L|64_< p <_128|128|



use kernel size 3 in all our main experiments. The layer _Zero Channel Padding_ in Table 5 just appends channels with value 0 to the input, and the layer _First Channels(c)_ outputs only the first _c_ channels, and ignores the rest. Finally, the layer _Pixel Unshuffle_ (implemented in _PyTorch_ ) takes each 2 _×_ 2 _× c_ patches of an image and reshapes them into size 1 _×_ 1 _×_ 4 _c_ . 

For each 1-Lipschitz layer, we also test architectures of different sizes. In particular, we define 4 categories of models based on the number of parameters. We call those categories XS, S, M and L. See Table 7 for the exact numbers. In this table we also report the _width parameter w_ that ensures our architecture has the correct number of parameters. 

**Remark 2.** For most methods, the number of parameters per layer are about the same. There are two exceptions, BCOP and Sandwich. BCOP parameterizes the convolution kernel with _c_ input channels and _c_ output channels using a matrix of size _c × c_ and 2( _k −_ 1) matrices of size _c × c/_ 2. Therefore, the number of parameters of a convolution using BCOP is _kc_[2] , less than the _k_[2] _c_[2] parameters of a plain convolution. The Sandwich layer has about twice as many parameters as the other layers for the same width, as it parameterizes two weight matrices, _A_ and _B_ in Equation (12), per layer. 

## **E.2. Loss function** 

We use the loss function proposed by [28], with the temperature parameter set to the value used there ( _t_ = 1 _/_ 4). Our goal metric is certified robust accuracy for perturbation of maximal size _ϵ_ = 36 _/_ 255. We aim at robustness of maximal size 2 _ϵ_ during training. In order to achieve that we set the margin parameter to 2 _√_ 2 _ϵ_ . 

## **E.3. Optimizer** 

We use SGD with a momentum of 0.9 for all experiments. We also used a learning rate schedule. We choose to use _OneCycleLR_ , as described by [32], with default values as in _PyTorch_ . We set the batch size to 256 for all experiments. 

## **E.4. Training Time** 

On of our main goals is to evaluate what is the best model to use given a certain time budget. In order to do this, we measure the time per epoch as described in Section 4.1 on an A100 GPU with 80GB memory for different methods and different model sizes. Then we estimate the number of epochs we can do in our chosen time budget of either 2h, 10h or 24h, and use that many epochs to train our models. The amount of epochs corresponding to the given time budget is summarized in Table 8. 

## **E.5. Hyperparameter Random Search** 

The learning rate and weight decay for each setting (model size, method and dataset) was tuned on the validation set. For each method we did hyperparameter search by training for 2 _h_ (corresponding number of epochs in Table 8). We did 16 

15 

Table 8. Budget of training epochs for different model sizes, layer types and datasets. Batch size and training time are set to be 256 and 2h respectively for all the architectures. 

||CIFAR<br>TinyImageNet<br>XS<br>S<br>M<br>L<br>XS<br>S<br>M<br>L|CIFAR<br>TinyImageNet<br>XS<br>S<br>M<br>L<br>XS<br>S<br>M<br>L|
|---|---|---|
||||
|**AOL**<br>**BCOP**<br>**CPL**<br>**Cayley**<br>**ECO**<br>**LOT**<br>**SLL**<br>**SOC**|837 763 367<br>83<br>127 125<br>94<br>24<br>836 797 522<br>194<br>356 214<br>70<br>17<br>399 387 290<br>162<br>222 68<br>11<br>-<br>735 703 353<br>79<br>371 336 201<br>77|223 213 123<br>34<br>50<br>50<br>39<br>11<br>240 194 148<br>63<br>138 86<br>30<br>8<br>142 131<br>95<br>54<br>83<br>29<br>5<br>-<br>242 194 118<br>32<br>122 87<br>63<br>27|
||||
|**Param.s (M)**†|1.57 6.28 25.12 100.46|1.58 6.29 25.16 100.63|



> † BCOP has less parameters overall, see Remark 2. 

runs with learning-rate of the form 10 _[x]_ , where _x_ is sampled uniformly in the interval [ _−_ 4 _, −_ 1], and with weight-decay of the form 10 _[x]_ , where _x_ is sampled uniformly in the interval [ _−_ 5 _._ 5 _, −_ 3 _._ 5]. Finally, we selected the learning rate and weight decay corresponding to the run with the highest validation certified robust accuracy for radius 36 _/_ 255. We use these hyperparameters found also for the experiments with longer training time. 

## **E.6. Datasets** 

We evaluate on three different datasets, CIFAR-10, CIFAR-100 [16] and Tiny ImageNet [18]. 

For CIFAR-10 and CIFAR-100 we use the architecture described in Table 5. Since the architectures are identical, so are time- and memory requirements, and therefore also the epoch budget. As preprocessing we subtract the dataset channel means from each image. As data augmentation at training time we apply random crops (4 pixels) and random flipping. 

In order to assess the behavior on larger images, we replicate the evaluation on the Tiny ImageNet dataset [18]: a subset of 200 classes of the ImageNet [11] dataset, with images scaled to have size 64 _×_ 64. 

In order to allow for the larger input size of this dataset, we add one additional _Downsize Block_ to our model. We also divide the width parameter (given in Table 7) by 2 to keep the amount of parameters similar. We again subtract the channel mean for each image. As data augmentation we we us _RandAugment_ [10] with 2 transformations of magnitude 9 (out of 31). 

## **E.7. Metrics** 

As described in Section 4.1 we evaluate the methods in terms of three main metrics. The throughput, the memory requirements as well and the certified robust accuracy a model can achieve in a fixed amount of time. 

The evaluation of the _throughput_ is performed on an NVIDIA A100 80GB PCIe GPU[*] . We measure it by averaging the time it takes to process 100 batches (including forward pass, backward pass and parameter update), and use this value to calculate the average number of examples a model can process per second. In order to estimate the inference throughput, we first evaluate and cache all calculations that do not depend on the input (such as power iterations on the weights). With this we measure the average time of the forward pass of 100 batches, and calculate the throughput from that value. 

## **F. Batch Activation Variance** 

As one (simple to compute) sanity check that the models we train are actually 1-Lipschitz, we consider the _batch activation variance_ . For layers that are 1-Lipschitz, we show below that the batch activation variance cannot increase from one layer to the next. This gives us a mechanism to detect (some) issues with trained models, including numerical ones, conceptual ones as well as problems in the implementation. 

> *https://www.nvidia.com/content/dam/en-zz/Solutions/Data-Center/a100/pdf/PB-10577-001 ~~v~~ 02.pdf 

16 

To compute the batch activation variance we consider a mini-batch of inputs, and for this mini-batch we consider the outputs of each layer. Denote the outputs of layer _l_ as _a_[(] 1 _[l]_[)] _[, . . . , a]_[(] _b[l]_[)][, where] _[ b]_[ is the batch size.][Then we set] 

**==> picture [321 x 65] intentionally omitted <==**

where the _l_ 2 norm is calculated based on the flattened tensor. Denote layer _l_ as _fl_ . Then we have that 

**==> picture [339 x 115] intentionally omitted <==**

Here, for the first inequality we use that (by definition) _a_[(] _i[l]_[+1)] = _fl_ ( _a_[(] _i[l]_[)][)][ and that the term][ �] _[n] i_ =1 _[∥][a] i_[(] _[l]_[+1)] _− x∥_ 2[2][is minimal for] _x_ = _µ_[(] _[l]_[+1)] . The second inequality follows from the 1-Lipschitz property. The equation above shows that the batch activation variance can not increase from one layer to the next for 1-Lipschitz layers. Therefore, if we see an increase in experiments that shows that the layer is not actually 1-Lipschitz. 

As a further check that the layers are 1-Lipschitz we also apply (convolutional) power iteration to each linear layer after training. 

## **G. Further Experimental Results** 

In this section, further experiments –not presented in the main paper— can be found. 

## **G.1. Different training time budgets** 

In this section we report the experimental results for three different training budgets: 2 _h_ , 10 _h_ and 24 _h_ . See the results in Table 9 (CIFAR-10), Table 10 (CIFAR-100), and Table 11 (Tiny ImageNet). Each of those tables also reports the best learning rate and weight decay found by the random search for each setting. Furthermore, a different representation of the impact of the training time on the robust accuracy can be found in Figure 7. 

## **G.2. Time and Memory Requirements on Tiny ImageNet** 

See plot Fig. 8 for an evaluation of time and memory usage for Tiny ImageNet dataset. The models used on CIFAR-10 and the ones on Tiny ImageNet are identical up to one convolutional block, therefore also the results in Figure 8 are similar to the results on CIFAR-10 reported in the main paper. 

## **G.3. Kernel size** 1 _×_ 1 

For CIFAR-10 dataset, we tested models where convolutional layers have a kernel size of 1 _×_ 1, to evaluate if the quicker epoch time can compensate for the lower number of parameters. In almost all cases the answer was negative, the version with 3 _×_ 3 kernel outperformed the one with the 1 _×_ 1 kernel.We therefore do not recommend reducing the kernel size. See Table 12 for a detailed view of the accuracy and robust accuracy. 

## **G.4. Clean Accuracy** 

As a reference, we plotted the accuracy of different models in Figure 9. The rankings by accuracy are similar to the rankings by certified robust accuracy. One difference is that the Cayley method performs better relative to other methods when measured in terms of accuracy. 

17 

**==> picture [496 x 342] intentionally omitted <==**

**----- Start of picture text -----**<br>
ConvNetXS ConvNetS<br>0.675<br>AOL<br>0.650 BCOP<br>CPL<br>0.625<br>Cayley<br>LOT<br>0.600<br>SLL<br>0.575 SOC<br>0.550<br>0.525<br>0.500<br>ConvNetM ConvNetL<br>0.675<br>0.650<br>0.625<br>0.600<br>0.575<br>0.550<br>0.525<br>0.500<br>2h 10h 24h 2h 10h 24h<br>training_time training_time<br>Robust Accuracy<br>Robust Accuracy<br>**----- End of picture text -----**<br>


Figure 7. Line plots of the robust accuracy for various methods where models are training with different time budgets 

## **H. Issues and observations** 

As already thoroughly analyzed in the dedicated section, some of the known methods in the literature have been omitted in the main paper since we faced serious concerns. Nevertheless, we also encountered some difficulties during the implementation of the methods that we did report in the main paper. The aim of this section is to highlight these difficulties, we hope this can open a constructive debate. 

1. In the SLL [2] code, taken from the authors’ repository, there is no attention to numerical errors that can easily happen from close-to-zero divisions during the parameter transformation. We solve the issue, by adopting the commonly used strategy, i.e. we included a factor of 1 _·_ 10 _[−]_[6] while dividing for the AOL-rescaling of the weight matrix. Furthermore, the code provided in the SLL repository only works for a kernel size of 3, we fixed the issue in our implementation. 

2. The CPL method [25] features a high sensitivity to the initialization of the weights. Long training, e.g. 24-hour training, can sometimes result in _NaN_ during the update of the weights. In that case we re-ran the models with different seeds. 

3. Furthermore, there was no initialization method stated in the CPL paper, and also no code was provided. Therefore, we used the initialization from the similar SLL method. 

4. During the training of Sandwich we faced some numerical errors. To investigate such errors, we tested a lighter version of the method — without the learnable rescaling Ψ — for the reason described in Remark 3, which shows that the rescaling Ψ inside the layer can be embedded into the bias term and hence the product ΨΨ _[−]_[1] can be omitted. 

5. Similarly, for SLL, the matrix _Q_ in Equation (8) does not add additional degrees of freedom to the model. Instead of having parameters _W_ , _Q_ and _b_ we could define and optimize over _P_ = _WQ[−]_[1] and[˜] _b_ = _Q[−]_[1] _b_ . However, for our experiments we used the original parameterization. 

6. The method Cayley [34], in the form proposed in the original paper, does not cache the — costly — transformation of the weight matrix whenever the layer is in inference mode. We fix this issue in our implementation. 

18 

Figure 8. Measured time and memory requirements on Tiny ImageNet. 

**==> picture [494 x 477] intentionally omitted <==**

**----- Start of picture text -----**<br>
Training time per epoch 64 GB Memory required training<br>8 min AOL AOL<br>32 GB<br>4 min BCOP BCOP<br>CPL 16 GB CPL<br>2 min Cayley Cayley<br>8 GB<br>1 min LOT LOT<br>30 sec SLL 4 GB SLL<br>SOC SOC<br>15 sec Standard 2 GB Standard<br>7.5 sec 1 GB<br>XS S M L XS S M L<br>Model Size Model Size<br>Inference Throughput per second Memory required forward<br>2 [15]<br>AOL 4 GB AOL<br>2 [14]<br>BCOP BCOP<br>2 [13] CPL 2 GB CPL<br>2 [12] Cayley 1 GB Cayley<br>LOT LOT<br>2 [11] SLL 500 MB SLL<br>2 [10] SOC 250 MB SOC<br>Standard Standard<br>2 [9]<br>125 MB<br>TXS TS TM TL XS S M L<br>Model Size Model Size<br>Accuracy for CIFAR10<br>80 AOL<br>BCOP<br>CPL<br>75 Cayley<br>LOT<br>SLL<br>70 SOC<br>65<br>Model<br>Accuracy for CIFAR100 Accuracy for TinyImageNet<br>34<br>48<br>32<br>46<br>44 30<br>42<br>28<br>40<br>38 26<br>Model Model<br>Time<br>Memory (GB)<br>Memory<br>Throughput (examples/s)<br>Accuracy [%] SOC - M SOC - L CPL - L CPL - M LOT - S CPL - S LOT - XS SLL - M SOC - S CPL - XS BCOP - L Cayley - M SLL - L SLL - S Cayley - S SOC - XS BCOP - M AOL - L SLL - XS AOL - S Cayley - L AOL - M Cayley - XS BCOP - S LOT - M AOL - XS BCOP - XS<br>Accuracy [%] SOC - M SOC - L SOC - S CPL - M LOT - S AOL - M CPL - L Cayley - S BCOP - M Cayley - M Accuracy [%] LOT - S SOC - L SOC - M LOT - XS CPL - L AOL - M Cayley - M AOL - L CPL - M Cayley - S<br>**----- End of picture text -----**<br>


Figure 9. Barplots of models sorted by decreasing clean accuracy. For CIFAR-100 and Tiny ImageNet only the 10 best performing models are shown. 

7. The LOT method, [40], leverages 10 inner iterations for both training and inference in order to estimate the inverse of the square root with their proposed Newton-like method. Since the gradient is tracked for the whole procedure, the amount of memory required during the training is prohibitive for large models. Furthermore, since the memory is required for the parameter transformation, reducing the batch size does not solve this problem. In order to make the Large model (L) fit in the memory, we tested the LOT method with only 2 inner iterations. However, the performance in terms of accuracy and robust accuracy is not comparable to other strategies, hence we omitted it from our tables. 

- **Remark 3.** The learnable parameter Ψ of the sandwich layer corresponds to a scaling of the bias. In details, for each 

19 

parameters _A, B, b_ and Ψ = diag � _e[d][i]_[�] there exists a rescaling of the bias[˜] _b_ such that 

**==> picture [393 x 19] intentionally omitted <==**

_Proof._ Observing that for each _α >_ 0 and _x ∈_ R, ReLU ( _αx_ ) = _α_ ReLU ( _x_ ), and that 

**==> picture [139 x 43] intentionally omitted <==**

the following identity holds 

**==> picture [349 x 85] intentionally omitted <==**

Considering[˜] _b_ = Ψ _b_ concludes the proof. 

## **I. Code** 

We often build on code provided with the original papers. This includes 

- https://github.com/berndprach/AOL (AOL) 

- https://github.com/ColinQiyangLi/LConvNet (BCOP) 

- https://github.com/locuslab/orthogonal-convolutions (Cayley) 

- https://github.com/AI-secure/Layerwise-Orthogonal-Training (LOT) 

- https://github.com/acfr/LBDN (Sandwich) 

- https://github.com/araujoalexandre/Lipschitz-SLL-Networks (SLL) 

- https://github.com/singlasahil14/SOC (SOC) 

We are grateful for authors providing code to the research community. 

20 

Table 9. Standard and Robust Accuracy on **CIFAR-10** . We also report the best learning rate and weight decay found by a random search. 

|Training Time<br>Layer<br>Model<br>LR<br>WD|Accuracy [%]<br>2h<br>10h<br>24h|Robust Accuracy [%]<br>2h<br>10h<br>24h|
|---|---|---|
||||
|**AOL**<br>**XS**<br>**6**_·_**10**_−_**2**<br>**4**_·_**10**_−_**5**<br>**S**<br>**1**_·_**10**_−_**2**<br>**5**_·_**10**_−_**5**<br>**M**<br>**2**_·_**10**_−_**2**<br>**1**_·_**10**_−_**4**<br>**L**<br>**2**_·_**10**_−_**2**<br>**7**_·_**10**_−_**5**<br>**BCOP**<br>**XS**<br>**7**_·_**10**_−_**3**<br>**3**_·_**10**_−_**4**<br>**S**<br>**4**_·_**10**_−_**3**<br>**8**_·_**10**_−_**5**<br>**M**<br>**6**_·_**10**_−_**3**<br>**7**_·_**10**_−_**6**<br>**L**<br>**1**_·_**10**_−_**3**<br>**9**_·_**10**_−_**6**<br>**CPL**<br>**XS**<br>**3**_·_**10**_−_**2**<br>**1**_·_**10**_−_**4**<br>**S**<br>**7**_·_**10**_−_**2**<br>**1**_·_**10**_−_**4**<br>**M**<br>**8**_·_**10**_−_**2**<br>**1**_·_**10**_−_**4**<br>**L**<br>**5**_·_**10**_−_**2**<br>**3**_·_**10**_−_**4**<br>**Cayley XS**<br>**2**_·_**10**_−_**2**<br>**2**_·_**10**_−_**5**<br>**S**<br>**1**_·_**10**_−_**2**<br>**1**_·_**10**_−_**5**<br>**M**<br>**1**_·_**10**_−_**2**<br>**6**_·_**10**_−_**6**<br>**L**<br>**8**_·_**10**_−_**3**<br>**2**_·_**10**_−_**4**<br>**LOT**<br>**XS**<br>**8**_·_**10**_−_**2**<br>**4**_·_**10**_−_**6**<br>**S**<br>**3**_·_**10**_−_**2**<br>**7**_·_**10**_−_**5**<br>**M**<br>**2**_·_**10**_−_**2**<br>**9**_·_**10**_−_**6**<br>**SLL**<br>**XS**<br>**9**_·_**10**_−_**2**<br>**2**_·_**10**_−_**5**<br>**S**<br>**4**_·_**10**_−_**2**<br>**2**_·_**10**_−_**4**<br>**M**<br>**9**_·_**10**_−_**2**<br>**9**_·_**10**_−_**5**<br>**L**<br>**6**_·_**10**_−_**2**<br>**2**_·_**10**_−_**4**<br>**SOC**<br>**XS**<br>**5**_·_**10**_−_**2**<br>**7**_·_**10**_−_**6**<br>**S**<br>**2**_·_**10**_−_**2**<br>**2**_·_**10**_−_**5**<br>**M**<br>**7**_·_**10**_−_**2**<br>**1**_·_**10**_−_**4**<br>**L**<br>**2**_·_**10**_−_**2**<br>**2**_·_**10**_−_**4**|68.5<br>71.7<br>71.7<br>70.9<br>73.0<br>73.6<br>70.3<br>73.4<br>73.4<br>64.7<br>71.8<br>73.7<br>69.0<br>70.8<br>71.7<br>70.6<br>72.5<br>73.1<br>71.8<br>73.6<br>74.0<br>67.6<br>73.2<br>74.6<br>71.7<br>74.3<br>74.9<br>73.9<br>74.1<br>76.1<br>74.3<br>76.4<br>76.6<br>72.6<br>76.5<br>76.8<br>71.3<br>73.2<br>73.1<br>71.9<br>73.6<br>74.2<br>70.2<br>73.5<br>74.4<br>61.3<br>71.1<br>73.6<br>73.5<br>75.2<br>75.5<br>70.5<br>75.0<br>76.6<br>61.4<br>69.3<br>72.0<br>69.9<br>73.1<br>73.7<br>72.9<br>74.0<br>74.2<br>70.5<br>74.4<br>75.3<br>56.7<br>72.7<br>74.3<br>68.9<br>72.9<br>74.1<br>67.3<br>73.3<br>75.0<br>73.1<br>77.0<br>76.9<br>62.3<br>73.8<br>76.9|55.6<br>58.8<br>**59.1**<br>57.9 **61.0**<br>60.8<br>57.0<br>60.7<br>**61.0**<br>51.4<br>59.0<br>**61.5**<br>55.0<br>57.6<br>**58.5**<br>57.5<br>59.1<br>**59.3**<br>57.9<br>59.9<br>**60.5**<br>52.5<br>59.7<br>**61.5**<br>58.2<br>61.7<br>**62.5**<br>61.1<br>61.1<br>**64.2**<br>61.6<br>64.7<br>**65.1**<br>59.1<br>64.5<br>**65.2**<br>57.2<br>59.4<br>**59.5**<br>58.1<br>60.0<br>**61.1**<br>55.8<br>60.2<br>**61.0**<br>45.9<br>57.0<br>**60.1**<br>59.6<br>62.7<br>**63.4**<br>56.4<br>62.3<br>**64.6**<br>45.7<br>54.7<br>**58.7**<br>56.4<br>59.9<br>**61.0**<br>59.8<br>61.4<br>**62.0**<br>57.4<br>61.5<br>**62.8**<br>38.9<br>60.0<br>**62.3**<br>55.1<br>60.0<br>**61.3**<br>53.2<br>60.8<br>**62.9**<br>60.3<br>66.0<br>**66.3**<br>46.2<br>60.8<br>**65.4**|



21 

Table 10. Standard and Robust Accuracy on **CIFAR-100** . We also report the best learning rate and weight decay found by a random search. 

|Training Time<br>Layer<br>Model<br>LR<br>WD|Accuracy [%]<br>2h<br>10h<br>24h|Robust Accuracy [%]<br>2h<br>10h<br>24h|
|---|---|---|
||||
|**AOL**<br>**XS**<br>**3**_·_**10**_−_**2**<br>**1**_·_**10**_−_**4**<br>**S**<br>**2**_·_**10**_−_**2**<br>**2**_·_**10**_−_**5**<br>**M**<br>**7**_·_**10**_−_**2**<br>**6**_·_**10**_−_**6**<br>**L**<br>**6**_·_**10**_−_**2**<br>**4**_·_**10**_−_**5**<br>**BCOP**<br>**XS**<br>**8**_·_**10**_−_**3**<br>**3**_·_**10**_−_**4**<br>**S**<br>**6**_·_**10**_−_**3**<br>**3**_·_**10**_−_**4**<br>**M**<br>**2**_·_**10**_−_**3**<br>**2**_·_**10**_−_**4**<br>**L**<br>**4**_·_**10**_−_**3**<br>**1**_·_**10**_−_**5**<br>**CPL**<br>**XS**<br>**9**_·_**10**_−_**2**<br>**3**_·_**10**_−_**5**<br>**S**<br>**9**_·_**10**_−_**2**<br>**2**_·_**10**_−_**4**<br>**M**<br>**4**_·_**10**_−_**2**<br>**4**_·_**10**_−_**5**<br>**L**<br>**9**_·_**10**_−_**2**<br>**2**_·_**10**_−_**4**<br>**Cayley XS**<br>**4**_·_**10**_−_**2**<br>**2**_·_**10**_−_**5**<br>**S**<br>**2**_·_**10**_−_**2**<br>**1**_·_**10**_−_**4**<br>**M**<br>**6**_·_**10**_−_**3**<br>**4**_·_**10**_−_**6**<br>**L**<br>**5**_·_**10**_−_**3**<br>**2**_·_**10**_−_**5**<br>**LOT**<br>**XS**<br>**6**_·_**10**_−_**2**<br>**3**_·_**10**_−_**4**<br>**S**<br>**5**_·_**10**_−_**2**<br>**2**_·_**10**_−_**4**<br>**M**<br>**4**_·_**10**_−_**2**<br>**9**_·_**10**_−_**5**<br>**SLL**<br>**XS**<br>**5**_·_**10**_−_**2**<br>**6**_·_**10**_−_**5**<br>**S**<br>**1**_·_**10**_−_**1**<br>**7**_·_**10**_−_**5**<br>**M**<br>**7**_·_**10**_−_**2**<br>**2**_·_**10**_−_**4**<br>**L**<br>**9**_·_**10**_−_**2**<br>**8**_·_**10**_−_**5**<br>**SOC**<br>**XS**<br>**7**_·_**10**_−_**2**<br>**2**_·_**10**_−_**4**<br>**S**<br>**9**_·_**10**_−_**2**<br>**1**_·_**10**_−_**4**<br>**M**<br>**4**_·_**10**_−_**2**<br>**3**_·_**10**_−_**4**<br>**L**<br>**7**_·_**10**_−_**2**<br>**3**_·_**10**_−_**5**|37.9<br>40.1<br>40.3<br>40.5<br>43.4<br>43.4<br>40.5<br>43.5<br>44.3<br>34.5<br>41.1<br>41.9<br>35.4<br>40.0<br>41.4<br>37.8<br>42.1<br>42.8<br>37.6<br>43.8<br>43.7<br>29.2<br>40.3<br>42.2<br>39.7<br>42.0<br>42.3<br>42.1<br>1.0<br>1.0<br>40.5<br>44.5<br>45.2<br>40.1<br>43.9<br>44.3<br>41.1<br>41.6<br>42.3<br>42.3<br>43.1<br>43.9<br>38.6<br>43.3<br>43.5<br>26.3<br>40.3<br>42.9<br>42.7<br>43.8<br>43.5<br>40.3<br>45.2<br>45.2<br>28.4<br>38.9<br>42.8<br>37.9<br>40.9<br>41.4<br>40.0<br>41.9<br>42.8<br>39.3<br>41.9<br>42.4<br>22.0<br>38.5<br>42.1<br>40.7<br>43.1<br>43.1<br>42.2<br>44.5<br>45.2<br>41.8<br>46.2<br>47.3<br>34.7<br>43.1<br>46.2|26.6 **28.0**<br>27.9<br>29.0<br>30.8<br>**31.0**<br>28.4<br>31.1<br>**31.4**<br>23.1<br>29.2<br>**29.7**<br>22.9<br>27.8<br>**28.4**<br>24.5<br>29.5<br>**30.1**<br>24.6<br>30.4<br>**31.2**<br>17.3<br>27.2<br>**29.2**<br>27.9<br>29.8<br>**30.1**<br>**29.8**<br>0.0<br>0.0<br>27.4<br>32.4<br>**33.2**<br>27.3<br>31.5<br>**32.1**<br>27.9<br>29.2<br>**29.2**<br>28.8<br>30.4<br>**30.5**<br>25.3<br>29.9<br>**30.5**<br>14.3<br>27.0<br>**29.5**<br>29.4 **30.9**<br>30.8<br>27.2<br>31.8<br>**32.5**<br>15.5<br>25.9<br>**29.6**<br>25.9 **29.0**<br>28.9<br>28.4<br>29.9<br>**30.5**<br>27.0 **30.0**<br>29.9<br>10.8<br>26.4<br>**29.6**<br>27.7<br>29.7<br>**30.6**<br>29.3<br>31.9<br>**32.6**<br>28.8<br>33.5<br>**34.9**<br>21.5<br>30.2<br>**33.5**|



22 

Table 11. Experimental results on the **TinyImageNet** dataset. 

|Training Time<br>Layer<br>Model<br>LR<br>WD|Accuracy [%]<br>2h<br>10h<br>24h|Robust Accuracy [%]<br>2h<br>10h<br>24h|
|---|---|---|
||||
|**AOL**<br>**XS**<br>**3**_·_**10**_−_**2**<br>**2**_·_**10**_−_**5**<br>**S**<br>**7**_·_**10**_−_**2**<br>**5**_·_**10**_−_**6**<br>**M**<br>**4**_·_**10**_−_**2**<br>**8**_·_**10**_−_**6**<br>**L**<br>**2**_·_**10**_−_**2**<br>**8**_·_**10**_−_**6**<br>**BCOP**<br>**XS**<br>**6**_·_**10**_−_**4**<br>**5**_·_**10**_−_**5**<br>**S**<br>**7**_·_**10**_−_**4**<br>**4**_·_**10**_−_**5**<br>**M**<br>**3**_·_**10**_−_**4**<br>**1**_·_**10**_−_**4**<br>**L**<br>**1**_·_**10**_−_**4**<br>**3**_·_**10**_−_**4**<br>**CPL**<br>**XS**<br>**1**_·_**10**_−_**1**<br>**9**_·_**10**_−_**6**<br>**S**<br>**4**_·_**10**_−_**2**<br>**3**_·_**10**_−_**5**<br>**M**<br>**4**_·_**10**_−_**2**<br>**2**_·_**10**_−_**5**<br>**L**<br>**6**_·_**10**_−_**2**<br>**1**_·_**10**_−_**5**<br>**Cayley XS**<br>**8**_·_**10**_−_**3**<br>**8**_·_**10**_−_**5**<br>**S**<br>**5**_·_**10**_−_**3**<br>**7**_·_**10**_−_**5**<br>**M**<br>**4**_·_**10**_−_**3**<br>**4**_·_**10**_−_**5**<br>**L**<br>**1**_·_**10**_−_**3**<br>**3**_·_**10**_−_**4**<br>**LOT**<br>**XS**<br>**3**_·_**10**_−_**2**<br>**2**_·_**10**_−_**4**<br>**S**<br>**5**_·_**10**_−_**2**<br>**1**_·_**10**_−_**4**<br>**M**<br>**2**_·_**10**_−_**2**<br>**6**_·_**10**_−_**6**<br>**SLL**<br>**XS**<br>**7**_·_**10**_−_**2**<br>**3**_·_**10**_−_**4**<br>**S**<br>**4**_·_**10**_−_**2**<br>**2**_·_**10**_−_**4**<br>**M**<br>**5**_·_**10**_−_**2**<br>**5**_·_**10**_−_**5**<br>**L**<br>**7**_·_**10**_−_**2**<br>**1**_·_**10**_−_**4**<br>**SOC**<br>**XS**<br>**9**_·_**10**_−_**2**<br>**1**_·_**10**_−_**4**<br>**S**<br>**7**_·_**10**_−_**2**<br>**2**_·_**10**_−_**5**<br>**M**<br>**7**_·_**10**_−_**2**<br>**1**_·_**10**_−_**4**<br>**L**<br>**6**_·_**10**_−_**2**<br>**1**_·_**10**_−_**4**|24.5<br>26.9<br>26.6<br>24.9<br>27.3<br>29.3<br>26.2<br>29.5<br>30.3<br>22.1<br>27.7<br>30.0<br>11.7<br>20.4<br>22.4<br>19.0<br>25.3<br>26.2<br>20.0<br>25.4<br>27.6<br>9.6<br>23.6<br>27.0<br>26.5<br>27.5<br>28.3<br>26.2<br>29.3<br>29.3<br>26.3<br>29.4<br>29.8<br>24.7<br>29.8<br>30.3<br>25.3<br>27.5<br>27.8<br>25.6<br>29.3<br>29.6<br>20.2<br>29.2<br>30.1<br>5.7<br>22.1<br>27.2<br>28.1<br>31.1<br>30.7<br>27.1<br>32.0<br>32.5<br>12.6<br>25.2<br>28.8<br>24.2<br>25.3<br>25.1<br>24.4<br>25.7<br>27.0<br>17.0<br>26.2<br>26.5<br>11.4<br>26.2<br>27.9<br>25.5<br>28.7<br>28.9<br>23.9<br>28.4<br>28.8<br>25.7<br>31.1<br>32.1<br>20.3<br>30.1<br>32.1|16.5 **18.4**<br>18.1<br>16.8<br>18.5<br>**19.7**<br>18.1<br>20.4<br>**21.0**<br>12.8<br>18.8<br>**20.6**<br>4.7<br>11.6<br>**13.8**<br>10.1<br>15.7<br>**16.9**<br>10.5<br>15.8<br>**17.2**<br>2.6<br>14.0<br>**16.8**<br>16.3<br>17.5<br>**18.9**<br>16.7<br>19.4<br>**19.7**<br>16.7<br>19.5<br>**20.3**<br>15.0<br>19.2<br>**20.1**<br>15.7 **17.9**<br>**17.9**<br>15.8<br>19.1<br>**19.5**<br>9.9<br>18.8<br>**19.3**<br>0.9<br>11.9<br>**16.7**<br>18.2<br>20.4<br>**20.8**<br>16.3<br>21.6<br>**21.9**<br>4.6<br>14.5<br>**18.1**<br>14.9 **16.7**<br>16.6<br>15.6<br>16.8<br>**18.4**<br>7.8<br>17.0<br>**17.7**<br>2.9<br>16.7<br>**18.8**<br>15.7<br>18.7<br>**18.9**<br>14.0<br>18.5<br>**18.8**<br>15.5<br>20.4<br>**21.2**<br>10.1<br>19.7<br>**21.1**|



23 

Table 12. **Kernel size** 1 _×_ 1, on CIFAR-10, for different time budgets. We report accuracy and certified robust accuracy for radius _ϵ_ = 36 _/_ 355, as well as the best learning rate and weight decay found by a random search. 

|Training Time<br>Layer<br>Model<br>LR<br>WD|Accuracy [%]<br>2h<br>10h<br>24h|Robust Accuracy [%]<br>2h<br>10h<br>24h|
|---|---|---|
||||
|**AOL**<br>**XS**<br>**8**_·_**10**_−_**2**<br>**7**_·_**10**_−_**6**<br>**S**<br>**5**_·_**10**_−_**2**<br>**4**_·_**10**_−_**5**<br>**M**<br>**2**_·_**10**_−_**2**<br>**1**_·_**10**_−_**4**<br>**L**<br>**3**_·_**10**_−_**2**<br>**8**_·_**10**_−_**5**<br>**BCOP**<br>**XS**<br>**1**_·_**10**_−_**2**<br>**7**_·_**10**_−_**5**<br>**S**<br>**4**_·_**10**_−_**3**<br>**2**_·_**10**_−_**5**<br>**M**<br>**8**_·_**10**_−_**3**<br>**5**_·_**10**_−_**6**<br>**L**<br>**4**_·_**10**_−_**3**<br>**2**_·_**10**_−_**4**<br>**BnB**<br>**XS**<br>**8**_·_**10**_−_**3**<br>**1**_·_**10**_−_**4**<br>**S**<br>**2**_·_**10**_−_**2**<br>**2**_·_**10**_−_**5**<br>**M**<br>**2**_·_**10**_−_**2**<br>**4**_·_**10**_−_**6**<br>**L**<br>**3**_·_**10**_−_**2**<br>**2**_·_**10**_−_**4**<br>**CPL**<br>**XS**<br>**2**_·_**10**_−_**2**<br>**1**_·_**10**_−_**4**<br>**S**<br>**9**_·_**10**_−_**2**<br>**9**_·_**10**_−_**5**<br>**M**<br>**1**_·_**10**_−_**1**<br>**2**_·_**10**_−_**4**<br>**L**<br>**8**_·_**10**_−_**2**<br>**9**_·_**10**_−_**6**<br>**Cayley XS**<br>**1**_·_**10**_−_**2**<br>**2**_·_**10**_−_**5**<br>**S**<br>**1**_·_**10**_−_**2**<br>**4**_·_**10**_−_**6**<br>**M**<br>**2**_·_**10**_−_**2**<br>**2**_·_**10**_−_**5**<br>**L**<br>**2**_·_**10**_−_**2**<br>**8**_·_**10**_−_**5**<br>**LOT**<br>**XS**<br>**2**_·_**10**_−_**2**<br>**2**_·_**10**_−_**4**<br>**S**<br>**5**_·_**10**_−_**2**<br>**3**_·_**10**_−_**4**<br>**SLL**<br>**XS**<br>**4**_·_**10**_−_**2**<br>**1**_·_**10**_−_**4**<br>**S**<br>**3**_·_**10**_−_**2**<br>**2**_·_**10**_−_**4**<br>**M**<br>**7**_·_**10**_−_**2**<br>**2**_·_**10**_−_**4**<br>**L**<br>**9**_·_**10**_−_**2**<br>**2**_·_**10**_−_**4**<br>**SOC**<br>**XS**<br>**7**_·_**10**_−_**2**<br>**2**_·_**10**_−_**5**<br>**S**<br>**4**_·_**10**_−_**2**<br>**6**_·_**10**_−_**6**<br>**M**<br>**3**_·_**10**_−_**2**<br>**7**_·_**10**_−_**5**<br>**L**<br>**4**_·_**10**_−_**2**<br>**9**_·_**10**_−_**5**|66.5<br>67.9<br>68.0<br>67.7<br>69.0<br>69.7<br>67.5<br>69.4<br>70.0<br>64.3<br>68.7<br>69.6<br>65.3<br>67.5<br>68.6<br>66.9<br>69.1<br>69.5<br>67.3<br>69.8<br>70.3<br>64.0<br>68.6<br>69.6<br>66.1<br>66.3<br>66.4<br>67.9<br>69.8<br>69.7<br>67.5<br>70.3<br>71.0<br>66.0<br>66.2<br>61.0<br>69.2<br>71.5<br>72.0<br>70.6<br>71.2<br>10.0<br>69.7<br>10.0<br>10.0<br>67.8<br>72.3<br>73.8<br>65.3<br>67.4<br>67.9<br>65.9<br>68.4<br>68.8<br>63.5<br>67.5<br>69.1<br>57.4<br>64.7<br>67.2<br>65.8<br>68.0<br>69.3<br>60.0<br>68.1<br>68.8<br>67.9<br>70.2<br>10.0<br>69.1<br>70.4<br>10.0<br>69.0<br>10.0<br>10.0<br>62.9<br>69.5<br>69.8<br>65.0<br>67.2<br>67.5<br>65.4<br>68.1<br>68.7<br>66.0<br>69.2<br>70.5<br>64.0<br>69.2<br>70.4|52.1<br>53.9<br>**54.3**<br>53.7<br>55.1<br>**55.6**<br>54.1<br>55.7<br>**56.7**<br>50.0<br>54.8<br>**56.1**<br>51.3<br>53.4<br>**54.5**<br>52.6<br>54.3<br>**55.4**<br>52.8<br>55.5<br>**56.1**<br>48.9<br>54.3<br>**55.8**<br>**52.1** 51.2<br>51.5<br>53.1 **55.8**<br>55.3<br>52.8<br>56.0<br>**56.8**<br>51.5 **51.7**<br>45.5<br>55.5<br>58.6<br>**59.1**<br>57.8 **58.2**<br>0.0<br>**56.1**<br>0.0<br>0.0<br>54.0<br>59.4<br>**61.1**<br>50.7<br>52.9<br>**53.8**<br>51.3<br>53.8<br>**54.5**<br>48.8<br>53.4<br>**55.0**<br>41.4<br>49.9<br>**52.9**<br>51.1<br>53.9<br>**54.9**<br>44.4<br>54.3<br>**54.5**<br>54.8 **57.3**<br>0.0<br>55.9 **57.1**<br>0.0<br>**55.5**<br>0.0<br>0.0<br>48.7<br>55.6<br>**56.1**<br>49.2<br>52.1<br>**52.3**<br>49.9<br>52.5<br>**54.2**<br>50.5<br>54.3<br>**55.6**<br>48.5<br>54.3<br>**55.9**|



24 

