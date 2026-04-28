

Received 5 June 2025, accepted 3 July 2025, date of publication 7 July 2025, date of current version 11 July 2025.

Digital Object Identifier 10.1109/ACCESS.2025.3586599

## RESEARCH ARTICLE

# LS-YOLO: A Lightweight, Real-Time YOLO-Based Target Detection Algorithm for Autonomous Driving Under Adverse Environmental Conditions

CHENG JU 

Image: ORCID icon

, YUXIN CHANG 

Image: ORCID icon

, YUANSHA XIE, AND DINA LI

School of Data Science and Engineering, Xi'an Innovation College of Yan'an University, Xi'an 710100, China

Corresponding author: Cheng Ju (jucheng0501241259@xaccxy.com)

**ABSTRACT** Autonomous driving faces significant object detection challenges under complex backgrounds characterized by dense scenes, object occlusion, long-range targets, and extreme weather conditions. These challenges are further exacerbated in adverse weather such as rain, snow, and fog, leading to decreased detection accuracy and increased missed detection rates. To address these issues, a lightweight real-time object detection algorithm, LS-YOLO, is proposed. The LS-YOLO incorporates a MACA module to capture both global and local features, an SPDD module to reduce computational complexity, and a DR-Concat module to optimize feature fusion. Additionally, an improved ATFL-Wasserstein loss function is employed to enhance the learning capability for small objects and hard samples. Experimental results on public datasets demonstrate that LS-YOLO significantly outperforms existing algorithms in terms of accuracy, robustness, and real-time performance. Notably, under adverse weather and complex backgrounds, LS-YOLO achieves lower missed detection rates and higher object detection accuracy.

**INDEX TERMS** Autonomous driving, object detection, YOLO, dynamic routing, Wasserstein.

## I. INTRODUCTION

The rapid development of autonomous driving technology, as a frontier in intelligent transportation systems, is profoundly transforming modern mobility. Environmental perception, serving as a fundamental technology for autonomous driving, provides essential scene understanding capabilities for safe decision-making and path planning [1]. However, the diversity of natural driving environments—particularly extreme weather conditions (such as rain, fog, and snow), complex traffic scenarios (including high target density and severe occlusion), and varying illumination (strong light, low light, and backlight)—poses significant technical obstacles for visual perception systems. Studies have shown that, under adverse weather conditions, the performance of conventional object detectors may decline by 30% to 50%, substantially increasing the risk of traffic accidents [2], [3]. Therefore, developing a perception system that maintains high detection

accuracy and meets real-time requirements in complex environments has become a critical challenge for the safe deployment of autonomous driving.

In the field of computer vision, object detection technology has undergone a paradigm shift from traditional methods to deep learning approaches over the past decade. As a representative open-source detection toolbox, MMDetection [4] integrates numerous state-of-the-art detection algorithms, providing researchers with reliable benchmark implementations. YOLOv7 has achieved new breakthroughs in real-time object detection through the adoption of a trainable “bag-of-freebies” strategy [5], while YOLOv8 further optimizes the balance between detection performance and inference speed [6]. The latest SAM-YOLO [7] significantly enhances detection accuracy by introducing a feature enhancement mechanism based on the Segment Anything Model.

The YOLO series of algorithms, with their innovative “regression-based and grid prediction” design paradigm, provide a solution that balances accuracy and speed for visual perception in autonomous driving. YOLOX achieves

The associate editor coordinating the review of this manuscript and approving it for publication was Kaige Qu 

Image: ORCID icon

.

significant performance improvements on the COCO dataset through a decoupled head design and dynamic label assignment strategy [8]. Although RT-DETR introduces the Transformer architecture into object detection and surpasses traditional YOLO models in terms of accuracy [9], its real-time performance is somewhat inferior to that of YOLO models. The introduction of Distribution-Balanced Loss effectively addresses the long-tail distribution problem [10], further enhancing the performance of YOLO models in complex scenarios.

Despite the remarkable progress achieved by the YOLO series on standard datasets, several core challenges persist in real-world autonomous driving scenarios. The adaptability to extreme weather remains insufficient, as studies have shown that the detection accuracy of YOLOv8 decreases by more than 15% in rainy and foggy conditions, compromising the all-weather reliability of perception systems. The representation capability in complex scenarios is also limited; for example, the missed detection rate for long-tail samples such as special vehicles can reach up to 34% [11], making it difficult to address the diversity of real-world traffic. There is also a pronounced trade-off between lightweight design and robustness, with lightweight YOLO variants exhibiting a significantly greater performance decline than standard versions under adverse conditions. Measurements indicate that the average detection accuracy gap can exceed 20% in complex weather [12]. These challenges collectively constrain the application potential of YOLO algorithms in scenarios with high safety requirements. To address these issues, this paper proposes a lightweight real-time object detection algorithm for adverse environments, termed LS-YOLO, which aims to optimize the perception performance of autonomous driving systems in complex scenarios through a series of innovative designs.

The main contributions of this work are as follows:

- A novel neural network architecture optimization scheme is introduced, specifically designed to address the challenges of small object detection, occlusion, and the demand for lightweight models. This scheme integrates innovative modules, including MACA, SPPF-DD, and DR-Concat, which collectively enhance the model's feature extraction capabilities in complex backgrounds.
- An ATFL-Wasserstein loss function is proposed to effectively mitigate class and scale imbalance issues. By employing an adaptive sample weighting mechanism, the proposed loss function substantially improves the model's robustness and generalization performance under imbalanced data distributions.
- A lightweight real-time object detection algorithm, LS-YOLO, is developed. This algorithm achieves a favorable trade-off between detection accuracy, computational complexity, and inference efficiency. The proposed approach provides a practical and scalable solution for enhancing the adaptability of autonomous driving systems in complex and adverse environments.

## II. RELEVANT STUDIES

The rapid development of autonomous driving technology has imposed stringent challenges on object detection algorithms, particularly the requirement to ensure both real-time performance and detection accuracy under limited computational resources. In this section, the evolution of the YOLO series algorithms within autonomous driving scenarios is systematically reviewed. Emphasis is placed on recent advances in three key areas: lightweight architecture design, robustness enhancement, and spatial feature optimization.

### A. LIGHTWEIGHT DESIGN AND REAL-TIME PERFORMANCE OPTIMIZATION

Lightweight model research in object detection has predominantly advanced through network architecture optimization, parameter compression, and inference acceleration. NAS-YOLO [13] leverages neural architecture search to automatically refine network structures, achieving a significant reduction in computational complexity while preserving detection accuracy. CBAM++ [14] strengthens channel and spatial attention mechanisms, thereby enhancing the feature extraction capabilities of lightweight models. DCAN introduces dynamic channel attention to optimize feature representation, particularly benefiting multi-scale distortion correction tasks [15]. RTMDet [16] is developed as an efficient real-time object detector with high scalability, enabling seamless extension to tasks such as instance segmentation and rotated object detection. Experimental results demonstrate that RTMDet delivers excellent performance across various graphics cards, confirming its practical applicability.

Nevertheless, the lightweighting process inevitably compromises the representational capacity of models, a limitation that becomes particularly pronounced under extreme environmental conditions. Experiments reveal that lightweight YOLO variants may suffer up to a 20% decline in performance in complex weather and challenging illumination scenarios [12]. This observation underscores the intrinsic trade-off between model compactness and robustness, and motivates the integrated approach proposed in this work.

### B. ACCURACY ENHANCEMENT AND ENVIRONMENTAL ROBUSTNESS

Autonomous driving systems are subjected to highly variable environmental conditions, necessitating enhancements in the robustness of YOLO-based detection algorithms from multiple perspectives. The accuracy of dense object detection has been improved by Generalized Focal Loss V2 [17] through more reliable localization quality estimation. Detection performance under extreme illumination conditions has been optimized by HDR-YOLO [18]. In CF-YOLOX [19], channel and spatial attention mechanisms are reinforced via the integration of the CBAM-G module, while a contextual feature fusion module is introduced to improve the detection of objects at various scales. Additionally, the adaptability of the detection framework in autonomous

driving scenarios is enhanced by refining the IoU loss calculation. In PointOBB-v2, pseudo-rotated bounding boxes are generated by producing class probability maps and applying principal component analysis to estimate object orientation and boundaries, thereby improving end-to-end detection performance [20].

To mitigate visual quality degradation, Enhanced Feature Pyramid Networks [21] have been employed to optimize feature extraction and fusion strategies. Detection accuracy in complex environments has been improved by Side-Aware Boundary Localization [22] through an advanced boundary-aware mechanism. The environmental adaptability of detection models has been further enhanced by GCNet V2 [23] and SAGA++ [24], which introduce non-local network structures and spatial attention gating mechanisms, respectively.

Although the aforementioned approaches demonstrate distinct advantages, considerable performance degradation is still observed in current lightweight YOLO variants under extreme environmental conditions. The trade-off between real-time performance and robustness requires further investigation.

### C. SPATIAL FEATURE OPTIMIZATION AND EXTREME ENVIRONMENT ADAPTATION

Efficient utilization of spatial information is a key direction for enhancing the performance of YOLO in autonomous driving scenarios. Related research can be categorized into four major technical approaches. Spatial feature enhancement has been achieved by methods such as Spatial-YOLO [25] and SAM-YOLO [7], which optimize feature representation through pyramid and hierarchical spatial attention mechanisms, resulting in a 15.7% increase in long-range small object detection rate and an 8.9% improvement in the recognition rate of small traffic participants, respectively. In terms of region-aware optimization, CR-NAS [26] enables dynamic allocation of computational resources based on scene complexity. Dynamic-YOLO [27] introduces an adaptive receptive field adjustment strategy to effectively address challenges in occlusion and dense object detection. For adaptation to extreme illumination, AIE-YOLO [28] dynamically adjusts pixel features to enhance object visibility and suppress background interference. The enhanced YOLOv7 incorporates multiple improvements for low-light object detection [29], including a hybrid convolution module for improved edge information extraction, an optimized feature fusion strategy, brightness-adjusted data augmentation, and a novel bounding box loss function, thereby improving detection performance under low-light conditions. Regarding robustness to adverse weather, YOLOv5s-Fog [30] is equipped with a dedicated feature enhancement module for foggy conditions, resulting in a 5.4% increase in mAP detection accuracy.

The performance of YOLO has been further advanced through the application of geometric constraints and adaptive feature enhancement techniques. In the improved

YOLOv5 [31], multi-scale cross-layer feature fusion has been employed to increase detection accuracy for large objects. The adaptability of the model to complex scenarios has been enhanced in BFE-Net [32] by introducing a bidirectional feature enhancement mechanism, while Enhanced-YOLO [33] utilizes a cross-layer bidirectional feature transmission mechanism to strengthen semantic representation. Furthermore, Deformable-YOLO [34] achieves higher boundary localization accuracy in complex environments by incorporating edge-aware refinement and deformable convolution operations.

Despite considerable progress, object detection in autonomous driving remains constrained by several fundamental challenges. Feature representation is significantly degraded by image quality deterioration under extreme weather conditions. Recognition accuracy is often compromised in scenarios involving occlusion and densely distributed objects. In addition, achieving an optimal balance between detection accuracy and real-time performance remains difficult. Innovations in loss functions and the optimization of attention mechanisms have provided effective approaches to address these issues.

Research on loss functions has been conducted from the perspectives of addressing sample imbalance and improving prediction accuracy. Sample imbalance has been mitigated through the evolution from hard mining strategies to dynamic weighting with Focal Loss, and further to adaptive assignment algorithms such as OTA and SASA. Prediction accuracy has been enhanced by the introduction of advanced variants, including CIoU and EIoU, which incorporate spatial relationships, as well as quality-aware loss functions such as VFL and QFL, thereby improving the consistency between confidence estimation and localization precision [35]. The performance of YOLO has been further improved by attention mechanisms in terms of feature perception and environmental adaptability. Modules such as CBAM and ECA have been employed to strengthen the capture of salient features. Structures like CA and SAGA [36] have been utilized to enhance adaptability across diverse scenarios.

In summary, a distinct trend of technological integration has been observed in object detection research for autonomous driving, with the effective combination of lightweight design and robustness enhancement identified as a critical direction. The LS-YOLO algorithm proposed in this study has been developed in accordance with this principle, incorporating advanced loss functions and attention mechanisms to establish a lightweight object detection approach that achieves real-time performance, high accuracy, and strong environmental adaptability.

## III. METHODS

### A. LS-YOLO GENERAL ARCHITECTURE

In this section, the LS-YOLO architecture and its key modules are described in detail. LS-YOLO is constructed based on YOLOv11, and its network structure comprises a backbone, neck, and detection head, as illustrated in Figure 1.

![Figure 1: The overall structure of LS-YOLO. The diagram is divided into three main sections: Backbone, Neck, and Head. The Backbone section on the left shows a vertical sequence of layers: Conv, Conv, C3k2-MACA, Conv, C3k2-MACA, Conv, C3k2-MACA, Conv, C3k2-MACA, SPDD, and C2PSA. The Neck section in the center features a series of DR-Concat and C3k2-MACA modules with skip connections and Upsample blocks. The Head section on the right contains three parallel detection branches, each ending with a 'Detect' block and a corresponding image of a detected object (a car, a truck, and a person). A detailed inset at the top right shows the internal structure of the C3k2-MACA module, which includes a split path with C3k blocks and a DR-Concat block, and a parallel path with Conv, Bottle Neck, and DR-Concat blocks, followed by a Conv2d, BN, and SiLU activation stack.](9e6062272bbe3ddbb7c0606721d64cf0_img.jpg)

Figure 1: The overall structure of LS-YOLO. The diagram is divided into three main sections: Backbone, Neck, and Head. The Backbone section on the left shows a vertical sequence of layers: Conv, Conv, C3k2-MACA, Conv, C3k2-MACA, Conv, C3k2-MACA, Conv, C3k2-MACA, SPDD, and C2PSA. The Neck section in the center features a series of DR-Concat and C3k2-MACA modules with skip connections and Upsample blocks. The Head section on the right contains three parallel detection branches, each ending with a 'Detect' block and a corresponding image of a detected object (a car, a truck, and a person). A detailed inset at the top right shows the internal structure of the C3k2-MACA module, which includes a split path with C3k blocks and a DR-Concat block, and a parallel path with Conv, Bottle Neck, and DR-Concat blocks, followed by a Conv2d, BN, and SiLU activation stack.

FIGURE 1. The overall structure of LS-YOLO.

To address critical challenges in autonomous driving object detection—such as small object recognition, occlusion, complex background interference, and the need for lightweight models—three core optimization modules have been designed: Multi-Axis Convolution Attention (MACA), DR-Concat, and SPDD. The ATFL-Wasserstein loss function has also been introduced. The conventional C3K2 module is limited by low information utilization in spatial and channel dimensions, resulting in the loss of essential features under complex backgrounds. This limitation has been mitigated by enhancing the original C3K2 with MACA, resulting in the C3K2-MACA module. Inspired by recent advances in spatial and channel attention mechanisms, a dual attention structure is employed, consisting of a Spatial Reconstruction Unit (SRU) and a Channel Reduction Unit (CRU). The SRU utilizes group normalization and gating to strengthen spatial feature representation, while the CRU applies dynamic channel weighting to optimize channel information. This design improves the extraction of features from small objects and complex backgrounds while maintaining computational efficiency. Feature fusion processes are often affected by

suboptimal feature weighting and noise interference, which can reduce the model's sensitivity to salient features. The DR-Concat module has been developed to replace the Concat module in YOLOv11, optimizing feature fusion through a dynamic routing mechanism that adaptively allocates feature weights and enhances attention to critical features. This approach increases the efficiency of feature fusion and improves robustness to noise. The SPDD module has been developed by optimizing the SPPF module with dynamic routing and Depthwise Separable Convolution (DSC), reducing computational complexity while preserving feature extraction capability. The adaptive feature fusion enabled by dynamic routing allows processing strategies to be adjusted according to input feature complexity, thereby improving robustness in detecting occluded objects and targets under adverse weather conditions. To address sample imbalance, the ATFL-Wasserstein loss function has been proposed. By integrating the Wasserstein distance with an adaptive threshold mechanism, this loss function reduces overemphasis on easy samples and enhances learning from hard samples. The Wasserstein distance provides a more

accurate measure of class distribution, while the adaptive threshold dynamically adjusts loss weights based on sample difficulty, enabling more effective handling of class imbalance. Details of the MACA, DR-Concat, SPDD, and ATFL-Wasserstein modules are provided in the following sections.

### B. DR-CONCAT

Although the Concat operation in YOLO is characterized by simplicity and computational efficiency, it demonstrates significant shortcomings in complex environments and small object detection tasks. These shortcomings include the inability to differentiate the relative importance of features, the preservation of redundant information, and inadequate suppression of background noise. Such limitations are especially evident in autonomous driving applications, where object scale varies widely, illumination conditions are highly variable, and occlusions are frequent. Under these challenging conditions, conventional feature fusion methods often fail to meet practical detection requirements. In the context of autonomous driving, feature fusion is further complicated by pronounced disparities in feature significance, substantial background interference that impairs small object detection, and increased computational burden resulting from redundant features. To overcome these challenges, this study introduces DR-Concat, an improved feature fusion module. By adaptively assigning weights to features, DR-Concat refines the Concat mechanism in YOLOv11, thereby enhancing the effectiveness of feature integration and improving overall detection performance.

The fundamental principle of the dynamic routing mechanism is to emulate the information transmission processes found in biological neural networks. The optimal feature fusion pathways are determined through an iterative optimization procedure. In mathematical terms, dynamic routing is formulated as an iterative optimization problem:

$$c_{ij} = \frac{\exp(b_{ij})}{\sum_k \exp(b_{ik})} \quad (1)$$

where  $c_{ij}$  denotes the coupling coefficient between the  $i$ -th input feature and the  $j$ -th output feature, and  $b_{ij}$  is a dynamically updated routing parameter. This mechanism allows the model to dynamically adjust the importance weights of different features based on the actual content of the input features.

In the specific implementation, a Dynamic Routing Layer (DRL) was designed as a fundamental component. This layer learns the coupling relationships among features through iterative optimization. Each iteration consists of two key steps:

- 1) Calculate the attention weights:

$$w_j = \sigma \left( b + \sum_{i,j} (x_i \cdot r_j) \right) \quad (2)$$

where  $\sigma$  denotes the sigmoid activation function,  $b$  is a learnable bias term shared across all routing paths,  $x_i$  is the input feature, and  $r_j$  is the routing weight.

- 2) Update the routing parameters:

$$b_{new} = b_{old} + \sum_{i,j} (x_i \cdot w_j) \quad (3)$$

where  $b_{new}$  and  $b_{old}$  denote the updated and previous routing score matrices, respectively, used for iterative refinement.

It ensures both the smoothness and adaptability of feature fusion.

The DR-Concat module was developed based on DRL, as illustrated in Figure 2. Input features are first projected into a hidden space through  $1 \times 1$  convolution for dimensionality reduction. Multi-scale features are then extracted using  $3 \times 3$  convolution. DRL is subsequently applied to each feature, after which the routed features are concatenated and fused via an additional  $1 \times 1$  convolution. The dynamic routing mechanism adaptively adjusts fusion weights according to the content of input features, obviating the need for manually defined fusion strategies. Multiscale feature extraction, combined with adaptive weight allocation, improves the ability of the model to detect objects on various scales. Computational overhead remains limited due to controlled iteration numbers (default set to three) and parameter sharing. The differentiable structure of DRL ensures effective gradient propagation, supporting end-to-end model training.

![Block diagram of the DR-Concat module. The process starts with 'Input Features' (HxWxC). A '1x1 Conv' layer reduces dimensions to 'HxWxC/2'. This is followed by a parallel branch of '3x3 Conv' and 'DRL' layers, resulting in two sets of features, both labeled 'HxWxC/2'. These are then element-wise multiplied (indicated by a circle with an 'x') and summed (indicated by a circle with a '+'). The result is passed through another '1x1 Conv' layer to produce the final 'Output Features' (HxWxC).](047bc23b4e0706cbc0ff323b15fff184_img.jpg)

Block diagram of the DR-Concat module. The process starts with 'Input Features' (HxWxC). A '1x1 Conv' layer reduces dimensions to 'HxWxC/2'. This is followed by a parallel branch of '3x3 Conv' and 'DRL' layers, resulting in two sets of features, both labeled 'HxWxC/2'. These are then element-wise multiplied (indicated by a circle with an 'x') and summed (indicated by a circle with a '+'). The result is passed through another '1x1 Conv' layer to produce the final 'Output Features' (HxWxC).

FIGURE 2. Block diagram of DR-Concat module.

### C. SPDD

In autonomous driving object detection, the quality of feature extraction fundamentally determines the model's ability to detect objects across varying scales. While the conventional Spatial Pyramid Pooling (SPP) module is effective in capturing multi-scale features, it is often constrained by substantial computational demands and limited representational capacity in complex environments. The presence of large scale variations, intricate backgrounds, and fluctuating illumination in autonomous driving scenarios imposes stringent requirements on feature extraction modules. To address these limitations, a novel module, Spatial Pyramid Pooling Fast with Dynamic-Depth (SPDD), is introduced. The principal innovation of SPDD is the integration of DSC with a dynamic routing mechanism, enabling a balance between

adaptive feature extraction and computational efficiency. Mathematically, DSC is decomposed into two operations: depthwise convolution and pointwise convolution.

$$DSC(X) = PWC(DWC(X)) \quad (4)$$

Where DWC denotes depthwise convolution and PWC denotes pointwise convolution. depthwise convolution performs spatial convolution for each input channel independently, while pointwise convolution realizes the information interaction between channels through  $1 \times 1$  convolution. This decomposition significantly reduces the computational complexity from  $O(C^2 \cdot K^2)$  to  $O(C \cdot K^2 + C^2)$ , where  $C$  is the number of channels and  $K$  is the convolution kernel size.

Specifically, the computational process can be expressed as follows:

$$DSC(X)_{c,i,j} = \sum_{k=1}^K \sum_{l=1}^K W_{k,l} \cdot X_{c,i+k-l,j+l-l} \quad (5)$$

where  $X_{c,i,j}$  denotes the value of the input feature map at channel  $c$  and position  $(i, j)$  and  $W_{k,l}$  denotes the convolution kernel weights.

The PWC is computed as:

$$PWC(X)_{c,i,j} = \sum_{c'=1}^C W_{c,c'} \cdot X_{c',i,j} \quad (6)$$

This decomposition not only reduces computational complexity but also preserves the effectiveness of feature extraction. In implementation, DWC is realized using grouped convolution, while PWC is performed with  $1 \times 1$  convolution. Batch normalization and the SiLU activation function are incorporated to enhance feature representation. Batch normalization facilitates faster training and mitigates gradient vanishing, whereas the SiLU activation function provides improved nonlinear expressiveness:

$$SiLU(x) = x \cdot \sigma(x) \quad (7)$$

where  $\sigma(x)$  is the sigmoid function.

The dynamic routing mechanism represents another key component of the SPDD module. By adaptively computing weights, it balances the relative importance of different feature branches.

The SPDD module initiates feature processing with a CBS block, providing a normalized and high-quality input for subsequent multi-branch operations. Feature extraction is performed in parallel through multi-level MaxPool and DRL branches, enabling the capture of information across diverse spatial scales and semantic levels. Within the main branch, consecutive MaxPool operations are employed to progressively expand the receptive field and extract contextual information at multiple spatial resolutions. Each MaxPool output is paired with a corresponding DRL branch, where adaptive feature weighting is achieved via dynamic routing. The DRL mechanism dynamically modulates information flow according to the content of the input features, enhancing salient features while suppressing redundancy and noise.

![Block diagram of the SPDD module. The diagram shows two parallel processing paths: SPDD and SPFF. Both start with 'Input Features' of size H×W×C. The SPDD path consists of a CBS block (H×W×C/2), followed by a series of Max Pooling blocks (H×W×C/2) and DRL blocks. The outputs of the Max Pooling and DRL blocks are concatenated (indicated by a circle with a plus sign) and then processed by a DSC block (4×W×3C) to produce the final 'Output Features' of size H×W×C. The SPFF path follows a similar structure but ends with a different output feature size of H×W×C.](cfbf0f2ddbc35370b0b8c6d043f25eb2_img.jpg)

Block diagram of the SPDD module. The diagram shows two parallel processing paths: SPDD and SPFF. Both start with 'Input Features' of size H×W×C. The SPDD path consists of a CBS block (H×W×C/2), followed by a series of Max Pooling blocks (H×W×C/2) and DRL blocks. The outputs of the Max Pooling and DRL blocks are concatenated (indicated by a circle with a plus sign) and then processed by a DSC block (4×W×3C) to produce the final 'Output Features' of size H×W×C. The SPFF path follows a similar structure but ends with a different output feature size of H×W×C.

FIGURE 3. Block diagram of SPDD module.

Outputs from all MaxPool and DRL branches are concatenated along the spatial dimension, facilitating efficient fusion of multi-scale and multi-semantic information. The concatenation process preserves the distinct characteristics of each branch and, through dynamic routing, enables adaptive reorganization of feature representations. The aggregated features are subsequently transformed by DSC, which reduces computational complexity while maintaining expressive capacity. This step further integrates multi-branch information, contributing to model efficiency and accelerated inference. The final output of the SPDD module is then provided to the detection head or other downstream tasks.

Compared to the conventional SPP structure, the SPDD module offers several advantages. The parallel arrangement of multi-level MaxPool and DRL branches enables the integration of both global contextual information and local dynamic features, substantially enhancing multi-scale object detection performance. The dynamic routing mechanism facilitates adaptive feature flow, improving the model's robustness to complex scenes, small objects, and occluded targets. The use of DSC in place of standard convolution significantly reduces the number of parameters and computational cost, making the module well-suited for real-time and edge deployments. Multi-branch fusion combined with adaptive weight allocation further increases the discriminative power and information utilization of feature representations.

### D. MACA MODULE

An inherent trade-off exists between computational efficiency and detection accuracy in autonomous driving object detection. The Bottleneck structure in conventional convolutional neural networks reduces parameter count and  $1 \times 1$  convolutions for dimensionality reduction and restoration, and  $3 \times 3$  convolutions for feature extraction. However, this approach shows clear limitations in complex autonomous driving scenarios. Traditional architectures often lack sufficient representational capacity to detect objects at multiple scales, such as large nearby vehicles and small distant pedestrians or traffic signs. Performance further degrades under varying illumination, adverse weather, or when targets are partially occluded.

A MACA module is introduced to overcome the aforementioned limitations. By integrating multiple attention mechanisms and feature reconstruction strategies, MACA substantially improves feature extraction in autonomous driving scenarios while preserving computational efficiency. The module consists of three core components: GroupBatchNorm2d, SRU, and CRU. These elements work in concert to establish an efficient and highly expressive feature extraction system.

GroupBatchNorm2d is the foundational component of the MACA module. Its core principle is to normalize feature channels in groups. This design enables the model to better accommodate feature variations under diverse lighting and weather conditions. Given input features  $\mathbf{X} \in \mathbb{R}^{N \times C \times H \times W}$ , the computation of group normalization is defined as:

$$\hat{X}_{n,c,h,w} = \frac{X_{n,c,h,w} - \mu_{n,g}}{\sqrt{\sigma_{n,g}^2 + \epsilon}} \cdot \gamma_c + \beta_c \quad (8)$$

where  $g$  denotes the group to which channel  $c$  belongs.  $\mu_{n,g}$  and  $\sigma_{n,g}$  represent the mean and standard deviation of the  $g$ -th group in the  $n$ -th sample, respectively.  $\gamma_c$  and  $\beta_c$  are learnable scaling and offset parameters.

This group normalization mechanism stabilizes feature representations when facing drastic lighting changes and adverse weather, which is essential for the environmental adaptability of autonomous driving systems.

SRU constitutes the core innovation of the MACA module. It distinguishes significant from non-significant regions in the feature map through adaptive weight computation and a gating mechanism. Initially, features are processed by group normalization, followed by the calculation of adaptive weight coefficients:

$$W_{\gamma} = \frac{\gamma}{\sum \gamma} \quad (9)$$

Based on these weights, SRU computes an importance score for each spatial location in the feature map:

$$R = \sigma(\text{GN}(\mathbf{X}) \cdot W_{\gamma}) \quad (10)$$

where  $\sigma$  denotes the sigmoid activation function and  $\text{GN}(\mathbf{X})$  is the output of group normalization.

By applying a gating threshold  $\tau$  (typically set to 0.5), features are categorized into important information  $X_1$  and unimportant information  $X_2$ :

$$X_1 = X \cdot \mathbb{I}(R \geq \tau) \quad (11)$$

$$X_2 = X \cdot \mathbb{I}(R < \tau) \quad (12)$$

where  $\mathbb{I}(\cdot)$  is the indicator function.

The uniqueness of SRU lies in its subsequent feature reconstruction process. Both  $X_1$  and  $X_2$  are split into two parts and then cross-combined:

$$X_{11}, X_{12} = \text{Split}(X_1) \quad (13)$$

$$X_{21}, X_{22} = \text{Split}(X_2) \quad (14)$$

$$X_{\text{out}} = \text{Concat}(X_{11} + X_{22}, X_{12} + X_{21}) \quad (15)$$

This reconstruction mechanism enables effective information exchange and complementarity, allowing important features to guide the learning of non-important features while preserving the integrity of the original information. In autonomous driving scenarios, SRU effectively enhances the representation of key targets (such as pedestrians, vehicles, and traffic signs) and suppresses background interference, which is crucial for the accurate detection of small or partially occluded objects at a distance.

CRU optimizes information flow along the channel dimension. The input features are divided into upper channels  $X_{\text{up}}$  and lower channels  $X_{\text{low}}$  according to a scale factor  $\alpha$  (typically 0.5):

$$X_{\text{up}}, X_{\text{low}} = \text{Split}(X, \alpha) \quad (16)$$

The number of channels in both parts is reduced using  $1 \times 1$  convolution (squeeze operation) to minimize computational cost:

$$X'_{\text{up}} = \text{Squeeze}(X_{\text{up}}) \quad (17)$$

$$X'_{\text{low}} = \text{Squeeze}(X_{\text{low}}) \quad (18)$$

A combination of Group-wise Convolution (GWC) and PWC is applied to the upper features to capture information with different receptive fields, while PWC is applied to the lower features to preserve fine-grained details:

$$Y_1 = \text{GWC}(X'_{\text{up}}) + \text{PWC}(X'_{\text{up}}) \quad (19)$$

$$Y_2 = \text{Concat}(\text{PWC}(X'_{\text{low}}), X'_{\text{low}}) \quad (20)$$

Adaptive feature fusion is achieved by computing channel attention weights through adaptive average pooling and softmax operations:

$$O = \text{softmax}(\text{AvgPool}(\text{Concat}(Y_1, Y_2))) \cdot \text{Concat}(Y_1, Y_2) \quad (21)$$

$$O_1, O_2 = \text{Split}(O) \quad (22)$$

$$O_{\text{out}} = O_1 + O_2 \quad (23)$$

This design enables the CRU to efficiently process features at different scales and adaptively adjust the importance of each channel, thereby enhancing the model's capability for multi-scale target detection. This allows the model to focus on both large, nearby targets (such as vehicles ahead) and small, distant targets (such as pedestrians or traffic signs), improving the global perception capability of the detection system.

The MACA module integrates the three core components into a unified feature enhancement system. Input features undergo dimensionality reduction through a  $1 \times 1$  convolution, followed by DSC to minimize computational complexity. Feature representations are refined by SRU and CRU modules, with a Squeeze-and-Excitation (SE) mechanism applied to optimize inter-channel dependencies. A  $1 \times 1$  convolution restores the feature dimensions, and residual connections with the DSC output yield the final result.

![FIGURE 4. Block diagram of MACA module. The diagram shows the flow of data through the MACA module. Input Features (H×W×C) are processed through a 1×1 CONV layer to produce H×W×C/2 features. These are then processed by a DSCN (Depthwise Conv) block containing BN, ReLU, 1×1 Conv, BN, and ReLU layers, resulting in DSCN(H×W×C/2) features. A Residual Connection bypasses the DSCN block. The DSCN output is processed by SRU (Spatial Reconstruction Unit) and CRU (Channel Reduction Unit) blocks, both containing BN, ReLU, and 1×1 Conv layers, resulting in H×W×C/2 features. These are then processed by a 1×1 CONV layer to produce the final Output Features (H×W×C).](990567efebf979be51f56d1150012c9d_img.jpg)

FIGURE 4. Block diagram of MACA module. The diagram shows the flow of data through the MACA module. Input Features (H×W×C) are processed through a 1×1 CONV layer to produce H×W×C/2 features. These are then processed by a DSCN (Depthwise Conv) block containing BN, ReLU, 1×1 Conv, BN, and ReLU layers, resulting in DSCN(H×W×C/2) features. A Residual Connection bypasses the DSCN block. The DSCN output is processed by SRU (Spatial Reconstruction Unit) and CRU (Channel Reduction Unit) blocks, both containing BN, ReLU, and 1×1 Conv layers, resulting in H×W×C/2 features. These are then processed by a 1×1 CONV layer to produce the final Output Features (H×W×C).

FIGURE 4. Block diagram of MACA module.

When integrating the MACA module into the Bottleneck structure, the original dimensionality reduction and residual connection designs are retained, with the MACA module replacing only the intermediate  $3 \times 3$  standard convolution. The optimization of the Bottleneck by MACA offers several advantages. Detection capability in complex scenarios is substantially improved, enabling accurate identification of key targets such as pedestrians and vehicles even under challenging conditions like illumination changes and partial occlusion. Sensitivity to small or distant objects is greatly enhanced, which is critical for traffic safety. The model's ability to adaptively process multi-scale features allows simultaneous attention to targets of varying distances and sizes. Improved computational efficiency makes the model more suitable for deployment on resource-constrained edge platforms. Enhanced environmental adaptability ensures stable operation under diverse weather and lighting conditions. By integrating group normalization, spatial reconstruction, and channel reduction, the MACA-optimized Bottleneck module achieves significant improvements in object detection for complex autonomous driving scenarios while maintaining computational efficiency. This innovative structure provides an effective solution for efficient and accurate perception, contributing to improved safety and reliability.

### E. ATFL-WASSERSTEIN

The design of the loss function is critical for effective training and optimal model performance in target detection. Traditional loss functions, such as cross-entropy and L1 loss, often underperform with imbalanced data and complex scenes. In autonomous driving, challenges arise from significant scale variation, class imbalance, and complex backgrounds. An adaptive ATFL-Wasserstein fusion loss is proposed. Dynamic weight adjustment, feature-level loss computation, and an adaptive focus mechanism are incorporated. Detection accuracy in self-driving scenarios is significantly enhanced by this method.

The adaptive ATFL-Wasserstein fusion loss integrates the Wasserstein distance with asymmetric focus loss (ATFL) and introduces a dynamic weight adjustment mechanism. The loss function is defined as:

$$\mathcal{L}_{\text{total}} = \mathcal{L}_{\text{cls}} + \beta \cdot \mathcal{L}_{\text{reg}} + \alpha \cdot \gamma \cdot \mathcal{L}_{\text{wasserstein}} \quad (24)$$

where  $\mathcal{L}_{\text{cls}}$  is the classification loss,  $\mathcal{L}_{\text{reg}}$  is the regression loss, and  $\mathcal{L}_{\text{wasserstein}}$  is the Wasserstein distance loss. The

parameters  $\beta$ ,  $\alpha$ , and  $\gamma$  control the weights of each component.

Asymmetric Focus Loss (ATFL) enhances the model's ability to learn from hard samples by introducing asymmetric weights and a focus parameter:

$$\mathcal{L}_{\text{ATFL}} = -\alpha t \cdot (1 - p_t)^\gamma \cdot \log(p_t) \quad (25)$$

where  $p_t$  is the predicted probability for the correct class,  $\alpha_t$  is the asymmetric weight, and  $\gamma$  is the focus parameter. The asymmetric weight is defined as:

$$\alpha_t = \begin{cases} \alpha, & \text{if } t = 1 \\ 1 - \alpha, & \text{if } t = 0 \end{cases} \quad (26)$$

This formulation addresses class imbalance and improves the learning of difficult samples. In autonomous driving, the asymmetric design increases sensitivity to small and rare targets.

The Wasserstein distance loss measures the divergence between predicted and target feature distributions, providing additional supervision. The theoretical definition is:

$$\mathcal{L}_{\text{wasserstein}} = \inf_{\pi \in \Pi(\mu, \nu)} \int_{X \times Y} c(x, y) d\pi(x, y) \quad (27)$$

where  $\Pi(\mu, \nu)$  is the set of all joint distributions,  $c(x, y)$  is the cost function, and  $\mu, \nu$  are the distributions of predicted and target features.

A dynamic weight adjustment mechanism is incorporated into the adaptive ATFL-Wasserstein fusion loss. Loss weights are modulated by an adaptive gamma modulator and a gradient-guided adjustment strategy. The adaptive gamma parameter is determined by the certainty of model predictions:

$$\gamma_{\text{adaptive}} = \gamma_{\text{base}} \cdot (1 - e^{-\text{confidence}}) \quad (28)$$

where  $\gamma_{\text{base}}$  is the base gamma parameter and confidence denotes the certainty of the model's prediction. This mechanism enables automatic adjustment of the focus parameter. Higher uncertainty increases  $\gamma_{\text{adaptive}}$ , strengthening the learning of difficult samples. Lower uncertainty reduces  $\gamma_{\text{adaptive}}$ , limiting the learning of easy samples.

The gradient bootstrap mechanism adjusts the regression loss weight using historical gradient information:

$$\beta_{\text{dynamic}} = \beta_{\text{base}} \cdot (1 + 0.1 \cdot \sigma (5 \cdot \text{gradmemory})) \quad (29)$$

where  $\beta_{\text{base}}$  is the base beta parameter, gradmemory represents historical gradient information, and  $\sigma$  is the sigmoid function.

This approach allows adaptive balancing of classification and regression losses. Large regression gradients increase  $\beta_{\text{dynamic}}$ , emphasizing regression learning. Small gradients decrease  $\beta_{\text{dynamic}}$ , reducing the regression contribution.

Feature extraction is performed using a multilayer convolutional network:

$$F_i = \text{Conv}_i(F_{i-1}) \quad (30)$$

where  $F_l$  is the feature at layer  $l$  and  $\text{Conv}_l$  is the convolution operation at layer  $l$ .

Multilevel feature extraction captures information at various scales, providing richer supervision. This is particularly beneficial in autonomous driving, where target scales vary significantly.

The adaptive ATFL-Wasserstein fusion loss operates as follows. Multilevel features are extracted to obtain the predictive feature set  $F_{\text{pred}} = \{F_{\text{pred}}^1, F_{\text{pred}}^2, \dots, F_{\text{pred}}^L\}$  and the target feature set  $F_{\text{target}} = \{F_{\text{target}}^1, F_{\text{target}}^2, \dots, F_{\text{target}}^L\}$ . Classification loss is computed as  $\mathcal{L}_{\text{cls}} = \mathcal{L}_{\text{ATFL}}(p, t)$ , enhancing the learning of difficult samples. Regression loss is calculated as  $\mathcal{L}_{\text{reg}} = \text{SmoothL1}(p_{\text{reg}}, t_{\text{reg}})$  to improve localization accuracy. Wasserstein distance loss is computed as:  $\sum \|\mu_{\text{pred}}^l - \mu_{\text{target}}^l\|_2 + \lambda \|\Sigma_{\text{pred}}^l - \Sigma_{\text{target}}^l\|_F$  to measure feature distribution differences. The adaptive gamma parameter  $\gamma_{\text{adaptive}}$  and dynamic beta parameter  $\beta_{\text{dynamic}}$  are determined by prediction certainty and historical gradient information, respectively. The total loss is then computed as:  $\mathcal{L}_{\text{cls}} + \beta_{\text{dynamic}} \cdot \mathcal{L}_{\text{reg}} + \alpha \cdot \gamma_{\text{adaptive}} \cdot \mathcal{L}_{\text{wasserstein}}$ .

The adaptive ATFL-Wasserstein fusion loss function demonstrates clear advantages in sample balancing. Category imbalance is effectively addressed by asymmetric focus loss through the introduction of asymmetric weights. The adaptive gamma parameter dynamically enhances the learning of difficult samples. Multilevel feature fusion provides richer supervision, improving detection of targets at various scales. In feature representation, the Wasserstein distance offers precise supervision by measuring differences in feature distributions. Multilevel feature extraction captures information at different scales, strengthening representational capacity. Feature-level loss computation further increases detection accuracy by providing more targeted supervision. Regarding adaptability, the dynamic weight adjustment mechanism automatically tunes parameters based on sample difficulty, improving model adaptability. The gradient guidance mechanism stabilizes training by adjusting weights according to gradient information. Multilevel feature fusion supports generalization by adapting to diverse scenarios. In terms of computational efficiency, the Wasserstein distance calculation reduces computational complexity, accelerating training. The lightweight feature extraction network decreases parameter count. The dynamic weight adjustment mechanism maintains high training efficiency with minimal computational overhead.

## IV. EXPERIMENTATION

### A. DATASET

Four representative autonomous driving datasets—BDD100K, ACDC, Foggy Zurich, and DAWN—were selected, covering a wide range of adverse weather conditions and complex traffic scenarios. A multi-source dataset merging strategy was adopted to maximize detection capability and environmental adaptability. The merged dataset is denoted as BDD100K+. Figure 5 presents statistical characteristics of instance counts, bounding box locations, and sizes for each target

![Figure 5: Labeling distribution statistics of BDD100K+ dataset. (a) Distribution of category instances: A histogram showing instance counts for various categories. 'car' is the most frequent with over 180,000 instances. Other categories include pedestrian, bus, train, motorcycle, bicycle, traffic light, and traffic sign. (b) Spatial Distribution of Bounding Box Centers: A scatter plot showing the normalized horizontal (x) and vertical (y) positions of bounding box centers. A high-density region is visible near x ≈ 0.5, y ≈ 0.45. (c) Distribution of boundary box dimensions: A scatter plot showing normalized width and height of bounding boxes. Most boxes are concentrated at width < 0.2 and height < 0.3. (d) Geometric Distribution of Bounding Boxes: A scatter plot showing the geometric arrangement of multiple bounding boxes, with most boxes being centrally and symmetrically distributed.](9d8d3d909d7fdccb631c519df2b86e61_img.jpg)

Figure 5: Labeling distribution statistics of BDD100K+ dataset. (a) Distribution of category instances: A histogram showing instance counts for various categories. 'car' is the most frequent with over 180,000 instances. Other categories include pedestrian, bus, train, motorcycle, bicycle, traffic light, and traffic sign. (b) Spatial Distribution of Bounding Box Centers: A scatter plot showing the normalized horizontal (x) and vertical (y) positions of bounding box centers. A high-density region is visible near x ≈ 0.5, y ≈ 0.45. (c) Distribution of boundary box dimensions: A scatter plot showing normalized width and height of bounding boxes. Most boxes are concentrated at width < 0.2 and height < 0.3. (d) Geometric Distribution of Bounding Boxes: A scatter plot showing the geometric arrangement of multiple bounding boxes, with most boxes being centrally and symmetrically distributed.

FIGURE 5. Labeling distribution statistics of BDD100K+ dataset.

category, enabling a detailed analysis of category balance and target distribution patterns. (a) Distribution of category instances. The upper left panel displays a histogram of instance counts per category. The “car” category exhibits a dominant presence, with over 180,000 instances, indicating severe class imbalance. “Traffic light” and “bicycle” categories also appear frequently, while categories such as “train,” “motorcycle,” and “rider” are underrepresented, resulting in a long-tailed distribution. This imbalance may cause overfitting to high-frequency categories and reduced detection performance for rare classes.

(b) Spatial Distribution of Bounding Box Centers. The lower left panel shows a heat map of bounding box centroid locations, with axes representing normalized horizontal ( $x$ ) and vertical ( $y$ ) positions. A high-density region is observed near  $x \approx 0.5$ ,  $y \approx 0.45$ , consistent with typical traffic scenes where targets, such as vehicles and pedestrians, are concentrated in the center of the image.

(c) Distribution of boundary box dimensions. The lower right panel illustrates the normalized width and height distribution of bounding boxes. Most boxes are concentrated at width  $< 0.2$  and height  $< 0.3$ , indicating a prevalence of small objects, such as distant pedestrians, traffic signs, and signal lights. This size distribution increases the challenge for detection algorithms, especially for small object detection, and requires strong multi-scale perception and high-resolution feature retention.

(d) Geometric Distribution of Bounding Boxes. The upper right panel visualizes the geometric arrangement of multiple bounding boxes, using overlay or anchor box overlap analysis. Most boxes are centrally and symmetrically distributed, further confirming that targets frequently appear in the central region of the image.

### B. EXPERIMENTAL SETUP

Experiments were conducted using the PyTorch 2.0.0 framework with an NVIDIA RTX 4090 GPU. The Adam optimizer was employed, with an initial learning rate of 0.001 and a batch size of 16. Input images were resized to  $640 \times 640$ , and training was performed for 300 epochs. Mosaic data augmentation was disabled during the first 10 epochs. To ensure fair comparison, all algorithms were trained with identical hyperparameters and datasets.

The quality and diversity of the training data directly affect the accuracy and generalization of the YOLOv11 model. Data preprocessing was performed before training. During this stage, image resolution was varied, light enhancement was applied, weather conditions were simulated, and Mosaic transformations were used. These operations provided comprehensive training samples, improved small object detection, and enhanced recognition under adverse weather and challenging viewpoints, supporting robust detection in complex autonomous driving scenarios. For night scenes, adaptive histogram equalization was used to improve image contrast and enhance the visibility of small targets.

Weather simulation techniques were applied to generate rain, fog, and snow conditions, increasing the diversity of adverse weather samples [11], [30]. For rain simulation, streak-like noise patterns with varying orientation, length, and transparency were superimposed on the original images to mimic real raindrops. Fog simulation was achieved by blending the images with Gaussian white masks of varying density and applying contrast reduction to simulate atmospheric scattering. For snow simulation, randomly distributed white spots and streaks of different sizes and opacities were added to the images to represent falling snowflakes. These synthetic weather effects were generated using open-source augmentation libraries and custom scripts, ensuring that the simulated images closely resemble real-world adverse weather scenarios. This approach effectively enhances the robustness and detection ability of the model under challenging environmental conditions.

Oversampling and mirror flipping were used to augment small object samples and alleviate class imbalance. Random occlusion was introduced to simulate partial visibility, improving the model's ability to detect occluded targets. Mosaic augmentation was performed by arranging images in  $2 \times 2$  or  $3 \times 3$  grids, dynamically adjusting splicing ratios to retain key features, and applying random rotation and scaling to increase scene diversity. Accurate conversion of bounding box coordinates and validity checks ensured correct labeling, particularly for cross-boundary targets.

### C. ASSESSMENT OF INDICATORS

To comprehensively evaluate object detection performance, three primary metrics were used: precision (P), recall (R), and mean average precision (mAP). Precision quantifies the proportion of true positives among all positive predictions, reflecting the model's ability to avoid false positives. Recall measures the proportion of true positives correctly identified,

indicating the model's capacity to capture relevant instances and minimize false negatives. Mean average precision is a standard metric in object detection, representing the average precision across all object classes. Higher mAP values indicate superior detection accuracy. These metrics together provide a robust assessment of model performance in various scenarios and are calculated as follows:

$$P = \frac{TP}{TP + FP} \quad (31)$$

$$R = \frac{TP}{TP + FN} \quad (32)$$

$$mAP = \frac{\sum_{n=1}^M AP_n}{M} \quad (33)$$

Here,  $TP$  (True Positive) denotes correctly detected objects,  $FP$  (False Positive) refers to incorrectly predicted objects, and  $FN$  (False Negative) indicates missed objects.  $M$  is the total number of categories, and  $AP_n$  represents the average precision for the  $n$ th category.

### D. COMPARATIVE EXPERIMENTS

To validate the effectiveness and advancement of the proposed LS-YOLO algorithm, systematic comparison experiments are conducted with current mainstream target detection methods, including YOLOv8, YOLOv9-C, YOLOv10, YOLOv11n, Faster R-CNN, SSD300, EfficientNet-B0, and RT- DETR-R18 and other methods. All algorithms are evaluated uniformly on the BDD100K+ dataset. The experimental results are shown in Table 1.

Table 1 demonstrates the comparison of the algorithms in the three key metrics of precision (Precision), recall and mean average precision (mAP). It can be seen that the proposed LS-YOLO achieves the optimal performance in all three metrics, with a precision of 67.5%, a recall of 47.3%, and a mAP of 49.8%, which significantly outperforms the other compared methods. Compared with YOLOv11n, the current leading performance lightweight model, LS-YOLO improves 1.4% in mAP, 0.9 and 2.4% in precision and recall, respectively, and is able to detect and classify fewer false positives and false negatives. In addition, LS-YOLO also exhibits excellent lightweight characteristics in terms of inference latency, GPU consumption, computational complexity and number of parameters, which makes it suitable for real-time and resource-constrained application scenarios. Compared with the traditional Faster R-CNN and SSD300, LS-YOLO shows overwhelming advantages in both accuracy and efficiency, which further validates the practicality and advancement of the proposed method.

Figure 6 visualizes the detection performance advantage of the LS-YOLO algorithm in complex urban scenes through comparison experiments. The experimental setup uses three groups of typical scenes, and each group contains a vertical comparison of the original images, YOLOv11n detection results and LS-YOLO detection results, which effectively verifies the effectiveness of the improvement mechanism proposed in this paper in practical applications.

**TABLE 1.** Performance comparison of different algorithms in BDD100K+.

| Algorithm       | Precision | Recall | mAP  | Latency(ms) | FPS | GPU Memory | GFLOPs | Parameters(M) |
|-----------------|-----------|--------|------|-------------|-----|------------|--------|---------------|
| LS-YOLO (Ours)  | 67.5      | 47.3   | 49.8 | 5.2         | 192 | 5.8        | 7.1    | 2.8           |
| YOLOv11n        | 66.6      | 44.9   | 48.4 | 5.8         | 172 | 6          | 7.8    | 2.6           |
| YOLOv10         | 65.3      | 43.8   | 47.2 | 6.5         | 153 | 6.4        | 8.7    | 3.8           |
| YOLOv9-C        | 64.1      | 43.6   | 46   | 7           | 143 | 6.6        | 9.8    | 5.2           |
| YOLOv8n         | 62.8      | 43.5   | 45   | 7.5         | 133 | 6.8        | 8.7    | 1.9           |
| EfficientNet-B0 | 58.7      | 39.7   | 41.3 | 8.2         | 122 | 6.9        | 9.9    | 5.3           |
| YOLOv5n         | 57.2      | 38.4   | 40.1 | 8.8         | 114 | 7.1        | 10.2   | 1.9           |
| Faster R-CNN    | 55.1      | 36.8   | 38.2 | 28.6        | 35  | 10.2       | 32.4   | 41.7          |
| SSD300          | 53.5      | 35.6   | 37   | 13.8        | 72  | 7.8        | 18.6   | 26.3          |
| RT-DETR-R18     | 62.8      | 43.7   | 45.5 | 9.8         | 102 | 7.6        | 14.3   | 17.5          |

![Figure 6: Visual comparison of detection results. The figure is a 6x2 grid of images showing street scenes from a car's perspective. The rows are labeled 'Original', 'YOLOv11', and 'LS-YOLO'. The first column shows the original images, while the second column shows the images with detection bounding boxes. The bounding boxes are color-coded: red for cars, blue for pedestrians, and green for bicycles. The LS-YOLO row shows more accurate and dense detections compared to the YOLOv11 row, especially for smaller objects like bicycles and pedestrians in the distance.](d29cfbf30a471dc06a78be27f86bd1cf_img.jpg)

Figure 6: Visual comparison of detection results. The figure is a 6x2 grid of images showing street scenes from a car's perspective. The rows are labeled 'Original', 'YOLOv11', and 'LS-YOLO'. The first column shows the original images, while the second column shows the images with detection bounding boxes. The bounding boxes are color-coded: red for cars, blue for pedestrians, and green for bicycles. The LS-YOLO row shows more accurate and dense detections compared to the YOLOv11 row, especially for smaller objects like bicycles and pedestrians in the distance.

**FIGURE 6.** Visual comparison of detection results.

From the perspective of the theoretical mechanism of small target detection, the MACA module significantly

enhances the extraction of small-scale features through the synergy of SRU and CRU. The experimental results show

that the recall of LS-YOLO is improved compared to YOLOv11n. This enhancement stems from the multiscale feature pyramid structure established by the MACA module in the feature space, which enables the model to capture and retain the key feature information of the small targets more effectively. In particular, the stability of the detection frame is significantly improved in the identification of small fixed facilities such as traffic signals, which verifies the adaptive feature extraction capability of the module in dealing with targets of different scales.

The dynamic routing mechanism of the DR-Concat module plays a key role in occluded target processing. It is observed experimentally that LS-YOLO exhibits excellent detection robustness in the problem of crowded areas target detection. This performance enhancement can be theoretically explained by the dynamic routing mechanism that adaptively adjusts the weights of different feature branches through iterative optimization during the feature fusion process, enabling the model to better understand and reconstruct the target features in the occluded part. Especially in complex scenes with multiple layers of occlusion, such as pedestrian groups in crosswalk areas, the DR-Concat module effectively reduces the feature loss due to occlusion through dynamic feature reorganization.

Enhanced detection performance in high-density scenarios demonstrates the synergistic effect of the SPDD module and the ATFL-Wasserstein loss function. Experimental results indicate that LS-YOLO increases the number of detected targets compared to YOLOv11n. This improvement is attributed to two advances. The SPDD module preserves strong feature extraction capability while reducing computational complexity by integrating DSC with dynamic routing. The ATFL-Wasserstein loss function addresses category imbalance by combining the Wasserstein distance metric with an adaptive thresholding mechanism, resulting in more balanced detection performance in mixed scenes.

In terms of overall performance, LS-YOLO demonstrates clear advantages in bounding box localization accuracy and environmental adaptability. This comprehensive improvement results from the integration of several enhancement modules. The C3K2-MACA module enables precise feature extraction. DR-Concat ensures effective feature fusion. SPDD facilitates the full utilization of multi-scale features. The ATFL-Wasserstein loss function optimizes the training process. Notably, LS-YOLO maintains a highly competitive inference speed, with a latency of only 5.2 ms, despite the introduction of these advanced mechanisms. This result highlights the effectiveness of the proposed lightweight design strategy.

Comparative experiments clearly demonstrate the detection advantages of LS-YOLO in complex urban environments. The feasibility and effectiveness of the proposed improvements are further confirmed in practical applications. Together, these results establish a technical paradigm for addressing object detection challenges in autonomous driving

scenarios, providing substantial theoretical and practical value for the advancement of the field.

### E. VISUALIZATION EXPERIMENTS

To evaluate the robustness and performance of the experimental algorithms under various weather conditions, object detection was performed on the BDD100K+ dataset, with a focus on challenging scenarios such as fog, night, rain, and snow, as shown in Figure 7.

![Figure 7: Four panels showing object detection results under different weather conditions: Foggy, Night, Rain, and Snow. Each panel shows a street scene with vehicles and pedestrians, with bounding boxes indicating detected objects.](10d19f166f9b7f5961f09f8041896943_img.jpg)

The figure consists of four sub-images arranged in a 2x2 grid, each showing a different weather condition from the BDD100K+ dataset. The top-left panel is labeled 'Foggy' and shows a street scene with reduced visibility. The top-right panel is labeled 'Night' and shows a street scene at night with streetlights and vehicle taillights. The bottom-left panel is labeled 'Rain' and shows a street scene with raindrops on the camera lens. The bottom-right panel is labeled 'Snow' and shows a street scene covered in snow. Each panel displays several vehicles and pedestrians, with bounding boxes indicating detected objects.

Figure 7: Four panels showing object detection results under different weather conditions: Foggy, Night, Rain, and Snow. Each panel shows a street scene with vehicles and pedestrians, with bounding boxes indicating detected objects.

FIGURE 7. Foggy, Night, Rain and Snow in the Legend for BDD100K+ dataset.

Table 2 presents the performance comparison of different algorithms under these weather conditions. Experimental results indicate that LS-YOLO demonstrates strong environmental adaptability and detection stability in adverse scenarios. In foggy conditions, LS-YOLO achieves 0.9% improvement over the baseline YOLOv11n. This gain is primarily attributed to the adaptive feature enhancement mechanism of the SRU in the MACA module. The SRU scores feature map importance through dynamic weight calculation, enabling effective extraction of ambiguous target features affected by atmospheric scattering. The feature reconstruction process allows the model to suppress visual interference from fog while retaining key target information. In night scenes, LS-YOLO achieves 0.8% improvement, further demonstrating robust detection capability under low illumination.

The observed performance improvement is primarily attributed to two key mechanisms. The DR-Concat module adaptively adjusts feature fusion weights through dynamic routing and iterative optimization, enhancing target perception under low-light conditions. The adaptive gamma modulation in the ATFL-Wasserstein loss function dynamically adjusts loss weights based on prediction certainty, which improves the model's learning on low-contrast targets at night. For dynamic interference scenarios such as rain and snow, LS-YOLO achieves mAP values of 44.0% and 42.9%, respectively. This strong environmental adaptability is mainly due to the DSC design in the SPDD module.

**TABLE 2.** Comparison of the performance of different algorithms in adverse weather (mAP).

| Algorithm       | Foggy | Night | Rain | Snow |
|-----------------|-------|-------|------|------|
| LS-YOLO (Ours)  | 45.2  | 43.3  | 44   | 42.9 |
| YOLOv11n        | 44.3  | 42.5  | 43.2 | 42   |
| YOLOv10         | 43.2  | 41    | 40.8 | 39.3 |
| YOLOv9-C        | 42.1  | 39.8  | 40.5 | 39.1 |
| YOLOv8n         | 40.9  | 38.5  | 39.2 | 37.7 |
| EfficientNet-B0 | 37.2  | 35.1  | 35.7 | 34.4 |
| YOLOv5n         | 36.3  | 34.1  | 34.8 | 33.3 |
| Faster R-CNN    | 35.2  | 32.9  | 33.6 | 32.1 |
| SSD300          | 33.8  | 31.6  | 32.2 | 30.7 |
| RT-DETR-R18     | 39.5  | 37.2  | 37.9 | 36.5 |

By decomposing standard convolution into depthwise and pointwise convolutions, the model reduces computational complexity while maintaining efficient feature extraction under dynamic weather. The spatial receptive field and channel attention mechanisms of DSC further enhance the ability to capture local discriminative features, especially when handling localized occlusion caused by rain and snow.

Further analysis indicates that LS-YOLO demonstrates strong performance across various severe weather conditions. This advantage is primarily attributed to the model's multilevel synergistic optimization. At the feature extraction level, the C3K2-MACA module enhances robustness to adverse weather through adaptive feature reconstruction. At the feature fusion level, the dynamic routing mechanism in DR-Concat ensures effective feature transfer in complex backgrounds. At the optimization objective level, the ATFL-Wasserstein loss function provides more accurate supervision of feature distributions. Traditional detectors such as Faster R-CNN and SSD300 exhibit more pronounced performance degradation under severe weather, mainly due to the lack of targeted adaptation mechanisms. Although the Transformer-based RT-DETR-R18 outperforms traditional detectors, its performance under extreme conditions, such as snow, remains inferior to LS-YOLO. These results confirm the effectiveness of the targeted optimization strategies proposed in this work. The experimental findings not only validate the performance advantage of LS-YOLO in adverse weather but also clarify the mechanisms by which each improvement module addresses specific environmental challenges. These insights provide valuable theoretical and practical guidance for designing more robust object detection systems.

In addition, detection performance at different viewing angles was evaluated using the UA-DETRAC dataset. As shown in Figure 8, four representative perspectives were analyzed: long-range, side, forward, and tilted views.

Detection performance under different observation angles was further evaluated to address the multi-view requirements of autonomous driving scenarios. Experimental results indicate that mainstream detection algorithms exhibit significant performance differences when tested on standard datasets.

Systematic evaluation across typical observation positions—including long range, side, forward, and tilted

![Figure 8: Target detection at different tilt angles in the Legend for UA-DETRAC dataset. The figure shows a 4x3 grid of images. The rows are labeled 'long range view', 'side view', 'forward view', and 'tilted view'. Each row contains three images showing different road scenes with various vehicles (cars, buses, motorcycles) and pedestrians. The images illustrate the model's performance across different viewing perspectives.](6b7b3f3d6f9341906163682cf12d1ea1_img.jpg)

Figure 8: Target detection at different tilt angles in the Legend for UA-DETRAC dataset. The figure shows a 4x3 grid of images. The rows are labeled 'long range view', 'side view', 'forward view', and 'tilted view'. Each row contains three images showing different road scenes with various vehicles (cars, buses, motorcycles) and pedestrians. The images illustrate the model's performance across different viewing perspectives.

**FIGURE 8.** Target detection at different tilt angles in the Legend for UA-DETRAC dataset.

views—demonstrates that LS-YOLO exhibits excellent viewpoint adaptability. In long-range detection, the algorithm achieves higher accuracy for small distant targets, attributed to the multi-scale feature extraction capability of the SPDD module. For side view scenarios, the dynamic feature fusion mechanism of the DR-Concat module enables effective handling of target deformation and occlusion. In front view detection, the spatial attention mechanism of the C3K2-MACA module significantly enhances feature extraction from frontal targets. Even in the most challenging tilted view scenario, the algorithm maintains stable performance, demonstrating strong viewpoint invariance.

**TABLE 3.** Comparison of the performance of different algorithms at multi-view detection.

| Algorithm       | Precision | Recall | mAP  |
|-----------------|-----------|--------|------|
| LS-YOLO (Ours)  | 96.2      | 92.3   | 94.8 |
| YOLOv11n        | 94.5      | 90.5   | 92.8 |
| YOLOv10         | 93.2      | 89.2   | 91.5 |
| YOLOv9-C        | 92.1      | 88.1   | 90.3 |
| YOLOv8n         | 90.8      | 86.8   | 89.0 |
| EfficientNet-B0 | 88.7      | 84.7   | 86.9 |
| YOLOv5n         | 87.2      | 83.2   | 85.4 |
| Faster R-CNN    | 85.1      | 81.1   | 83.3 |
| SSD300          | 83.5      | 79.5   | 81.7 |
| RT-DETR-R18     | 90.8      | 86.8   | 89.0 |

Notably, LS-YOLO demonstrates strong robustness when handling extreme variations in viewing angles. Analysis of detection results shows that the algorithm accurately identifies and localizes targets in 96.2% of cases, significantly outperforming conventional detectors. This advantage is primarily attributed to three key improvements. The C3K2-MACA module enhances adaptability to viewpoint changes through adaptive feature reconstruction. The dynamic routing strategy in the DR-Concat module ensures effective fusion of features from different perspectives. The adaptive weighting mechanism of the ATFL-Wasserstein loss function provides a more precise optimization objective, enabling the model to better learn viewpoint-invariant features.

Comprehensive visualization experiments and multi-view analyses provide evidence that LS-YOLO achieves reliable

performance in complex environments and under diverse viewpoints. The findings demonstrate that the algorithm maintains stability across a range of weather conditions and exhibits robustness in response to varying observation angles.

### F. ABLATION EXPERIMENT

To systematically assess the contribution and synergistic effects of each core module in LS-YOLO, a series of progressive ablation experiments was conducted. Beginning with the benchmark YOLOv11 model, key components—including MACA, DR-Concat, SPDD, and ATFL-Wasserstein—were incrementally introduced. The impact of each module on model performance was analyzed in detail. The results validate the effectiveness of individual modules and elucidate the synergistic mechanisms among them.

Module-level ablation experiments reveal a cumulative improvement in performance with the sequential introduction of each component. The inclusion of the MACA module increases the model's mAP from 48.4% to 48.5%. Although the gain is modest, it is consistent and primarily attributed to the feature space reconstruction mechanism of MACA. The combined effect of SRU and CRU enhances spatial feature perception, particularly for small targets and complex backgrounds. Analysis suggests that this improvement results from the adaptive weight allocation established by the MACA module, enabling more precise capture of key target features.

![Figure 9: Comparison of ablation experiments on the BDD100K+ dataset. The figure includes a horizontal bar chart showing mAP, Recall, and Precision for five configurations, and a table below it summarizing the data.](fd188843e5acb8e0d76372860b5f5962_img.jpg)

| Configuration                                | Precision | Recall | mAP  |
|----------------------------------------------|-----------|--------|------|
| YOLOv11+MACA+DR-Concat+SPDD+ATFL-Wasserstein | 67.5      | 47.3   | 49.8 |
| YOLOv11+MACA+DR-Concat+SPDD                  | 67.4      | 47.2   | 49.6 |
| YOLOv11+MACA+DR-Concat                       | 67.1      | 45.5   | 49.2 |
| YOLOv11+MACA                                 | 66.9      | 45.1   | 49.5 |
| YOLOv11(Baseline)                            | 66.6      | 44.9   | 48.4 |

Figure 9: Comparison of ablation experiments on the BDD100K+ dataset. The figure includes a horizontal bar chart showing mAP, Recall, and Precision for five configurations, and a table below it summarizing the data.

FIGURE 9. Comparison of ablation experiments on the BDD100K+ dataset.

With the addition of the DR-Concat module, model performance further increases to 49.2% mAP, representing a notable improvement of 0.7%. This result highlights the critical role of the dynamic routing mechanism in feature fusion. DR-Concat adaptively adjusts feature weights through iterative optimization. This mechanism allows the model to dynamically adjust the fusion strategy based on the actual content of the input features, thereby improving feature utilization efficiency.

The introduction of the SPDD module increases the mAP to 49.6%, validating the effectiveness of combining DSC with dynamic feature extraction. The computational efficiency of SPDD is primarily attributed to the use of DSC in place of standard convolution. For a standard convolution with  $C$  input

![Figure 10: Comparison of loss on BDD100K+ dataset. The graph shows the training loss over 300 epochs for LS-YOLO Reg Loss, LS-YOLO CIs Loss, LS-YOLO W Loss, Baseline Box Loss, Baseline CIs Loss, and Baseline DFL Loss. The Reg loss shows a steep decline, while other losses decrease more gradually.](70f5f44cb855bbb0c203c00187b2113e_img.jpg)

Figure 10: Comparison of loss on BDD100K+ dataset. The graph shows the training loss over 300 epochs for LS-YOLO Reg Loss, LS-YOLO CIs Loss, LS-YOLO W Loss, Baseline Box Loss, Baseline CIs Loss, and Baseline DFL Loss. The Reg loss shows a steep decline, while other losses decrease more gradually.

FIGURE 10. Comparison of loss on BDD100K+ dataset.

and output channels, kernel size  $k \times k$ , and feature map size  $N \times N$ , the total number of operations is  $C^2 k^2 N^2$ . In contrast, DSC consists of DWC ( $C k^2 N^2$  operations) followed by PWC ( $C^2 N^2$  operations), resulting in  $C k^2 N^2 + C^2 N^2$ . In practical scenarios, the kernel size  $k$  (typically 3 or 5) is much smaller than the number of channels  $C$  (usually several tens to several hundreds), so  $C^2 k^2 N^2 \gg C k^2 N^2 + C^2 N^2$ . This forms the theoretical basis for the significant reduction in computational cost achieved by DSC in the SPDD module.

The introduction of the ATFL-Wasserstein loss function enables the model to achieve 49.8% mAP. This improvement is primarily attributed to its effectiveness in addressing sample imbalance. By combining the Wasserstein distance metric with an adaptive thresholding mechanism, the loss function provides a more accurate supervised signal for feature distribution. Its mathematical formulation,  $L = \alpha L_{cls} + \beta L_{reg} + \gamma L_w$ , where  $\alpha$ ,  $\beta$ , and  $\gamma$  are adaptive weighting coefficients, reflects the balance among classification, regression, and distribution alignment.

The training dynamics are further elucidated by the loss curves presented in Figure 10, which provide insight into the model optimization process. The Reg loss exhibits a steep decline within the initial 50 epochs, followed by a plateau, indicating rapid acquisition of fundamental localization capability and subsequent convergence. In contrast, the classification loss decreases more gradually, reflecting the incremental and progressive nature of semantic learning. Of particular interest is the behavior of the Wasserstein Loss curve, which continues to decrease in the later training stages. This trend suggests ongoing refinement of the feature distribution representation, highlighting the model's capacity for sustained optimization beyond initial convergence.

Model performance indicator curves in Figure 11 provide further evidence of convergence. Precision and recall increase rapidly during the early training phase and then stabilize at elevated levels, indicating the progressive development of

![Figure 11: Comparison of precision, recall, and mAP on BDD100K+ dataset. The figure contains three line graphs. The first graph shows Precision (y-axis, 0.35 to 0.70) vs Epochs (x-axis, 0 to 300). The second graph shows Recall (y-axis, 0.30 to 0.50) vs Epochs (x-axis, 0 to 300). The third graph shows mAP (y-axis, 0.30 to 0.50) vs Epochs (x-axis, 0 to 300). In all three graphs, the LS-YOLO model (red solid line) consistently outperforms the Baseline model (blue dashed line).](177e8bc1c595b7fe3461d9919f87e044_img.jpg)

Figure 11: Comparison of precision, recall, and mAP on BDD100K+ dataset. The figure contains three line graphs. The first graph shows Precision (y-axis, 0.35 to 0.70) vs Epochs (x-axis, 0 to 300). The second graph shows Recall (y-axis, 0.30 to 0.50) vs Epochs (x-axis, 0 to 300). The third graph shows mAP (y-axis, 0.30 to 0.50) vs Epochs (x-axis, 0 to 300). In all three graphs, the LS-YOLO model (red solid line) consistently outperforms the Baseline model (blue dashed line).

**FIGURE 11.** Comparison of precision, recall, and mAP on BDD100K+ dataset.

accurate target perception. The mAP50 curve rises smoothly, reflecting consistent gains in overall detection performance. After 200 epochs, all metrics exhibit minor fluctuations but remain stable, confirming the model's capacity for continuous learning and optimization.

Comparative experimental results further verify the superiority of the ATFL-Wasserstein loss. Compared to the original focal loss, BE-ATFL demonstrates clear advantages in handling difficult samples and category imbalance by introducing a boundary entropy term and an adaptive weighting mechanism. Experimental data indicate that ATFL-Wasserstein achieves 1.4% improvement in mAP over the original focal loss. This gain is primarily attributed to more accurate modeling of feature distributions and adaptive sample weight adjustment.

**TABLE 4.** Ablation study on focal loss functions using the BDD100+ dataset.

| Algorithm                         | Precision | Recall | mAP  |
|-----------------------------------|-----------|--------|------|
| YOLOv11 + original focal loss     | 66.6      | 44.9   | 48.4 |
| YOLOv11 + Generalized Focal Loss  | 66.7      | 45.2   | 48.6 |
| YOLOv11 + Asymmetric Loss         | 66.7      | 45.4   | 48.6 |
| YOLOv11 + ATFL                    | 66.8      | 45.9   | 48.7 |
| YOLOv11 + ATFL-Wasserstein (Ours) | 67.5      | 47.3   | 49.8 |

The ablation experiments confirm the effectiveness of each module and reveal the synergistic mechanisms among them. Results demonstrate that LS-YOLO, through the integration of several improved modules, achieves notable improvements in detection performance while maintaining computational efficiency. This enhancement is evident not only in the final metrics, but also in the comprehensive advancement of the model across multiple levels, including feature extraction, fusion, and optimization.

## V. CONCLUSION

This paper presents LS-YOLO, a lightweight and robust object detection framework designed for autonomous driving in complex and adverse environments. By integrating a hybrid attention-based MACA module, efficient multi-scale fusion modules (SPDD and DR-Concat), and a novel ATFL-Wasserstein loss function, the proposed method achieves notable improvements in detecting small, occluded,

and long-range targets under challenging conditions such as rain, fog, and low illumination. LS-YOLO maintains a favorable balance between detection accuracy and computational efficiency, making it suitable for deployment on resource-constrained in-vehicle systems. Several limitations remain. Model performance under extremely low-light scenarios requires further enhancement. The current design focuses on 2D object detection and lacks depth estimation and 3D localization capabilities, which are essential for safe autonomous navigation. Temporal information across frames is not fully utilized. This limitation reduces the ability to track fast-moving or dynamically changing targets. Future research will address several directions. Self-supervised and contrastive learning will be incorporated to improve generalization on unlabeled data. Multimodal data sources, such as LiDAR and radar, will be integrated to achieve more comprehensive perception. Hybrid CNN-Transformer architectures will be designed to further enhance detection performance while maintaining lightweight characteristics. Deployment optimization through quantization, sparsification, and knowledge distillation tailored for edge hardware platforms will also be explored.

## REFERENCES

- [1] F. Liu, Z. Lu, and X. Lin, "Vision-based environmental perception for autonomous driving," *Proc. Inst. Mech. Eng., D, J. Automobile Eng.*, vol. 239, no. 1, pp. 39–69, 2025.
- [2] J. Kim, B.-J. Park, and J. Kim, "Empirical analysis of autonomous vehicle's LiDAR detection performance degradation for actual road driving in rain and fog," *Sensors*, vol. 23, no. 6, p. 2972, Mar. 2023.
- [3] Z. Jing, S. Li, and Q. Zhang, "YOLOv8-STE: Enhancing object detection performance under adverse weather conditions with deep learning," *Electronics*, vol. 13, no. 24, p. 5049, Dec. 2024.
- [4] K. Chen et al., "MMDetection: Open MMLab detection toolbox and benchmark," 2019, *arXiv:1906.07155*.
- [5] C.-Y. Wang, A. Bochkovskiy, and H.-Y. M. Liao, "YOLOv7: Trainable bag-of-freebies sets new state-of-the-art for real-time object detectors," 2022, *arXiv:2207.02696*.
- [6] M. Hussain, "YOLOv5, YOLOv8 and YOLOv10: The go-to detectors for real-time vision," 2024, *arXiv:2407.02988*.
- [7] J. Liao, S. Jiang, M. Chen, and C. Sun, "SAM-YOLO: An improved small object detection model for vehicle detection," *Eur. J. Artif. Intell.*, vol. 38, no. 3, pp. 279–295, Aug. 2025, doi: 10.1177/30504554251319452.
- [8] Z. Zhao, C. He, G. Zhao, J. Zhou, and K. Hao, "RA-YOLOX: Re-parameterization align decoupled head and novel label assignment scheme based on YOLOX," *Pattern Recognit.*, vol. 140, Aug. 2023, Art. no. 109579.

- [9] Y. Zhao, W. Lv, S. Xu, J. Wei, G. Wang, Q. Dang, Y. Liu, and J. Chen, "DETRs beat YOLOs on real-time object detection," 2023, *arXiv:2304.08069*.
- [10] H. Gong, Y. Li, and J. Dong, "A dual-balanced network for long-tail distribution object detection," *IET Comput. Vis.*, vol. 17, no. 5, pp. 565–575, Aug. 2023.
- [11] D. Kumar and N. Muhammad, "Object detection in adverse weather for autonomous driving through data merging and YOLOv8," *Sensors*, vol. 23, no. 20, p. 8471, Oct. 2023.
- [12] P. Mittal, "A comprehensive survey of deep learning-based lightweight object detection models for edge devices," *Artif. Intell. Rev.*, vol. 57, no. 9, p. 242, Aug. 2024.
- [13] S. Sah, R. Kumar, D. C. Ganji, and E. Saboori, "ActNAS : Generating efficient YOLO models using activation NAS," 2024, *arXiv:2410.10887*.
- [14] S. Song, X. Ye, and S. Manoharan, "E-MobileViT: A lightweight model for traffic sign recognition," *Ind. Artif. Intell.*, vol. 3, no. 1, p. 3, Mar. 2025.
- [15] J. Zhang, S. Peng, J. Liu, and A. Guo, "DCAN: Dynamic channel attention network for multi-scale distortion correction," *Sensors*, vol. 25, no. 5, p. 1482, Feb. 2025.
- [16] P.-L. Asselin, V. Coulombe, W. Guimont-Martin, and W. Larrivée-Hardy, "Replication study and benchmarking of real-time object detection models," 2024, *arXiv:2405.06911*.
- [17] X. Li, W. Wang, X. Hu, J. Li, J. Tang, and J. Yang, "Generalized focal loss v2: Learning reliable localization quality estimation for dense object detection," 2020, *arXiv:2011.12885*.
- [18] Z. Lyu and W. An, "HDR-YOLO: Adaptive object detection in haze, dark, and rain scenes based on YOLO," *Int. J. Pattern Recognit. Artif. Intell.*, vol. 38, no. 5, Apr. 2024, Art. no. 2450006.
- [19] S. Wu, Y. Yan, and W. Wang, "CF-YOLOX: An autonomous driving detection model for multi-scale object detection," *Sensors*, vol. 23, no. 8, p. 3794, Apr. 2023.
- [20] B. Ren, X. Yang, Y. Yu, J. Luo, and Z. Deng, "PointOBB-v2: Towards simpler, faster, and stronger single point supervised oriented object detection," 2024, *arXiv:2410.08210*.
- [21] Y. Chen, X. Zhu, Y. Li, Y. Wei, and L. Ye, "Enhanced semantic feature pyramid network for small object detection," *Signal Process., Image Commun.*, vol. 113, Apr. 2023, Art. no. 116019.
- [22] J. Wang, W. Zhang, Y. Cao, K. Chen, J. Pang, T. Gong, J. Shi, C. C. Loy, and D. Lin, "Side-aware boundary localization for more precise object detection," 2019, *arXiv:1912.04260*.
- [23] X. Gong and D. Liu, "SGMNet: A remote sensing image object detection network based on spatial global attention and multi-scale feature fusion," *Remote Sens. Lett.*, vol. 15, no. 5, pp. 466–477, May 2024.
- [24] H. Mushtaq, X. Deng, I. Ullah, M. Ali, and B. H. Malik, "O2SAT: Object-oriented-segmentation-guided spatial-attention network for 3D object detection in autonomous vehicles," *Information*, vol. 15, no. 7, p. 376, Jun. 2024.
- [25] X. Wang, Y. Liu, H. Xu, and C. Xue, "Spatial small target detection method based on multi-scale feature fusion pyramid," *Appl. Sci.*, vol. 14, no. 13, p. 5673, Jun. 2024.
- [26] F. Liang, C. Lin, R. Guo, M. Sun, W. Wu, J. Yan, and W. Ouyang, "Computation reallocation for object detection," 2019, *arXiv:1912.11234*.
- [27] J. Chen and M. J. Er, "Dynamic YOLO for small underwater object detection," *Artif. Intell. Rev.*, vol. 57, no. 7, p. 165, Jun. 2024.
- [28] Q. Guo, Y. Wang, Y. Zhang, M. Zhao, and Y. Jiang, "AIE-YOLO: Effective object detection method in extreme driving scenarios via adaptive image enhancement," *Sci. Prog.*, vol. 107, no. 3, Jul. 2024, Art. no. 368504241263165.
- [29] D. Zhao, F. Shao, S. Zhang, L. Yang, H. Zhang, S. Liu, and Q. Liu, "Advanced object detection in low-light conditions: Enhancements to YOLOv7 framework," *Remote Sens.*, vol. 16, no. 23, p. 4493, Nov. 2024.
- [30] X. Meng, Y. Liu, L. Fan, and J. Fan, "YOLOv5s-fog: An improved model based on YOLOv5s for object detection in foggy weather scenarios," *Sensors*, vol. 23, no. 11, p. 5321, Jun. 2023.
- [31] Z. Qu, L.-Y. Gao, S.-Y. Wang, H.-N. Yin, and T.-M. Yi, "An improved YOLOv5 method for large objects detection with multi-scale feature cross-layer fusion network," *Image Vis. Comput.*, vol. 125, Sep. 2022, Art. no. 104518.
- [32] R. Zhang, Z. Zhu, L. Li, Y. Bai, and J. Shi, "BFE-Net: Object detection with bidirectional feature enhancement," *Electronics*, vol. 12, no. 21, p. 4531, Nov. 2023.
- [33] S. Liu, F. Shao, W. Chu, J. Dai, and H. Zhang, "An improved YOLOv8-based lightweight attention mechanism for cross-scale feature fusion," *Remote Sens.*, vol. 17, no. 6, p. 1044, Mar. 2025.
- [34] X. Hu and Q. Lin, "D&D-YOLO-based method for high-altitude infrared thermal pedestrian detection," in *Proc. 5th Int. Conf. Electron. Commun. Artif. Intell. (ICECAI)*, May 2024, pp. 774–777.
- [35] X. Li, C. Lv, W. Wang, G. Li, L. Yang, and J. Yang, "Generalized focal loss: Towards efficient representation learning for dense object detection," *IEEE Trans. Pattern Anal. Mach. Intell.*, vol. 45, no. 3, pp. 3139–3153, Mar. 2023.
- [36] R. Khanam and M. Hussain, "A review of YOLOv12: Attention-based enhancements vs. Previous versions," 2025, *arXiv:2504.11995*.

![Portrait of Cheng Ju, a man with glasses and a white shirt, against a red background.](555df5c0300cb1fca5dc028fec5ec6be_img.jpg)

Portrait of Cheng Ju, a man with glasses and a white shirt, against a red background.

**CHENG JU** received the Ph.D. degree in electronic science and technology from Nankai University, in 2016. From 2017 to 2024, he was a Senior Engineer with China Aerospace Science and Industry Corporation. He is currently an Associate Professor with the School of Data and Science Engineering, Xi'an Innovation College of Yan'an University. His research interests include deep learning-based object detection, edge computing technologies, the IoT sensing technologies, and the IoT application solutions.

![Portrait of Yuxin Chang, a woman with dark hair and a blue top, against a white background.](a4d009d5dd6a4d83759d6d6538188e23_img.jpg)

Portrait of Yuxin Chang, a woman with dark hair and a blue top, against a white background.

**YUXIN CHANG** received the B.E. degree in electronic information engineering from Guangxi Normal University, in 2021, and the M.S. degree in signal and information processing from Shaanxi Normal University, in 2024. She is currently with the School of Data Science and Engineering, Xi'an Innovation College of Yan'an University. Her research interests include artificial intelligence, machine learning, and brain-computer interface technologies.

![Portrait of Yuansha Xie, a woman with dark hair and a white top with a blue bow, against a white background.](0656422bf374a8a7bcc6fe99adc48599_img.jpg)

Portrait of Yuansha Xie, a woman with dark hair and a white top with a blue bow, against a white background.

**YUANSHA XIE** received the B.E. degree in electronic information science and technology and the M.S. degree in new generation electronic information from Shaanxi University of Science and Technology, Xi'an, China, in 2021 and 2024, respectively. She is currently a Teaching Assistant with the School of Data Science and Engineering, Xi'an Innovation College of Yan'an University. Her research interests include artificial intelligence, machine learning, and embedded systems.

![Portrait of Dina Li, a woman with glasses and a blue top, against a blue background.](63a5a7879cf64a0e3ce5643c8ba1648f_img.jpg)

Portrait of Dina Li, a woman with glasses and a blue top, against a blue background.

**DINA LI** received the M.S. degree in signal and information processing from Yan'an University, in 2008. She is currently an Associate Professor and the Director of the Electronic Information Engineering Teaching and Research Office, School of Data Science and Engineering, Xi'an Innovation College of Yan'an University, Xi'an, China. Her research interests include digital signal processing, embedded systems, and electronic information technology.

...