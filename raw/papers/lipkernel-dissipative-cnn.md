---
title: "LipKernel: Lipschitz-Bounded Convolutional Neural Networks via Dissipative Layers"
arxiv: "2410.22258"
authors: ["Patricia Pauli", "Ruigang Wang", "Ian R. Manchester", "Frank Allg\u00f6wer"]
year: 2024
source: paper
ingested: 2026-05-02
sha256: ba35a1ee3365097fd292de2c9c2eb51f6894230af17af210fb743243347f1510
conversion: pymupdf4llm
---

# **LipKernel: Lipschitz-Bounded Convolutional Neural Networks via Dissipative Layers** _[⋆]_ 

# Patricia Pauli[a] , Ruigang Wang[c] , Ian R. Manchester[c] , Frank Allg¨ower[b] 

> a _Department of Mechanical Engineering, Eindhoven University of Technology, 5600 MB Eindhoven, Netherlands, (e-mail: p.d.pauli@tue.nl)_ 

> b _Institute for Systems Theory and Automatic Control, University of Stuttgart, 70550 Stuttgart, Germany, (e-mail: frank.allgower@ist.uni-stuttgart.de)_ 

> c _Australian Centre for Robotics and School of Aerospace, Mechanical and Mechatronic Engineering, The University of Sydney, Australia, (e-mail: {ruigang.wang, ian.manchester}@sydney.edu.au)_ 

## **Abstract** 

We propose a novel layer-wise parameterization for convolutional neural networks (CNNs) that includes built-in robustness guarantees by enforcing a prescribed Lipschitz bound. Each layer in our parameterization is designed to satisfy a linear matrix inequality (LMI), which in turn implies dissipativity with respect to a specific supply rate. Collectively, these layer-wise LMIs ensure Lipschitz boundedness for the input-output mapping of the neural network, yielding a more expressive parameterization than through spectral bounds or orthogonal layers. Our new method LipKernel directly parameterizes dissipative convolution kernels using a 2-D Roesser-type state space model. This means that the convolutional layers are given in standard form after training and can be evaluated without computational overhead. In numerical experiments, we show that the run-time using our method is orders of magnitude faster than state-of-the-art Lipschitz-bounded networks that parameterize convolutions in the Fourier domain, making our approach particularly attractive for improving the robustness of learning-based real-time perception or control in robotics, autonomous vehicles, or automation systems. We focus on CNNs, and in contrast to previous works, our approach accommodates a wide variety of layers typically used in CNNs, including 1-D and 2-D convolutional layers, maximum and average pooling layers, as well as strided and dilated convolutions and zero padding. However, our approach naturally extends beyond CNNs as we can incorporate any layer that is incrementally dissipative. 

_Key words:_ Convolutional neural networks, Lipschitz bounds, dissipativity, 2-D systems. 

## **1 Introduction** 

Deep learning architectures such as deep neural networks (NNs), convolutional neural networks (CNNs) and recurrent neural networks have ushered in a paradigm shift across numerous domains within engineering and computer science (LeCun et al., 2015). Some prominent 

_⋆_ P. Pauli was with the Institute for Systems Theory and Automatic Control, University of Stuttgart, while carrying out this work. F. Allg¨ower acknowledges that this work was funded by Deutsche Forschungsgemeinschaft (DFG, German Research Foundation) under Germany’s Excellence Strategy - EXC 2075 - 390740016 and under grant 468094890. P. Pauli thanks the International Max Planck Research School for Intelligent Systems (IMPRS-IS) for supporting her. The work of R. Wang and I. Manchester was supported in part by the Australian Research Council (DP230101014) and Google LLC. 

applications of such NNs include image and video processing tasks, natural language processing tasks, nonlinear system identification, and learning-based control (Bishop, 1994; Li et al., 2021). In these applications, NNs have been found to exceed other methods in terms of flexibility, accuracy, and scalability. However, as black box models, NNs in general lack robustness guarantees, limiting their utility for safety-critical applications. 

In particular, it has been shown that NNs are highly sensitive to small “adversarial” input perturbations (Szegedy et al., 2014). This sensitivity can be quantified by the Lipschitz constant of an NN. In learning-based control, ensuring safety and stability of closed-loop systems with a neural component often requires the gain of the NN to be bounded (Berkenkamp et al., 2017; Brunke et al., 2022; Jin and Lavaei, 2020), and the Lipschitz constant bounds the NN gain. Numerous approaches 

_Published in Automatica_ 

have been proposed for Lipschitz constant estimation (Virmaux and Scaman, 2018; Combettes and Pesquet, 2020; Fazlyab et al., 2019; Latorre et al., 2020). While calculating the Lipschitz constant is an NP-hard problem (Virmaux and Scaman, 2018; Jordan and Dimakis, 2020), computationally cheap but loose upper bounds are obtained as the product of the spectral norms of the matrices (Szegedy et al., 2014), and much tighter bounds can be determined using semidefinite programming (SDP) methods derived from robust control (Fazlyab et al., 2019; Revay et al., 2020a; Latorre et al., 2020; Pauli et al., 2023a, 2024a). 

While analysis of a given NN is of interest, it naturally raises the question of _synthesis_ of NNs with builtin Lipschitz bounds, which is the subject of the present work. Motivated by the composition property of Lipschitz bounds, most approaches assume 1-Lipschitz activation functions (Anil et al., 2019; Prach and Lampert, 2022) and attempt to constrain the Lipschitz constant (i.e., spectral bound) of matrices and convolution operators appearing in the network. However, this can be conservative, resulting in limited expressivity, i.e., the constraints restrict the ability to fit the underlying function behavior. 

To impose more sophisticated linear matrix inequality (LMI) based Lipschitz bounds, Pauli et al. (2021, 2022); Gouk et al. (2021) include constraints or regularization terms into the training problem. However, the resulting constrained optimization problem tends to have a high computational overhead, e.g., due to costly projections or barrier calculations (Pauli et al., 2021, 2022). Alternatively, Revay et al. (2020b, 2023); Wang and Manchester (2023); Pauli et al. (2023b) construct so-called _direct_ parameterizations that map free variables to the network parameters in such a way that LMIs are satisfied by design, which in turn ensures Lipschitz boundedness for equilibrium networks (Revay et al., 2020b), recurrent equilibrium networks (Revay et al., 2023), deep neural networks (Wang and Manchester, 2023), and 1- D convolutional neural networks (Pauli et al., 2023b), respectively. The major advantage of direct parameterization is that it poses the training of robust NNs as an unconstrained optimization problem, which can be tackled with existing gradient-based solvers. In this work, we develop a new direct parameterization for Lipschitzbounded CNNs. 

Lipschitz-bounded convolutions can be parameterized in the Fourier domain, as in the Orthogonal and Sandwich layers in (Trockman and Kolter, 2021; Wang and Manchester, 2023). However, this adds computational overhead of performing nonlinear operations or alternatively full-image size kernels leading to longer computation times for inference. In contrast, in this paper, we use a Roesser-type 2-D systems representation (Roesser, 1975) for convolutions (Gramlich et al., 2023; Pauli et al., 2024b). This in turn allows us to directly parameterize 

the kernel entries of the convolutional layers, hence we denote our method as _LipKernel_ . This direct kernel parameterization has the advantage that at inference time we can evaluate convolutional layers of CNNs in standard form, which can be advantageous for system verification and validation processes. It also results in significantly reduced compute requirements for inference compared to Fourier representations, making our approach especially suitable for real-time control systems, e.g. in robotics, autonomous vehicles, or automation. Furthermore, LipKernel offers additional flexibility in the architecture choice, enabling pooling layers and any kind of zero-padding to be easily incorporated. 

Our work extends and generalizes the results in (Pauli et al., 2023b) for parameterizing Lipschitz-bounded 1-D CNNs. In this work, we frame our method in a more general way than in (Pauli et al., 2023b) such that _any_ dissipative layer can be included in the Lipschitz-bounded NN and we discuss a generalized Lipschitz property. In doing so, we include the concept of dissipativity into the synthesis problem, which we previously only discussed for analysis problems (Pauli et al., 2023a). We then focus the detailed derivations of our layer-wise parameterizations on the important class of CNNs. One main difference to (Pauli et al., 2023b) and a key technical contribution of this work is the non-trivial extension from 1-D to 2-D CNNs, also considering a more general form including stride and dilation. Our parameterization relies on the Cayley transform, as also used in (Trockman and Kolter, 2021; Wang and Manchester, 2023). Additionally, we newly construct solutions for a specific 2-D Lyapunov equation for 2-D finite impulse response (FIR) filters, which we then leverage in our parameterization. 

The remainder of the paper is organized as follows. In Section 2, we state the problem and introduce feedforward NNs and all considered layer types. Section 3 is concerned with the dissipation analysis problem used for Lipschitz constant estimation via semidefinite programming, followed by Section 4, wherein we discuss our main results, namely the layer-wise parameterization of Lipschitz-bounded CNNs via dissipative layers. Finally, in Section 5, we demonstrate the advantage in run-time at inference time and compare our approach to other methods used to design Lipschitz-bounded CNNs. 

**Notation:** By _In_ , we mean the identity matrix of dimension _n_ . We drop _n_ if the dimension is clear from context. By S _[n]_ (S _[n]_ ++[),][we][denote][(positive][definite)][sym-] metric matrices and by D _[n]_ (D _[n]_ ++[)][we][mean][(positive] definite) diagonal matrices of dimension _n_ , respectively. By chol( _·_ ) we mean the Cholesky decomposition _L_ = chol( _A_ ) of matrix _A_ = _L[⊤] L_ . Within our paper, we study CNNs processing image signals. For this purpose, we understand an image as a sequence ( _u_ [ _i_ 1 _, . . . , id_ ]) with free variables _i_ 1 _, . . . , id ∈_ N0. In this sequence, _u_ [ _i_ 1 _, . . . , id_ ] is an element of R _[c]_ , where _c_ is called the channel dimension (e.g., _c_ = 3 for RGB images). The _signal di-_ 

2 

_mension d_ will usually be _d_ = 1 for time signals (one time dimension) and _d_ = 2 for images (two spatial dimensions). The space of such signals/sequences is denoted by _ℓ[c]_ 2 _e_[(][N] _[d]_ 0[)][:=] _[{][u]_[:][N] _[d]_ 0 _[→]_[R] _[c][}]_[.][Images][are][se-] quences in _ℓ[c]_ 2 _e_[(][N] _[d]_ 0[)][with][a][finite][square][as][support.][For] convenience, we sometimes use multi-index notation for signals, i. e., we denote _u_ [ _i_ 1 _, . . . , id_ ] as _u_ [ _**i**_ ] for _**i** ∈_ N _[d]_ 0[.] For these multi-indices, we use the notation _**i**_ + _**j**_ for ( _i_ 1 + _j_ 1 _, . . . , id_ + _jd_ ) and _**ij**_ = ( _i_ 1 _j_ 1 _, . . . , idjd_ ). We further denote by [ _**i** ,_ _**j**_ ] = _{_ _**t** ∈_ N _[d]_ 0 _[|]_ _**[i]**[≤]_ _**[t]**[≤]_ _**[j]**[}]_[the] _interval_ of all multi-indices between _**i** ,_ _**j** ∈_ N _[d]_ 0[and][by] _|_ [ _**i** ,_ _**j**_ ] _|_ the number of elements in this set and the interval [ _**i** ,_ _**j**_ [= [ _**i** ,_ _**j** −_ 1]. By _∥· ∥_ we mean the _ℓ_ 2 norm of a signal, which reduces to the Euclidean norm for vectors, i.e., signals of length 1, and _∥u∥_[2] _X_[:=][�] _**[N] i**_ =0 _[−]_[1] _[u]_[[] _**[i]**_[]] _[⊤][Xu]_[[] _**[i]**_[]] is a signal norm weighted by some positive semidefinite matrix _X ⪰_ 0 of signals of length _**N**_ . 

recover the standard Lipschitz inequality 

**==> picture [235 x 13] intentionally omitted <==**

with Lipschitz constant _ρ_ . However, through our choice of _Q_ and _R_ , we can incorporate domain knowledge and enforce tailored dissipativity-based robustness measures with respect to expected or worst-case input perturbations, including direction information. In this sense, we can view _u_ ˜ _[⊤] u_ ˜ = _u[⊤] X_ 0 _u_ = _u[⊤] L[⊤]_ 0 _[L]_[0] _[u]_[,][i.e,] _[u]_[˜][=] _[L]_[0] _[u]_[as][a] rescaling of the expected input perturbation set to the unit ball. We can also weigh changes in the output of different classes (= entries of the output vector) differently according to their importance. Singla et al. (2022) suggest a last layer normalization, which corresponds to rescaling every row of _Wl_ such that all rows have norm 1, i.e., using _LlWl_ instead of _Wl_ with some diagonal scaling matrix _Ll_ . We can interpret this scaling matrix _L[⊤] l[L][l]_[as] the output gain _Xl_ = _L[⊤] l[L][l]_[.] 

## **2 Problem Statement and Neural Networks** 

In this work, we consider deep NNs as a composition of _l_ layers 

**==> picture [189 x 11] intentionally omitted <==**

The individual layers _Lk_ , _k_ = 1 _, . . . , l_ encompass many different layer types, including but not limited to convolutional layers, fully connected layers, activation functions, and pooling layers. Some of these layers, e.g., fully connected and convolutional layers, are characterized by parameters _θk, k_ = 1 _, . . . , l,_ that are learned during training. In contrast, other layers such as activation functions and pooling layers do not contain tuning parameters. 

The mapping from the input to the NN _u_ 1 to its output _yl_ is recursively given by 

**==> picture [220 x 11] intentionally omitted <==**

where _uk ∈Dk−_ 1 and _yk ∈Dk_ are the input and the output of the _k_ -th layer and _Dk−_ 1 and _Dk_ the input and output domains. In (2), we assume that the output space of the _k_ -th layer coincides with the input space of the _k_ + 1-th layer, which is ensured by reshaping operations at the transition between different layer types. 

The goal of this work is to synthesize Lipschitz-bounded NNs, i.e., NNs of the form (1), (2) that satisfy the generalized Lipschitz condition 

**==> picture [238 x 24] intentionally omitted <==**

for given _Q ∈_ S _[c]_ ++ _[l]_[,] _[R][∈]_[S] _[c]_ ++[0][with][input][and][output] dimension _c_ 0 and _cl_ by design, and we call such NNs ( _Q, R_ )-Lipschitz NNs. Choosing _Q_ = _I_ and _R_ = _ρ_[2] _I_ , we 

**Remark 1** _To parameterize input incrementally passive (i.e. strongly monotone) NNs, i.e., NNs with mapping f_ : _D_ 0 _→Dl with equal input and output dimension c_ 0 = _cl, which satisfy_ 

**==> picture [202 x 13] intentionally omitted <==**

_one can include a residual path f_ ( _u_ ) = _µu_ + NN _θ_ ( _u_ ) _with µ >_ 0 _and constrain_ NN _θ to have a Lipschitz bound < µ, see e.g. (Chen et al., 2019; Behrmann et al., 2019; Perugachi-Diaz et al., 2021; Wang et al., 2024). Recurrent equilibrium networks extend this to dynamic models with more general incremental_ ( _QSR_ ) _-dissipativity (Revay et al., 2023)._ 

## _2.1 Problem statement_ 

To train a ( _Q, R_ )-Lipschitz NN, one can include constraints on the parameters _θ_ = ( _θk_ ) _[l] k_ =1[in][the][underly-] ing optimization problem to ensure the desired Lipschitz property. This yields a constrained optimization problem 

**==> picture [232 x 28] intentionally omitted <==**

wherein ( _x_[(] _[i]_[)] _, y_[(] _[i]_[)] ) _[m] i_ =1[are the training data,] _[ J]_[ (] _[·][,][ ·]_[) is the] training objective, e.g., the mean squared error or the cross-entropy loss, and Θ( _Q, R_ ) is the set of parameters Θ( _Q, R_ ) := _{θ |_ (3) for given _Q ∈_ S _[c]_ ++ _[l][, R][ ∈]_[S] _[c]_ ++[0] _[}][.]_ It is, however, an NP-hard problem to find constraints _θ ∈_ Θ( _Q, R_ ) that characterize all ( _Q, R_ )-Lipschitz NNs, and conventional characterizations by NNs with norm constraints are conservative. This motivates us to derive LMI constraints that hold for a large subset of ( _Q, R_ )- Lipschitz NNs. 

3 

**Problem 1** _Given some matrices Q ∈_ S _[c]_ ++ _[l][and][R][∈]_ S _[c]_[0] ++ _[, identify a subset of the parameter set]_[ Θ(] _[Q, R]_[)] _[, de-] scribed by LMIs, such that for all_ NN _θ with weights satisfying these LMIs, the generalized Lipschitz inequality_ (3) _holds._ 

To avoid projections or barrier functions to solve such a constrained optimization problem (5) as utilized in (Pauli et al., 2021, 2022), we instead use a direct parameterization _ϕ �→ θ_ . This means that we parameterize _θ_ in such a way that the underlying LMI constraints are satisfied by design. We can then train the Lipschitzbounded NN by solving an unconstrained optimization problem 

**==> picture [189 x 29] intentionally omitted <==**

using common first-order optimizers. In doing so, we optimize over the unconstrained variables _ϕ ∈_ R _[N]_ , while the parameterization ensures that the NN satisfies the LMI constraints, which in turn imply (3). This leads us to Problem 2 of finding a direct parameterization _ϕ �→ θ_ . 

**Problem 2** _Given some matrices Q ∈_ S _[c]_ ++ _[l][and][R][∈]_ S _[c]_ ++[0] _[,][construct][a][parameterization][ϕ][�→][θ][for]_[NN] _[θ][such] that_ NN _θ satisfies the generalized Lipschitz inequality_ (3) _._ 

For general dimensions _d_ , a convolutional layer maps from _Dk−_ 1 = _ℓ[c]_ 2 _[k] e[−]_[1] (N _[d]_ 0[)][to] _[D][k]_[=] _[ℓ][c]_ 2 _[k] e_[(][N] 0 _[d]_[).][Using][a][com-] pact multi-index notation, we write 

**==> picture [199 x 25] intentionally omitted <==**

where _uk_ [ _**s** k_ _**i** −_ _**t**_ ] is set to zero if _**s** k_ _**i** −_ _**t**_ is not in the domain of _uk_ [ _·_ ] to account for possible zero-padding. The convolution kernel _Kk_ [ _**t**_ ] _∈_ R _[c][k][×][c][k][−]_[1] for 0 _≤_ _**t** ≤_ _**r** k_ and the bias _bk ∈_ R _[c][k]_ characterize the convolutional layer, and the stride _**s** k_ determines by how many propagation steps the kernel is shifted along the respective propagation dimension. 

**Remark 3** _We use the causal representation_ (7) _for convolutional layers, i.e., yk_ [ _**i**_ ] _is evaluated based on past information. By shifting the kernel, we can retrieve an acausal representation_ 

**==> picture [211 x 24] intentionally omitted <==**

_with symmetric kernels. The outputs of_ (7) _and_ (8) _are shifted accordingly._ 

In this work, we focus on 1-D and 2-D CNNs whose main building blocks are 1-D and 2-D convolutional layers, respectively. A 1-D convolutional layer is a special case of (7) with _d_ = 1, given by 

## _2.2 CNN architecture_ 

This subsection defines all relevant layer types for the parameterization of ( _Q, R_ )-Lipschitz CNNs. An example architecture of (1) is a classifying CNN 

**==> picture [237 x 9] intentionally omitted <==**

with _Lk ∈{F, C, P, σ, R}_ , wherein _F_ denote fully connected layers, _C_ denote convolutional layers, _P_ denote pooling layers, _σ_ denote activation functions, and _R_ denote reshape layers. In what follows, we formally define these layers. 

**Convolutional layer** A convolutional layer with layer index _k_ 

**==> picture [110 x 10] intentionally omitted <==**

where _∗_ denotes the convolution operator, is characterized by a convolution kernel _Kk_ , and a bias term _bk_ , i.e., _θk_ = ( _Kk, bk_ ). The input signal _uk_ may be a 1-D signal, such as a time series, a 2-D signal, such as an image, or even a d-D signal. 

**==> picture [190 x 28] intentionally omitted <==**

Furthermore, a 2-D convolutional layer ( _d_ = 2) reads 

**==> picture [232 x 41] intentionally omitted <==**

where _**r** k_ = ( _rk_[1] _[, r] k_[2][)][is][the][kernel][size][and] _**[s]**[k]_[=][(] _[s]_[1] _k[, s]_[2] _k_[)] the stride. 

**Fully connected layer** Fully connected layers _Fk_ are static mappings with domain space _Dk−_ 1 = R _[c][k][−]_[1] and image space _Dk_ = R _[c][k]_ with possibly large channel dimensions _ck−_ 1 _, ck_ (= neurons in the hidden layers). We define a fully connected layer as 

**==> picture [217 x 10] intentionally omitted <==**

with bias _bk ∈_ R _[c][k]_ and weight matrix _Wk ∈_ R _[c][k][×][c][k][−]_[1] , i.e., _θk_ = ( _Wk, bk_ ). 

4 

**Activation function** Convolutional and fully connected layers are affine layers that are typically followed by a nonlinear activation function. These activation functions _σ_ can be applied to both domain spaces _Dk−_ 1 = R _[c][k][−]_[1] or _Dk−_ 1 = _ℓ[c]_ 2 _[k] e[−]_[1] (N _[d]_ 0[),][but][they][necessi-] tate _Dk_ = _[∼] Dk−_ 1. Activation functions _σ_ : R _→_ R are applied element-wise to the input _uk ∈Dk−_ 1. For vector inputs _uk ∈_ R _[c][k]_ , _σ_ is then defined as 

**==> picture [218 x 21] intentionally omitted <==**

Furthermore, we lift the scalar activation function to signal spaces _ℓ[c]_ 2 _[k] e[−]_[1] (N _[d]_ 0 _[k][−]_[1] ), which results in _σ_ : _ℓ[c]_ 2 _[k] e_[(][N] 0 _[d]_[)] _[→] ℓ[c]_ 2 _[k] e_[(][N] 0 _[d]_[),] 

**==> picture [184 x 14] intentionally omitted <==**

**Pooling layer** A convolutional layer may be followed by an additional pooling layer _P_ , i. e., a downsampling operation from _Dk−_ 1 = _ℓ[c]_ 2 _[k] e_[(][N] 0 _[d]_[)][to] _[D][k]_[=] _[ℓ][c]_ 2 _[k] e_[(][N] 0 _[d]_[)][that] is applied channel-wise. Pooling layers generate a single output signal entry _y_ [ _**i**_ ] from the input signal batch ( _uk_ [ _**s** k_ _**i** −_ _**t**_ ] _|_ _**t** ∈_ [0 _,_ _**r** k_ ]). The two most common pooling layers are average pooling _P_[av] : _ℓ[c]_ 2 _[k] e_[(][N] 0 _[d]_[)] _[ →][ℓ][c]_ 2 _[k] e_[(][N] 0 _[d]_[),] 

**==> picture [161 x 42] intentionally omitted <==**

and maximum pooling _P_[max] : _ℓ[c]_ 2 _[k] e_[(][N] 0 _[d]_[)] _[ →][ℓ][c]_ 2 _[k] e_[(][N] 0 _[d]_[),] 

**==> picture [162 x 11] intentionally omitted <==**

where the maximum is applied channel-wise. Other than (Pauli et al., 2023b), we allow for all _**s** k ≤_ _**r** k_ , meaning that the kernel size is either larger than the shift or the same. 

**Reshape operation** An NN (1) may include signal processing layers such as convolutional layers and layers that operate on vector spaces, such as fully connected layers. At the transition of such different layer types, we require a reshape operation 

**==> picture [191 x 15] intentionally omitted <==**

that flattens a signal into a vector 

**==> picture [176 x 22] intentionally omitted <==**

or vice versa, a vector into a signal. 

## **3 Dissipation Analysis of Neural Networks** 

Prior to presenting the direct parameterization of Lipschitz-bounded CNNs in Section 4, we address Problem 1 of characterizing ( _Q, R_ )-Lipschitz NNs by LMIs in this section. In Subsection 3.1, we first discuss incrementally dissipative layers, followed by Subsection 3.2, wherein we introduce state space representations of the Roesser type for convolutions. In Subsection 3.3, we then state quadratic constraints for slope-restricted nonlinearities and discuss layer-wise LMIs that certify dissipativity for the layers and (3) for the CNN in Subsection 3.4. Throughout this section, where possible, we drop layer indices for improved readability. The subscript “ _−_ ” refers to the previous layer; for example, _c_ is short for _ck_ , and _c−_ is short for _ck−_ 1. 

## _3.1 Incrementally dissipative layers_ 

To design Lipschitz-bounded NNs, previous works have parameterized the individual layers of a CNN to be orthogonal or to have constrained spectral norms (Anil et al., 2019; Trockman and Kolter, 2021; Prach and Lampert, 2022), thereby ensuring that they are 1-Lipschitz. An upper bound on the Lipschitz constant of the endto-end mapping is then given by 

**==> picture [72 x 30] intentionally omitted <==**

where Lip( _Lk_ ) are upper Lipschitz bounds for the _k_ = 1 _, . . . , l_ layers. In contrast, our approach does not constrain the individual layers to be orthogonal but instead requires them to be incrementally dissipative (Byrnes and Lin, 1994), thus providing more degrees of freedom while also guaranteeing a Lipschitz upper bound for the end-to-end mapping. 

**Definition 4 (Incremental dissipativity)** _A layer Lk_ : _Dk−_ 1 _→Dk_ : _uk �→ yk is incrementally dissipative with respect to a supply rate s_ (∆ _uk_ [ _**i**_ ] _,_ ∆ _yk_ [ _**i**_ ]) _if for all inputs u[a] k[, u][b] k[∈D][k][−]_[1] _[and all]_ _**[ N]**[ k][∈]_[N] _[d]_ 0 

**==> picture [189 x 24] intentionally omitted <==**

_where_ ∆ _uk_ [ _**i**_ ] = _u[a] k_[[] _**[i]**_[]] _[ −][u][b] k_[[] _**[i]**_[]] _[,]_[ ∆] _[y][k]_[[] _**[i]**_[] =] _[ y] k[a]_[[] _**[i]**_[]] _[ −][y] k[b]_[[] _**[i]**_[]] _[.]_ 

In particular, we design layers to be incrementally dissipative with respect to the supply 

**==> picture [235 x 30] intentionally omitted <==**

which can be viewed as a generalized incremental gain/Lipschitz property with directional gain matrices 

5 

_Xk ∈_ S _[c]_ ++[and] _[X][k][−]_[1] _[∈]_[S] _[c]_ ++ _[k][−]_[1][.][Note][that][(12)][includes] vector inputs, in which case _**N** k_ = 0. Furthermore, our approach naturally extends beyond the main layer types of CNNs presented in Section 2.2 as _any_ function that is incrementally dissipative with respect to (13) can be included as a layer _Lk_ into a ( _Q, R_ )-Lipschitz feedforward NN (1). 

**==> picture [240 x 135] intentionally omitted <==**

**----- Start of picture text -----**<br>
y 1 [(2)] =  u [(2)] 2<br>u 1 [(2)] 1 L 1 L 2 y 2 [(2)]<br>1<br>u [(1)] 1 y 1 [(1)] =  u [(1)] 2 y 2 [(1)]<br>y 2 [(2)]<br>u 1 [(2)] 1 L 1 y 1 [(2)] =  u [(2)] 2 L 2<br>1<br>u [(1)] 1 y 1 [(1)] =  u [(1)] 2 y 2 [(1)]<br>**----- End of picture text -----**<br>


Fig. 1. For _F_ 2 _◦ σ ◦F_ 1 with _c_ 0 = _c_ 1 = _c_ 2 = 2, we compare over-approximations for reachability sets shown in blue, we obtain ellipsoidal sets using incrementally dissipative layers (top) and circles using Lipschitz bounds (bottom). 

Fig. 1 illustrates the additional degrees of freedom gained by considering incrementally dissipative layers rather than Lipschitz-bounded layers considering a fully connected, two-layer NN with an input, hidden and output dimension of two. For input increments taken from a unit ball, we find an ellipse _E_ = _{y_ 1 _[a][, y]_ 1 _[b][∈]_[R] _[c][|]_[(] _[y]_ 1 _[a][−][y]_ 1 _[b]_[)] _[⊤][X]_[1][(] _[y]_ 1 _[a][−][y]_ 1 _[b]_[)] _[≤]_[1] _[}]_[that] over-approximates the reachability set in the hidden layer or a Lipschitz bound that characterizes a circle for this purpose, respectively. The third and final reachability set is a circle scaled by a Lipschitz upper bound. This set is created using either the ellipse characterized by _X_ 1 or the circle of the previous layer as inputs. These input sets were chosen such that the final reachability set is minimized. We see a clear difference between the two approaches. Using ellipses obtained by the incremental dissipativity approach, the Lipschitz bound is 1, using circles as in the Lipschitz approach, it is almost 2, illustrating that we can find tighter Lipschitz upper bounds. 

In NN design this translates into a higher model expressivity. To illustrate this, we consider the regression problem of fitting the cosine function between _[−]_ 2 _[π]_ and _π_[also][utilized][in][(Pauli][et][al.,][2021).][We][use][a][simple] 2[,] NN architecture _F_ 2 _◦ σ ◦F_ 1 with _c_ 0 = _c_ 2 = 1, _c_ 1 = 2, and activation function tanh and construct weights and biases as 

**==> picture [230 x 31] intentionally omitted <==**

Both layers are incrementally dissipative and the weights 

**==> picture [204 x 107] intentionally omitted <==**

**----- Start of picture text -----**<br>
1<br>0 . 5 Cosine<br>Dissipative layers<br>1-Lipschitz layers<br>0<br>- π /2 0 π /2<br>u 1<br>yl<br>**----- End of picture text -----**<br>


Fig. 2. Fit of a cosine function using NN from LMI-based parameterization with dissipative layers and an NN with 1-Lipschitz layers with weights which are constrained to have spectral norm 1. 

satisfy LMI constraints that verify that the end-to-end mapping is guaranteed to be 1-Lipschitz, as will be discussed in detail in Subsection 3.4. Clearly the weights have spectral norms of _√_ 2, meaning that the individual layers are _not_ 1-Lipschitz. Next, we construct an NN to best fit the cosine with 1-Lipschitz weights obtained by spectral normalization as 

**==> picture [138 x 58] intentionally omitted <==**

In Fig. 2, we see the resulting fit of the two functions and a clear advantage in expressiveness of the LMI-based parameterization using dissipative layers. 

## _3.2 State space representation for convolutions_ 

In kernel representation (7), convolutions are not amenable to SDP-based methods. However, they can be reformulated as fully connected layers via Toeplitz matrices (Goodfellow et al., 2016; Pauli et al., 2022; Aquino et al., 2022), parameterized in the Fourier domain (Wang and Manchester, 2023), or represented in state space (Gramlich et al., 2023; Pauli et al., 2024b). In what follows, we present compact state space representations for 1-D and 2-D convolutions derived in (Pauli et al., 2024b), which allow the direct parameterization of the kernel parameters. 

**1-D convolutions** A possible discrete-time state space representation of a convolutional layer (9) with stride _s_ = 1 is given by 

**==> picture [182 x 24] intentionally omitted <==**

6 

with initial condition _x_ [0] = 0, where 

**==> picture [200 x 53] intentionally omitted <==**

In (14), we denote the state, input, and output by _x_ [ _i_ ] _∈_ R _[n]_ , _u_ [ _i_ ] _∈_ R _[c][−]_ and _y_ [ _i_ ] _∈_ R _[c]_ , respectively, and the state dimension is _n_ = _rc−_ . 

It should be noted that in the state space representation (15), all parameters _K_ [ _i_ ], _i_ = 0 _, . . . , r_ are collected in the matrices _**C**_ and _**D**_ , and _**A**_ and _**B**_ account for shifting previous inputs into memory. Accordingly, _**C**_ and _**D**_ are parameterized in Section 4.3. 

**2-D convolutions** We describe a 2-D convolution using the Roesser model (Roesser, 1975) 

**==> picture [232 x 99] intentionally omitted <==**

with states _x_ 1[ _i, j_ ] _∈_ R _[n]_[1] , _x_ 2[ _i, j_ ] _∈_ R _[n]_[2] , input _u_ [ _i, j_ ] _∈_ R _[n][u]_ , and output _y_ [ _i, j_ ] _∈_ R _[n][y]_ . A possible state space representation for the 2-D convolution (10) is given by Lemma 5 (Pauli et al., 2024b). 

**Lemma 5 (Realization of 2-D convolutions)** _Consider a convolutional layer C_ : _ℓ[c]_ 2 _[−] e_[(][N] 0[2][)] _[→][ℓ][c]_ 2 _e_[(][N][2] 0[)] _with representation_ (10) _and stride s_ 1 = _s_ 2 = 1 _characterized by the convolution kernel K and the bias b. This layer is realized in state space_ (16) _by the matrices_ 

**==> picture [232 x 159] intentionally omitted <==**

_where K_ [ _i_ 1 _, i_ 2] _∈_ R _[c][×][c][−] , i_ 1 = 0 _, . . . , r_ 1 _, i_ 2 = 0 _, . . . , r_ 2 _with initial conditions x_ 1[0 _, i_ 2] = 0 _for all i_ 2 _∈_ N0 _, and x_ 2[ _i_ 1 _,_ 0] = 0 _for all i_ 1 _∈_ N0 _. The state, input, and output dimensions are n_ 1 = _cr_ 1 _, n_ 2 = _c−r_ 2 _, nu_ = _c−, ny_ = _c._ 

**Remark 2** _For stride_ _**s** >_ 1 _, (Pauli et al., 2024b) constructs state space representations_ (15) _and_ (17) _, based on which our parameterization directly extends to strided convolutions._ 

## _3.3 Slope-restricted activation functions_ 

The nonlinear and large-scale nature of NNs often complicates their analysis. However, over-approximating activation functions with quadratic constraints enables SDP-based Lipschitz estimation and verification (Fazlyab et al., 2020, 2019). Common activations like ReLU and tanh are slope-restricted on [0 _,_ 1] and satisfy the following incremental quadratic constraint (Fazlyab et al., 2019; Pauli et al., 2021)[1] . 

**Lemma 6 (Slope-restriction )** _Suppose σ_ : R _→_ R _is slope-restricted on_ [0 _,_ 1] _. Then for all_ Λ _∈_ D _[n]_ ++ _[,][the] vector-valued function σ_ ( _u_ ) _[⊤]_ = _σ_ ( _u_ 1) _. . . σ_ ( _un_ ) : � � R _[n] →_ R _[n] satisfies_ 

**==> picture [224 x 34] intentionally omitted <==**

_where_ ∆ _u_ = _u[a] − u[b] and_ ∆ _y_ = _σ_ ( _u[a]_ ) _− σ_ ( _u[b]_ ) _._ 

## _3.4 Layer-wise LMI conditions_ 

Using the quadratic constraints (18) to over-approximate the nonlinear activation functions, (Fazlyab et al., 2019; Gramlich et al., 2023; Pauli et al., 2023a, 2024a) formulate SDPs for Lipschitz constant estimation. The works (Pauli et al., 2023a, 2024a) derive layer-wise LMI conditions for 1-D and 2-D CNNs, respectively. In this work, we characterize Lipschitz NNs by these LMIs, thus addressing Problem 1. More specifically, the LMIs in (Pauli et al., 2023a, 2024a) yield incrementally dissipative layers and, as a result, the end-to-end mapping satisfies (3), as detailed next in Theorem 7. 

**Theorem 7** _Let every layer k_ = 1 _, . . . , l of an NN_ (1) _,_ (2) _be incrementally dissipative with respect to the supply_ (13) _and let X_ 0 = _R, Xl_ = _Q. Then the input-output mapping u_ 1 _�→ yl satisfies_ (3) _._ 

> 1 Note that Fazlyab et al. (2019) suggest using full-block multipliers Λ, however this construction is incorrect as corrected by Pauli et al. (2021). 

7 

**PROOF.** All layers _k_ = 1 _, . . . , l_ are incrementally dissipative with respect to the supply (13), i.e., 

**==> picture [222 x 11] intentionally omitted <==**

We sum up (19) for all _k_ = 1 _, . . . , l_ layers and insert _X_ 0 = _R_ , _Xl_ = _Q_ . This yields 

**==> picture [216 x 29] intentionally omitted <==**

Using _uk_ +1 = _yk_ , cmp. (2), we recognize that (20) entails a telescoping sum. We are left with _∥_ ∆ _u_ 1 _∥_[2] _R[−∥]_[∆] _[y][l][∥]_[2] _Q[≥]_ 0. 

Note that at a layer transition the directional gain matrix _Xk_ is shared between the current and the subsequent layer, which is a natural consequence of the LMI derivation in (Pauli et al., 2024a) and accounts for the feedforward interconnection of the NN. During training, the parameters _θk_ are learned. Activation function layers and pooling layers typically do not hold any parameters _θk_ and it is convenient to combine fully connected layers and the subsequent activation function layer _σ ◦F_ and convolutional layers and the subsequent activation function layer _σ ◦C_ , or even a convolutional layer, an activation function and a pooling layer _P ◦ σ ◦C_ and treat these concatenations as one layer. In this way, we split the CNN into subnetworks, each holding parameters _θk_ to be learned. Previous approaches parameterize all convolutional and fully connected layers as 1- Lipschitz and leverage the fact that pooling layers and activation functions are Lipschitz by design. By choosing an LMI-based approach that includes pooling layers and activation functions in layer concatenations rather than using 1-Lipschitz linear layers, we account for the coupling of information between neurons. This results in better expressivity. In the following, we state LMIs that imply incremental dissipativity with respect to (13) for the layer types _σ ◦F_ , _σ ◦C_ , and _P ◦ σ ◦C_ . 

## **Convolutional layers** 

**Lemma 8 (LMI for** _σ ◦C_ **(Pauli et al., 2024a))** _Consider a 2-D (1-D) convolutional layer σ ◦C with activation functions that are slope-restricted in_ [0 _,_ 1] _. For some X ∈_ S _[c]_ ++ _[and][X][−][∈]_[S] _[c]_ ++ _[−][,][σ][ ◦C][satisfies]_[(12)] _[with] respect to the supply_ (13) _if there exist positive definite matrices P_ 1 _∈_ S _[n]_ ++[1] _[,][P]_[2] _[∈]_[S] _[n]_ ++[2] _[,]_ _**[P]**_[=][blkdiag(] _[P]_[1] _[, P]_[2][)] _(_ _**P** ∈_ S _[n]_ ++ _[) and a diagonal][matrix]_[Λ] _[ ∈]_[D] _[c]_ ++ _[such][that]_ 

**==> picture [226 x 51] intentionally omitted <==**

**PROOF.** The proof follows typical arguments used in robust dissipativity proofs, using Lemma 6, i.e., exploiting the slope-restriction property of the activation functions. The proof is provided in (Pauli et al., 2024a). 

**Corollary 9 (LMI for** _P ◦ σ ◦C_ **)** _Consider a 2-D (1D) convolutional layer P ◦ σ ◦C with activation functions that are slope-restricted in_ [0 _,_ 1] _and an average pooling layer / a maximum pooling layer. For some X ∈_ S _[c]_ ++ _/ X ∈_ D _[c]_ ++ _[and][X][−][∈]_[S] _[c]_ ++ _[−][,][P][◦][σ][◦C][satisfies]_[(12)] _with respect to supply_ (13) _if there exist positive definite matrices P_ 1 _∈_ S _[n]_ ++[1] _[,][P]_[2] _[∈]_[S] _[n]_ ++[2] _[,]_ _**[P]**_[=][blkdiag(] _[P]_[1] _[, P]_[2][)] _(_ _**P** ∈_ S _[n]_ ++ _[) and a diagonal matrix]_[ Λ] _[ ∈]_[D] _[c]_ ++ _[such that]_ 

**==> picture [231 x 52] intentionally omitted <==**

_where ρ_ p _is the Lipschitz constant of the pooling layer._ 

**Remark 3** _Lemma 8 and Corollary 9 entail all kinds of zero-padding (Pauli et al., 2024a), just like (Prach and Lampert, 2022), giving our method an advantage over (Trockman and Kolter, 2021; Wang and Manchester, 2023), which are restricted to circular padding._ 

## **Fully connected layers** 

**Lemma 10 (LMI for** _σ ◦F_ **(Pauli et al., 2024a))** _Consider a fully connected layer σ ◦F with activation functions that are slope-restricted in_ [0 _,_ 1] _. For some X ∈_ S _[c]_ ++ _[and][X][−][∈]_[S] _[c]_ ++ _[−][,][σ][ ◦F][satisfies]_[(12)] _[with][re-] spect to_ (13) _if there exists a diagonal matrix_ Λ _∈_ D _[c]_ ++ _such that_ 

**==> picture [168 x 31] intentionally omitted <==**

**Remark 4** _Technically, we can interpret a fully connected layer as a 0-D convolutional layer with a signal length of 1,_ _**D**_ = _W and_ _**A**_ = 0 _,_ _**B**_ = 0 _,_ _**C**_ = 0 _. Accordingly,_ (23) _is a special case of_ (21) _._ 

**The last layer** The last layer is treated separately, as it typically lacks an activation function and _Xl_ = _Q_ is predefined. In classifying NNs the last layer typically is a fully connected layer _Fl_ , for which the LMI 

**==> picture [165 x 12] intentionally omitted <==**

implies (12) with respect to the supply (13), cmp. Theorem 7. 

We denote the LMIs (21) to (24) as instances of _Gk_ ( _Xk, Xk−_ 1 _, νk_ ) _⪰_ 0, where _νk_ denote the respective 

8 

multipliers and slack variables in the specific LMIs (for _σ ◦Fk_ , _νk_ = Λ _k_ , for _σ ◦Ck_ , _νk_ = (Λ _k,_ _**P** k_ )). 

**Remark 5 (Lipschitz constant estimation)** _To determine an upper bound on the Lipschitz constant for a given NN, we solve the SDP_ 

**==> picture [233 x 32] intentionally omitted <==**

_In_ (25) _, X_ = _{Xk}[l] k[−]_ =1[1] _[,][ν]_[=] _[{][ν][k][}][l] k_ =1 _[,][ρ]_[2] _[serve][as][deci-] sion variables. Based on Theorem 7, the solution for ρ is an upper bound on the Lipschitz constant for the NN (Pauli et al., 2024a)._ 

## **4 Synthesis of Dissipative Layers** 

In the previous section, we revisited LMIs, derived in (Pauli et al., 2024a) for Lipschitz constant estimation for NNs, which we use to characterize robust NNs that satisfy (3) or (4). This work is devoted to the synthesis of such Lipschitz-bounded NNs. To this end, in this section, we derive layer-wise parameterizations for _θk_ that render the layer-wise LMIs _Gk_ ( _Xk, Xk−_ 1 _, νk_ ) _⪰_ 0, _k_ = 1 _, . . . , l_ feasible by design, addressing Problem 2. For our parameterization the Lipschitz bound _ρ_ or, respectively, the matrices _Q_ , _R_ are hyperparameters that can be chosen by the user. Low Lipschitz bounds _ρ_ lead to high robustness, yet compromise the expressivity of the NN, as we will observe in Subsection 5.2. Inserting the parameterizations _ϕ �→ θ_ presented in this section into (5) yields (6), which can be conveniently solved using first-order solvers. 

After introducing the Cayley transform in Subsection 4.1, we discuss the parameterization of fully connected layers and convolutional layers in Subsections 4.2 and 4.3, respectively, based on the Cayley transform and a solution to the 1-D and 2-D Lyapunov equations. To improve readability, we drop the layer index _k_ in this section. If we refer to a variable of the previous layer, we denote it by the subscript “ _−_ ”. 

## _4.1 Cayley transform_ 

The Cayley transform maps skew-symmetric matrices to orthogonal matrices, and its extended version parameterizes the Stiefel manifold from non-square matrices. The Cayley transform can be used to map continuous time systems to discrete time systems (Guo and Zwart, 2006). Furthermore, it has proven useful in designing NNs with norm-constrained weights or Lipschitz constraints (Trockman and Kolter, 2021; Helfrich et al., 2018; Wang and Manchester, 2023). 

**Lemma 11 (Cayley transform)** _For all Y ∈_ R _[n][×][n] and Z ∈_ R _[m][×][n] the Cayley transform_ 

**==> picture [212 x 31] intentionally omitted <==**

_where M_ = _Y − Y[⊤]_ + _Z[⊤] Z, yields matrices U ∈_ R _[n][×][n] and V ∈_ R _[m][×][n] that satisfy U[⊤] U_ + _V[⊤] V_ = _I._ 

Note that _I_ + _M_ is nonsingular since 1 _≤ λ_ min( _I_ + _Z[⊤] Z_ ) _≤ Re_ ( _λ_ min( _I_ + _M_ )). 

## _4.2 Fully connected layers_ 

For fully connected layers _σ ◦F_ , Theorem 12 gives a mapping _ϕ �→_ ( _W, b_ ) from unconstrained variables _ϕ_ that renders (23) feasible by design, and thus the layer is dissipative with respect to the supply (13). 

**Theorem 12** _A fully connected layer σ ◦F parameterized by_ 

**==> picture [163 x 13] intentionally omitted <==**

_wherein_ 

**==> picture [219 x 31] intentionally omitted <==**

_satisfies_ (23) _. This yields the mapping_ 

**==> picture [100 x 11] intentionally omitted <==**

**==> picture [170 x 10] intentionally omitted <==**

A proof is provided in (Pauli et al., 2023b, Theorem 5). We collect the free variables in _ϕ_ = ( _Y, Z, γ, b_ ) and the weight and bias terms in _θ_ = ( _W, b_ ). To train a Lipschitzbounded NN, we parameterize the weights _W_ of all fully connected layers using (26) and then train over the free variables _ϕ_ using (6). Toolboxes are used to determine gradients with respect to _ϕ_ . The by-product Γ parameterizes Λ = Γ[2] , and _L_ parameterizes the directional gain _X_ = _L[⊤] L_ and is passed on to the subsequent layer, where it appears as _X−_ . The first layer _k_ = 1 takes _L_ 0 = chol( _R_ ), which is _L_ 0 = _ρI_ when considering (4). Incremental properties such as Lipschitz boundedness are independent of the bias term such that _b ∈_ R _[c]_ is a free variable as well. 

Note that the parameterization (26) for fully connected layers of a Lipschitz-bounded NN is the same as the one proposed in (Wang and Manchester, 2023). According to (Wang and Manchester, 2023, Theorem 3.1), (26) is necessary and sufficient, i. e., the fully connected layers _σ ◦F_ satisfy (23) if and only if the weights can be parameterized by (26). 

9 

**Remark 6** _To ensure that_ Γ _and L are nonsingular, w.l.o.g., we may parameterize_ Γ = diag( _e[γ]_ ) _, γ ∈_ R _[c] (Wang and Manchester, 2023) and L_ = _U[⊤]_ diag( _e[l]_ ) _V , l ∈_ R _[c] with square orthogonal matrices U and V , e.g., found using the Cayley transform._ 

## _4.3 Convolutional layers_ 

The parameterization of convolutional layers is divided into two steps. We first parameterize the upper left block in (21), namely 

**==> picture [218 x 31] intentionally omitted <==**

by constructing a parameter-dependent solution of a 1- D or 2-D Lyapunov equation. Secondly, we parameterize _**C**_ and _**D**_ from the auxiliary variables determined in the previous step. 

To simplify the notation of (21) to 

**==> picture [96 x 37] intentionally omitted <==**

we introduce _**C**_[�] := _**C D**_ . In the following, we distin� � guish between the parameterization of 1-D convolutional layers and 2-D convolutional layers. 

appear in _**C**_[�] , cmp. the chosen state space represenation (15), and are parameterized as follows. 

**Theorem 14** _A 1-D convolutional layer σ ◦C that is parameterized by_ 

**==> picture [184 x 18] intentionally omitted <==**

_wherein_ 

**==> picture [231 x 31] intentionally omitted <==**

_satisfies_ (21) _. Here, F is given by_ (27) _with_ _**P** parameterized from X− and H using_ (28) _, where X_ = _L[⊤] L, L_ 0 = _R, L_ = _√_ 2 _U_ Γ _. This yields the mapping_ 

**==> picture [110 x 11] intentionally omitted <==**

**==> picture [234 x 12] intentionally omitted <==**

Note that we have to slightly modify _L_ in case the convolutional layer contains an average pooling layer. We ~~_√_~~ 2 then parameterize _L_ = _ρ_ p _[U]_[Γ, where] _[ ρ]_[p][is the Lipschitz] constant of the average pooling layer. In case the convolutional layer contains a maximum pooling layer, i. e., _P_[max] _◦σ◦C_ , we need to modify the parameterization of _L_ to ensure that _X_ is a diagonal matrix, cmp. Corollary 9. 

**Corollary 15** _A 1-D convolutional layer that contains a maximum pooling layer P_[max] _◦ σ ◦C parameterized by_ 

**1-D convolutional layers** The parameterization of 1-D convolutional layers uses the controllability Gramian (Pauli et al., 2023b), which is the unique solution to a discrete-time Lyapunov equation. The first parameterization step entails to parameterize _**P**_ such that (27) is feasible. To do so, we use the following lemma (Pauli et al., 2023b). 

**Lemma 13 (Parameterization of** _**P**_ **)** _Consider the 1-D state space representation_ (15) _. For some ε >_ 0 _and all H ∈_ R _[n][×][n] , the matrix_ _**P**_ = _**T**[−]_[1] _with_ 

**==> picture [229 x 30] intentionally omitted <==**

_renders_ (27) _feasible._ 

A proof is provided in (Pauli et al., 2023b, Lemma 7). The key idea behind the proof is that by Schur complements (27) can be posed as a Lyapunov equation. The expression (28) then provides the solution to this Lyapunov equation. The second step now parameterizes _**C**_[�] from _F_ , as detailed in Theorem 14. All kernel parameters 

**==> picture [181 x 19] intentionally omitted <==**

_wherein_ 

**==> picture [215 x 21] intentionally omitted <==**

_satisfies_ (21) _. Here, F is given by_ (27) _with_ _**P** parameterized from X− and H using_ (28) _, where X_ = _L[⊤] L, L_ 0 = _ρI,_ � _L_ = diag( _l_ ) _, LF_ = chol( _F_ ) _. The free variables Y ∈_ R _[rc] −[×][c] , H ∈_ R _[n][×][n] ,_ ˜ _γ, l ∈_ R _[c] , compose the mapping_ 

**==> picture [111 x 13] intentionally omitted <==**

Proofs of Theorem 14 and Corollary 15 are provided in (Pauli et al., 2023b, Theorem 8 and Corollary 9). 

**2-D convolutional layers** Next, we turn to the more involved case of 2-D convolutional layers (10). The parameterization of 2-D convolutional layers in their 2-D 

10 

state space representation, i.e., the direct parameterization of the kernel parameters, is one of the main technical contributions of this work. Since there does not exist a solution for the 2-D Lyapunov equation in general (Anderson et al., 1986), we construct one for the special case of a 2-D convolutional layer, which is a 2-D FIR filter. The utilized state space representation of the FIR filter (17) has a characteristic structure, which we leverage to find a parameterization. 

We proceed in the same way as in the 1-D case by first parameterizing _**P**_ to render (27) feasible. In the 2-D case this step requires to consecutively parameterize _P_ 1 and _P_ 2 that make up _**P**_ = blkdiag( _P_ 1 _, P_ 2). Inserting (17) into (16), we recognize that the _x_ 2 dynamic is decoupled from the _x_ 1 dynamic due to _A_ 21 = 0. Consequently, _P_ 2 can be parameterized in a first step, followed by the parameterization of _P_ 1. Let us define some auxiliary matrices _T_ 1 = _P_ 1 _[−]_[1] , _T_ 2 = _P_ 2 _[−]_[1] , _**T**_ = blkdiag( _T_ 1 _, T_ 2), 

**==> picture [187 x 31] intentionally omitted <==**

which is partitioned according to the state dimensions _n_ 1 and _n_ 2, i.e., _X_[�] 11 _∈_ R _[n]_[1] _[×][n]_[1] , _X_[�] 12 _∈_ R _[n]_[1] _[×][n]_[2] , _X_[�] 22 _∈_ R _[n]_[2] _[×][n]_[2] . We further define 

**==> picture [234 x 42] intentionally omitted <==**

**Lemma 16** _Consider the 2-D state space representation_ (17) _. For some ε >_ 0 _and all H_ 1 _∈_ R _[n]_[1] _[×][n]_[1] _, H_ 2 _∈_ R _[n]_[2] _[×][n]_[2] _, the matrices P_ 1 = _T_ 1 _[−]_[1] _, P_ 2 = _T_ 2 _[−]_[1] _with_ 

**==> picture [222 x 72] intentionally omitted <==**

_render_ (27) _feasible._ 

**PROOF.** Let us first consider the parameterization of _T_ 2. Given that _A_ 22 is a nilpotent matrix, cmp. (17), (33b) is equivalent to 

**==> picture [174 x 28] intentionally omitted <==**

which in turn is the unique solution to the Lyapunov equation 

**==> picture [217 x 14] intentionally omitted <==**

by (Chen, 1984, Theorem 6.D1). Next, we utilize that (33a) is equivalent to 

**==> picture [216 x 29] intentionally omitted <==**

due to the fact that _A_ 11 is also nilpotent. Equation (35) in turn is the unique solution to the Lyapunov equation 

**==> picture [176 x 13] intentionally omitted <==**

by (Chen, 1984, Theorem 6.D1). Using the definition (32), wherein the term _T_ 2 _− A_ 22 _T_ 2 _A[⊤]_ 22 _[−] X_[�] 22 _≻_ 0 according to (34), we apply the Schur complement to _T_ 1 _− A_ 11 _T_ 1 _A[⊤]_ 11 _[−] X_[�] 11 _≻_ 0. We obtain 

**==> picture [233 x 44] intentionally omitted <==**

which can equivalently be written as _**T** −_ _**AT A**[⊤] −_ _**B**_ ( _X−_ ) _[−]_[1] _**B**[⊤] ≻_ 0 using (31), to which we again apply the Schur complement. This yields 

**==> picture [166 x 49] intentionally omitted <==**

Finally, we again apply the Schur complement to (37) with respect to the lower right block and replace _**P**_ = _**T**[−]_[1] , which results in _F ≻_ 0. 

Note that the parameterization of _**T**_ takes the free variables _H_ 1, _H_ 2, _A_ 12, and _B_ 1. The matrices _A_ 11, _A_ 22, and _B_ 2 are predefined by the chosen state space representation (17). 

**Remark 7** _In the case of strided convolutional layers with_ _**s** ≥_ 2 _, A_ 12 _and B_ 1 _may also have a predefined structure and zero entries, see Remark 2 and (Pauli et al., 2024b), which we can incorporate into the parameterization, as well._ 

For the second part of the parameterization, we partition (21) as 

**==> picture [184 x 49] intentionally omitted <==**

and define _C_[�] 2 = _C_ 2 _D_ , noting that _C_[�] 2 holds all pa� � rameters of _K_ that are left to be parameterized, cmp. Lemma 5. Next, we introduce Lemma 17 that we used to 

11 

parameterize convolutional layers, directly followed by Theorem 18 that states the parameterization. 

**Lemma 17 (Theorem 3 (Araujo et al., 2023))** _Let W ∈_ R _[m][×][n] and T ∈_ D _[n]_ ++ _[. If there exists some][ Q][ ∈]_[D] _[n]_ ++ _such that T − QW[⊤] WQ[−]_[1] _is a symmetric and real diagonally dominant matrix, i.e.,_ 

**==> picture [158 x 24] intentionally omitted <==**

_then T ≻ W[⊤] W ._ 

We next show that 2Γ _− C_ 1 _F_ 1 _[−]_[1] _C_ 1 _[⊤]_[is][positive][definite] and therefore admits a Cholesky decomposition. Since _F_ 1 _≻_ 0, _C_ 1 _F_ 1 _[−]_[1] _C_ 1 _[⊤] ⪰_ 0 such that we know that 0 _≤_ ( _C_ 1 _F_ 1 _[−]_[1] _C_ 1 _[⊤]_[)] _[ii]_[=] _[ |][C]_[1] _[F][ −]_ 1[1] _C_ 1 _[⊤][|][ii]_[. With this, we notice that] 2Γ _− QC_ 1 _F_ 1 _[−]_[1] _C_ 1 _[⊤][Q][−]_[1][with] _[Q]_[=][diag(] _[q]_[)][is][diagonally] dominant as it component-wise satisfies 

**==> picture [213 x 54] intentionally omitted <==**

We see that diagonal dominance holds using that 

**Theorem 18** _A 2-D convolutional layer σ ◦C parameterized by_ 

**==> picture [174 x 19] intentionally omitted <==**

_wherein for some ϵ >_ 0 

**==> picture [237 x 78] intentionally omitted <==**

_satisfies_ (21) _. Here, F is parameterized from X− and free variables H_ 1 _, H_ 2 _, B_ 1 _, A_ 12 _using_ (33) _, where X_ = _L[⊤] L, L_ 0 = _ρI, L_ = _UL_ ΓΓ _[−]_[1] _. This yields the mapping_ 

**==> picture [179 x 11] intentionally omitted <==**

**==> picture [240 x 21] intentionally omitted <==**

**PROOF.** The matrices _U_ and _V_ are parametrized by the Cayley transform such that they satisfy _U[⊤] U_ + _V[⊤] V_ = _I_ . We solve for _U_ = _L_ Γ _L[−]_ Γ[1] and _V_ = _L[−⊤] F_[(] _[−][C]_[�][2][ +] _[ C]_[1] _[F][ −]_ 1[1] _F_ 12) _[⊤] L[−]_ Γ[1] and replace _LF_ with its definition, which we then insert into _U[⊤] U_ + _V[⊤] V_ = _I_ , yielding 

**==> picture [220 x 30] intentionally omitted <==**

By left and right multiplication of this equation with _L[⊤]_ Γ and _L_ Γ, respectively, we obtain 

**==> picture [233 x 29] intentionally omitted <==**

**==> picture [236 x 24] intentionally omitted <==**

which yields 2 _ϵ_ + 2 _δi_[2] _>_ 0, which in turn holds trivially. According to Lemma 17, the fact that 2Γ _− QC_ 1 _F_ 1 _[−]_[1] _C_ 1 _[⊤][Q][−]_[1][is][diagonally][dominant][implies] that 2Γ _− C_ 1 _F_ 1 _[−]_[1] _C_ 1 _[⊤]_[is positive definite.] 

Equality (39) implies the inequality 

**==> picture [203 x 30] intentionally omitted <==**

which we left and right multiply with Λ = Γ _[−]_[1] , which is invertible as _γi ≥ ϵ_ . We obtain 

**==> picture [228 x 42] intentionally omitted <==**

Given that _F ≻_ 0, we know that _F_ 1 _≻_ 0, _F_ 2 _≻_ 0 and by the Schur complement _F_ 2 _− F_ 12 _[⊤][F][ −]_ 1[1] _F_ 12 _≻_ 0. By the Schur complement, (40) is equivalent to 

**==> picture [232 x 31] intentionally omitted <==**

which in turn is equivalent to (38) again using the Schur complement. 

**Remark 8** _An alternative parameterization of γ in Theorem 18 would be_ 

**==> picture [201 x 27] intentionally omitted <==**

_obtained by setting_ diag( _q_ ) = _I. Another alternative is_ 

**==> picture [208 x 21] intentionally omitted <==**

12 

_as it also renders_ 

**==> picture [160 x 28] intentionally omitted <==**

_positive definite._ 

If the convolutional layer contains a pooling layer, we again need to slightly adjust the parameterization. For average pooling layers, we can simply replace _X_ by _ρ_[2] p _[X]_[,] yielding _L_ = _ρ_ 1p _[UL]_[Γ][Γ] _[−]_[1][instead of] _[ L]_[ =] _[ UL]_[Γ][Γ] _[−]_[1][, where] _ρ_ p is the Lipschitz constant of the average pooling layer. Maximum pooling layers are nonlinear operators. For that reason, the gain matrix _X_ needs to be further restricted to be a diagonal matrix, cmp. (Pauli et al., 2023b). 

**Theorem 19** _A 2-D convolutional layer that includes a maximum pooling layer with Lipschitz constant ρ_ p _parameterized by_ 

**==> picture [174 x 19] intentionally omitted <==**

_wherein for some ϵ >_ 0 

**==> picture [225 x 59] intentionally omitted <==**

_satisfies_ (22) _. Here, F is parameterized from X− and free variables H_ 1 _, H_ 2 _, B_ 1 _, A_ 12 _using_ (33) _, where X_ = _L[⊤] L, L_ = diag( _l_ ) _, li_ = ~~_√_~~ 2 _γγiiρ−_ p _ηi , L_ 0 = _ρI. This yields the mapping_ 

**==> picture [171 x 14] intentionally omitted <==**

**==> picture [240 x 24] intentionally omitted <==**

satisfies 

**==> picture [220 x 77] intentionally omitted <==**

Hence, 2Γ _− ρ_[2] P[Γ] _[X]_[Γ] _[−][C]_[1] _[F][ −]_ 1[1] _C_ 1 _[⊤] ≻_ 0 according to Lemma 17. Equality (41) implies the inequality 

**==> picture [210 x 30] intentionally omitted <==**

or, equivalently, using Λ = Γ _[−]_[1] , which is invertible as _γi ≥ ϵ_ , 

**==> picture [226 x 29] intentionally omitted <==**

which by Schur complements is equivalent to (22), cmp. proof of Theorem 18. 

## _4.4 The last layer_ 

In the last layer, we directly set _X_ = _Q_ = _L[⊤] Q[L][Q]_[ instead] of parameterizing some _X_ = _L[⊤] L_ through _L_ . 

**Corollary 20** _An affine fully connected layer_ (11) _parameterized by_ 

**==> picture [218 x 31] intentionally omitted <==**

_where LQ_ = chol( _Q_ ) _, Y ∈_ R _[c][×][c] , Z ∈_ R _[c][−][×][c] satisfies_ (24) _._ 

**PROOF.** The proof follows along the lines of the proof of Theorem 18. We solve for _U_[�] = _L[−⊤] F_[(] _[−][C]_[�][2][+] _C_ 1 _F_ 1 _[−]_[1] _F_ 12) _[⊤] L[−]_ Γ[1][,][which][we][then][insert][into] _[U]_[�] _[ ⊤][U]_[�][=] _[I]_ and subsequently left/right multiply with _L[⊤]_ Γ[and] _[L]_[Γ][,] respectively, to obtain 

**PROOF.** The proof follows along the lines of the proof in (Pauli et al., 2023b, Theorem 5). We insert _V_ = _L[−⊤] −[W][ ⊤] l[L][⊤] Q_[into] _[ U][ ⊤][U]_[+] _[ V][⊤][V]_[=] _[ I]_[and obtain] 

**==> picture [166 x 14] intentionally omitted <==**

**==> picture [503 x 42] intentionally omitted <==**

**==> picture [85 x 13] intentionally omitted <==**

Using _Xii_ = _li_[2][=][2] _γ[γ] i[i]_[2] _[−][ρ]_[2] P _[η][i]_[, we notice that 2Γ] _[ −][ρ]_ P[2][Γ] _[X]_[Γ] _[ −] QC_ 1 _F_ 1 _[−]_[1] _C_ 1 _[⊤][Q][−]_[1][is][by][design][diagonally][dominant][as][it] 

which in turn by two Schur complements implies (24). 

13 

**==> picture [227 x 154] intentionally omitted <==**

Fig. 3. Differences between convolutional layers using LipKernel (ours) and Sandwich layers (Wang and Manchester, 2023) in its parameterization complexity and its standard evaluation. The light blue boxes represent images and the green boxes the kernel. 

## _4.5 LipKernel vs. Sandwich convolutional layers_ 

In this section, we have presented an LMI-based method for the parameterization of Lipschitz-bounded CNNs that we call LipKernel as we directly parameterize the kernel parameters. Similarly, the parameterization of Sandwich layers (Wang and Manchester, 2023) is based on LMIs, i.e., is also shows an increased expressivity over approaches using orthogonal layers and layers with constrained spectral norms, cmp. Subsection 3.1. In the following, we point out the differences between Sandwich and LipKernel convolutional layers, which are also illustrated in Fig. 3. 

Both parameterizations Sandwich and LipKernel use the Cayley transform and require the computation of inverses at training time. However, LipKernel parameterizes the kernel parameters _K_ directly through the bijective mapping ( _**A** ,_ _**B** ,_ _**C** ,_ _**D**_ ) _�→ K_ given by Lemma 5. This means that after training at inference time, we can construct _K_ from ( _**A** ,_ _**B** ,_ _**C** ,_ _**D**_ ) and then evaluate the trained CNN using this _K_ . This is not possible using Sandwich layers (Wang and Manchester, 2023). At inference time Sandwich layers can either be evaluated using an full-image size kernel or in the Fourier domain, cmp. Fig. 3. The latter requires the use of a fast Fourier transform and an inverse fast Fourier transform and the computation of inverses at inference time, making it computationally more costly than the evaluation of LipKernel layers. 

## **5 Numerical Experiments** 

## _5.1 Run-times for inference_ 

First, we compare the run-times at inference, i.e., the time for evaluation of a fixed model after training, for varying numbers of channels, different input image sizes, and different kernel sizes for LipKernel, Sandwich, and Orthogon layers with randomly generated weights[2] . 

- **Sandwich:** Wang and Manchester (2023) suggest an LMI-based method using the Cayley transform, wherein convolutional layers are parameterized in the Fourier domain using circular padding, cmp. Subsection 4.5. 

- **Orthogon:** Trockman and Kolter (2021) use the Cayley transform to parameterize orthogonal layers. Convolutional layers are parameterized in the Fourier domain using circular padding. 

The averaged run-times are shown in Fig. 4. For all chosen channel, image, and kernel sizes the inference time of LipKernel is very short (from _<_ 1ms to around 100ms), whereas Sandwich layer and Orthogon layer evaluations are two to three orders of magnitude slower and increases significantly with channel and image sizes (from around 10ms to over 10s). Kernel size does not affect the runtime of either layer significantly. 

A particular motivation of our work is to improve the robustness of NNs for use in real-time control systems. In this context, these inference-time differences can have a significant impact, both in terms of achievable sample rates (100Hz vs 0.1Hz) and latency in the feedback loop. Furthermore, it is increasingly the case that compute (especially NN inference) consumes a significant percentage of the power in mobile robots and other “edge devices” (Chen et al., 2020). Significant reductions in inference time for robust NNs can therefore be a key enabler for use especially in battery-powered systems. 

## _5.2 Accuracy and robustness comparison_ 

We next compare LipKernel to three other methods developed to train Lipschitz-bounded NNs in terms of accuracy and robustness. In particular, we compare LipKernel to Sandwich and Orthogon as well as vanilla and almost-orthogonal Lipschitz (AOL) NNs: 

- **Vanilla:** Unconstrained neural network. 

We note that Sandwich requires circular padding instead of zero-padding and the implementation of Wang and Manchester (2023) only takes input image sizes of the specific size of 2 _[n]_ , _n ∈_ N0. In this respect, LipKernel is more versatile than Sandwich, it can handle all kinds of zero-padding and accounts for pooling layers, which are not considered in (Wang and Manchester, 2023). 

- **AOL:** Prach and Lampert (2022) introduce a rescaling-based weight matrix parametrization to obtain AOL layers which are 1-Lipschitz. Like LipKernel 

> 2 The code is written in Python using Pytorch and was run on a standard i7 notebook. It is provided at `https: //github.com/ppauli/2D-LipCNNs` . 

14 

**==> picture [245 x 245] intentionally omitted <==**

**----- Start of picture text -----**<br>
LipKernel Sandwich Orthogon<br>10s<br>100ms<br>1ms<br>10 20 50 100 200 500<br># Channels ( c in =  c out, N = 32, k = 3)<br>10s<br>100ms<br>1ms<br>8 16 32 64 128 256 512<br>Image Size ( c  = 32, k = 3)<br>100ms<br>10ms<br>1ms<br>0.1ms<br>3 5 7 9 11 13 15<br>Kernel Size ( c  = 32, N = 32)<br>time<br>run<br>Avg.<br>time<br>run<br>Avg.<br>time<br>run<br>Avg.<br>**----- End of picture text -----**<br>


Fig. 4. Inference times for LipKernel, Sandwich, and Orthogon layers with different numbers of channels _c_ = _c_ in = _c_ out, input image sizes _N_ = _N_ 1 = _N_ 2, and kernel sizes _k_ = _k_ 1 = _k_ 2. For all layers, we have stride equal to 1 and average the run-time over 10 different initializations. 

layers, at inference, convolutional AOL layers can be evaluated in standard form. 

We train classifying CNNs on the MNIST dataset (LeCun and Cortes, 2010) of size 32 _×_ 32 images with CNN architectures 2C2F: _c_ (16 _,_ 4 _,_ 2) _.c_ (32 _,_ 4 _,_ 2) _.f_ (100) _.f_ (10), 2CP2F: _c_ (16 _,_ 4 _,_ 1) _.p_ (av _,_ 2 _,_ 2) _.c_ (32 _,_ 4 _,_ 1) _.p_ (av _,_ 2 _,_ 2) _.f_ (100) _.f_ (10), wherein by _c_ ( _C, K, S_ ), we denote a convolutional layer with _C_ output channels, kernel size _K_ , and stride _S_ , by _f_ ( _N_ ) a fully connected layer with _N_ output neurons, and by _p_ (type _, K, S_ ) an ‘av’ or ‘max’ pooling layer. 

In Table 1, we show the clean accuracy, i.e., the test accuracy on unperturbed test data, the certified robust accuracy, and the robustness under the _ℓ_ 2 projected gradient descent (PGD) adversarial attack of the trained NNs. The certified robust accuracy is a robustness metric for NNs that gives the fraction of test data points that are guaranteed to remain correct under all perturbations from an _ϵ_ -ball. It is obtained by identifying all test data points _x_ with classification margin _Mf_ ( _x_ ) greater than _√_ 2 _ρϵ_ , where _ρ_ is the NN’s upper bound on the Lipschitz constant (Tsuzuku et al., 2018). The _ℓ_ 2 PGD attack is a white box multi-step attack that modifies each input data point by maximizing the loss within an _ℓ_ 2 _ϵ_ -ball around that point (Madry et al., 2018). The accuracy under _ℓ_ 2 PGD attacks gives the fraction of attacked test data points which are correctly classified. 

**==> picture [234 x 101] intentionally omitted <==**

**----- Start of picture text -----**<br>
1 1<br>0 . 95<br>0 . 95<br>Vanilla 0 . 9<br>LipKernel Vanilla<br>0 . 9 0 . 85<br>Orthogon LipKernel<br>Sandwich AOL<br>0 . 8<br>0 . 85<br>10 [0] 10 [1] 10 [2] 10 [0] 10 [1] 10 [2]<br>Lipschitz constant Lipschitz constant<br>accuracy<br>test<br>**----- End of picture text -----**<br>


Fig. 5. Robustness accuracy trade-off for 2C2F (left) 2CP2F (right) for NNs averaged over three initializations. 

First, we note that LipKernel is general and flexible in the sense that we can use it in both the 2C2F and the 2CP2F architectures, whereas Sandwich and Orthogon are limited to image sizes of 2 _[n]_ and to circular padding and AOL does not support strided convolutions. Comparing LipKernel to Orthogon and AOL, we notice better expressivity in the higher clean accuracy and significantly better robustness with the stronger Lipschitz bounds of 1 and 2. In comparison to Sandwich, LipKernel achieves comparable but slightly lower expressivity and robustness. However as discussed above it is more flexible in terms of architecture and has a significant advantage in terms of inference times. 

In Figure 5, we plot the achieved clean test accuracy over the Lipschitz lower bound for 2C2F and 2CP2F for LipKernel and the other methods, clearly recognizing the trade-off between accuracy and robustness. Again, we see that LipKernel shows better expressivity than Orthogon and AOL and similar performance to Sandwich. 

## **6 Conclusion** 

We have introduced LipKernel, an expressive and versatile parameterization for Lipschitz-bounded CNNs. Our parameterization of convolutional layers is based on a 2-D state space representation of the Roesser type that, unlike parameterizations in the Fourier domain, allows to directly parameterize the kernel parameters of convolutional layers. This in turn enables fast evaluation at inference time making LipKernel especially useful for real-time control systems. Our parameterization satisfies layer-wise LMI constraints that render the individual layers incrementally dissipative and the end-to-end mapping Lipschitz-bounded. Furthermore, our general framework can incorporate any dissipative layer. 

## **References** 

- Anderson, B., Agathoklis, P., Jury, E., Mansour, M., 1986. Stability and the matrix lyapunov equation for discrete 2- dimensional systems. IEEE Transactions on Circuits and Systems 33 (3), 261–267. 

- Anil, C., Lucas, J., Grosse, R., 2019. Sorting out Lipschitz function approximation. In: International Conference on Machine Learning. PMLR, pp. 291–301. 

15 

## Table 1 

Empirical lower Lipschitz bounds, clean accuracy, certified robust accuracy and adversarial robustness under _ℓ_ 2 PGD attack for vanilla, AOL, Orthogon, Sandwich, and LipKernel NNs using the architectures 2C2F and 2CP2F with ReLU activations, each trained for 20 epochs and averaged for three different initializations. 

|**Model**|**Method**<br>**Cert. UB**<br>**Emp. LB**<br>**Test acc.**|**Cert. robust acc.**<br>_ℓ_2 **PGD Adv. test acc.**|
|---|---|---|
|||_ϵ_=<br>36<br>255<br>_ϵ_=<br>72<br>255<br>_ϵ_= 108<br>255<br>_ϵ_= 1_._0<br>_ϵ_= 2_._0<br>_ϵ_= 3_._0|
|2C2F|Vanilla<br>–<br>221.7<br>99.0%|0.0%<br>0.0%<br>0.0%<br>69.5%<br>61.9%<br>59.6%|
||Orthogon<br>1<br>0.960<br>94.6%<br>Sandwich<br>1<br>0.914<br>97.3%<br>LipKernel<br>1<br>0.952<br>96.6%|92.9%<br>91.0%<br>88.3%<br>83.7%<br>65.2%<br>60.4%<br>96.3%<br>95.2%<br>93.8%<br>90.5%<br>76.5%<br>72.0%<br>95.6%<br>94.3%<br>92.6%<br>88.3%<br>72.2%<br>67.8%|
||Orthogon<br>2<br>1.744<br>97.7%<br>Sandwich<br>2<br>1.703<br>98.9%<br>LipKernel<br>2<br>1.703<br>98.2%|96.3%<br>94.4%<br>91.8%<br>89.1%<br>66.0%<br>58.2%<br>98.2%<br>97.0%<br>95.4%<br>93.1%<br>74.0%<br>67.2%<br>97.1%<br>95.6%<br>93.6%<br>89.8%<br>66.1%<br>58.9%|
||Orthogon<br>4<br>2.894<br>98.8%<br>Sandwich<br>4<br>2.969<br>99.3%<br>LipKernel<br>4<br>3.110<br>98.9%|97.4%<br>94.4%<br>88.6%<br>89.6%<br>56.0%<br>46.0%<br>98.4%<br>96.9%<br>93.6%<br>92.5%<br>63.3%<br>54.0%<br>97.5%<br>95.3%<br>91.3%<br>88.6%<br>49.6%<br>39.7%|
|2CP2F|Vanilla<br>–<br>148.0<br>99.3%|0.0%<br>0.0%<br>0.0%<br>73.2%<br>56.2%<br>53.7%|
||AOL<br>1<br>0.926<br>88.7%<br>LipKernel<br>1<br>0.759<br>91.7%|85.5%<br>81.7%<br>77.2%<br>70.6%<br>49.2%<br>44.6%<br>88.0%<br>83.1%<br>77.3%<br>77.3%<br>57.2%<br>52.2%|
||AOL<br>2<br>1.718<br>93.0%<br>LipKernel<br>2<br>1.312<br>94.9%|89.9%<br>85.9%<br>80.4%<br>75.8%<br>46.6%<br>38.1%<br>91.1%<br>85.4%<br>77.8%<br>80.9%<br>53.8%<br>45.8%|
||AOL<br>4<br>2.939<br>95.9%<br>LipKernel<br>4<br>2.455<br>97.1%|92.4%<br>86.2%<br>76.3%<br>78.2%<br>37.0%<br>29.6%<br>93.7%<br>87.2%<br>75.7%<br>80.0%<br>36.8%<br>29.0%|



- Aquino, B., Rahnama, A., Seiler, P., Lin, L., Gupta, V., 2022. Robustness against adversarial attacks in neural networks using incremental dissipativity. IEEE Control Systems Letters 6, 2341–2346. 

- Araujo, A., Havens, A. J., Delattre, B., Allauzen, A., Hu, B., 2023. A unified algebraic perspective on Lipschitz neural networks. In: International Conference on Learning Representations. 

- Behrmann, J., Grathwohl, W., Chen, R. T., Duvenaud, D., Jacobsen, J.-H., 2019. Invertible residual networks. In: International Conference on Machine Learning. PMLR, pp. 573–582. 

- Berkenkamp, F., Turchetta, M., Schoellig, A., Krause, A., 2017. Safe model-based reinforcement learning with stability guarantees. In: Advances in Neural Information Processing Systems. pp. 908–918. 

- Bishop, C. M., 1994. Neural networks and their applications. Review of scientific instruments 65 (6), 1803–1832. 

- Brunke, L., Greeff, M., Hall, A. W., Yuan, Z., Zhou, S., Panerati, J., Schoellig, A. P., 2022. Safe learning in robotics: From learning-based control to safe reinforcement learning. Annual Review of Control, Robotics, and Autonomous Systems 5 (1), 411–444. 

- Byrnes, C. I., Lin, W., 1994. Losslessness, feedback equivalence, and the global stabilization of discrete-time nonlinear systems. IEEE Transactions on Automatic Control 39 (1), 83–98. 

- Chen, C.-T., 1984. Linear system theory and design. Saunders college publishing. 

- Chen, R. T., Behrmann, J., Duvenaud, D. K., Jacobsen, J.H., 2019. Residual flows for invertible generative modeling. Advances in Neural Information Processing Systems 32. 

- Chen, Y., Zheng, B., Zhang, Z., Wang, Q., Shen, C., Zhang, Q., 2020. Deep learning on mobile and embedded devices: State-of-the-art, challenges, and future directions. ACM Computing Surveys (CSUR) 53 (4), 1–37. 

- Combettes, P. L., Pesquet, J.-C., 2020. Lipschitz certificates for layered network structures driven by averaged activation operators. SIAM Journal on Mathematics of Data 

- Science 2 (2), 529–557. 

- Fazlyab, M., Morari, M., Pappas, G. J., 2020. Safety verification and robustness analysis of neural networks via quadratic constraints and semidefinite programming. IEEE Transactions on Automatic Control. 

- Fazlyab, M., Robey, A., Hassani, H., Morari, M., Pappas, G., 2019. Efficient and accurate estimation of Lipschitz constants for deep neural networks. Advances in Neural Information Processing Systems 32. 

- Goodfellow, I., Bengio, Y., Courville, A., 2016. Deep Learning. MIT Press. 

- Gouk, H., Frank, E., Pfahringer, B., Cree, M. J., 2021. Regularisation of neural networks by enforcing Lipschitz continuity. Machine Learning 110, 393–416. 

- Gramlich, D., Pauli, P., Scherer, C. W., Allg¨ower, F., Ebenbauer, C., 2023. Convolutional neural networks as 2-d systems. arXiv:2303.03042. 

- Guo, B.-Z., Zwart, H., 2006. On the relation between stability of continuous-and discrete-time evolution equations via the Cayley transform. Integral Equations and Operator Theory 54, 349–383. 

- Helfrich, K., Willmott, D., Ye, Q., 2018. Orthogonal recurrent neural networks with scaled Cayley transform. In: International Conference on Machine Learning. PMLR, pp. 1969–1978. 

- Jin, M., Lavaei, J., 2020. Stability-certified reinforcement learning: A control-theoretic perspective. IEEE Access 8, 229086–229100. 

- Jordan, M., Dimakis, A. G., 2020. Exactly computing the local Lipschitz constant of ReLU networks. In: Advances in Neural Information Processing Systems. pp. 7344–7353. 

- Latorre, F., Rolland, P., Cevher, V., 2020. Lipschitz constant estimation of neural networks via sparse polynomial optimization. In: International Conference on Learning Representations. 

- LeCun, Y., Bengio, Y., Hinton, G., 2015. Deep learning. nature 521 (7553), 436–444. 

- LeCun, Y., Cortes, C., 2010. MNIST handwritten digit database. 

16 

- Li, Z., Liu, F., Yang, W., Peng, S., Zhou, J., 2021. A survey of convolutional neural networks: analysis, applications, and prospects. IEEE Transactions on Neural Networks and Learning Systems 33 (12), 6999–7019. 

- Madry, A., Makelov, A., Schmidt, L., Tsipras, D., Vladu, A., 2018. Towards deep learning models resistant to adversarial attacks. In: International Conference on Learning Representations. 

- Pauli, P., Funcke, N., Gramlich, D., Msalmi, M. A., Allg¨ower, F., 2022. Neural network training under semidefinite constraints. In: 61st Conference on Decision and Control. IEEE, pp. 2731–2736. 

- Pauli, P., Gramlich, D., Allg¨ower, F., 2023a. Lipschitz constant estimation for 1d convolutional neural networks. In: Learning for Dynamics and Control Conference. PMLR, pp. 1321–1332. 

- Pauli, P., Gramlich, D., Allg¨ower, F., 2024a. Lipschitz constant estimation for general neural network architectures using control tools. arXiv:2405.01125. 

- Pauli, P., Gramlich, D., Allg¨ower, F., 2024b. State space representations of the Roesser type for convolutional layers. IFAC-PapersOnLine 58 (17), 344–349. 

- Pauli, P., Koch, A., Berberich, J., Kohler, P., Allg¨ower, F., 2021. Training robust neural networks using Lipschitz bounds. IEEE Control Systems Letters 6, 121–126. 

- Pauli, P., Wang, R., Manchester, I. R., Allg¨ower, F., 2023b. Lipschitz-bounded 1D convolutional neural networks using the Cayley transform and the controllability Gramian. In: 62nd Conference on Decision and Control. IEEE, pp. 5345–5350. 

- Perugachi-Diaz, Y., Tomczak, J., Bhulai, S., 2021. Invertible densenets with concatenated lipswish. Advances in Neural Information Processing Systems 34, 17246–17257. 

- Prach, B., Lampert, C. H., 2022. Almost-orthogonal layers for efficient general-purpose Lipschitz networks. In: Computer Vision–ECCV 2022: 17th European Conference. 

- Revay, M., Wang, R., Manchester, I. R., 2020a. A convex parameterization of robust recurrent neural networks. IEEE Control Systems Letters 5 (4), 1363–1368. 

- Revay, M., Wang, R., Manchester, I. R., 2020b. Lipschitz bounded equilibrium networks. arXiv:2010.01732. 

- Revay, M., Wang, R., Manchester, I. R., 2023. Recurrent equilibrium networks: Flexible dynamic models with guaranteed stability and robustness. IEEE Transactions on Automatic Control. 

- Roesser, R., 1975. A discrete state-space model for linear image processing. IEEE Transactions on Automatic Control 20 (1). 

- Singla, S., Singla, S., Feizi, S., 2022. Improved deterministic l2 robustness on CIFAR-10 and CIFAR-100. In: International Conference on Learning Representations. 

- Szegedy, C., Zaremba, W., Sutskever, I., Bruna, J., Erhan, D., Goodfellow, I., Fergus, R., 2014. Intriguing properties of neural networks. In: International Conference on Learning Representations. 

- Trockman, A., Kolter, J. Z., 2021. Orthogonalizing convolutional layers with the Cayley transform. In: International Conference on Learning Representations. 

- Tsuzuku, Y., Sato, I., Sugiyama, M., 2018. Lipschitz-margin training: Scalable certification of perturbation invariance for deep neural networks. Advances in neural information processing systems 31. 

- Virmaux, A., Scaman, K., 2018. Lipschitz regularity of deep neural networks: analysis and efficient estimation. Advances in Neural Information Processing Systems 31. 

- Wang, R., Dvijotham, K., Manchester, I. R., 2024. Monotone, bi-Lipschitz, and Polyak- �Lojasiewicz networks. In: International Conference on Machine Learning. PMLR. 

**Patricia Pauli** received master’s degrees in mechanical engineering and computational engineering from the Technical University of Darmstadt, Germany, in 2019. She received a PhD from the University of Stuttgart, Germany, in 2025. Since 2025, she has been an Assistant Professor in the Department of Mechanical Engineering at Eindhoven University of Technology. Her research interests are in robust machine learning and learning-based control. 

**Ruigang Wang** received the Ph.D. degree in chemical engineering from The University of New South Wales (UNSW), Sydney, NSW, Australia, in 2017. From 2017 to 2018, he worked as a Postdoctoral Fellow with the UNSW. He is currently a Postdoctoral Fellow with the Australian Centre for Robotics, The University of Sydney, Sydney. His research interests include contraction-based control, estimation, and learning for nonlinear systems. 

**Ian R. Manchester** received the B.E. (Hons 1) and Ph.D. degrees in Electrical Engineering from the University of New South Wales, Australia, in 2002 and 2006, respectively. He was a Researcher with Ume˚a University, Ume˚a, Sweden, and the Massachusetts Institute of Technology, Cambridge, MA, USA. In 2012, he joined the Faculty with the University of Sydney, Camperdown, NSW, Aus- 

**==> picture [73 x 91] intentionally omitted <==**

tralia, where he is currently a Professor of mechatronic engineering, the Director of the Australian Centre for Robotics (ACFR), and Director of the Australian Robotic Inspection and Asset Management Hub (ARIAM). His research interests include optimization and learning methods for nonlinear system analysis, identification, and control, and the applications in robotics and biomedical engineering. 

**Frank Allg¨ower** studied engineering cybernetics and applied mathematics in Stuttgart and with the University of California, Los Angeles (UCLA), CA, USA, respectively, and received the Ph.D. degree from the University of Stuttgart, Stuttgart, Germany. Since 1999, he has been the Director of the Institute for Systems Theory and Automatic Control and a professor with the University of 

**==> picture [73 x 91] intentionally omitted <==**

Stuttgart. His research interests include predictive control, data-based control, networked control, cooperative control, and nonlinear control with application to a wide range of fields including systems biology. Dr. Allg¨ower was the President of the International Federation of Automatic Control (IFAC) in 2017–2020 and the Vice President of the German Research Foundation DFG in 2012–2020. 

- Wang, R., Manchester, I., 2023. Direct parameterization of Lipschitz-bounded deep networks. In: International Conference on Machine Learning. PMLR, pp. 36093–36110. 

17 

