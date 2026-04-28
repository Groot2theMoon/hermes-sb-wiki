---
title: "Decoding material networks: exploring performance of deep material network and interaction-based material networks"
authors: "Wen-Ning Wan, Ting-Ju Wei, Tung-Huan Su, Chuin-Shan Chen"
year: 2024
journal: "Journal of Mechanics"
doi: "10.1093/jom/ufae053"
ingested: 2026-04-28
sha256: 3eb84896f5c77ac8a19620f07ec4692b4f3c2d8cb4a840299b6651b7a1a634d3
source: paper
---



# Decoding material networks: exploring performance of deep material network and interaction-based material networks

Wen-Ning Wan ![ORCID icon](666e09182d4cd268646ea700ea60dcdf_img.jpg), Ting-Ju Wei ![ORCID icon](1ef1ef0bf9af6c6996401964cf280f2d_img.jpg), Tung-Huan Su ![ORCID icon](e9a80c8557f9285916925bd4ac40fff5_img.jpg) and Chuin-Shan Chen ![ORCID icon](88e2edecff3400e68a80dd08c57d2f9c_img.jpg),\*

<sup>1</sup>Department of Civil Engineering, National Taiwan University, Taipei, Taiwan

<sup>2</sup>Computational and Multiscale Mechanics Group, ANSYS Inc., Livermore, CA, USA

\*Corresponding author: [dchen@ntu.edu.tw](mailto:dchen@ntu.edu.tw)

## ABSTRACT

The deep material network (DMN) is a multiscale material modeling method well-known for its ability to extrapolate learned knowledge from elastic training data to nonlinear material behaviors. DMN is based on a two-layer building block structure. In contrast, the later proposed interaction-based material network (IMN) adopts a different approach, focusing on interactions within the material nodes rather than relying on laminate composite structures. Despite the increasing interest in both models, a comprehensive comparison of these two computational frameworks has yet to be conducted. This study provides an in-depth review and comparison of DMN and IMN, examining their underlying computational frameworks of offline training and online prediction. Additionally, we present a case study where both models are trained on short-fiber reinforced composites. We trained each model using elastic linear datasets to evaluate their performance and subjected them to multiple loading tests. Their performance is closely compared, and the possible factors that cause differences are explored. The superiority of IMN in offline training and online prediction is found.

**KEYWORDS:** deep material network, interaction-based material network, mechanistic machine learning

## 1 INTRODUCTION

Advancements in computational methods have expanded the capabilities of multiscale simulation. Traditionally, representative volume element (RVE) analysis and homogenization techniques, such as direct numerical simulations (DNS) via finite element methods [1–4], or fast Fourier transform [5,6], have relied on detailed microstructural information and high-resolution data to accurately model the response of an RVE. These methods, however, are computationally intensive and often require significant resources to capture the necessary microstructural details [7,8].

With the advent of artificial neural networks (ANNs) [9,10], data-driven material models [11,12] have emerged as powerful alternatives, serving as surrogate models that can reduce computational complexity and dramatically decrease the time required for online predictions. These models, including recurrent neural networks [13], convolutional neural networks [14] and graph neural networks (GNNs) [15–18], have shown remarkable performance in multiscale simulations by lowering the degrees of freedom in the computational process. Despite the promising speed enhancements ANN-based surrogate models offer, they often focus on a single problem. Another limitation is that the material sampling space is confined to the original training dataset, restricting the model's ability to predict material behavior beyond this known space. Moreover, these models cannot handle history-dependent material behaviors, such as those involving plasticity or other nonlinear responses. This limitation

is primarily due to the absence of physical information within the machine learning framework.

One of the models that stands out in the field is the deep material network (DMN), introduced by Liu *et al.* [19,20]. DMN employs a binary tree with two-layer linear elastic laminate building blocks to represent the homogenization behaviors of an RVE. Unlike previous approaches, DMN offers several notable advantages, including predicting nonlinear behaviors while training solely on linear data. A crucial feature of DMN is its physically informed nature, which allows for extracting microstructural information, such as volume fractions and rotation angles, directly from the building block. This capability enhances DMN's ability to capture mechanical properties that can be validated against real-world experimental data [21,22]. Consequently, DMN is well-suited to handle complex material behaviors, including finite strain, small strain deformation and nonlinear history-dependent plasticity. As a result, DMN can be extended to various material systems, including polycrystalline materials [19] and multiscale carbon-reinforced composite materials [20].

Several extended works have enhanced the implementation of the DMN. Some of these extensions address more complex problems, such as creep loading behavior [23] and thermo-mechanical responses [24]. Others focus on improving performance, including strategies like quilting [25], integration with GNNs [26] and the development of a rotation-free DMN [27]. An alternative approach, the interaction-based material network (IMN) [28] claims to accelerate training without sacrificing accuracy. This distinction sparked our interest in comparing the

![Figure 1: DMN structure data flow diagram. The diagram shows a hierarchical tree structure of nodes representing material networks. Phase 1 nodes are labeled C^1_1, C^1_2, C^1_3, C^1_4, C^1_5, C^1_6, C^1_7, C^1_8, C^1_9, C^1_10, C^1_11, C^1_12, C^1_13, C^1_14, C^1_15, C^1_16, C^1_17, C^1_18, C^1_19, C^1_20. Phase 2 nodes are labeled C^2_1, C^2_2, C^2_3, C^2_4, C^2_5, C^2_6, C^2_7, C^2_8, C^2_9, C^2_10, C^2_11, C^2_12, C^2_13, C^2_14, C^2_15, C^2_16, C^2_17, C^2_18, C^2_19, C^2_20. The root node is C^1_1. The diagram illustrates the flow of data through the network, with nodes connected by arrows and labels like 'R_{layer} = 0' and 'R_{layer} = 3'.](9ba3dc91984c80b96f217fb1bddd5c06_img.jpg)

Figure 1: DMN structure data flow diagram. The diagram shows a hierarchical tree structure of nodes representing material networks. Phase 1 nodes are labeled C^1\_1, C^1\_2, C^1\_3, C^1\_4, C^1\_5, C^1\_6, C^1\_7, C^1\_8, C^1\_9, C^1\_10, C^1\_11, C^1\_12, C^1\_13, C^1\_14, C^1\_15, C^1\_16, C^1\_17, C^1\_18, C^1\_19, C^1\_20. Phase 2 nodes are labeled C^2\_1, C^2\_2, C^2\_3, C^2\_4, C^2\_5, C^2\_6, C^2\_7, C^2\_8, C^2\_9, C^2\_10, C^2\_11, C^2\_12, C^2\_13, C^2\_14, C^2\_15, C^2\_16, C^2\_17, C^2\_18, C^2\_19, C^2\_20. The root node is C^1\_1. The diagram illustrates the flow of data through the network, with nodes connected by arrows and labels like 'R\_{layer} = 0' and 'R\_{layer} = 3'.

Figure 1 DMN structure data flow.

two material networks, and a direct comparison using the same study case has not been performed.

IMN was proposed by Noël *et al.* [28,29]. IMN offers a different aspect of material networks. Instead of relying on the laminate building blocks, IMN introduces the concept of interactions among discrete material nodes within the network. IMN is a tree-based structure like DMN, but the successor nodes are not limited to 2, allowing it to deal with multi-phase material. IMN is also capable of handling porous microstructure, where setting zero strain on a node does not work for DMN.

In this study, we will compare models' methodological topology and evaluate computational performances during offline training and online prediction based on our in-house implementations using Python. To seek the key that causes differences in the performances, we conduct a close investigation of the framework of the models.

The paper is organized as follows: In Section 2, the hierarchical structures of DMN and IMN will be fully described in both offline training and online prediction. In Section 3, models will be trained with an example, and the performance comparison will be presented. In Section 4, we will discuss the possible factors that cause improvement from DMN to IMN, and Section 5 for conclusion.

## 2 METHODS

This section presents the fundamental theories behind DMN and IMN and then compares their network topologies. Additionally, it includes a discussion on both offline and online workflows.

### 2.1 Offline training

Offline training is performed using linear data to capture the homogenized mechanical behavior of an RVE. The goal is to train the model to accurately represent the material's responses under linear elastic conditions.

#### 2.1.1 DMN offline training

The fundamental building block of DMN represents a two-phase laminate. The composition of laminates depicts a microstructure. To fit the microstructure pattern, DMN applies two key operations to the blocks: homogenization and rotation. The DMN structure data flow is demonstrated in Fig. 1.

Under Mandel notation, Cauchy stress  $\sigma$ , and infinitesimal strain  $\epsilon$  are presented as:

$$\begin{aligned}\sigma &= [\sigma_{11}, \sigma_{22}, \sigma_{33}, \sqrt{2}\sigma_{23}, \sqrt{2}\sigma_{13}, \sqrt{2}\sigma_{12}]^T \\ &\equiv [\sigma_1, \sigma_2, \sigma_3, \sqrt{2}\sigma_4, \sqrt{2}\sigma_5, \sqrt{2}\sigma_6]^T, \quad (1)\end{aligned}$$

$$\begin{aligned}\epsilon &= [\epsilon_{11}, \epsilon_{22}, \epsilon_{33}, \sqrt{2}\epsilon_{23}, \sqrt{2}\epsilon_{13}, \sqrt{2}\epsilon_{12}]^T \\ &\equiv [\epsilon_1, \epsilon_2, \epsilon_3, \epsilon_4, \epsilon_5, \epsilon_6]^T. \quad (2)\end{aligned}$$

Under the assumption of small strains in a three-dimensional framework, the stress-strain relationship within the building block can be expressed as

$$\sigma = C\epsilon \quad (3)$$

$C$  is a second-order stiffness tensor. For each material, phase 1 and 2, we have

$$\sigma^1 = C^1 \epsilon^1, \quad \sigma^2 = C^2 \epsilon^2. \quad (4)$$

The volume fractions of phase 1 is denoted by  $f_1$  and phase 2 is denoted by  $f_2 \equiv 1 - f_1$ , and the averaging equation for stresses is

$$\bar{\sigma} = f_1 \sigma^1 + f_2 \sigma^2. \quad (5)$$

The analytical homogenized solutions are derived based on the equilibrium condition

$$\sigma_3^1 = \sigma_3^2, \quad \sigma_4^1 = \sigma_4^2, \quad \sigma_5^1 = \sigma_5^2, \quad (6)$$

and kinematic constraints

$$\epsilon_1^1 = \epsilon_1^2, \quad \epsilon_2^1 = \epsilon_2^2, \quad \epsilon_6^1 = \epsilon_6^2. \quad (7)$$

The homogenized stiffness matrix, which is associated with individual stiffness matrices and weights, can be described as a homogenized function  $\mathcal{H}_{DMN}$ :

$$\bar{C}^r = \mathcal{H}_{DMN}(C^1, C^2, w^1, w^2) = C^2 - f_1 \Delta C b^1. \quad (8)$$

The detailed derivation starts with expanding (7)

$$\begin{aligned}\sigma_3^1 &= \sigma_3^2 \\ &\rightarrow C_{11}^1 \sigma_1^1 + C_{12}^1 \sigma_2^1 + C_{13}^1 \sigma_3^1 + C_{14}^1 \sigma_4^1 + C_{15}^1 \sigma_5^1 + C_{16}^1 \sigma_6^1 \\ &= C_{11}^2 \sigma_1^2 + C_{12}^2 \sigma_2^2 + C_{13}^2 \sigma_3^2 + C_{14}^2 \sigma_4^2 + C_{15}^2 \sigma_5^2 + C_{16}^2 \sigma_6^2. \quad (9)\end{aligned}$$

Substituting the rewritten (5):  $\epsilon^2 = \frac{1}{f_2} \bar{\epsilon} - \frac{f_1}{f_2} \epsilon^1$ , and (6), we can get

$$\begin{aligned}&(f_2 C_{33}^1 + f_1 C_{33}^2) \epsilon_1^1 + (f_2 C_{34}^1 + f_1 C_{34}^2) \epsilon_1^1 + (f_2 C_{35}^1 + f_1 C_{35}^2) \epsilon_1^1 \\ &= C_{33}^2 \bar{\epsilon}_3 + C_{34}^2 \bar{\epsilon}_4 + C_{35}^2 \bar{\epsilon}_5 \\ &\quad + f_2 [(C_{13}^2 - C_{13}^1) \bar{\epsilon}_1 + (C_{23}^2 - C_{23}^1) \bar{\epsilon}_2 + (C_{36}^2 - C_{36}^1) \bar{\epsilon}_6] \quad (10)\end{aligned}$$

same for  $\sigma_4^1 = \sigma_4^2$  and  $\sigma_5^1 = \sigma_5^2$ . After rewriting, we can get a  $b^1$  tensor

$$b_{3 \times 6}^1 = \begin{bmatrix} \hat{C}_{33} & \hat{C}_{34} & \hat{C}_{35} \\ \hat{C}_{34} & \hat{C}_{44} & \hat{C}_{45} \\ \hat{C}_{35} & \hat{C}_{45} & \hat{C}_{55} \end{bmatrix}^{-1}$$

$$\begin{bmatrix} f_2 \Delta C_{13} & f_2 \Delta C_{23} & D_{33}^2 & C_{34}^2 & C_{35}^2 & f_2 \Delta C_{36} \\ f_2 \Delta C_{13} & f_2 \Delta C_{23} & D_{33}^2 & C_{34}^2 & C_{35}^2 & f_2 \Delta C_{36} \\ f_2 \Delta C_{13} & f_2 \Delta C_{23} & D_{33}^2 & C_{34}^2 & C_{35}^2 & f_2 \Delta C_{36} \end{bmatrix}. \quad (11)$$

$\Delta C = C^2 - C^1$  and  $\hat{C} = f_2 C^1 + f_1 C^2$ , with  $b_{11}^1 = b_{12}^1 = b_{16}^1 = 1$ , with all other components being zero. Note that the homogenized process also works for compliance matrix and should be able to get the same result of homogenized stiffness matrix once inverse the homogenized compliance matrix.

After analytically deriving the homogenized compliance matrix, a rotation step is applied to generalize the building block. The stiffness matrix  $\hat{C}^r$  undergoes rotation by angles  $\alpha, \beta, \gamma$ .

$$\hat{C} = R^{-1}(\alpha, \beta, \gamma) \hat{C}^r R(\alpha, \beta, \gamma). \quad (12)$$

The rotation matrices  $R$  based on Tait–Bryan angles are given by:

$$\begin{aligned} X_{(1,1)} &= 1, X_{([2,3,4],[2,3,4])}(\alpha) = r^v(\alpha), \\ X_{([5,6],[5,6])}(\alpha) &= r^v(\alpha); \\ Y_{(2,2)} &= 1, Y_{([1,3,5],[1,3,5])}(\beta) = r^p(-\beta), \\ Y_{([4,6],[4,6])}(\beta) &= r^p(-\beta); \\ Z_{(3,3)} &= 1, Z_{([1,2,6],[1,2,6])}(\gamma) = r^v(\gamma), \\ Z_{([4,5],[4,5])}(\gamma) &= r^v(\gamma); \end{aligned} \quad (13)$$

$r^p$  and  $r^v$  are the in-plane and output-plane rotation matrices, respectively, and for an arbitrary input angle  $\theta$ , the matrices are:

$$\begin{aligned} r^p(\theta) &= \begin{bmatrix} \cos^2 \theta & \sin^2 \theta & \sqrt{2} \sin \theta \cos \theta \\ \sin^2 \theta & \cos^2 \theta & -\sqrt{2} \sin \theta \cos \theta \\ -\sqrt{2} \sin \theta \cos \theta & \sqrt{2} \sin \theta \cos \theta & \cos^2 \theta - \sin^2 \theta \end{bmatrix} \\ r^v(\theta) &= \begin{bmatrix} \cos \theta & -\sin \theta \\ \sin \theta & \cos \theta \end{bmatrix}. \end{aligned} \quad (14)$$

The combination of rotation function, which applies on the blocks, is denoted as

$$R(\alpha, \beta, \gamma) = X(\alpha)Y(\beta)Z(\gamma). \quad (15)$$

The complete DMN training algorithm is presented in Algorithm 1. The material properties of two phases are assigned to the leaf nodes, and the upper nodes are assigned with the homogenized tangent by a feed-forward process, detailed in Algorithm 2. Besides, consider a  $N$  layer DMN with  $l$  leaf nodes, an activation parameter  $z$  is used to assign weight to the bottom nodes. The relationship between activation  $z_i$  and weight  $w_i$  is

$$w_i = \text{ReLU}(z_i). \quad (16)$$

The activation function used in DMN is ReLU [30]:

$$\text{ReLU}(x) = \begin{cases} x & \text{if } x \geq 0, \\ 0 & \text{if } x < 0. \end{cases} \quad (17)$$

Then, the compliance matrices of two phases are homogenized and rotated following Eqs. (8) and (12). The homogenized matrix will be given to the parent node's value at the next layer. The weight of the parent nodes is the summation of its leaf node

$w_N = w_{N+1}^1 + w_{N+1}^2$ . Superscript 1 means the left node of the parent node, and superscript 2 means the right node of the parent node. Furthermore, the weight on each node reflects the volume fraction of the constituent phases, calculated as follows:

$$f_1 = \frac{w^1}{w^1 + w^2}, \quad f_2 = 1 - f_1. \quad (18)$$

The upscaling process repeats until the data flow reaches the root node. The matrix we get on the root node is the output matrix  $C^{dmn}$ , which will be used to calculate accuracy. The error of a sample  $s$ , comparing to DNS result  $C^{dns}$  is calculated as:

$$e_s = \frac{\|C_s^{dns} - C_s^{dmn}\|}{\|C_s^{dns}\|}. \quad (19)$$

Backpropagation done by PyTorch [31] will update parameters, including weight at leaf nodes  $w_i$  and rotation angles  $\alpha, \beta, \gamma$ .

##### Algorithm 1 DMN Training Algorithm

```

1: for epoch in epochs do
2:   for batch in batches do
3:      $X_{phase1}, X_{phase2}, X_{homogenized} \leftarrow \text{inputs}$ 
4:     output  $\leftarrow \text{FORWARD}(X_{phase1}, X_{phase2})$   $\triangleright$  Alg. 1
5:     loss  $\leftarrow \text{LOSS\_FN}(\text{output}, Y_{homogenized})$ 
6:     active_sum  $\leftarrow \sum(\text{weights at bottom nodes})$ 
7:      $\lambda \leftarrow 1e-3$   $\triangleright$  Regularization
8:      $\xi \leftarrow 2^{N_{layer}-2}$ 
9:     loss  $\leftarrow \text{loss} + \lambda \cdot (\text{active\_sum} - \xi)^2$ 
10:    Backpropagate
11:  end for
12: end for

```

##### Algorithm 2 DMN Forward Pass

```

1: function FORWARD( $X_{phase1}, X_{phase2}$ )
2:   UPSCALING(FOOT,  $X_{phase1}, X_{phase2}$ )
3: end function
4: function UPSCALING(node,  $X_{phase1}, X_{phase2}$ )
5:   if node.left is not leaf then
6:     UPSCALING(node.left,  $X_{phase1}, X_{phase2}$ )
7:     UPSCALING(node.right,  $X_{phase1}, X_{phase2}$ )
8:   end if
9:   Assign leaf node phase 1 or phase 2
10:   $\hat{C}^r \leftarrow \text{HOMOGENIZED}(\text{left.C}, \text{right.C})$   $\triangleright$  Eq. (8)
11:   $C \leftarrow R^{-1} \hat{C}^r R$   $\triangleright$  Eq. (12)
12: end function

```

#### 2.1.2 IMN offline training

The interaction mechanism in IMN focuses on maintaining equilibrium between material phases. The IMN structure data flow is demonstrated in Fig. 2. Under the assumption of small strain, as presented in Eq. (3), the averaging strain over the volume  $V$  of an RVE can be expressed as

$$\bar{\epsilon} = \frac{1}{V} \int_V \epsilon_i dV. \quad (20)$$

![Figure 2: IMN structure data flow diagram. The diagram shows a hierarchical tree structure of nodes. Phase 1 nodes are at the top, with one labeled 'C^1' and others connected to 'C^2'. Phase 2 nodes are below Phase 1. The bottom nodes are labeled 'N_leaf = 3'. Arrows between nodes are labeled with weights 'w_i' and activation functions 'ReLU'. The final output node is labeled 'C^dms' and 'N_leaf = 0'.](2fa4a1bf91d0f34e87c689fbc1211fe3_img.jpg)

Figure 2: IMN structure data flow diagram. The diagram shows a hierarchical tree structure of nodes. Phase 1 nodes are at the top, with one labeled 'C^1' and others connected to 'C^2'. Phase 2 nodes are below Phase 1. The bottom nodes are labeled 'N\_leaf = 3'. Arrows between nodes are labeled with weights 'w\_i' and activation functions 'ReLU'. The final output node is labeled 'C^dms' and 'N\_leaf = 0'.

Figure 2 IMN structure data flow.

Stress and strain are denoted in Mandel notation, refer to Eq. (1). If we discretize Eq. (20), and separate the RVE into  $\mathcal{K} = [i = 0, 1, 2, \dots, N - 1]$  parts, we can get:

$$\tilde{\mathbf{e}} = \sum W_i \mathbf{e}_i, \quad (21)$$

where

$$\frac{V_i}{\bar{V}} = \frac{W_i}{\sum_{i \in \mathcal{K}} W_i}. \quad (22)$$

The strain on each material part can be viewed as an averaging strain adding a fluctuation field  $\omega$ . Eq. (22) can be rewritten as:

$$\mathbf{e}_i = \tilde{\mathbf{e}} + \sum \frac{s}{V_i} \omega_i^k \otimes \mathbf{N}_i^k, \quad (23)$$

where  $s$  is the fluctuate boundary,  $k$  is the face number of the material part and  $N$  is the direction of the boundary. Therefore, we can apply the interaction mechanism:

$$\mathcal{I}(\mathbf{e}^0, \dots, \mathbf{e}^{N-1}) : \mathbf{e}_i = \tilde{\mathbf{e}} + \sum \mathbf{a}_{ij} \mathbf{a}_j \otimes \mathbf{G}_j. \quad (24)$$

Interaction mapping  $\mathcal{I}$  includes  $\mathbf{a}_{ij}$ , which is the contribution of node  $i$  in mechanism  $j$ , and  $\mathbf{a}_j$ , which is the strain fluctuation on mechanism  $j$ . The homogenized stiffness matrix can be expressed as a homogenized function  $\mathcal{H}_{IMN}$

$$\begin{aligned} \tilde{\mathbf{C}} &= \mathcal{H}_{IMN}(\mathbb{C}^1, \mathbb{C}^2, w^1, w^2) \\ &= f_1 \mathbb{C}^1 + f_2 \mathbb{C}^2 - f_1 f_2 \Delta \mathbb{C} \mathbb{Q} \Delta \mathbb{C}, \end{aligned} \quad (25)$$

where  $\Delta \mathbb{C} = \mathbb{C}^2 - \mathbb{C}^1$ . The interaction direction  $\mathbf{N}^j$  is defined as:

$$\mathbf{N}^j = [\cos(2\pi\phi)\sin(\pi\theta) \quad \sin(2\pi\phi)\cos(\pi\theta) \quad \cos(\pi\theta)]. \quad (26)$$

If we rewrite  $\mathbf{N}^j$  in to a tensor, we get:

$$\mathbf{H}(\mathbf{N}) = \begin{bmatrix} N_0 & 0 & 0 & 0 & N_2 & N_1 \\ 0 & N_1 & 0 & N_2 & 0 & N_0 \\ 0 & 0 & N_2 & N_1 & N_0 & 0 \end{bmatrix}. \quad (27)$$

After solving the analytical solution leads to

$$\mathbf{Q} = \mathbf{H}(\mathbf{H}^T \tilde{\mathbf{C}} \mathbf{H})^{-1} \mathbf{H}^T, \quad (28)$$

where  $\tilde{\mathbf{C}} = f_2 \mathbb{C}^1 + f_1 \mathbb{C}^2$ . The offline training process follows Algorithm 3. Similar to DMN, material properties of phases are assigned to the leaf nodes, as well as initial weight. The upscaling process follows Algorithm 4. Besides, consider a  $N$  layer IMN

with  $i$  leaf nodes, an activation parameter  $z$  is used to assign weight to the bottom nodes. The relationship between activation  $z_i$  and weight  $w_i$  is

$$w_i = \text{ReLU}^z(z_i). \quad (29)$$

The activation function used in IMN is the smoothed version of ReLU:

$$\text{ReLU}^z(x) = \frac{1}{s} \ln(1 + e^{sx}), \quad (30)$$

where  $s$  is the sharpness. IMN has its own gradient descent algorithm, explained in Algorithm 5. The weight is also upscaled following  $w_N = w_{N+1}^1 + w_{N+1}^2$ , and the relation between volume fraction and weight is also the same as Eq. (18). Superscript 1 refers to the left node of the parent, and superscript 2 refers to the right node of the parent. The homogenized stiffness matrix at the root node  $\mathbb{C}_{IMN}^m$  is used to measure the error of a sample.

$$e_{IMN} = \epsilon_s = \frac{\|\mathbb{C}_{IMN}^{dms} - \mathbb{C}_{IMN}^m\|}{\|\mathbb{C}_{IMN}^{dms}\|}. \quad (31)$$

The parameters that will be updated are the weights  $w$ , and the angles  $\phi$  and  $\theta$ .

##### Algorithm 3 IMN Training Algorithm

```

1: for epoch in epochs do
2:   for batch in batches do
3:      $X_{phase1}, X_{phase2}, Y_{homogenized} \leftarrow \text{inputs}$ 
4:     output  $\leftarrow \text{FORWARD}(X_{phase1}, X_{phase2})$   $\triangleright$  Alg. 4
5:     loss  $\leftarrow \text{LOSS\_FN}(\text{output}, Y_{homogenized})$   $\triangleright$  Eq. (31)
6:     active_sum  $\leftarrow \sum(\text{weights at bottom nodes})$ 
7:     BACKPROPAGATE
8:   end for
9:   total_loss  $\leftarrow \sum \text{loss}$   $\triangleright$  Accumulate batch losses
10:  scheduler.STEP(total_loss)  $\triangleright$  Alg. 5
11: end for

```

##### Algorithm 4 IMN Forward Pass

```

1: function FORWARD( $X_{phase1}, X_{phase2}$ )
2:   ASSIGN_STIFFNESS(root,  $X_{phase1}, X_{phase2}$ )
3:   UPSCALING(root,  $X_{phase1}, X_{phase2}$ )
4: end function
5: function UPSCALING( $\text{node}, X_{phase1}, X_{phase2}$ )
6:   if node.left is not leaf then
7:     UPSCALING( $\text{node.left}, X_{phase1}, X_{phase2}$ )
8:     UPSCALING( $\text{node.right}, X_{phase1}, X_{phase2}$ )
9:   end if
10:  Assign leaf node phase 1 or phase 2
11:   $C \leftarrow \text{HOMOGENIZED}(\text{left.C}, \text{right.C}, f_1, f_2, N_m)$ 
12:   $\triangleright$  Eq. (25)
13: end function

```

#### 2.1.3 Comparison of offline training

In the offline stage, the IMN adjusts the interaction direction angle in a single step to ensure stress balance, as indicated in Eq. (25). In contrast, the DMN requires two steps for this adjustment, detailed in Eqs. (8) and (12). The DMN's training parameters include activation  $z$  and the angles  $\alpha, \beta$  and  $\gamma$ , whereas

##### **Algorithm 5** IMN Scheduler

```

1: Input: Initial learning rate  $\eta_{max}$ 
2: Parameters:  $\eta_{min} \leftarrow 1e-4, \kappa \leftarrow 0.8$ 
3: Initialize: previous_loss  $\leftarrow$  None
4: function STEP(current_loss, learning_rate)
5:   if current_loss  $>$  previous_loss then
6:      $\eta \leftarrow \max(\text{learning\_rate} \times \kappa, \eta_{min})$ 
7:   else
8:      $\eta \leftarrow \text{learning\_rate}$ 
9:   end if
10:  previous_loss  $\leftarrow$  current_loss
11:  return  $\eta$   $\triangleright$  Updated learning rate
12: end function

```

**Table 1.** Compare parameters.

| Model       | DMN      |                     | IMN      |                     |
|-------------|----------|---------------------|----------|---------------------|
| Activations | $z$      | $(2^N)$ activations | $z$      | $(2^N)$ activations |
| angles      | $\alpha$ | $(2^{N+1} - 1)$     | $\theta$ | $(2^N - 1)$         |
|             | $\beta$  | $(2^{N+1} - 1)$     | $\phi$   | $(2^N - 1)$         |
|             | $\gamma$ | $(2^{N+1} + 1)$     |          |                     |

Inside () states the amount of the parameters in an N-layer network.

IMN's training parameters consist of activation  $z$  along with the angles  $\phi$  and  $\theta$ . The number of parameters used in each model is summarized in Table 1. Consequently, IMN operates with fewer degrees of freedom than DMN, which may lead to more efficient computation.

Furthermore, the DMN training strategy focuses on constructing the optimal laminate block, while the IMN emphasizes achieving force equilibrium. By considering the entire RVE, IMN may better capture the underlying mechanisms under load.

### **2.2 Online prediction**

A major advantage of material networks is their ability to extrapolate trained models to nonlinear material behaviors and complex loading conditions. The material nodes at the N layer of a tree represent individual material points, and by inputting boundary conditions, each iteration is designed to approximate the material's deformation at each loading step with increasing accuracy.

#### **2.2.1 DMN online prediction**

For an RVE under a loading test, DMN finds the incremental stress while applying an incremental strain. The macroscopic strain is  $\bar{\epsilon}_{out}$ , and the relationship between internal incremental stress and strain is

$$\Delta \epsilon = \mathbb{D} \Delta \sigma + \delta \epsilon. \quad (32)$$

$\mathbb{D}$  is the inverse of stiffness matrix  $\mathbb{C}$ . The incremental stress is updated by Newton's Method

$$\Delta \sigma_{in, n+1} = \Delta \sigma_{in, n} - \frac{\Delta \epsilon_{in, n} - \Delta \epsilon_{out}}{\mathbb{D}}. \quad (33)$$

$\Delta \sigma$ ,  $\Delta \epsilon$  and  $\delta \epsilon$  are initially set as zero. Assign the material to the bottom layer and follow Eqs. (8) and (12) to update the tangents for all layers. As for residual strains, they are homogenized

$$\delta \bar{\epsilon} = f_1 \epsilon^1 + f_2 \epsilon^2$$

$$\begin{aligned}
& + f_1 f_2 \left( \begin{bmatrix} D_{11}^1 & D_{12}^1 & D_{16}^1 \\ D_{21}^1 & D_{22}^1 & D_{26}^1 \\ D_{31}^1 & D_{32}^1 & D_{36}^1 \\ D_{41}^1 & D_{42}^1 & D_{46}^1 \\ D_{51}^1 & D_{52}^1 & D_{56}^1 \\ D_{61}^1 & D_{62}^1 & D_{66}^1 \end{bmatrix} - \begin{bmatrix} D_{11}^2 & D_{12}^2 & D_{16}^2 \\ D_{21}^2 & D_{22}^2 & D_{26}^2 \\ D_{31}^2 & D_{32}^2 & D_{36}^2 \\ D_{41}^2 & D_{42}^2 & D_{46}^2 \\ D_{51}^2 & D_{52}^2 & D_{56}^2 \\ D_{61}^2 & D_{62}^2 & D_{66}^2 \end{bmatrix} \right) \\
& \times \begin{bmatrix} f_1 D_{11}^2 + f_2 D_{11}^1 & f_1 D_{12}^2 + f_2 D_{12}^1 & f_1 D_{16}^2 + f_2 D_{16}^1 \\ f_1 D_{21}^2 + f_2 D_{21}^1 & f_1 D_{22}^2 + f_2 D_{22}^1 & f_1 D_{26}^2 + f_2 D_{26}^1 \\ f_1 D_{61}^2 + f_2 D_{61}^1 & f_1 D_{62}^2 + f_2 D_{62}^1 & f_1 D_{66}^2 + f_2 D_{66}^1 \end{bmatrix}^{-1} \\
& \times \begin{bmatrix} \delta \epsilon_1^2 - \delta \epsilon_1^1 \\ \delta \epsilon_2^2 - \delta \epsilon_2^1 \\ \delta \epsilon_6^2 - \delta \epsilon_6^1 \end{bmatrix}. \quad (34)
\end{aligned}$$

Rotated is also applied

$$\delta \epsilon = R(\alpha, \beta, \gamma) \delta \epsilon. \quad (35)$$

During the forward homogenization, the compliance matrix  $\mathbb{D}$  and residual strain  $\delta \epsilon$  are propagated from the leaf nodes to the root. At layer 0, the difference of  $\Delta \epsilon_0$  and  $\Delta \epsilon_{out}$  are used to update  $\Delta \sigma$  and  $\Delta \epsilon$ . The incremental strain is updated using Newton's method. Once we have the new incremental strain, we downscale it to each layer. At  $i$  layer,  $\Delta \epsilon_i$  will be downscale to  $\Delta \epsilon_{i+1}^2, \Delta \epsilon_{i+1}^1$  and assign them into its leaf node. Likewise, we undo strain rotation and dehomogenization on  $\Delta \epsilon$ :

$$\Delta \epsilon = R(\alpha, \beta, \gamma)^{-1} \Delta \epsilon, \quad (36)$$

$$\Delta \epsilon_{i+1}^1 = s^1 \Delta \epsilon_i^1,$$

$$\Delta \epsilon_{i+1}^2 = s^2 \Delta \epsilon_i^2, \quad (37)$$

$s$  is the strain localization matrix, which is done as follows:

$$\begin{aligned}
s_{3 \times 6} &= \begin{bmatrix} \hat{C}_{33} & \hat{C}_{34} & \hat{C}_{35} \\ \hat{C}_{43} & \hat{C}_{44} & \hat{C}_{45} \\ \hat{C}_{53} & \hat{C}_{54} & \hat{C}_{55} \end{bmatrix}^{-1} \\
& \begin{bmatrix} f_2 \Delta C_{31} & f_2 \Delta C_{32} & C_{33}^2 & C_{34}^2 & C_{35}^2 & f_2 \Delta C_{36} \\ f_2 \Delta C_{41} & f_2 \Delta C_{42} & C_{43}^2 & C_{44}^2 & C_{45}^2 & f_2 \Delta C_{46} \\ f_2 \Delta C_{51} & f_2 \Delta C_{52} & C_{53}^2 & C_{54}^2 & C_{55}^2 & f_2 \Delta C_{56} \end{bmatrix}. \quad (38)
\end{aligned}$$

$\Delta C = C^2 - C^1$  and  $\hat{C} = f_2 C^1 + f_1 C^2$ , with  $s_{11}^1 = s_{22}^2 = s_{66}^1 = 1$ , with all other components being zero. If the error converges, we move on to the next loading step, and the error is estimated by the difference between the current incremental strain  $\Delta \epsilon_s$  and the previous iteration incremental strain  $\Delta \epsilon_{s-1}$ .

$$\epsilon_s = \frac{\|\Delta \epsilon_s - \Delta \epsilon_{s-1}\|}{\|\Delta \epsilon_{s-1}\|}. \quad (39)$$

One forward homogenization and one backward dehomogenization constitute a single iteration of Newton's method, processed as Algorithms 6 and 7. Once convergence is achieved, the computation advances to the next loading step.

##### **Algorithm 6** DMN Online Prediction

---

```

1:  $model \leftarrow \text{READ}(model)$ 
2:  $loading\_step \leftarrow \text{List}()$ 
3: function  $\text{PREDICT}(model, loading\_step)$ 
4:   for  $\Delta\varepsilon_{out}$  in  $loading\_step$  do
5:     for each leaf node in  $model$  do
6:        $node.material\_law \leftarrow \text{phase1 or phase2}$ 
7:     end for
8:     while bottom node not converged do
9:        $\Delta\sigma, D, \delta\varepsilon \leftarrow \text{HOMOGENIZED}()$ 
10:       $\text{NEWTON\_METHOD}(\Delta\sigma, D, \delta\varepsilon)$ 
11:       $\Delta\varepsilon \leftarrow D\Delta\sigma + \delta\varepsilon$  ▷ Eq. (32)
12:       $\Delta\sigma \leftarrow \frac{\Delta\sigma - \Delta\varepsilon_{out}}{D[\text{direction}]}$  ▷ Eq. (33)
13:       $\text{DEHOMOGENIZED}()$  ▷ Alg. 7
14:      check convergence
15:    end while
16:  end for
17: end function

```

---

##### **Algorithm 7** DMN Downscale

---

```

1: function  $\text{DEHOMOGENIZED}(\text{node})$ 
2:   if node is not leaf then
3:      $C_1 \leftarrow \text{node.left.C}$ 
4:      $C_2 \leftarrow \text{node.right.C}$ 
5:      $s_1 \leftarrow \text{STRAIN\_LOCALIZATION}(C_1, C_2, f_1, f_2)$ 
6:     ▷ Eq. (34)
7:      $s_2 \leftarrow \text{STRAIN\_LOCALIZATION}(C_2, C_1, f_2, f_1)$ 
8:      $\Delta\varepsilon \leftarrow \text{UNDO\_ROTATION}(\Delta\varepsilon, \alpha, \beta, \gamma)$ 
9:      $\text{node.left.inc\_strain} \leftarrow s_1 \cdot \Delta\varepsilon$ 
10:     $\text{node.right.inc\_strain} \leftarrow s_2 \cdot \Delta\varepsilon$ 
11:    update bottom node material law
12:     $\text{DEHOMOGENIZED}(\text{node.left})$  ▷ Recursive call
13:     $\text{DEHOMOGENIZED}(\text{node.right})$ 
14:  end if
15: end function

```

---

#### **2.2.2 IMN online prediction**

Continuing on the structure of interaction mapping, the macroscopic strain is downscaled following:

$$\varepsilon_i = \tilde{\varepsilon} + D_i U, \quad (40)$$

where  $\varepsilon_i$  is the local strain,  $\tilde{\varepsilon}$  is the homogenized strain and  $U$  is an unknown vector, which will be updated during the iterations.  $D$  contains the information of weight  $w$  and local interaction directions  $N_i$  in each material interaction:

$$D = wH(N_i). \quad (41)$$

Function  $H(\cdot)$  can be found in Eq. (27).

IMN involves a downscaling process, where the homogenized strain is de-homogenized into each network layer. The summation of residual stress  $r$  at bottom layer is computed as

$$r = \sum w_i (D_i)^T \sigma_i. \quad (42)$$

This residual stress summation  $r$  is used as a convergence criterion.

$$\|r\|_{\infty} < \tau^{abs} \quad \text{or} \quad \|r\|_{\infty} < \tau^{rel} \|r_0\|_{\infty}, \quad (43)$$

$\tau^{abs} = 10^{-12}$ ,  $\tau^{rel} = 10^{-6}$  and  $r_0$  is the initial residual. If the conditions are not satisfied, the vector  $U$  is updated with

$$\delta U = -K r \quad \text{and} \quad U \leftarrow U + \delta U, \quad (44)$$

where  $K$  is the Jacobian matrix and can be estimated by

$$K = \sum w_i (D_i)^T C_i D_i \cdot r. \quad (45)$$

$C_i$  is the stiffness matrix at each material node. Take elastic and elastoplastic materials as an example (elastic and elastoplastic return mapping process can be found in [32]). Once the residual reaches convergence, we compute homogenized stress  $\tilde{\sigma}$  and homogenized tangent  $\tilde{C}$ .

$$\tilde{\sigma} = \frac{1}{\sum W_i} \sum W_i \sigma_i, \quad (46)$$

$$\tilde{C} = \frac{1}{\sum W_i} \sum W_i C_i + Y \left( \frac{\partial U}{\partial \tilde{\varepsilon}} \right)$$

$$Y = \frac{1}{\sum W_i} \sum W_i C_i D \quad (47)$$

$$\frac{\partial U}{\partial \tilde{\varepsilon}} = -K \sum W_i (D_i)^T C_i.$$

The overall online prediction algorithm can be found in Algorithms 8 and 9.

##### **Algorithm 8** IMN Online Prediction

---

```

1:  $model \leftarrow \text{READ}(model)$ 
2:  $loading\_step \leftarrow \text{List}()$ 
3: function  $\text{PREDICT}(model, loading\_step)$ 
4:   for  $\Delta\varepsilon_{out}$  in  $loading\_step$  do
5:     for each leaf node in  $model$  do
6:        $node.material\_law \leftarrow \text{phase1 or phase2}$ 
7:     end for
8:     while bottom node not converged do
9:        $\Delta\sigma, D, \delta\varepsilon \leftarrow \text{DOWNSCALE}(\tilde{\varepsilon})$ 
10:      update bottom node
11:      check convergence ▷ Eq. (43)
12:    end while
13:    update  $U$  ▷ Eq. (44)
14:  end for
15: end function

```

---

##### **Algorithm 9** IMN Downscale

---

```

1: function  $\text{DOWNSCALE}(\tilde{\varepsilon})$ 
2:   for each leaf node in  $model$  do
3:      $node.strain \leftarrow \tilde{\varepsilon} + D \cdot U$  ▷ Eq. (40)
4:   end for
5: end function

```

---

![Figure 3: A 3D visualization of a short fiber-reinforced composite material. The material is shown as a rectangular block with a red matrix and blue elliptical fibers embedded within it. A coordinate system (x, y, z) is shown at the bottom right of the block.](9ebd85380ef496499e5f23ec0d9cd744_img.jpg)

Figure 3: A 3D visualization of a short fiber-reinforced composite material. The material is shown as a rectangular block with a red matrix and blue elliptical fibers embedded within it. A coordinate system (x, y, z) is shown at the bottom right of the block.

Figure 3 Short fiber-reinforced composite used in offline training and online prediction used in training examples.

![Figure 4: A flow diagram illustrating the workflow for capturing mesh features. It starts with a 3D mesh of a material, followed by a 2D graph of stress (σ) versus strain (ε), and then a 3D cube representing the material network. The final output is a stress-strain curve.](997233d405f0d4b89ddeb7683e047f66_img.jpg)

Figure 4: A flow diagram illustrating the workflow for capturing mesh features. It starts with a 3D mesh of a material, followed by a 2D graph of stress (σ) versus strain (ε), and then a 3D cube representing the material network. The final output is a stress-strain curve.

Figure 4 Capture the feature of the mesh with material network, establish a testing sample with the trained RVE, load the RVE and present stress-strain curve.

#### 2.2.3 Comparison of online prediction

In an iterative approach, DMN involves two distinct stages: homogenization and de-homogenization. In each iteration, DMN first computes the microscopic stress and strain through homogenization and then de-homogenizes these values to verify them against the current loading step. On the other hand, IMN directly de-homogenizes the strain through a single downscaling operation. DMN could be more computationally intensive and time-consuming, contributing to slower convergence.

Another noteworthy difference is that IMN's convergence process considers the overall force equilibrium of the material node system. By incorporating the global equilibrium condition, IMN ensures that the system remains balanced at the microscopic, which may benefit performance.

## 3 RESULTS

To investigate the loading behavior of a material with a microstructure, as illustrated in Fig. 3, the material network is trained on various samples of orthotropic elastic material properties. The learned knowledge from elastic training procedures in material networks is then extrapolated to nonlinear material mechanical behaviors. The workflow is outlined in Fig. 4. This micro-structure is trained on 4, 5, 6 layers with DMN, and 4, 5, 6, 8 layers in IMN. The performance of each material network will be closely compared.

### 3.1 Offline training

The tested mesh represents a short fiber-reinforced composite (SFC) material widely used in engineering applications due to its lightweight and sustainable properties. SFC materials are commonly evaluated using machine learning-based multiscale methods [33]. The mesh is assigned 500 samples with varying orthotropic elastic material properties. This dataset, which includes matrix, fiber and homogenized stiffness tangent, is sourced from [28] and is publicly available online.

Offline training follows the algorithm detailed in Algorithms 1 and 3, and the error of samples in each training is defined

![Figure 5: A log-log plot showing the average error versus epoch for DMN and IMN models. The y-axis represents average error from 10^-2 to 10^0. The x-axis represents epoch from 10^0 to 10^4. The legend indicates various models: IMN N=4 training, IMN N=4 validation, IMN N=5 training, IMN N=5 validation, IMN N=6 training, IMN N=6 validation, IMN N=8 training, IMN N=8 validation, DMN N=4 training, DMN N=4 validation, DMN N=5 training, DMN N=5 validation, DMN N=6 training, DMN N=6 validation. IMN models show a sharp initial drop in error, while DMN models show a more gradual decline.](4ae1b32e57b3072ef112b19e647dfead_img.jpg)

Figure 5: A log-log plot showing the average error versus epoch for DMN and IMN models. The y-axis represents average error from 10^-2 to 10^0. The x-axis represents epoch from 10^0 to 10^4. The legend indicates various models: IMN N=4 training, IMN N=4 validation, IMN N=5 training, IMN N=5 validation, IMN N=6 training, IMN N=6 validation, IMN N=8 training, IMN N=8 validation, DMN N=4 training, DMN N=4 validation, DMN N=5 training, DMN N=5 validation, DMN N=6 training, DMN N=6 validation. IMN models show a sharp initial drop in error, while DMN models show a more gradual decline.

Figure 5 Offline training curves of DMN with depth 4, 5, 6 layers and IMN models with depth 4, 5, 6, 8 layers.

Table 2. Offline training error.

| Model   | DMN   | IMN   |
|---------|-------|-------|
| $N = 4$ | 5.13% | 5.71% |
| $N = 5$ | 4.22% | 3.43% |
| $N = 6$ | 2.24% | 2.31% |
| $N = 8$ | -     | 0.88% |

Table 3. Offline training time (s).

| Model   | DMN    | IMN |
|---------|--------|-----|
| $N = 4$ | 23592  | 37  |
| $N = 5$ | 48544  | 84  |
| $N = 6$ | 103176 | 203 |

as Eq. (19) for DMN and Eq. (31) for IMN. Figure 5 displays the average training and validation error histories for material networks with varying depths. The best training error and time usage can be found in Tables 2 and 3, respectively. Accuracy improves with increasing network depth. Accuracy levels are similar under the same network depth, but training epochs vary notably. IMN converges within 200 epochs, whereas DMN requires 20,000 epochs to achieve convergence. IMN's error decreases sharply after a few epochs, in contrast to the more gradual reduction observed with DMN. Additionally, DMN exhibits slight over-fitting in the middle epochs.

In the training framework, the volume fraction represents the proportion of the material occupied by each phase, making its accuracy a target of the performance of a material network. Figure 6 illustrates the variation in volume fraction over time. The mesh contains 79.34% phase 1 material and 20.66% phase 2 material. DMN and IMN exhibit distinct learning curves. DMN begins at 50%, experiences an overshoot, and gradually converges to the target. The deepest model of DMN has the least overshoot and converges earlier than the other DMN models. In contrast, IMN starts at 100% and efficiently reaches the target volume fraction. Table 4 lists the error between the volume fraction at the last epoch and the target volume fraction. The error of DMN models fluctuates with model depth, while the error of IMN models decreases as the depth increases.

![Figure 6: Volume fraction of phase 1 variation along training of all models. The plot shows volume fraction (y-axis, 0.5 to 1.0) versus epoch (x-axis, log scale from 10^0 to 10^4). A dashed line at 0.8 represents the target. IMN models (N=4, 5, 6, 8) show a sharp drop to 0.8 around epoch 10^1. DMN models (N=4, 5, 6) show a more gradual approach to 0.8, with some oscillations.](3121afa7ca030b22ee0345864ca6f38b_img.jpg)

Figure 6: Volume fraction of phase 1 variation along training of all models. The plot shows volume fraction (y-axis, 0.5 to 1.0) versus epoch (x-axis, log scale from 10^0 to 10^4). A dashed line at 0.8 represents the target. IMN models (N=4, 5, 6, 8) show a sharp drop to 0.8 around epoch 10^1. DMN models (N=4, 5, 6) show a more gradual approach to 0.8, with some oscillations.

Figure 6 Volume fraction of phase 1 variation along training of all models.

Table 4. Volume fraction error.

| Model   | DMN   | IMN   |
|---------|-------|-------|
| $N = 4$ | 1.00% | 1.82% |
| $N = 5$ | 2.24% | 1.26% |
| $N = 6$ | 0.09% | 0.69% |
| $N = 8$ | -     | 0.66% |

Table 5. Material property.

| Phase                 | Elastic | Elastoplastic |
|-----------------------|---------|---------------|
| Volume fraction       | 20.66%  | 79.34%        |
| Elastic modulus (MPa) | 500     | 100           |
| Tangent modulus (MPa) | -       | 5             |
| Poisson's ratio       | 0.19    | 0.3           |
| Yield stress (MPa)    | -       | 0.1           |
| Beta                  | -       | 0             |

### 3.2 Online prediction

A nonlinear elastoplastic RVE is considered for testing the material networks' nonlinear prediction capability. In the RVE, phase 1 material is elastoplastic with an isotropic von Mises yield surface and piece-wise linear hardening law, and phase 2 is isotropic elastic, with a larger elastic modulus. Detailed material properties are in Table 5.

Three loading conditions are applied to the structure: tension, compression and load-unloading, all uniaxial. Figures 7 and 8 show the results of tensile loading in the  $x$  and  $y$  directions, respectively. Given the low training error achieved with  $N = 8$  IMN model layers, it is considered the best-fitting curve (Typically, a DNS loading path can be calculated using finite element software. However, given the material network's convergence, the best-performing model is the ground truth.). The material networks demonstrate strong performance in the elastic region and capture the yielding behavior at the yield point.

The fibers in the mesh are ellipsoidal, with their major axes aligned in the  $x$  direction, and the structure's length in the  $x$  direction is twice that of the other directions. As the figures reflect,

![Figure 7: Tensile loading applied along the x-axis, with strain increased to 1%. Stress-strain curve of sigma_1 and epsilon_1. The plot shows stress (MPa) versus strain (0% to 1.0%). IMN models (N=4, 5, 6, 8) show a linear elastic region followed by a yielding plateau and then a linear hardening region. DMN models (N=4, 5, 6) show a similar behavior but with slightly lower stress values in the hardening region.](635262c3456135a70f7585ae445951e7_img.jpg)

Figure 7: Tensile loading applied along the x-axis, with strain increased to 1%. Stress-strain curve of sigma\_1 and epsilon\_1. The plot shows stress (MPa) versus strain (0% to 1.0%). IMN models (N=4, 5, 6, 8) show a linear elastic region followed by a yielding plateau and then a linear hardening region. DMN models (N=4, 5, 6) show a similar behavior but with slightly lower stress values in the hardening region.

Figure 7 Tensile loading applied along the  $x$ -axis, with strain increased to 1%. Stress-strain curve of  $\sigma_1$  and  $\epsilon_1$ .

![Figure 8: Tensile loading applied along the y-axis, with strain increased to 1%. Stress-strain curve of sigma_2 and epsilon_2. The plot shows stress (MPa) versus strain (0% to 1.0%). IMN models (N=4, 5, 6, 8) show a linear elastic region followed by a yielding plateau and then a linear hardening region. DMN models (N=4, 5, 6) show a similar behavior but with slightly lower stress values in the hardening region.](fd40c60cfaff879ea9bec71d4f72a8ec_img.jpg)

Figure 8: Tensile loading applied along the y-axis, with strain increased to 1%. Stress-strain curve of sigma\_2 and epsilon\_2. The plot shows stress (MPa) versus strain (0% to 1.0%). IMN models (N=4, 5, 6, 8) show a linear elastic region followed by a yielding plateau and then a linear hardening region. DMN models (N=4, 5, 6) show a similar behavior but with slightly lower stress values in the hardening region.

Figure 8 Tensile loading applied along the  $y$ -axis, with strain increased to 1%. Stress-strain curve of  $\sigma_2$  and  $\epsilon_2$ .

these characteristics result in different stiffness during the loading tests. The stress in Fig. 7 is higher than that in Fig. 8 due to the anisotropic nature of the SFC microstructure. A similar result can be seen in tensile loading, as shown in Figs 9 and 10. The alignment of the short fibers causes a difference in the loading slope between the  $x$  and  $y$  directions. The material networks are also able to capture elastoplastic behavior under compressive loading, so as the anisotropic mechanical feature of SFC microstructure.

A more complex loading test is applied, where the RVE is loaded beyond the plastic region, unloaded to zero strain and reloaded. The Bauschinger effect is evident in Figs 11 and 12, further demonstrating the predictive capability of both material networks.

Nevertheless, slight differences can still be observed between the loading curves. In general, as the number of layers increases, the error decreases. The online prediction time and total iterations for each loading test are shown in Table 6. IMN consistently has lower time consumption in all six loading cases than DMN for the same number of layers. IMN also requires fewer

![Figure 9: Stress-strain curve for compressive loading along the x-axis. The plot shows stress (MPa) on the y-axis (from -0.5 to 0.0) versus strain on the x-axis (from 0.0% to 1.0%). Multiple curves are shown for different model configurations: IMN N=8 (black), IMN N=4 (orange), IMN N=5 (red), IMN N=6 (green), DMN N=4 (blue), DMN N=5 (purple), and DMN N=6 (dark blue). All curves show a linear decrease in stress with increasing strain, with IMN models generally maintaining higher stress values than DMN models at higher strain levels.](b93cbfb52e37619e688175a6aad9edd9_img.jpg)

Figure 9: Stress-strain curve for compressive loading along the x-axis. The plot shows stress (MPa) on the y-axis (from -0.5 to 0.0) versus strain on the x-axis (from 0.0% to 1.0%). Multiple curves are shown for different model configurations: IMN N=8 (black), IMN N=4 (orange), IMN N=5 (red), IMN N=6 (green), DMN N=4 (blue), DMN N=5 (purple), and DMN N=6 (dark blue). All curves show a linear decrease in stress with increasing strain, with IMN models generally maintaining higher stress values than DMN models at higher strain levels.

Figure 9 Compressive loading applied along the x-axis, with strain increased to 1%. Stress-strain curve of  $\sigma_1$  and  $\epsilon_1$ .

![Figure 10: Stress-strain curve for compressive loading applied along the y-axis. The plot shows stress (MPa) on the y-axis (from -0.5 to 0.0) versus strain on the x-axis (from 0.0% to 1.0%). The same model configurations as in Figure 9 are shown. The curves exhibit a similar linear decrease in stress with increasing strain, with IMN models showing slightly higher stress values compared to DMN models at higher strain levels.](bedcca5cdf168e3508ef511d94ec514c_img.jpg)

Figure 10: Stress-strain curve for compressive loading applied along the y-axis. The plot shows stress (MPa) on the y-axis (from -0.5 to 0.0) versus strain on the x-axis (from 0.0% to 1.0%). The same model configurations as in Figure 9 are shown. The curves exhibit a similar linear decrease in stress with increasing strain, with IMN models showing slightly higher stress values compared to DMN models at higher strain levels.

Figure 10 Compressive loading applied along the y-axis, with strain increased to 1%. Stress-strain curve of  $\sigma_3$  and  $\epsilon_2$ .

![Figure 11: Stress-strain curve for loading applied along the x-axis to 0.2% strain, followed by unloading and reloading to 1% strain. The plot shows stress (MPa) on the y-axis (from -0.1 to 0.5) versus strain on the x-axis (from 0.0% to 1.0%). The curves show an initial loading phase, a unloading phase where stress drops to zero, and a reloading phase. IMN models show a more pronounced hysteresis loop and higher stress values during reloading compared to DMN models.](925f55ce69802b9d3b00546382663ee2_img.jpg)

Figure 11: Stress-strain curve for loading applied along the x-axis to 0.2% strain, followed by unloading and reloading to 1% strain. The plot shows stress (MPa) on the y-axis (from -0.1 to 0.5) versus strain on the x-axis (from 0.0% to 1.0%). The curves show an initial loading phase, a unloading phase where stress drops to zero, and a reloading phase. IMN models show a more pronounced hysteresis loop and higher stress values during reloading compared to DMN models.

Figure 11 Loading applied along the x-axis to 0.2% strain, followed by unloading and reloading to 1% strain. Stress-strain curve of  $\sigma_1$  and  $\epsilon_1$ .

![Figure 12: Stress-strain curve for loading applied along the y-axis to 0.2% strain, followed by unloading and reloading to 1% strain. The plot shows stress (MPa) on the y-axis (from -0.1 to 0.5) versus strain on the x-axis (from 0.0% to 1.0%). Similar to Figure 11, the curves show loading, unloading, and reloading phases. IMN models generally exhibit higher stress values and more distinct hysteresis loops than DMN models during the reloading phase.](e8ff6e66c77a8e96203c9f8db8f0986f_img.jpg)

Figure 12: Stress-strain curve for loading applied along the y-axis to 0.2% strain, followed by unloading and reloading to 1% strain. The plot shows stress (MPa) on the y-axis (from -0.1 to 0.5) versus strain on the x-axis (from 0.0% to 1.0%). Similar to Figure 11, the curves show loading, unloading, and reloading phases. IMN models generally exhibit higher stress values and more distinct hysteresis loops than DMN models during the reloading phase.

Figure 12 Loading applied along the y-axis to 0.2% strain, followed by unloading and reloading to 1% strain. Stress-strain curve of  $\sigma_2$  and  $\epsilon_2$ .

Table 6. Online prediction time and total iterations.

| Model                       | DMN               | IMN               |
|-----------------------------|-------------------|-------------------|
| $N = 4$ tensile_x           | 61 s (Iter= 359)  | 8 s (Iter= 295)   |
| $N = 5$ tensile_x           | 119 s (Iter= 342) | 23 s (Iter= 295)  |
| $N = 6$ tensile_x           | 290 s (Iter= 434) | 33 s (Iter= 297)  |
| $N = 8$ tensile_y           | -                 | 223 s (Iter= 296) |
| $N = 4$ tensile_y           | 57 s (Iter= 334)  | 8 s (Iter= 296)   |
| $N = 5$ tensile_y           | 128 s (Iter= 369) | 16 s (Iter= 297)  |
| $N = 6$ tensile_y           | 342 s (Iter= 506) | 34 s (Iter= 296)  |
| $N = 8$ tensile_y           | -                 | 217 s (Iter= 295) |
| $N = 4$ compression_x       | 61 s (Iter= 359)  | 8 s (Iter= 295)   |
| $N = 5$ compression_x       | 119 s (Iter= 342) | 23 s (Iter= 295)  |
| $N = 6$ compression_x       | 290 s (Iter= 434) | 33 s (Iter= 297)  |
| $N = 8$ compression_x       | -                 | 217 s (Iter= 295) |
| $N = 4$ compression_y       | 70 s (Iter= 331)  | 8 s (Iter= 296)   |
| $N = 5$ compression_y       | 172 s (Iter= 364) | 18 s (Iter= 297)  |
| $N = 6$ compression_y       | 466 s (Iter= 504) | 36 s (Iter= 296)  |
| $N = 8$ compression_y       | -                 | 253 s (Iter= 295) |
| $N = 4$ loading-unloading_x | 85 s (Iter= 485)  | 11 s (Iter= 387)  |
| $N = 5$ loading-unloading_x | 119 s (Iter= 472) | 21 s (Iter= 386)  |
| $N = 6$ loading-unloading_x | 479 s (Iter= 591) | 47 s (Iter= 387)  |
| $N = 8$ loading-unloading_x | -                 | 300 s (Iter= 386) |
| $N = 4$ loading-unloading_y | 78 s (Iter= 451)  | 11 s (Iter= 387)  |
| $N = 5$ loading-unloading_y | 216 s (Iter= 530) | 23 s (Iter= 388)  |
| $N = 6$ loading-unloading_y | 502 s (Iter= 702) | 45 s (Iter= 385)  |
| $N = 8$ loading-unloading_y | -                 | 279 s (Iter= 386) |

total iterations. IMN's total iteration numbers remain nearly constant across all layers for the same loading case, whereas DMN requires more iterations as the network depth increases. The mean square error for each loading test compared to the ground truth is presented in Table 7. In summary, both DMN and IMN are effective at learning the critical features of a microstructure and extrapolating to unknown loading steps. However, IMN demonstrates superior performance in both offline training and online prediction. The potential reasons for this will be discussed in the following section.

**Table 7.** Online prediction accuracy (MSE)

| Model                       | DMN                   | IMN                   |
|-----------------------------|-----------------------|-----------------------|
| $N = 4$ tensile_x           | $1.40 \times 10^{-4}$ | $1.06 \times 10^{-4}$ |
| $N = 5$ tensile_x           | $1.28 \times 10^{-4}$ | $1.16 \times 10^{-4}$ |
| $N = 6$ tensile_x           | $2.95 \times 10^{-4}$ | $0.22 \times 10^{-4}$ |
| $N = 4$ tensile_y           | $3.75 \times 10^{-4}$ | $3.62 \times 10^{-4}$ |
| $N = 5$ tensile_y           | $0.87 \times 10^{-4}$ | $2.13 \times 10^{-4}$ |
| $N = 6$ tensile_y           | $1.67 \times 10^{-4}$ | $0.20 \times 10^{-4}$ |
| $N = 4$ compression_x       | $1.45 \times 10^{-4}$ | $1.05 \times 10^{-4}$ |
| $N = 5$ compression_x       | $1.49 \times 10^{-4}$ | $1.16 \times 10^{-4}$ |
| $N = 6$ compression_x       | $3.20 \times 10^{-4}$ | $0.22 \times 10^{-4}$ |
| $N = 4$ compression_y       | $4.10 \times 10^{-4}$ | $3.62 \times 10^{-4}$ |
| $N = 5$ compression_y       | $0.74 \times 10^{-4}$ | $2.13 \times 10^{-4}$ |
| $N = 6$ compression_y       | $1.86 \times 10^{-4}$ | $0.20 \times 10^{-4}$ |
| $N = 4$ loading-unloading_x | $1.10 \times 10^{-4}$ | $0.76 \times 10^{-4}$ |
| $N = 5$ loading-unloading_x | $0.89 \times 10^{-4}$ | $0.94 \times 10^{-4}$ |
| $N = 6$ loading-unloading_x | $0.11 \times 10^{-4}$ | $0.11 \times 10^{-4}$ |
| $N = 4$ loading-unloading_y | $2.47 \times 10^{-4}$ | $2.47 \times 10^{-4}$ |
| $N = 5$ loading-unloading_y | $0.74 \times 10^{-4}$ | $1.54 \times 10^{-4}$ |
| $N = 6$ loading-unloading_y | $0.12 \times 10^{-4}$ | $0.16 \times 10^{-4}$ |

## 4 DISCUSSION

Several crucial technologies implemented by the revisited material network, IMN, make it a more efficient model than DMN. Our discussion focuses on the differences between the two models regarding offline training and online prediction.

### 4.1 Offline training discussion

Although the number of training epochs required for DMN is 100 times greater than that of IMN, the overall time difference between the two models exceeds this factor, proving that every epoch in IMN is faster than in DMN. As highlighted in Section 2.1.3, DMN has more training parameters than IMN. In addition, fitting the angles in DMN's building blocks is more complicated than the angles in IMN. Specifically, in DMN, the homogenized function between the rotation equation Eq. (12) involves both addition and subtraction operations alongside rotation matrices  $R$ , derived from trigonometric functions (cosine and sine) based on input angles. In contrast, IMN has a simpler process. The angle-fitting term in IMN involves matrix multiplication and decoupled with other terms. Values in  $H(N)$  (Eq. (27)) come from a smaller matrix  $N$ . These differences in complexity affect the time costs of each model. The homogenization step in DMN is expected to take longer due to the additional operations and more complex calculations involved in the angle fitting. Furthermore, the backward propagation step in DMN is likely to be more time-consuming, as its parameters undergo more intricate computations compared to IMN.

We selected 20,000 training epochs for DMN and 200 training epochs for IMN, at which point both models appeared to converge. One of the possible reasons for IMN's rapid convergence is the use of an aggressive gradient descent algorithm outlined in Algorithm 5. According to this algorithm, if the current loss is larger than the previous loss, the learning rate is reduced by 20%. This adaptive learning rate adjustment allows IMN to

minimize errors more efficiently. Interestingly, we experimented with other optimization methods, such as stochastic gradient descent (SGD) and resilient propagation (Rprop), but neither could train IMN as effectively. This suggests that IMN benefits from the more aggressive scheduling strategy, which quickly adjusts the learning rate in response to fluctuations in the loss. On the other hand, DMN employs SGD by adding a regularization term (Algorithm 2). This makes DMN more conservative in its approach to minimizing error, leading to a steadier but slower reduction in loss. The regularization term helps prevent overfitting by controlling the complexity of the model, but it also contributes to the more gradual slope of DMN's learning curve. Assuming DMN uses a gradient descent algorithm with large steps, given the variation in volume fraction during the initial training stages, it is likely that DMN would struggle to reach a convergent state.

### 4.2 Online prediction discussion

As seen in Table 6, the time consumption and the number of iterations needed for online prediction are significantly higher in DMN than in IMN. This can be explained by the differences in their respective online prediction algorithms, Algorithms 6 and 8. In DMN, the calculation of residual strain involves both a homogenization and de-homogenization process, while IMN requires only one downscaling operation to decompose the strain. This difference means that each iteration in IMN is less computationally expensive than in DMN.

Another factor that causes DMN to be inferior to IMN in online prediction is the impact of randomness in DMN models. Homogenization and de-homogenization are involved in increasing the number of computations and exacerbating the effects of randomness within the material network. This randomness can lead to fluctuations in stress and strain computations, requiring more iterations to reach convergence. While DMN with  $N = 6$  layers may show lower offline training error, this does not necessarily translate to better performance during online prediction. Additionally, DMN's performance can vary across different loading steps. In some cases, DMN might require up to 10 times more iterations to converge; in extreme cases, it may fail to converge altogether. In contrast, such issues are rarely observed in IMN models, which exhibit much more stable behavior during prediction.

## 5 CONCLUSIONS

This paper compares the theories and performance of the deep material network (DMN) and the IMN. We analyzed the differences in their frameworks, particularly focusing on the laminate building block used in DMN and the interaction-based building block employed by IMN during the training stage. Our findings indicate that IMN, by considering stress balance within the RVE, exhibits superior performance in capturing the mechanical features of an RVE. Regarding online prediction, IMN offers a simpler, streamlined process, enabling faster convergence and reducing the time required for online prediction.

We also conducted an example by training both models on a short-fiber reinforced composite. IMN demonstrated impressive results in both accuracy and efficiency during training. Both

models effectively capture phase changes in elastoplastic behavior during loading tests. In addition, they successfully capture the anisotropic characteristics of the RVE, proving their ability to learn and represent the mechanical features embedded within the microstructure.

When discussing the factors influencing model performance, we observe that DMN requires more training parameters and introduces greater computational complexity than IMN. Additionally, IMN is optimized for fast gradient descent algorithms, whereas DMN requires more conservative tuning processes. Furthermore, deeper IMN models exhibit better performance, a trend that is less apparent in DMN.

In conclusion, both DMN and IMN have contributed to computational material modeling. However, IMN demonstrates better overall performance regarding computational efficiency and accuracy, making it a more practical solution for complex multiscale simulations.

## ACKNOWLEDGMENTS

This paper is dedicated to the memory of Prof. Chien-Ching Ma. Prof. Ma made important contributions to solid mechanics and was renowned for his unique insight and novelty in solving complex and real-world problems. Prof. Ma is a role model for us and an elder brother figure who has supported and guided us for many years. We all miss him very much!

## FUNDING

This work is supported by the National Science and Technology Council, Taiwan, under Grant 111-2221-E-002-054-MY3. We are grateful for the computational resources and support from the NTUICE-NCREE Joint Artificial Intelligence Research Center and the National Center of High-performance Computing (NCHC).

## REFERENCES

- Smit RJM, Brekelmans WAM, Meijer HEH. Prediction of the mechanical behavior of nonlinear heterogeneous systems by multi-level finite element modeling. *Computer Methods in Applied Mechanics and Engineering* 1998;155(1):181–192. <https://www.sciencedirect.com/science/article/pii/S0045782597001394>.
- Temizer I, Wriggers P. An adaptive multiscale resolution strategy for the finite deformation analysis of microheterogeneous structures. *Computer Methods in Applied Mechanics and Engineering* 2011;37(37):2639–2661. Special Issue on Modeling Error Estimation and Adaptive Modeling. <https://www.sciencedirect.com/science/article/pii/S0045782510001805>.
- Feyel F, Chaboche JL. FE2 multiscale approach for modelling the elastoviscoplastic behaviour of long fibre SiC/Ti composite materials. *Computer Methods in Applied Mechanics and Engineering* 2000;183(3):309–330. <https://www.sciencedirect.com/science/article/pii/S0045782599002248>.
- Belytschko T, Loehnert S, Song JH. Multiscale aggregating discontinuities: a method for circumventing loss of material stability. *International Journal for Numerical Methods in Engineering* 2008;73(6):869–894.
- Moulinec H, Suquet P. A numerical method for computing the overall response of nonlinear composites with complex microstructure. *Computer Methods in Applied Mechanics and Engineering* 1998;157(1):69–94. <https://www.sciencedirect.com/science/article/pii/S0045782597002181>.
- de Geus TWJ, Vondřejc J, Zeman J, Peerlings RHJ, Geers MGD. Finite strain FFT-based non-linear solvers made simple. *Computer Methods in Applied Mechanics and Engineering* 2017;318:412–430. <https://www.sciencedirect.com/science/article/pii/S0045782516318709>.
- Liu D, Yang H, Elkhdary K, Tang S, Liu WK, Guo X. Mechanistically informed data-driven modeling of cyclic plasticity via artificial neural networks. *Computer Methods in Applied Mechanics and Engineering* 2022;393:114766.
- Liu H, Liu S, Liu Z, Mrad N, Milani AS. Data-driven approaches for characterization of delamination damage in composite materials. *IEEE Transactions on Industrial Electronics* 2020;68(3):2532–2542.
- Zhang A, Mohr D. Using neural networks to represent von Mises plasticity with isotropic hardening. *International Journal of Plasticity* 2020;132:102732.
- Jang DP, Fazily P, Yoon JW. Machine learning-based constitutive model for J2-plasticity. *International Journal of Plasticity* 2021;138:102919.
- Su TH, Huang SJ, Jean JG, Chen CS. Multiscale computational solid mechanics: data and machine learning. *Journal of Mechanics*. 2022;38:568–585. <https://doi.org/10.1093/jom/ufac037>.
- Su TH, Jean JG, Chen CS. Model-free data-driven identification algorithm enhanced by local manifold learning. *Computational Mechanics* 2023;71:637–655.
- Mozaffar M, Bostanabad R, Chen W, Ehmann K, Cao J, Bessa M. Deep learning predicts path-dependent plasticity. *Proceedings of the National Academy of Sciences* 2019;116(52):26414–26420.
- Rao C, Liu Y. Three-dimensional convolutional neural network (3D-CNN) for heterogeneous material homogenization. *Computational Materials Science* 2020;184:109850.
- Vlassis NN, Ma R, Sun W. Geometric deep learning for computational mechanics Part I: anisotropic hyperelasticity. *Computer Methods in Applied Mechanics and Engineering* 2020;371:113299.
- Jones R, Safta C, Frankel A. Deep learning and multi-level featurization of graph representations of microstructural data. *Computational Mechanics* 2023;72(1):57–75.
- Chou YT, Chang WT, Jean JG, Chang KH, Huang YN, Chen CS. StructGNN: an efficient graph neural network framework for static structural analysis. *Computers & Structures* 2024;299:107385.
- Kuo PC, Chou YT, Li KY, Chang WT, Huang YN, Chen CS. GNN-LSTM-based fusion model for structural dynamic responses prediction. *Engineering Structures* 2024;306:117733.
- Liu Z, Wu C. Exploring the 3D architectures of deep material network in data-driven multiscale mechanics. *Journal of the Mechanics and Physics of Solids* 2019;127:20–46.
- Liu Z, Wu C, Koishi M. A deep material network for multiscale topology learning and accelerated nonlinear modeling of heterogeneous materials. *Computer Methods in Applied Mechanics and Engineering* 2019;345:1138–1168.
- Liu Z, Wu C, Koishi M. Transfer learning of deep material network for seamless structure-property predictions. *Computational Mechanics* 2019;64(2):451–465.
- Liu Z. Deep material network with cohesive layers: multi-stage training and interfacial failure analysis. *Computer Methods in Applied Mechanics and Engineering* 2020;363:112913.
- Dey AP, Welschinger F, Schneider M, Gajek S, Böhlke T. Training deep material networks to reproduce creep loading of short fiber-reinforced thermoplastics with an inelasticity-informed strategy. *Archive of Applied Mechanics* 2022;92(9):2733–2755.
- Shin D, Alberdi R, Lebensohn RA, Dingreville R. A deep material network approach for predicting the thermomechanical response of composites. *Composites Part B: Engineering* 2024;272:111177.
- Shin D, Alberdi R, Lebensohn RA, Dingreville R. Deep material network via a quilting strategy: visualization for explainability and

- recursive training for improved accuracy. *npj Computational Materials* 2023;9(1):128.
26. Jean JG, Su TH, Huang SJ, Wu CT, Chen CS. Graph-enhanced deep material network: multiscale materials modeling with microstructural informatics. *Computational Mechanics* 2024;1432–0924.
  27. Gajek S, Schneider M, Bohlke T. On the micromechanics of deep material networks. *Journal of the Mechanics and Physics of Solids* 2020;142:103984. <https://www.sciencedirect.com/science/article/pii/S0022509620302192>.
  28. Noels L. Micromechanics-based material networks revisited from the interaction viewpoint; robust and efficient implementation for multi-phase composites. *European Journal of Mechanics-A/Solids* 2022;91:104384.
  29. Noels L. Interaction-based material network: a general framework for (porous) microstructured materials. *Computer Methods in Applied Mechanics and Engineering* 2022;389:114300.
  30. Glorot X, Bordes A, Bengio Y. Deep Sparse Rectifier Neural Networks. In: Gordon G, Dunson D Dudik M, (eds). *Proceedings of the Fourteenth International Conference on Artificial Intelligence and Statistics*. vol. 15 of *Proceedings of Machine Learning Research*. Fort Lauderdale, FL, USA: PMLR; 2011. p. 315–323.
  31. Paszke A, Gross S, Massa F, Lerer A, Bradbury J, Chanan G, Killeen T, Lin Z, Gimelshein N, Antiga L, Desmaison A. PyTorch: An Imperative Style, High-Performance Deep Learning Library. In: *Advances in Neural Information Processing Systems* 32. Curran Associates, Inc.; 2019. p. 8024–8035. <http://papers.neurips.cc/paper/9015-pytorch-an-imperative-style-high-performance-deep-learning-library.pdf>.
  32. Kim NH. *Introduction to nonlinear finite element analysis*. New York, US: Springer Science & Business Media; 2014.
  33. Wei H, Wu CT, Hu W, Su TH, Oura H, Nishi M, Naito T, Chung S, Shen L. LS-DYNA machine learning–based multiscale method for nonlinear modeling of short fiber–reinforced composites. *Journal of Engineering Mechanics*. 2023;149(3):04023003. <http://dx.doi.org/10.1061/JENMDT.EMENG-6945>.