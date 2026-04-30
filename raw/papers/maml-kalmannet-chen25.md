---
source_url: (user-provided PDF — IEEE TSP 2025)
ingested: 2026-04-30
sha256: 0f200f7d7eac90012f6322bdc36ba21b1ae7e40d97188823b7db2e91da5198f2
source: paper
conversion: pymupdf4llm
---

IEEE TRANSACTIONS ON SIGNAL PROCESSING, VOL. 73, 2025 

988 

# MAML-KalmanNet: A Neural Network-Assisted Kalman Filter Based on Model-Agnostic Meta-Learning 

Shanli Chen , Yunfei Zheng , Dongyuan Lin , Peng Cai , Yingying Xiao , and Shiyuan Wang , _Senior Member, IEEE_ 

_**Abstract**_ **—Neural network-assisted (NNA) Kalman filters provide an effective solution to addressing the filtering issues involving partially unknown system information by incorporating neural networks to compute the intermediate values influenced by unknown data, such as the Kalman gain in the filtering process. However, whenever there are slight changes in the state-space model (SSM), previously trained networks used in NNA Kalman filters become outdated, necessitating extensive time and data for retraining. Furthermore, obtaining sufficient labeled data for supervised learning is costly, and the effectiveness of unsupervised learning can be inconsistent. To this end, to address the inflexibility of neural network architecture and the scarcity of training data, we propose a model-agnostic metalearning based neural network-assisted Kalman filter in this paper, called MAML-KalmanNet, by employing a limited amount of labeled data and training rounds to achieve desirable outcomes comparable to the supervised NNA Kalman filters with sufficient training. MAML-KalmanNet utilizes a pre-training approach based on specifically tailored meta-learning, enabling the network to adapt to model changes with minimal data and time without the requirement of retraining. Simultaneously, by fully leveraging the information from the SSM, MAML-KalmanNet eliminates the requirement of a large amount of labeled data to train the meta-learning initialization network. Simulations show that MAML-KalmanNet can mitigate the shortcomings existing in NNA Kalman filters regarding the requirements of abundant training data and sensitive network architecture, while providing real-time state estimation across a range of noise distributions.** 

_**Index Terms**_ **—Kalman filters, state-space model, deep learning, meta-learning, recurrent neural networks.** 

Received 20 August 2024; revised 10 December 2024 and 26 January 2025; accepted 3 February 2025. Date of publication 12 February 2025; date of current version 25 February 2025. This work was supported in part by the National Natural Science Foundation of China under Grant 62471406 and Grant 62306245, in part by the Natural Science Foundation of Chongqing under Grant CSTB2024NSCQ-MSX0234, in part by the Graduate Research and Innovation Project of Chongqing under Grant CYB23144, and in part by the Graduate Research and Innovation Project of Southwest University under Grant SWUB24072. The associate editor coordinating the review of this article and approving it for publication was Sijia Liu. _(Corresponding author: Shiyuan Wang.)_ 

The authors are with the College of Electronic and Information Engineering, Southwest University, Chongqing 400715, China (e-mail: csl2232@ email.swu.edu.cn; zhengyfswu@swu.edu.cn; ldy000447@email.swu.edu.cn; cpxuexi@email.swu.edu.cn; xyy2021@email.swu.edu.cn; wsy@swu.edu.cn). Digital Object Identifier 10.1109/TSP.2025.3540018 

## I. INTRODUCTION 

EURAL network-assisted (NNA) Kalman filters [1], [2], **N** [3], [4], [5], [6], [7], [8], [9], [10] have become one of the most popular tools for estimating the hidden states of dynamic systems from noisy measurements, driven by rapid advancements in neural network technologies and improvements in hardware. The NNA Kalman filters have been already widely used in the fields of tracking, localization, and navigation [11], [12], [13]. Additionally, NNA Kalman filters exhibit superior performance in handling highly nonlinear systems and scenarios with unknown partial state-space model (SSM) information, outperforming traditional model-based Kalman filters that mainly depend on dynamic system models [14], [15], [16], [17], [18] and purely data-driven filtering methods that rely entirely on neural networks [19], [20], [21]. 

Specifically, the model-based Kalman filters such as the Kalman filter (KF) [14] and extended Kalman filter (EKF) [15] provide the advantages of low complexity and fast convergence. However, they often suffer from performance degradation in the presence of highly nonlinear or partially unknown SSMs [22], [23]. Conversely, the purely data-driven filtering methods such as deep Markov models [20] and attention mechanisms [21] do not depend on SSMs; instead they directly learn the latent states using neural networks. However, these approaches necessitate extensive training due to their complex architectures. NNA Kalman filters integrate the advantages of the aforementioned two approaches by using neural networks to compute certain intermediate values existing in model-based Kalman filters that are affected by the absence of SSM information. NNA Kalman filters not only address the challenges encountered by modelbased Kalman filters in compensating for the absence of SSM information [24], [25], [26], but also reduce model complexity and significantly decrease the number of neural network parameters (NNPs) compared to the data-driven filtering methods. For instance, KalmanNet [2] can eliminate the dependence on the statistical properties of noise by employing a dedicated recurrent neural network to compute the Kalman gain. 

However, incorporating neural networks into the Kalman filter framework also introduces the inherent challenges associated with neural networks [27] when addressing the filtering problem. The prerequisite for executing NNA filtering tasks 

1053-587X © 2025 IEEE. All rights reserved, including rights for text and data mining, and training of artificial intelligence and similar technologies. Personal use is permitted, but republication/redistribution requires IEEE permission. See https://www.ieee.org/publications/rights/index.html for more information. 

Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 12:51:45 UTC from IEEE Xplore.  Restrictions apply. 

CHEN et al.: MAML-KALMANNET: A NEURAL NETWORK-ASSISTED KALMAN FILTER 

989 

is that the NNPs have been already trained off-line. However, acquiring a suitable dataset for training NNPs presents a significant challenge. As noted in KalmanNet [2], it is possible to obtain latent states by utilizing ultra-high precision sensors. However, the labeled data (state-measurement pairs) obtained through this method is generally costly, and ultra-precise sensors frequently cannot operate long enough to gather sufficient training data. Although unsupervised NNA Kalman filters, such as the data-driven nonlinear state estimation (DANSE) [9], rely solely on measurements to update NNPs, their performance is often unsatisfactory. Additionally, due to the black box nature of neural networks, purely data-driven and NNA methods lack the adaptability to model changes. When the model experiences minor adjustments such as variations in noise covariance, the trained NNPs of purely data-driven and NNA methods may become obsolete, necessitating extensive time to collect new datasets and then retrain the NNPs. Although some NNA methods can accommodate model changes without retraining [10], [28], they frequently demand substantial labeled data and prior information. For example, adaptive KalmanNet (AKNet) [10] uses a hypernetwork to adapt KalmanNet’s NNPs during inference, eliminating the need for additional fine-tuning. However, it requires a large and diverse dataset that encompasses various noise scenarios. Similarly, adaptive Kalman-informed transformer (A-KIT) [28] utilizes transformer-based architectures to adapt to changes in process noise, providing flexibility while depending on large-scale training data. 

In the field of machine learning, the challenges of data scarcity and the limitations of neural network adaptability have given rise to the concept of meta-learning or “learning to learn” [29]. One prominent approach in meta-learning is modelagnostic meta-learning (MAML) [30], which involves training a model across a series of related yet distinct tasks to distill a set of generalizable initial NNPs. This process equips the model not only with strategies for solving specific tasks, but also more importantly, with the ability to quickly learn from a small amount of data for new tasks. Once these initial parameters are acquired, the model can rapidly adapt to new tasks only with a few examples and training rounds, demonstrating its remarkable efficiency and adaptability. However, MAML encounters several challenges during training, such as instability and high computational complexity due to its nested optimization structure. An enhanced version of MAML, called MAML++, has been proposed to address these issues [31]. Nevertheless, it also introduces new challenges in state estimation due to the substantial variability among different tasks. Additionally, the efficacy of MAML largely depends on extensive collections of similar yet diverse training data to distill a set of general initial NNPs, which often proves inadequate in the context of state prediction. Therefore, these constraints hinder the direct application of MAML to the field of state prediction. 

This paper aims to address the NNA state estimation issues regarding data scarcity and network inflexibility. The objective is to design a novel NNA Kalman filter based on MAML called MAML-KalmanNet. MAML-KalmanNet effectively trains neural networks with limited data and minimal 

training rounds, and thus diverges from existing supervised or unsupervised learning methods used in NNA Kalman filters. By integrating the advantages of MAML for fast adaptation, MAML-KalmanNet achieves real-time state estimation under the conditions of partially unknown SSMs and limited available data. To this end, we need to address the following challenges: 1) The nested optimization structure of MAML inherently results in high computational complexity and unstable training. The unstable training is further exacerbated by the significant variability encountered in state prediction tasks. 2) The data requirements of MAML training far surpass those of conventional supervised learning, exacerbating the existing challenge in obtaining sufficient training data for state prediction problems. Based on the aforementioned challenges, the main contributions of this paper are as follows: 

- 1) A novel training paradigm, called MAML-KalmanNet, is proposed to achieve acceptable results by utilizing scarce data and limited training rounds compared to supervised learning methods. The MAML-KalmanNet framework leverages the strengths of both MAML and KalmanNet, synergistically by integrating MAML strategies into the KalmanNet training process. 

- 2) Integrating the principles of MAML, MAML-KalmanNet enhances the initialization process of NNPs. And to address the challenges of training instability and high computational cost existing in the structure of MAML, an improved structure is proposed for a better alignment with the predictive demand of sequential data. 

- 3) The artificially assumed labeled (AAL) data are crafted by leveraging the available SSM information. In this manner, the challenge of obtaining labeled data in the domain of state prediction can be addressed, especially when the introduction of the MAML mechanism increases the demand for a substantial amount of training data. 

- 4) MAML-KalmanNet demonstrates its effectiveness across various SSMs, including uniform circular motion, Lorenz attractor, reentry vehicle tracking, and localization using the UZH-FPV dataset [32]. The results show MAMLKalmanNet can achieve performance comparable to, or even superior to, KalmanNet, while requiring significantly less labeled data. 

The rest structure of this paper is organized as follows: Section II provides an overview of the SSM and associated preliminaries, as well as the problem statement. Section III gives the proposed MAML-KalmanNet approach in detail. Section IV presents the simulation results, and Section V concludes this paper. 

In this paper, vectors are indicated by boldface lower-case letters, and matrices are represented by boldface upper-case letters. The transpose operation, _ℓ_ 2 norm, and gradient operator are denoted by ( _·_ )[T] , _∥· ∥_ 2, and _∇_ ( _·_ ), respectively. NNPs are symbolized by boldface lowercase _**θ**_ . The _m_ -dimensional identity matrix is denoted as **I** _m_ . The notation _N_ ( _**μ** ,_ **Σ** ) represents a Gaussian distribution with mean _**μ**_ and covariance **Σ** . Finally, R and Z[+] denote the sets of real and non-negative integer numbers, respectively. 

Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 12:51:45 UTC from IEEE Xplore.  Restrictions apply. 

IEEE TRANSACTIONS ON SIGNAL PROCESSING, VOL. 73, 2025 

990 

## II. SYSTEM MODEL AND PRELIMINARIES 

In this section, the system model and relevant preliminaries are presented. Subsection II-A begins with an introduction to the SSM, followed by a discussion on the state estimation problem in Subsection II-B. A brief review of the model-based EKF [15], KalmanNet [2], and MAML [30] are introduced in Subsections II-C, II-D, and II-E, respectively. 

## _A. State-Space Model_ 

We consider a dynamic system characterized by a (possibly) nonlinear SSM at discrete time _t ∈_ Z[+] . Define an _m_ -dimensional latent state vector at discrete time _t_ as **x** _t_ and its corresponding _n_ -dimensional measurement as **y** _t_ . The relationships between the latent state vector **x** _t_ , previous state vector **x** _t−_ 1, and available measurement vector can be described as 

**==> picture [207 x 26] intentionally omitted <==**

where **f** ( _·_ ) and **h** ( _·_ ) are the state-evolution and measurement functions, respectively, with additive process noise **e** _t ∼ N_ ( **0** _,_ **Q** ) and measurement noise **w** _t ∼N_ ( **0** _,_ **R** ), which are mutually independent. For a special case where the stateevolution and measurement functions are linear and represented by matrices **F** and **H** , the above SSM is rewritten as 

**==> picture [163 x 25] intentionally omitted <==**

## _B. Problem Statement_ 

The essence of filtering lies in the real-time monitoring of hidden states using noisy measurements obtained from various sensors up to current time _t_ . For instance, the three-dimensional coordinates of an aircraft in a Cartesian coordinate system can be estimated based on current measurements [33], [34], such as linear acceleration and angular velocity measured by sensors like gyroscopes. 

For model-based methods, although they have multiple advantages including low complexity, high accuracy, and realtime implementation, their performance is closely related to the accuracy of the SSMs. However, accurately estimating the noise statistics **Q** and **R** is challenging due to modeling errors, discretization inaccuracies, external disturbances, and inherent randomness, leading to a degradation in filtering performance. 

NNA approaches are capable of performing real-time prediction for partially unknown SSMs, provided that the NNPs training has been completed off-line prior to deployment. However, the training procedure encounters several challenges. Creating a dataset presents a significant challenge in collecting a large volume of potential states and aligning them with current measurement values. Moreover, any changes in the SSMs can degrade the filtering performance of the initially trained NNPs. In this paper, such changes primarily relate to variations in noise statistics or factors such as modeling errors, which can be viewed as changes in noise. 

This work focuses on scenarios where partially unknown SSMs significantly impact the performance of model-based filters, and where the unavailability of sufficient labeled data and inflexible architectures hinder the implementation of NNA Kalman filters. More specifically, we assume: 

- The noise statistics **Q** and **R** are unknown, while the functions **f** ( _·_ ) and **h** ( _·_ ), or their rough approximations, are accessible. 

- Sufficient labeled data for supervised learning are lacking, yet filtering tasks require accuracy comparable to that of fully trained supervised models. 

- The SSM information is sensitive to environmental changes, which in this paper are modeled as variations in noise levels, including the increased process noise resulting from modeling errors. 

Although sufficient labeled data are lacking, a limited amount of labeled data can be obtained through high-precision sensors within a short period, facilitating adaptation to changes in the system model. This data consist of _N_ trajectories of paired states and measurements, i.e., 

**==> picture [175 x 15] intentionally omitted <==**

where **x**[(] 1: _[n] T_[)][and] **[y]** 1:[(] _[n] T_[)][are][the][state-measurement][pairs][of] _[n]_[th] trajectory and _T_ denotes the trajectory length. 

## _C. Preliminaries: EKF_ 

The EKF [15] is a widely used tool for nonlinear state estimation. It executes recursively two primary steps: i) _predict_ and ii) _update_ . 

_Predict_ : The EKF first computes the prior information ( **ˆx** _t|t−_ 1 and **P** _t|t−_ 1) at current time _t_ based on the posteriori estimates of the previous step ( **ˆx** _t−_ 1 _|t−_ 1 and **P** _t−_ 1 _|t−_ 1) via 

**==> picture [197 x 28] intentionally omitted <==**

evaluatedwhere **F**[ˆ] _t_ =at the _∂[∂]_ **x[f]** ��current **x** =ˆ **x** _t|t_[is] state estimate[the][Jacobian] **x** ˆ[matrix] _t|t_ .[of][function] **[f]**[(] _[·]_[)] 

_Update_ : In the update step, the EKF generates the posterior estimates at current time _t_ using the measurement **y** _t_ and the prior information computed by (6) and (7), i.e., 

**==> picture [193 x 12] intentionally omitted <==**

**==> picture [195 x 13] intentionally omitted <==**

where **y** ˆ _t|t−_ 1 = **h** (ˆ **x** _t|t−_ 1) represents the predicted measurement at current time _t_ , with **S** _t_ and **K** _t_ being given by 

**==> picture [175 x 14] intentionally omitted <==**

**==> picture [178 x 14] intentionally omitted <==**

in which **H**[ˆ] _t_ = _[∂] ∂_ **[h] x** �� **x** =ˆ **x** _t|t−_ 1[is][the][instantaneous][linearization] ˆ of **h** ( _·_ ) obtained by evaluating the Jacobian matrix at **x** _t|t−_ 1. 

Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 12:51:45 UTC from IEEE Xplore.  Restrictions apply. 

CHEN et al.: MAML-KALMANNET: A NEURAL NETWORK-ASSISTED KALMAN FILTER 

991 

## _D. Preliminaries: KalmanNet_ 

The accuracy of SSMs impacts the performance of the model-based Kalman filters significantly. In scenarios where noise distributions are unknown, we can only use approximated methods to estimate the noise statistics [35], [36]. This limitation can significantly impact the accuracy of state estimation. To address this issue, KalmanNet [2] has been proposed as an NNA approach that combines the strengths of neural network and EKF. This method replaces the computation of the Kalman gain with a neural network model that incorporates a gated recurrent unit (GRU) [37]. In KalmanNet, the GRU-based architecture can implicitly learn the noise statistics from the input features. This allows it to capture the essential information required to Δ evaluate the Kalman gain. For example, we choose Δ **y** _t_ = **y** _t −_ **y** ˆ _t|t−_ 1 and Δ˜ **x** _t_ = ˆΔ **x** _t|t −_ **x** ˆ _t−_ 1 _|t−_ 1 as the input features. Letting _f_ _**θ**_ ( _·_ ) represent the mapping from the input features to the Kalman gain with NNPs _**θ**_ , KalmanNet estimates the Kalman gain by 

**==> picture [176 x 10] intentionally omitted <==**

Due to the characteristics of KalmanNet, there is no need to compute any second-order information of the latent state, allowing the _predict_ and _update_ steps of the EKF to be replaced by 

**==> picture [207 x 12] intentionally omitted <==**

where **ˆx** _t|t−_ 1 can be obtained from (6). The NNPs _**θ**_ in the dedicated architecture are trained by optimizing the squareerror loss function in a supervised fashion. 

During the training phase, the mean-squared error (MSE) loss is used to measure the error between the true states **x** _t_ and their estimated states **ˆx** _t|t_ computed by (13), i.e., 

**==> picture [173 x 16] intentionally omitted <==**

The gradient of the MSE loss with respect to _**θ**_ is then propagated through the entire EKF framework. This process optimizes the calculation of the Kalman gain, resulting in state estimates that closely align with the data, as assessed by the MSE loss. 

Therefore, KalmanNet can implicitly learn noise statistics from data. However, scarce labeled data and inflexible neural network architecture constrain its application scenarios. This motivates the development of the proposed MAML-KalmanNet in this paper. Before introducing the proposed algorithm, it is essential discuss MAML. 

## _E. Preliminaries: MAML_ 

MAML, a meta-learning framework for few-shot learning, excels in achieving state-of-the-art results across various tasks, including few-shot regression, classification, and reinforcement learning tasks [30]. Unlike traditional machine learning focusing on specific tasks, MAML aims to find a set of initialization parameters of network that can be quickly adapted to various tasks using limited data and few training rounds. 

Specifically, the base model is defined as a parameterized function _f_ _**θ**_ with parameters _**θ**_ . In this paper, the parameters _**θ**_ refer to KalmanNet’s NNPs. The goal of MAML is to learn initial parameters _**θ**_ = _**θ**_ 0 from a series of similar tasks _T_ , enabling the network to achieve desirable performance on new tasks with limited data and fewer training rounds comparable to traditional neural networks trained on large datasets. The learning process in MAML consists of two steps: i) _inner-loop update process_ and ii) _outer-loop update process_ . 

_Inner-loop update process_ : During the _i_ th inner loop, a batch of tasks _Ti ∼T_ is first sampled, and the base model parameters _**θ**_ are then distributed across these tasks. For each task _τb ∼Ti_ , its dataset is divided into a support set _Sτb_ and a query set _Qτb_ . The support set is primarily used to update the NNPs for the tasks, while the query set is used to compute the loss or gradient information for updating the base model. The model parameters are updated locally for each task using its respective support set. Specifically, starting from the parameters _**θ**_ of base model, the parameters are updated for each task _τb_ by performing gradient descent on the loss _LSτb_ ( _f_ _**θ**_ ) calculated over the support sets _Sτb_ : 

**==> picture [178 x 15] intentionally omitted <==**

where _α_ denotes the learning rate for the inner loop. Each task _τb_ typically needs a small number _K_ of gradient descent steps on its support set _Sτb_ to obtain _**θ**[K] τb_[.] 

_Outer-loop update process_ : In the outer loop, the base model parameters _**θ**_ are updated based on the loss across all sampled tasks’ query sets. The goal of the outer loop is to enhance the model’s generalization ability across multiple tasks. The parameters _**θ**_ in the outer loop are updated by taking the average of meta-gradient updates across all tasks, i.e., 

**==> picture [187 x 30] intentionally omitted <==**

where _β_ is the learning rate for the outer loop, _B_ represents the task batch size, and _LQτb_ ( _f_ _**θ** Kτb_[)][denotes][the][loss][on][the][query] set _Qτb_ for task _τb_ . 

## III. MAML-KALMANNET 

In this section, we present the proposed MAML-KalmanNet, designed to handle partially unknown SSMs, limited labeled data, and inflexibility of NNA Kalman filters. The introduction to MAML-KalmanNet begins with an explanation of the training method in Subsection III-A. Subsection III-B describes the high-level architecture of MAML-KalmanNet. The process of establishing the AAL data is outlined in Subsection III-C. Subsection III-D gives the details of pre-training procedure in the proposed algorithm. Finally, a discussion is provided in Subsection III-E. 

## _A. Training Method_ 

In terms of training methods, semi-supervised learning [38], [39] offers a balance between unsupervised and supervised 

Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 12:51:45 UTC from IEEE Xplore.  Restrictions apply. 

IEEE TRANSACTIONS ON SIGNAL PROCESSING, VOL. 73, 2025 

992 

**==> picture [207 x 182] intentionally omitted <==**

Fig. 1. Structure of the proposed semi-supervised KalmanNet. 

learning, providing effective training while reducing the reliance on extensive labeled data. Among the various semisupervised learning methods, the most common and accessible approach involves pre-training with unlabeled data followed by fine-tuning with labeled data. This straightforward and effective method combines the strengths of both unsupervised and supervised learning. 

Therefore, semi-supervised learning methods can be directly applied to NNA Kalman filters to address the scarcity of labeled data, given sufficient measurement data. According to the fact that KalmanNet and unsupervised KalmanNet share the same network architecture, we propose a new semi-supervised KalmanNet architecture, as depicted in Fig. 1. Unlike the semisupervised architecture in [3] which pre-trains NNPs using labeled data collected from a different environment and then fine-tunes them in an unsupervised online manner, the proposed architecture reverses this process. It first pre-trains NNPs using measurements in an unsupervised manner and subsequently fine-tunes them with limited state-measurement pairs collected from the current environment through supervised learning. It is important to note that all neural network architectures in Fig. 1 should have the same structure. However, this approach does not fully utilize the information from the SSM (e.g., functions **f** ( _·_ ) and **h** ( _·_ )). In contrast, MAML-KalmanNet, building upon the semi-supervised KalmanNet framework, effectively leverages information from the SSM. This results in improved performance compared to directly applying semi-supervised methods to NNA Kalman filters and addresses their limitations in terms of adaptability. 

## _B. High-Level Architecture_ 

Most NNA Kalman filters operate on the principle of using neural network methods to compute certain intermediate values in the EKF process, without considering further leveraging the available current system information. Therefore, we design MAML-KalmanNet to intelligently leverage the information provided by the SSM for optimization of the neural network 

**==> picture [203 x 182] intentionally omitted <==**

Fig. 2. Structure of MAML-KalmanNet. 

training method. Specifically, considering the fast convergence and simplicity of KalmanNet [2], it is adopted as the foundational framework for implementing and integrating the newly proposed architecture, as illustrated in Fig. 2. 

Similar to the architecture illustrated in Fig. 1, MAMLKalmanNet trains NNPs in two steps: _offline pre-training_ and _online fine-tuning_ . 

1) _Offline pre-training step:_ Different from the pre-training approach in semi-supervised KalmanNet that leverages abundant unlabeled data (measurements) to train NNPs in an unsupervised manner, MAML-KalmanNet adopts a novel strategy for pre-training the NNPs. Specifically, AAL data are used to replace measurements, enabling supervised training of the NNPs. This approach ensures that the training process benefits from the explicit guidance of labeled data, improving the accuracy of pre-training model and reducing the ambiguity associated with unlabeled data. Furthermore, to enhance the generalization capabilities of the pre-trained NNPs, the MAML [30] framework is adopted as our pre-training strategy. The core principle of MAML is to train the model across multiple tasks, which manifests in this context as the same SSM with different noise covariances. This enables the model to quickly adapt to new tasks and improve its performance in new environments. However, it is impractical to directly apply MAML which is mainly used in image recognition to the proposed structure. Therefore, further improvements to MAML are required to make it more suitable for state prediction problems. A detailed description regarding the improved MAML can be found in Section III-D. 

2) _Online fine-tuning step:_ This step is similar to the semisupervised KalmanNet. Nevertheless, MAML-KalmanNet is not only capable of fine-tuning with a small amount of labeled data, but it can also leverage unlabeled data in scenarios where labeled data are unavailable. This advantage stems from the fact that KalmanNet and unsupervised KalmanNet have the same network architecture. Additionally, the training performance may vary. During initial fine-tuning with labeled data, semi-supervised KalmanNet may exhibit good performance and converge quickly in some linear tasks due to the unlabeled data 

Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 12:51:45 UTC from IEEE Xplore.  Restrictions apply. 

CHEN et al.: MAML-KALMANNET: A NEURAL NETWORK-ASSISTED KALMAN FILTER 

993 

used during pre-training. However, it may become trapped in a local optimum when labeled data are limited. In contrast, MAML-KalmanNet demonstrates faster convergence rate and better overall performance than semi-supervised KalmanNet, once the optimized NNPs are obtained. 

However, the aforementioned introduction to the flow of MAML-KalmanNet for obtaining initial parameters raises two important questions: 

1) How can we use the known state-evolution function **f** ( _·_ ) and measurement function **h** ( _·_ ) to generate AAL data? 

2) How can we pre-train the network to obtain a set of initialization parameters? 

In the following, we will address the resolution of these two questions. 

## _C. AAL Data Generating_ 

Compared to the proposed semi-supervised KalmanNet, one of the main advantages of MAML-KalmanNet is the use of AAL data to train NNPs in a supervised manner during the pre-training phase. This approach adeptly overcomes the inherent instability associated with the outcomes of unsupervised learning in semi-supervised KalmanNet, while simultaneously streamlining the computational procedures of the entire algorithm. To implement such computations in a supervised fashion, we creatively reutilize the state-evolution function **f** ( _·_ ) and the measurement function **h** ( _·_ ) in SSM to artificially generate labeled data. 

Since neural networks excel at identifying intricate relationships within datasets during the learning process [40], especially in this context of translating input data to Kalman gain, the learning mechanism operates independently of the data’s origin. This autonomy allows us to establish initial values **x** 0 without compromising the neural network’s ability to uncover underlying data connections. Upon determining a suitable initial value, the subsequent step is to select the statistical properties of noise. This paper focuses on Gaussian noise with varying amplitudes. Future studies will explore the selection of noise data that encompasses a variety of types. By varying the values of _q_ 2 and _r_ 2, chosen from a set Υ, we construct a diverse set of covariance matrices **Q** = _q_ 2 _·_ **I** _m_ and **R** = _r_ 2 _·_ **I** _n_ throughout the numerical study to reflect the characteristics of process noise and measurement noise, unless stated otherwise. The difference between process and measurement noise is the key factor influencing the Kalman gain. Therefore, we assume that the difference among tasks is characterized by the ratio of _q_ 2 to _r_ 2. Specifically, the tasks generated by the AAL data can be estimated as 

**==> picture [241 x 25] intentionally omitted <==**

where _P_ and _P[′]_ denote the complete set of different tasks and the set of already selected elements, respectively. Set Υ in this paper is defined as 

**==> picture [246 x 23] intentionally omitted <==**

where _ω_ represents the elements of Υ, and _ϕ, φ ∈_ Z[+] denote the lower and upper bounds for the exponent _v_ , respectively. 

Finally, any desired amount of AAL data can be iteratively generated by employing predefined starting values **x** 0, along with noise statistics **Q** and **R** , and integrating functions **f** ( _·_ ) and **h** ( _·_ ) in the current SSM. 

## _D. Pre-Training Procedure_ 

This subsection focuses on how to obtain a set of initialization parameters _**θ**_ 0. Properly initialized NNPs not only facilitate fast convergence on specific tasks but also ensure effective training across various tasks with minimal labeled data and limited training rounds. To this end, the MAML approach is adopted. Its efficiency, versatility, and scalability enable the proposed algorithm to excel in state estimation and adapt effectively to changing SSM conditions. 

The MAML framework is especially effective when tasks share underlying similarities. Recognizing the specialized nature of the neural network, we propose that variations in noise levels can be conceptualized as a set of analogous yet distinct tasks. These tasks are defined by adjusting the parameters _q_ 2 and _r_ 2 as described in Subsection III-C. Therefore, this paper aims to leverage MAML to learn task-specific initialization parameters for different noise conditions, thereby enhancing the model’s generalization ability. 

After gathering a sufficient number of similar tasks that constitute the total training tasks _T_ , using MAML to train initialization parameters presents several challenges, primarily including the following two aspects. On one hand, as noted in MAML++ [31], MAML encounters challenges such as training instability due to its reliance on query set gradients computed solely from the final parameters _**θ**[K] τb_[of][the] _[inner-loop]_[update,] as well as the high computational cost associated with secondorder gradients. On the other hand, although MAML++ offers solutions to these problems, both MAML and MAML++ are primarily designed for image recognition tasks which differ from the state estimation task explored in this paper. Hence, the following two methods are proposed to address these challenges. 

_Gradient Instability → Multi-Step Gradient Optimization (MSG)_ : MAML aims to minimize the query set loss calculated by the updated base network which completes all _K_ gradient descent steps on a support set task. MAML++ refines this by minimizing the cumulative query set loss calculated by the base network after each gradient descent step, thereby stabilizing the training process. However, since our AAL data are generated through the random fluctuation of noise levels, and with the aim of enabling the NNPs trained to converge quickly on tasks involving diverse noise magnitudes, this has led to significant discrepancies between different tasks within a single epoch of MAML. Therefore, during the external gradient computation step, the weights of base network are susceptible to being influenced by tasks with significant discrepancies between process and measurement noises, potentially neglecting the contributions of other tasks. To this end, the multi-step loss optimization method from MAML++ has been refined to cater to the scenarios discussed in this paper. Specifically, the proposal involves the gradient information for the _outer-loop update process_ being a weighted sum of query set gradients calculated by 

Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 12:51:45 UTC from IEEE Xplore.  Restrictions apply. 

IEEE TRANSACTIONS ON SIGNAL PROCESSING, VOL. 73, 2025 

994 

the parameters _**θ**[k] τb_[(] _[k]_[ = 1] _[,]_[ 2] _[, . . . , K]_[)][on][the][query][sets.][More] formally, for an epoch of MAML-KalmanNet training, a task batch of _Ti_ containing _B_ different tasks is first sampled from the overall training tasks _T_ . Then, we compute the MSE loss of task _τb ∼Ti_ with respect to the base model parameters _**θ**_ based on the support set, i.e., 

**==> picture [238 x 30] intentionally omitted <==**

where _λ >_ 0 represents the regularization coefficient, **ˆx**[(] _t|[r] t_[)][is the] posterior mean of trajectory _r_ at time step _t_ , computed using (13), and _R_ is the _inner-loop_ batch size. The gradient of the MSE loss is thus used to update _inner-loop_ parameters _**θ**_ , i.e., 

**==> picture [179 x 14] intentionally omitted <==**

After obtaining the new model weights _**θ**_[1] _τb_[,][the][query][set] gradient _Gτ_[1] _b_[corresponding][to][task] _[τ][b]_[is][computed][and][saved] for _outer-loop_ updates by 

**==> picture [171 x 16] intentionally omitted <==**

We repeat the executions of (19), (20), and (21) _K_ = 4 times to acquire all the gradient information _Gτb_ of task _τb_ by 

**==> picture [198 x 30] intentionally omitted <==**

**==> picture [199 x 31] intentionally omitted <==**

where _wτ[k] b_[denotes the adaptive weight for the query set gradient] at step _k_ of task _τb_ , _q_ 2 _,τb_ and _r_ 2 _,τb_ represent the values used in generating AAL data for task _τb_ , and _p[k]_ represents the fixed weight at step _k_ within the _inner-loop_ for all the tasks. As _k_ increases, _p[k]_ decreases since model parameters start to overfit the support set, resulting in less useful gradient information in subsequent training rounds. 

Finally, we compute the gradient for all tasks in a task batch _Ti_ , and update the _outer-loop_ base model weights by 

**==> picture [173 x 30] intentionally omitted <==**

_Remark_ : Using the proposed _MSG_ , the gradient propagation is enhanced, resulting in the base model weights receiving weighted gradients from each step in the _inner-loop_ . Specifically, the main difference between our proposed _MSG_ and _Multi-Step loss Optimization_ in MAML++ lies in the sequence of gradient computation and accumulation. Our method computes the gradient for each step within every task independently and then accumulates these values with weighting, preserving the unique characteristics of each task and preventing excessive influence from any single task. In contrast, MAML++ calculates the total loss after considering all tasks and updates the gradient based on this aggregated loss. Therefore, although MAML++ may facilitate quicker adaptation to overall tasks, it remains vulnerable to the of outliers or noise from 

specific tasks. Additionally, the proposed _MSG_ effectively eliminates unusual gradient information from any task or update step, thereby preventing issues such as gradient explosion or vanishing. 

_Second-Order Gradients Cost → Compromise-Order Cost_ : Since computing second-order gradients for base network updates (16) in the _outer-loop_ is computationally expensive, MAML substitutes this process with a first-order approximation. With the introduction of _MSG_ , a single _outer-loop_ update (24) requires calculating second-order gradients _BK_ times, leading to a catastrophic increase in computational complexity. Therefore, to reduce computational complexity while ensuring the training efficiency, a compromise-order scheme is proposed. Specifically, _MSG_ with the first-order approximation is used for the first half of the training epochs, followed by a transition to the standard MAML update method where either the first-order approximation or the second-order gradient is selected for the remainder of the training based on the complexity of the SSM. Notably, the second phase of all simulations in this study utilizes the first-order approximation for simplicity. This approach not only alleviates the computational burden by reducing the number of steps that require intensive gradient calculations, but also stabilizes gradient updates through the use of the first-order approximation in _MSG_ . Furthermore, it can flexibly enhance the adaptability of the neural network across different tasks or improve training efficiency by modifying the gradient computation method used in the second training phase. The complete pretraining algorithm used in this paper is detailed in Algorithm 1. 

## _E. Discussions_ 

The newly designed MAML-KalmanNet aims to tackle the variations in noise statistics, limited information in SSMs, and paucity of labeled data. This innovative framework not only leverages the neural network architecture of KalmanNet to address unknown noise challenges in model-based filters, but also outperforms KalmanNet in terms of data requirements and adaptability to variations in SSMs. By scrutinizing the distinctive features of the neural network architecture of KalmanNet and recognizing the shared attributes with sequential prediction tasks, MAML-KalmanNet applies MAML to identify the common threads across various tasks, especially those characterized by different Gaussian noise levels within the same SSM. This enables MAML-KalmanNet to generate a set of advantageous initial NNPs for improving learning efficiency across these different noise scenarios. These pre-trained initialization NNPs empower MAML-KalmanNet to specifically tailor the network to individual tasks through fine-tuning with limited data. It is worth noting that MAML-KalmanNet cannot aim to cover all possible task scenarios during the pre-training phase, but instead focuses on learning the common characteristics across different tasks to obtain a set of initial NNPs that can be quickly fine-tuned for all seen and unseen tasks. In the simulation setup, we aim to showcase MAML-KalmanNet’s ability to quickly adapt to changes in SSMs with limited training data and training rounds. Each simulation utilizes only 25 real trajectories, which may vary in length from the AAL data, along with 16 training 

Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 12:51:45 UTC from IEEE Xplore.  Restrictions apply. 

995 

CHEN et al.: MAML-KALMANNET: A NEURAL NETWORK-ASSISTED KALMAN FILTER 

## **Algorithm 1** MAML-KalmanNet for Pre-training 

**Require** : **f** ( _·_ ), **h** ( _·_ ): SSM **Require** : _P_ : Task set **Require** : _α, β_ : Step size for pre-training 1: **while** not done **do** 2: Randomly select ( _q_ 2 _, r_ 2) _∈P_ and initialize **x** 0 3: Iteratively generate AAL data for tasks _T_ using **f** ( _·_ ) and **h** ( _·_ ) 4: **end while** 5: Randomly initialize _**θ**_ 6: **for** _i_ = 1 _,_ 2 _, . . . ,_ half epochs **do** 7: Sample a batch of tasks _Ti ∼T_ 8: **for** each task _τb ∈Ti_ **do** 9: **for** _k_ = 1 _,_ 2 _, . . . , K_ **do** 10: Compute query set gradient for step _k_ using (19), (20), and (21): _Gτ[k] b_ 11: **end for** 12: Compute weighted query set gradient for task _τb_ using (22): _Gτb_ 13: **end for** _B_ 14: Update _**θ** ←_ _**θ** − β_ � _Gτb∼Ti b_ =1 15: **end for** 16: **for** _i_ = half epochs, _. . . ,_ epochs **do** 17: Sample a batch of tasks _Ti ∼T_ 18: **for** each task _τb ∼Ti_ **do** 19: Compute query set loss of task _b_ after final step of _inner-loop_ update: _LQτb ∼Ti_ ( _f_ _**θ** Kτb_[)] 20: **end for** _B_ 21: Update _**θ** ←_ _**θ** − β∇_ _**θ** b_ �=1 _LQτb ∼Ti_ ( _f_ _**θ** Kτb_[)] 22: **end for** 

## **Algorithm 2** MAML-KalmanNet for fine-tuning 

|**Require**: **_θ_**: Initial NNPs (from Algorithm 1)|
|---|
|**Require**: _γ_: Step size for fne-tuning|
|**Require**: _D_: Dataset with 25 trajectories|
|1: Load initial NNPs:**_θ_**|
|2: **for** _i_= 1_,_2_, . . . ,_ 16 **do**|
|3:<br>Sample a batch of trajectories from_D_<br>4:<br>Update **_θ_**_i ←_**_θ_**_i−_1 _−γ∇_**_θ_**_i−_1_L_(_f_**_θ_**_i−_1)<br>5: **end for**|



rounds to fine-tune MAML-KalmanNet. Specifically, the finetuning process is detailed in Algorithm 2, where _**θ**[i]_ represents the parameters after the _i_ th gradient descent step, and _L_ ( _f_ _**θ** i−_ 1 ) denotes the loss computed using the parameters _**θ**[i][−]_[1] . 

Unlike the semi-supervised approach in KalmanNet that also relies on pre-training and fine-tuning but only adjusts NNPs for specific tasks with limited data, the pre-trained NNPs of MAML-KalmanNet are versatile and suitable for all tasks within the same SSMs but with different noise statistics. Theoretically, for a SSM affected by Gaussian noise, it is sufficient 

for MAML-KalmanNet to pre-train the model only once to handle all instances of noise under that model due to the versatility and scalability of MAML. Although the training procedure of the proposed algorithm is more complex and computationally intensive than that of KalmanNet or semi-supervised KalmanNet, MAML-KalmanNet proves to be more practical and economical in the long run. In addition, the real-time deployment in NNA filters like KalmanNet [2] often ignores environmental changes, assuming consistency between data collection and prediction phases. However, prolonged data acquisition and training may lead to environmental shifts, causing prediction errors. MAML-KalmanNet addresses this by timely fine-tuning the network before major changes, allowing real-time predictions with minimal on-site labeled data and rapid adaptation to current conditions. Although NNA filters such as AKNet [10] and A-KIT [28] can adapt to model changes without retraining, this capability comes at the expense of requiring extensive training data and additional prior information beyond the functions **f** ( _·_ ) and **h** ( _·_ ). For instance, AKNet requires datasets that encompass all potential noise scenarios, as well as the knowledge of the relationship between process and measurement noises across different conditions. Similarly, A-KIT relies on extensive labeled data for training, along with the measurement noise and initial value of process noise covariance **Q** . In contrast, MAMLKalmanNet requires fine-tuning for model changes but demands significantly less data than AKNet and A-KIT, and it does not depend on additional prior information. As shown in Table II, its fine-tuning process is fast enough to be considered negligible. 

Furthermore, the training procedure of KalmanNet requires a large amount of labeled data, which is costly and sometimes unfeasible. Although semi-supervised KalmanNet can use measurement data to pre-train the network model, which significantly reduces the demand for labeled data, it also introduces the hassle of collecting measurement data. In contrast, MAMLKalmanNet alleviates the need for data collection by employing pre-training the network with AAL data. In the context of AAL data creation, a diverse range of tasks that share similarities but exhibit unique characteristics under different Gaussian distributions can be effectively produced through the modification of parameters _q_ 2 and _r_ 2. The methodology used for generating AAL data eliminates the need for collecting authentic data in the pre-training stage, while simultaneously addressing the limitation of meta-learning, which typically requires large volumes of data from diverse tasks with similar characteristics. Meanwhile, to stabilize the training procedure of MAML and improve training efficiency, we have refined the methods outlined in MAML++, adapting them to more effectively address the state estimation problem. 

Applying the MAML concept to KalmanNet presents a novel and comprehensive approach to state estimation in NNA filters. This approach allows us to develop existing methods through AAL data generation and meta-learning techniques, effectively overcoming the inherent drawbacks in neural networks. For instance, AKNet [10] and A-KIT [28] can leverage AAL data generation to alleviate the requirement for large and diverse datasets. While our current focus is exclusively on Gaussian noise, real-world applications frequently involve a variety of 

Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 12:51:45 UTC from IEEE Xplore.  Restrictions apply. 

IEEE TRANSACTIONS ON SIGNAL PROCESSING, VOL. 73, 2025 

996 

other noise types, including heavy-tailed noise, Laplace noise, and scenarios where multiple noise sources coexist [41], [42], [43]. Extending MAML-KalmanNet to handle these diverse noise types is essential for transitioning from theoretical concepts to practical applications in real-world scenarios. Future work will focus on adapting the model to accommodate these various noise scenarios, ensuring its robust performance in state estimation across a wide range of practical environments. 

TABLE I 

SIMULATION SETTINGS: _ϕ, φ_ OF Υ, NUMBER OF TASKS AND TRAJECTORY LENGTH OF AAL DATA 

||Simulations<br>IV-A<br>IV-B|_ϕ_<br>0<br>1|_φ_<br>4<br>5|Task|Number<br>63<br>49|_T AAL_<br>_train_<br>30<br>30|
|---|---|---|---|---|---|---|
||IV-C|2|7||63|50|
||IV-D|1|5||49|100|



## IV. SIMULATIONS 

In this section, we conduct thorough numerical analysis of the proposed MAML-KalmanNet[1] to evaluate its performance for comprehensive comparison with various benchmark algorithms, such as the model-based KF [14] and EKF [15] that is known to minimize the MSE in SSMs. Given that MAMLKalmanNet originates from semi-supervised learning, a comparison with unsupervised, semi-supervised, and supervised methods is necessary. To this end, KalmanNet [2] serves as the benchmark for supervised learning. For semi-supervised learning, we use the proposed semi-supervised KalmanNet detailed in III-A. Additionally, DANSE [9] and the unsupervised KalmanNet [3] are included to represent unsupervised learning approaches. To further illustrate the advantages of incorporating MAML into KalmanNet, we select a pre-training algorithm [44] that also uses AAL data to obtain initial NNPs for comparison, representing an averaged initialization across all tasks. The simulations are organized as below: 

- a) The first simulation, detailed in Subsection IV-A, examines the case of uniform circular motion to provide a proof-of-concept regarding performance of MAMLKalmanNet. Additionally, MAML-KalmanNet is compared to AKNet [10] to demonstrate its adaptivity to noise changes. 

- b) Subsection IV-B considers the chaotic Lorenz attractor, where the state-evolution function is nonlinear. This simulation showcases MAML-KalmanNet’s robustness to trajectory length, model mismatch, and data mismatch. 

- c) Subsection IV-C focuses on the reentry vehicle tracking, a completely nonlinear system, to demonstrate MAMLKalmanNet’s ability to handle abrupt model changes. 

d) The final study, detailed in Subsection IV-D, uses the UZH-FPV dataset [32] that assumes a linear SSM as a localization case to showcase the capability of the proposed algorithm in tracking real-world dynamics. _Ttrain_ , _Ttest_ , and _Ttrain[AAL]_[represent][the][lengths][of][training] trajectories for compared algorithms, test trajectories for all algorithms, and AAL data, respectively. _ϕ, φ_ of Υ, number of tasks, and trajectory length of AAL data for different simulations are organized as Table I. Meanwhile, the averaged MSE with [dB] scale is used as the performance measure defined as below: 

**==> picture [241 x 31] intentionally omitted <==**

> 1The source code and hyperparameter settings used in our numerical study are publicly available at https://github.com/ShanLi-2000/MAML-KalmanNet. 

Furthermore, we define _V_ = 10 log _r[q]_[2] 2[to][represent][the][re-] lationship between process noise and measurement noise. For clarity, the term _fully trained_ refers to scenarios where supervised or unsupervised algorithms use sufficient labeled or unlabeled data and adequate training rounds to train NNPs. Specifically, in the following simulations, unless stated otherwise, the fully trained KalmanNet refers to be trained on the corresponding dataset _D_ , as defined in (5), which includes _N_ = 2000 labeled trajectories with a length equal to that of the test sets trajectories. For the fully trained unsupervised algorithms, the measurement component of _D_ is provided, along with the exact measurement noise covariance **R** if required. Finally, 500 training rounds with a batch size of 64 are conducted to fully train these algorithms. Besides, the term _pretrained_ refers to the algorithms that utilize AAL data or its measurement component to initialize the NNPs. For example, the initial NNPs of pre-trained KalmanNet are obtained through training on all tasks in AAL, while those of the pre-trained DANSE are obtained by accumulating the losses for each task in AAL and then performing gradient updates. These NNPs are then fine-tuned for specific tasks, similar to the approach used by MAML-KalmanNet, i.e., with 25 task-specific trajectories and 16 training rounds. Additionally, all model-based filters in this section have access to accurate SSM information. Notably, the test sets are designed to include noise distributions that differ from those in the AAL data. Fair comparisons are achieved by running all methods using PyTorch on the same hardware equipped with an Intel Core i9-14900KF processor (3.20 GHz) and an NVIDIA GeForce RTX 4070 SUPER GPU with 12 GB of memory. 

## _A. Uniform Circular Motion (UCM)_ 

To illustrate the characteristics of rapid convergence with few labeled data in MAML-KalmanNet, we first employed a simple two-dimensional state-evolution model [4], i.e., 

**==> picture [196 x 25] intentionally omitted <==**

T 2 where **x** _t_ = � _xt yt_ � _∈_ R is the position vector in the Euclidean plane and _θ_ = 10 _[◦]_ is the constant rotation speed. 

As a measurement model, we consider both linear and nonlinear measurements as follows 

**==> picture [236 x 37] intentionally omitted <==**

Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 12:51:45 UTC from IEEE Xplore.  Restrictions apply. 

CHEN et al.: MAML-KALMANNET: A NEURAL NETWORK-ASSISTED KALMAN FILTER 

997 

**==> picture [196 x 140] intentionally omitted <==**

Fig. 3. MSE losses for UCM linear system ( _V_ = _−_ 10 dB) of different algorithms. 

In the linear case, the measurement matrix is a unit matrix, while in the nonlinear case, the distance and angle constitute the state vector **x** _t_ in the Euclidean plane. In the following, we will divide the investigation into three distinct parts to separately validate the advantages of the proposed algorithm over supervised learning, unsupervised learning, semi-supervised learning, pre-training approaches, and AKNet [10]. Here, the trajectory lengths are set as _Ttrain_ = _Ttest_ = 50. In addition, to assess the performance of all the algorithms, we evaluate them on an additional set of 15 trajectories. 

1) _Linear measurement_ : To validate the unique applicability and superior performance of MAML-KalmanNet, a linear system is first considered for comparison of the proposed algorithm with supervised learning, unsupervised learning and pretraining approaches. Notably, while both supervised and unsupervised learning methods have access to enough training data, the proposed algorithm employs a small amount of training data for fine-tuning to simulate scenarios where sufficient labeled data acquisition is challenging. To generate the training and testing data, we simulate both Eq. (26) and the linear segment of Eq. (27). 

Simulation results presented in Fig. 3 with _V_ fixed at -10 dB, show that MAML-KalmanNet, despite using significantly less training data and fewer training rounds than the fully trained algorithms, not only outperforms the unsupervised algorithms and the pre-trained algorithms, but also achieves comparable performance to the fully trained KalmanNet and closely approaches the theoretically optimal value, namely the MSE loss of KF. Additionally, both the fully trained and pretrained DANSE algorithms are less effective compared to other methods, which is expected given that DANSE requires less prior information, such as the state-evolution function **f** ( _·_ ) and process noise covariance **Q** , and updates its NNPs through unsupervised learning. 

2) _Nonlinear measurement_ : To validate the architectural choices under limited labeled data, MAML-KalmanNet is compared to the proposed semi-supervised KalmanNet discussed in III-A. Besides, unsupervised MAML-KalmanNet is considered to simulate the scenario where labeled data are lacking. Additionally, the fully trained KalmanNet is used to compare the 

**==> picture [196 x 139] intentionally omitted <==**

Fig. 4. MSE losses for UCM nonlinear system ( _q_ 2 = 0 _._ 15) compared to semi-supervised KalmanNet. 

performance of the supervised learning method to the proposed algorithm. The EKF is also used to evaluate the performance differences between model-based filter methods and neural network ones. 

The data generation approach in current simulation is similar to that of the previous one, with the key distinction being the adoption of the nonlinear measurement part of Eq. (27). To train the semi-supervised KalmanNet, the process begins with obtaining a fully trained unsupervised KalmanNet. Then, a small set of labeled data (25 corresponding trajectories) and 16 training rounds are introduced to fine-tune the NNPs for final optimization under supervised learning. Additionally, the unsupervised MAML-KalmanNet utilizes the measurement portion of the labeled data for fine-tuning. 

Simulation results shown in Fig. 4 demonstrate that MAMLKalmanNet not only surpasses the semi-supervised KalmanNet, achieving a 3 to 5 dB increase in accuracy, but also nearly matches the precision of the fully trained KalmanNet. The unsupervised MAML-KalmanNet, which only uses a small set of unlabeled data to fine-tune the NNPs, outperforms the semisupervised KalmanNet that gets trapped in a local optimum. Moreover, MAML-KalmanNet, even with limited labeled data, surprisingly surpasses KalmanNet with sufficient labeled data when _V_ = 20. This is primarily due to a limitation observed in [4]. When there is a large discrepancy between process noise and measurement noise, KalmanNet struggles to accurately determine which part of the noise significantly influences the Kalman gain, leading to a sharp decline in performance. In contrast, MAML-KalmanNet, having been pre-trained on a multitude of tasks with significantly varying noise, exhibits better adaptability and robustness in scenarios involving large differences in noise. In this scenario, the performance of modelbased EKF appears to deteriorate due to the high nonlinearity of the measured values. 

3) _Adaptive ability_ : To verify the ability of the proposed method to fast fine-tune with limited data, MAML-KalmanNet is compared to AKNet [10] which manages noise variations without requiring retraining. The pre-trained KalmanNet shown to fine-tune quickly in Fig. 3, is also included for comparison, with KF serving as the baseline. 

Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 12:51:45 UTC from IEEE Xplore.  Restrictions apply. 

IEEE TRANSACTIONS ON SIGNAL PROCESSING, VOL. 73, 2025 

998 

**==> picture [196 x 140] intentionally omitted <==**

Fig. 5. MSE losses for UCM nonlinear system ( _q_ 2 = 0 _._ 15) compared to AKNet. 

**==> picture [196 x 131] intentionally omitted <==**

KalmanNet starts from a better initial position, it often suffers from local optima due to limited training data. In contrast, MAML-KalmanNet achieves faster convergence and superior filtering accuracy, highlighting the advantages of MAML in the MAML-KalmanNet framework. 

## _B. Lorenz Attractor_ 

To evaluate the proposed algorithm’s performance on chaotic and nonlinear dynamic systems, the Lorenz attractor SSM is employed. This model simulates chaotic particle motion sampled at discrete time intervals, as described in [45]. The noisefree state-evolution function is derived from the following differential equation in continuous time _τ_ : 

**==> picture [241 x 43] intentionally omitted <==**

where **x** _τ_ describes the continuous-time process. 

To transform the model into a discrete-time state-evolution form, we follow the steps in [46]. First, the noiseless process is sampled with an interval of Δ _τ_ and the matrix is assumed to be constant in a small vicinity of **x** _τ_ : 

**==> picture [170 x 11] intentionally omitted <==**

The continuous-time solution to the differential system (28), valid near **x** _τ_ over a short interval Δ _τ_ , is 

**==> picture [186 x 11] intentionally omitted <==**

Fig. 6. Loss curves for UCM linear system ( _q_ 2 = 0 _._ 15) compared to pretrained KalmanNet. 

AKNet consists of two networks: KalmanNet and a hypernetwork with the input _SoW_ being used to adjust KalmanNet’s NNPs. Since **x** _t_ and **y** _t_ here have the same dimension, we have _V_ = _−SoW_ dB. Regarding the training of AKNet, it first fully trains KalmanNet on a specific task (in this simulation, the task is defined by _q_ 2 = 0 _._ 15 and _V_ = _−_ 5), then freezes KalmanNet’s NNPs and uses a dataset containing various noise scenarios to train the hypernetwork. 500 training rounds are conducted to fully train KalmanNet and the hypernetwork sequentially. Additionally, two variants of AKNet are evaluated: a fully trained AKNet and a partially trained AKNet. The fully trained model is trained on a dataset including all noise scenarios, whereas the partially trained model is limited to the first five noise types. Notably, both variants utilize accurate _SoW_ values to differentiate noise types during both training. Here, different noise scenarios are generated by varying _V_ , with _q_ 2 fixed at 0.15. 

The compared results are shown in Figs. 5 and 6. Fig. 5 shows that MAML-KalmanNet, requiring significantly less training data, fewer training rounds, and less prior information, achieves comparable performance to the fully trained AKNet and outperforms the partially trained AKNet. Furthermore, the detailed loss curves between MAML-KalmanNet and pre-trained KalmanNet shown in Fig. 6 show that although the pre-trained 

We then expand (30) using the Taylor series and approximate it with a finite series (up to _J_ terms), resulting in 

**==> picture [238 x 31] intentionally omitted <==**

Thus, the noise-free discrete-time evolution process is 

**==> picture [178 x 12] intentionally omitted <==**

For simplicity, the measurement function **h** ( _·_ ) is set to be the identity transformation, namely **H** = **I** 3. By recursively simulating Eq. (32) using a Taylor order of _J_ = 5 and a sampling interval of Δ _τ_ = 0 _._ 02 with added process noise, along with the measurement function, sufficient data can be generated. 

1) _Different trajectory lengths_ : In this simulation, the impact of varying trajectory lengths and the highly nonlinear state-evolution function on the proposed algorithm is examined. Specifically, the test trajectory length is set to _Ttest_ = 300 which differs from _Ttrain[AAL]_[= 30][used][in][the][AAL][dataset,][and] _V_ in the test set is fixed at _−_ 10 dB. Notably, the pre-trained algorithms and MAML-KalmanNet are pre-trained using the AAL dataset with a trajectory length of _Ttrain[AAL]_[= 30][,][while] other NNA algorithms are trained using datasets with trajectory lengths matching those of the respective test sets. 

Throughout the simulation results shown in Fig. 7 and Table II, we see that MAML-KalmanNet consistently demonstrates its capability to perform real-time state estimations while requiring significantly less time and training data compared 

Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 12:51:45 UTC from IEEE Xplore.  Restrictions apply. 

CHEN et al.: MAML-KALMANNET: A NEURAL NETWORK-ASSISTED KALMAN FILTER 

999 

**==> picture [196 x 140] intentionally omitted <==**

Fig. 7. MSE losses for Lorenz system ( _V_ = _−_ 10 dB) of different trajectory lengths: _Ttrain[AAL]_[= 30][,] _[T][test]_[ = 300][.] 

TABLE II 

## TABLE III 

LORENZ SYSTEM ( _V_ = _−_ 15 dB): COMPARISON OF MSE [DB] WITH MISMATCHED STATE-EVOLUTION 

||1_/q_2 [dB]||20|30|40|50|
|---|---|---|---|---|---|---|
||EKF|ˆ_μ_|-12.51|-22.59|-32.41|-42.45|
||(_J_ = 5)|ˆ_σ_|_±_0_._17|_±_0_._24|_±_0_._11|_±_0_._18|
||EKF|ˆ_μ_|-12.29|-20.86|-24.95|-26.05|
||(_J_ = 2)|ˆ_σ_|_±_0_._14|_±_0_._17|_±_0_._27|_±_0_._40|
||EKF|ˆ_μ_|-3.83|-4.22|-4.25|-4.21|
||(_J_ = 1)|ˆ_σ_|_±_0_._36|_±_0_._41|_±_0_._36|_±_0_._49|
||KalmanNet|ˆ_μ_|-13.00|-22.85|-32.06|-40.49|
||(_J_ = 2)|ˆ_σ_|_±_0_._24|_±_0_._19|_±_0_._14|_±_0_._09|
||KalmanNet|ˆ_μ_|-12.89|-21.55|-29.21|-36.95|
||(_J_ = 1)|ˆ_σ_|_±_0_._09|_±_0_._09|_±_0_._06|_±_0_._13|
||MAML-KalmanNet|ˆ_μ_|-12.50|-21.88|-30.90|-38.52|
||(_J_ = 2)|ˆ_σ_|_±_0_._15|_±_0_._27|_±_0_._20|_±_0_._34|
||MAML-KalmanNet|ˆ_μ_|-10.91|-18.62|-26.33|-31.60|
||(_J_ = 1)|ˆ_σ_|_±_0_._05|_±_0_._27|_±_0_._19|_±_1_._38|



LORENZ SYSTEM ( _V_ = _−_ 10 dB): COMPARISON OF TRAINING TIME AND TRAJECTORY REQUIREMENTS 

|Model<br>DANSE<br>KalmanNet|Requiring Trajectories<br>2000<br>2000|Training Time[sec]<br>1.58<br>271.17|
|---|---|---|
|Pre-trained KalmanNet|25|10.88|
|Pre-trained DANSE<br>MAML-KalmanNet|25<br>25|0.09<br>10.87|



to other NNA algorithms. Additionally, in scenarios involving relatively complex systems and a large discrepancy between _Ttrain[AAL]_[and] _[ T][test]_[, the pre-trained algorithms cannot achieve the] superior performance observed in the UCM system. In contrast, MAML-KalmanNet can still adapt quickly and accurately to different tasks. This emphasizes its robustness against variations in trajectory lengths and supports the result discussed in III-C that MAML-KalmanNet learns the intricate interrelationships within datasets rather than specific values. Notably, the training time of the pre-trained algorithms and MAMLKalmanNet in Table II refer to the time spent on 16 finetuning rounds. The significantly shorter runtime of DANSE and pre-trained DANSE, compared to other algorithms, is due to their omission of the state-evolution function, which would otherwise incur substantial computational costs. However, this comes at the expense of reduced performance, which is notably lower than that of the other algorithms. 

2) _Model mismatch_ : A state-evolution mismatch scenario is considered to verify the robustness of MAML-KalmanNet by changing the Taylor expansion series from _J_ = 5 to _J_ = 2 and _J_ = 1 in Eq. (31), simulating a situation where the true stateevolution model differs from the one assumed during training. Such mismatches can arise during the discretization of continuous systems, where coarse discretization can introduce inaccuracies and challenges with model adaptability. In this scenario, the mismatched MAML-KalmanNet is pre-trained with AAL data generated using the mismatched SSM, i.e. _J_ = 2 or _J_ = 1, while the fine-tuning data are generated with the matched SSM, i.e. _J_ = 5, to simulate the availability of 

limited labeled data in practice. For comparison, mismatched KalmanNet and matched/mismatched EKF are employed, with the matched EKF serving as the baseline for the lower bound of MSE. Notably, the Taylor series expansion of the stateevolution for all mismatched algorithms is set to _J_ = 2 or _J_ = 1. While the mismatched KalmanNet utilizes a mismatched SSM, it is trained on data generated by the matched SSM. Here, _V_ is fixed at -15 dB. The MSE and its standard deviation are denoted by _μ_ ˆ and ˆ _σ_ , respectively. Simulation results in Table III demonstrate that MAML-KalmanNet can achieve effective filtering even when pre-trained on mismatched AAL data. However, its performance falling short of KalmanNet at _J_ = 1 indicates its sensitivity to substantial discrepancies in the SSM, highlighting opportunities for further refinement in highly inaccurate model conditions. 

3) _Data mismatch_ : In this simulation, another practical issue is considered. The data mismatch problem arises due to the different sampling frequencies of sensors, resulting in temporally mismatched ground truth and measurement data. To simulate this scenario, the following steps are taken. First, a Lorenz model sequence of length 6,000,000 is sampled at a frequency of 2000 Hz, obtaining time-synchronized state values and measurements (state values plus random noise). Next, the first 2000 data points are removed from the original sequence, the remaining sequence is resampled at 2000 Hz, and a Gaussian noise is added to the resampled data, thereby generating measurements that are mismatched on the time axis. In this scenario, MAML-KalmanNet pre-trains with AAL data where the latent states and measurements are time-synchronized, but it fine-tunes with mismatched data. As the contrast algorithm, KalmanNet is both trained and tested with mismatched data. Additionally, data-mismatched EKF is included for comparison with model-based filters. Simulation results shown in Fig. 8 demonstrate that although MAML-KalmanNet fine-tunes with mismatched data, it retains the ability to make relatively reliable state estimates, unlike EKF and KalmanNet which fail to effectively track the latent state under such conditions. This 

Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 12:51:45 UTC from IEEE Xplore.  Restrictions apply. 

IEEE TRANSACTIONS ON SIGNAL PROCESSING, VOL. 73, 2025 

1000 

**==> picture [196 x 140] intentionally omitted <==**

Fig. 8. MSE losses for Lorenz system ( _q_ 2 = 0 _._ 15) with mismatched data. 

is mainly because MAML-KalmanNet, pre-trained with timesynchronized AAL data and fine-tuned with mismatched data, is capable of addressing this mismatch by modeling it as additional measurement noise. In contrast, KalmanNet, trained and tested on mismatched data, fails to interpret the mismatch as noise and instead treats it as part of the normal system dynamics. 

## _C. Reentry Vehicle Tracking (RVT)_ 

A nonlinear SSM for reentry vehicle tracking [47] is considered to demonstrate the robustness of MAML-KalmanNet. The SSM of RVT consists of the position ( _x_ 1 _, x_ 2), velocity ( _x_ 3 _, x_ 4), and aerodynamic coefficients ( _x_ 5) of the vehicle. The discrete-time dynamics model is defined as 

**==> picture [242 x 72] intentionally omitted <==**

where **e** _t_ = [ _et,_ 1 _, et,_ 2 _, et,_ 3 _, et,_ 4 _, et,_ 5] _[T]_ is the process noise vector with covariance **Q** = _q_ 2 _·_ diag([1 _,_ 1 _,_ 10 _,_ 10 _,_ 1]) and Δ _τ_ is the sampling interval, set to 0.1. The parameters _St_ and _Gt_ , which are related to drag and gravity, are given by: 

**==> picture [187 x 49] intentionally omitted <==**

where _Rt_ = � _x_[2] _t,_ 1[+] _[ x]_[2] _t,_ 2[is][the][distance][between][the][aircraft] and the Earth’s center, and _Vt_ = � _x_[2] _t,_ 3[+] _[ x]_[2] _t,_ 4[denotes][the][rel-] ative velocity. The parameters are set as _β_ 0 = 0 _._ 59783, _H_ 0 = 13 _._ 406, _Gm_ 0 = 3 _._ 9860 _×_ 10[5] , and _R_ 0 = 6374. 

For the measurement function, the radar position is given as ( _sx, sy_ ) = ( _R_ 0 _,_ 0), with _ρt_ , _ϕt_ , and _ξt_ being the range, azimuth 

angle, and range rate, respectively: 

**==> picture [230 x 55] intentionally omitted <==**

where **w** _t_ = [ _wt,_ 1 _, wt,_ 2 _, wt,_ 3] _[T]_ represents the measurement noise vector with covariance **R** = _r_ 2 _·_ **I** 3. 

_Abrupt model changes_ : Here, we consider a scenario where the system undergoes multiple model transitions. In this context, the initially fine-tuned NNPs of MAML-KalmanNet are only suitable for the original model while getting outdated when the system shifts to a different SSM. In such case, MAMLKalmanNet has to utilize the dataset collected within a short period to quickly adjust the NNPs. For comparison, we select the interacting multiple model (IMM) filter [48] which is capable of handling model transitions. In addition to the RVT stateevolution function described in (33), we also consider another model, defined as 

**==> picture [252 x 109] intentionally omitted <==**

where ( _x_ 6 _, x_ 7) is the vehicle acceleration, and the covariance matrix of process noise is defined as **Q** _[∗]_ = 100 _q_ 2 _·_ diag([1 _,_ 1 _,_ 10 _,_ 10 _,_ 1 _,_ 1 _,_ 1]). 

The dynamic system using (33) as its state-evolution function is referred to as the constant velocity model ( _CV-model_ ), while the constant acceleration model ( _CA-model_ ) employs (36). Both the _CV-model_ and _CA-model_ share the same nonlinear measurement function (35). As for the IMM filter, which performs a weighted sum of filtering results of _CV-model_ and _CA-model_ , its model transition probability matrix **Φ** and the prior model probability _**μ**_ 0 are set to 

**==> picture [165 x 25] intentionally omitted <==**

**==> picture [169 x 13] intentionally omitted <==**

Here, we set _q_ 2 = _−_ 58 dB and _r_ 2 = _−_ 38 dB. The length of the test trajectories is set to _Ttest_ = 400, with the first half generated by _CV-model_ and the second half by _CA-model_ , thereby simulating a scenario of abrupt model change. Notably, the AAL data used for pre-training ( _Ttrain[AAL]_[= 50][) and training data] for fine-tuning ( _Ttrain_ = 200) are only generated by _CV-model_ . Additionally, to explicitly represent the loss of each step, the MSE _t_ with [dB] scale for step _t_ is defined as 

**==> picture [233 x 31] intentionally omitted <==**

Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 12:51:45 UTC from IEEE Xplore.  Restrictions apply. 

CHEN et al.: MAML-KALMANNET: A NEURAL NETWORK-ASSISTED KALMAN FILTER 

1001 

**==> picture [196 x 131] intentionally omitted <==**

Fig. 9. Step MSE losses for RVT system compared to IMM filter. 

TABLE IV 

RVT SYSTEM: COMPARISON OF RUNTIME [SEC] AND AVERAGED MSE [DB] WITH ABRUPT MODEL CHANGES 

|Model<br>EKF-CV-model<br>EKF-CA-model<br>EKF-IMM<br>Semi-MAML-KalmanNet|MSE<br>1.42<br>-5.63<br>-6.97<br>-8.68|Runtime<br>0.70<br>0.70<br>1.91<br>0.98|Fine-Tune <br>N/A<br>N/A<br>N/A<br>1.46|Time|
|---|---|---|---|---|
|MAML-KalmanNet|-8.95|0.98|0.71||



where the number of trajectories _N_ is set to 30 to ensure the generality of the simulation. 

Since the NNPs of MAML-KalmanNet become outdated when the model transitions to _CA-model_ , it is necessary to collect a new dataset at current time for retraining NNPs. Specifically, upon detecting a model change, such as when the residual exceeds a specified threshold, we gather data for 50 steps starting from that moment and then retrain the NNPs. Meanwhile, we assume that the retraining process does not disrupt the ongoing filtering operations. Notably, the NNPs used for retraining are the initial NNPs of MAML-KalmanNet rather than the outdated NNPs previously used. 

Based on whether the collected data contains label information (i.e., latent states), the method using unlabeled data for fine-tuning is named semi-MAML-KalmanNet, while MAMLKalmanNet fine-tunes with labeled data. In both approaches, the initial training phase involves fine-tuning with labeled data. Simulation results are presented in Fig. 9 and Table IV. During the time interval _t_ from 200 to 250, the abrupt model changes cause the previously trained NNPs to become outdated, leading to a significant decline in filtering performance. However, once sufficient data are collected and the fine-tuning of the NNPs is completed, both semi-MAML-KalmanNet and MAML-KalmanNet regain their ability to track the reentry vehicle and surpass the filtering accuracy of EKF-IMM. This demonstrates the robustness of MAML-KalmanNet in handling abrupt model changes by attributing these changes to additional noise. From a runtime perspective, although MAMLKalmanNet requires additional time for fine-tuning, its overall runtime is shorter than that of EKF-IMM, which incurs extra computational overhead due to updating the model probability at each step. 

## _D. Real World Dynamics: the UZH FPV Dataset_ 

In the final simulation, we evaluate MAML-KalmanNet using the UZH-FPV drone racing dataset [32]. This dataset includes various labeled trajectories, some of which contain noisy readings and the ground truth locations of a quadrotor. The sensor data are affected not only by noises, but also by the effects of Earth’s gravitational force and the intentional control exerted on aircraft movements by humans. For simplicity, we introduce noise to the acceleration components presented in ground truth to generate the necessary measurement data instead of using the sensor readings. Here, we model the aircraft’s kinematics using the _constant acceleration_ model [49]. The state is **x** _t_ = [ **p** _,_ **v** _,_ **a** ][T] _∈_ R[9] and the measurement is **y** _t_ = **a**[T] _∈_ R[3] . Here, **p** _,_ **v** , and **a** are 3-dimensional position, velocity, and acceleration vector. Specifically, the linear SSM is 

**==> picture [217 x 150] intentionally omitted <==**

where Δ _τ_ = 0 _._ 01 is the sampling interval. We consider the session with the _6th indoor forward-facing_ . Sampling at 100 Hz results in 3020 time steps. This trajectory is split into two sections: 2/3 for training (25 sequences of length _T_ = 80) and the remaining part for testing (1 sequence, _T_ = 1020). Due to the scarcity of training sequences, traditional supervised learning methods are not feasible, and there are also insufficient measurement data in this dataset to support unsupervised learning. Thus, MAML-KalmanNet, as an innovative algorithm, demonstrates its unique advantages and application value by achieving desirable performance only with a small amount of labeled data. In this simulation, MAML-KalmanNet is compared to the KF and KalmanNet. The KF is assumed to have precise knowledge of the SSM, except for the process noise which is estimated statistically. Given the limited availability of labeled data, the training rounds for KalmanNet are restricted to 200. 

Fig. 10 illustrates that MAML-KalmanNet achieves superior performance compared to KalmanNet and KF, even when the latter is provided with nearly accurate SSM information. On the other hand, KalmanNet, trained on limited data, suffers from overfitting, resulting in poor performance. This result indirectly highlights the challenge of obtaining accurate SSM information in practical applications, which reduces the effectiveness of traditional filtering techniques such as the KF. Although supervised and unsupervised learning methods can address inaccuracies in the SSM, they are impractical in scenarios with limited data. MAML-KalmanNet successfully overcomes these issues, pioneering a new approach to learning in NNA Kalman 

Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 12:51:45 UTC from IEEE Xplore.  Restrictions apply. 

IEEE TRANSACTIONS ON SIGNAL PROCESSING, VOL. 73, 2025 

1002 

**==> picture [78 x 40] intentionally omitted <==**

**==> picture [39 x 52] intentionally omitted <==**

Fig. 10. Trajectories for UZH FPV system with data from the _6th indoor forward-facing_ sampled at 100 Hz. 

## V. CONCLUSION 

Neural network-assisted (NNA) Kalman filters excel in handling partially unknown state-space models (SSMs). However, they face challenges with dataset acquisition and inflexible neural network architectures. To address these issues, a metalearning-based NNA Kalman filter called MAML-KalmanNet is proposed in this paper. This approach combines the strength of model-agnostic meta-learning (MAML) for few-shot learning with KalmanNet. MAML-KalmanNet trains neural network parameters (NNPs) through two phases: _offline pre-training_ and _online fine-tuning_ . During the _offline pre-training_ stage, a specifically tailored MAML framework is used to obtain the initial NNPs. Meanwhile, artificially assumed labeled (AAL) data are generated by skillfully leveraging available SSM information to meet the requirement of MAML for a large amount of labeled data from diverse tasks with similar characteristics. Notably, once the initial NNPs are obtained, they can handle all tasks that share the same SSM but have different noise statistics. Additionally, they can also accommodate tasks with different SSMs, where the differences between SSMs can be modeled as additional noise during the _online fine-tuning_ stage. Simulation results demonstrate that our proposed algorithm not only converges rapidly under few-shot conditions but also approaches, and in certain instances surpasses, the performance of supervised learning algorithms with sufficient data and training rounds. MAML-KalmanNet demonstrates robustness to SSM mismatches such as state-evolution discrepancies. However, the effectiveness of MAML-KalmanNet in handling SSM mismatches is limited when faced with severe discrepancies. In such cases, the AAL data may diverge significantly from real-world scenarios, leading to a loss of generality in the initial NNPs. 

## REFERENCES 

- [1] N. Shlezinger, J. Whang, Y. C. Eldar, and A. G. Dimakis, “Model-based deep learning,” _Proc. IEEE_ , vol. 111, no. 5, pp. 465–499, May 2023. 

- [2] G. Revach, N. Shlezinger, X. Ni, A. L. Escoriza, R. J. Van Sloun, and Y. C. Eldar, “KalmanNet: Neural network aided Kalman filtering for partially known dynamics,” _IEEE Trans. Signal Process._ , vol. 70, pp. 1532–1547, 2022. 

- [3] G. Revach, N. Shlezinger, T. Locher, X. Ni, R. J. van Sloun, and Y. C. Eldar, “Unsupervised learned Kalman filtering,” in _Proc. Eur. Signal Process. Conf. (EUSIPCO)_ , Belgrade, Serbia, Aug. 2022, pp. 1571–1575. 

- [4] G. Choi, J. Park, N. Shlezinger, Y. C. Eldar, and N. Lee, “SplitKalmanNet: A robust model-based deep learning approach for state estimation,” _IEEE Trans. Veh. Technol._ , vol. 72, no. 9, pp. 12326–12331, Sep. 2023. 

- [5] I. Buchnik, G. Revach, D. Steger, R. J. G. van Sloun, T. Routtenberg, and N. Shlezinger, “Latent-KalmanNet: Learned Kalman filtering for tracking from high-dimensional signals,” _IEEE Trans. Signal Process._ , vol. 72, pp. 352–367, 2024. 

- [6] S. Jouaber, S. Bonnabel, S. Velasco-Forero, and M. Pilte, “NNAKF: A neural network adapted Kalman filter for target tracking,” in _Proc. IEEE Int. Conf. Acoust., Speech Signal Process. (ICASSP)_ , Toronto, ON, Canada, May 2021, pp. 4075–4079. 

- [7] L. Xu and R. Niu, “EKFNet: Learning system noise statistics from measurement data,” in _Proc. IEEE Int. Conf. Acoust., Speech Signal Process. (ICASSP)_ , Toronto, ON, Canada, May 2021, pp. 4075–4079. 

- [8] L. Xu and R. Niu, “EKFNet: Learning system noise covariance parameters for nonlinear tracking,” _IEEE Trans. Signal Process._ , vol. 72, pp. 3139–3152, 2024. 

- [9] A. Ghosh, A. Honoré, and S. Chatterjee, “DANSE: Data-driven nonlinear state estimation of model-free process in unsupervised learning setup,” _IEEE Trans. Signal Process._ , vol. 72, pp. 1824–1838, 2024. 

- [10] X. Ni, G. Revach, and N. Shlezinger, “Adaptive KalmanNet: Data-driven Kalman filter with fast adaptation,” in _Proc. IEEE Int. Conf. Acoust., Speech Signal Process. (ICASSP)_ , Seoul, South Korea, Apr. 2024, pp. 5970–5974. 

- [11] S. R. Jondhale and R. S. Deshpande, “Kalman filtering framework-based real time target tracking in wireless sensor networks using generalized regression neural networks,” _IEEE Sens. J._ , vol. 19, no. 1, pp. 224–233, Jan. 2019. 

- [12] D. Yu, C. Li, and J. Xiao, “Neural networks-based Wi-Fi/PDR indoor navigation fusion methods,” _IEEE Trans. Instrum. Meas._ , vol. 72, pp. 1– 14, 2023. 

- [13] G. Liu, P. Neupane, H.-C. Wu, W. Xiang, L. Pu, and S. Y. Chang, “Novel robust indoor device-free moving-object localization and tracking using machine learning with Kalman filter and smoother,” _IEEE Syst. J._ , vol. 16, no. 4, pp. 6253–6264, Dec. 2022. 

- [14] R. E. Kalman, “A new approach to linear filtering and prediction problems,” _J. Basic Eng._ , vol. 82, no. 1, pp. 35–45, Mar. 1960. 

- [15] S. J. Julier and J. K. Uhlmann, “A new extension of the Kalman filter to nonlinear systems,” in _Proc. 11th Int. Symp. Aerosp./Defence Sens. Simulat. Controls_ , Jul. 1997, pp. 182–193. 

- [16] E. A. Wan and R. Van Der Merwe, “The unscented Kalman filter,” in _Kalman Filtering and Neural Networks_ , Hoboken, NJ, USA: Wiley, Oct. 2001, pp. 221–280. 

- [17] I. Arasaratnam, S. Haykin, and T. R. Hurd, “Cubature Kalman filtering for continuous-discrete systems: Theory and simulations,” _IEEE Trans. Signal Process._ , vol. 58, no. 10, pp. 4977–4993, Oct. 2010. 

- [18] N. J. Gordon, D. J. Salmond, and A. F. Smith, “Novel approach to nonlinear/non-Gaussian Bayesian state estimation,” in _IEE Proc. F. (Radar Signal Process.)_ , vol. 140, no. 2, pp. 107–113, Apr. 1993. 

- [19] M. T. Hoang, B. Yuen, X. Dong, T. Lu, R. Westendorp, and K. Reddy, “Recurrent neural networks for accurate RSSI indoor localization,” _IEEE Internet Things J._ , vol. 6, no. 6, pp. 10639–10651, Dec. 2019. 

- [20] T. Zhi-Xuan, H. Soh, and D. Ong, “Factorized inference in deep Markov models for incomplete multimodal time series,” in _Proc. AAAI Conf. Artif. Intell._ , New York, USA, vol. 34, no. 6, Feb. 2020, pp. 10334– 10341. 

- [21] B. Tang and D. S. Matteson, “Probabilistic transformer for time series analysis,” in _Proc. Adv. Neural Inf. Process. Syst_ . _(NeurIPS)_ , Dec. 2021, pp. 23592–23608. 

- [22] R. B. Abdallah, G. Pagès, D. Vivet, J. Vilà-Valls, and E. Chaumette, “Robust linearly constrained square-root cubature Kalman filter for mismatched nonlinear dynamic systems,” _IEEE Control Syst. Lett._ , vol. 6, pp. 2335–2340, 2022. 

- [23] J. Vilà-Valls, E. Chaumette, F. Vincent, and P. Closas, “Robust linearly constrained Kalman filter for general mismatched linear state-space models,” _IEEE Trans. Autom. Control_ , vol. 67, no. 12, pp. 6794–6801, Dec. 2022. 

- [24] W. Yan, S. Chen, D. Lin, and S. Wang, “Variational Bayesian-based generalized loss cubature Kalman filter,” _IEEE Trans. Circuits Syst. II_ , vol. 71, no. 5, pp. 2874–2878, May 2024. 

Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 12:51:45 UTC from IEEE Xplore.  Restrictions apply. 

CHEN et al.: MAML-KALMANNET: A NEURAL NETWORK-ASSISTED KALMAN FILTER 

1003 

- [25] X. Yu and Z. Meng, “Robust Kalman filters with unknown covariance of multiplicative noise,” _IEEE Trans. Autom. Control_ , vol. 69, no. 2, pp. 1171–1178, Feb. 2024. 

- [26] S. Chen, Q. Zhang, D. Lin, and S. Wang, “Generalized loss based geometric unscented Kalman filter for robust power system forecastingaided state estimation,” _IEEE Signal Process. Lett._ , vol. 29, pp. 2353– 2357, 2022. 

- [27] A. Shrestha and A. Mahmood, “Review of deep learning algorithms and architectures,” _IEEE Access_ , vol. 7, pp. 53040–53065, 2019. 

- [28] N. Cohen and I. Klein, “A-KIT: Adaptive Kalman-informed transformer,” 2024, _arXiv:2401.09987_ . 

- [29] T. Hospedales, A. Antoniou, P. Micaelli, and A. Storkey, “Meta-learning in neural networks: A survey,” _IEEE Trans. Pattern Anal. Mach. Intell._ , vol. 44, no. 9, pp. 5149–5169, Sep. 2022. 

- [30] C. Finn, P. Abbeel, and S. Levine, “Model-agnostic meta-learning for fast adaptation of deep networks,” in _Proc. Int. Conf. Mach. Learn. (ICML)_ , Sydney, Australia, Aug. 2017, pp. 1126–1135. 

- [31] A. Antreas, H. Edwards, and A. Storkey, “How to train your MAML,” in _Proc. 7th Int. Conf. Learn. Representations (ICLR)_ , New Orleans, USA, May 2019, pp. 1–11. 

- [32] J. Delmerico, T. Cieslewski, H. Rebecq, M. Faessler, and D. Scaramuzza, “Are we ready for autonomous drone racing? The UZH-FPV drone racing dataset,” _2019 Int. Conf. Robot. Automat. (ICRA)_ , Montreal, Canada, May. 2019, pp. 6713–6719. 

- [33] M. Mallick, S. Arulampalam, Y. Yan, and J. Ru, “Three-dimensional tracking of an aircraft using two-dimensional radars,” _IEEE Trans. Aerosp. Electron. Syst._ , vol. 54, no. 2, pp. 585–600, Apr. 2018. 

- [34] A. Buelta, A. Olivares, E. Staffetti, W. Aftab, and L. Mihaylova, “A Gaussian process iterative learning control for aircraft trajectory tracking,” _IEEE Trans. Aerosp. Electron. Syst._ , vol. 57, no. 6, pp. 3962– 3973, Dec. 2021. 

- [35] C. Zhang, J. Bütepage, H. Kjellström, and S. Mandt, “Advances in Variational inference,” _IEEE Trans. Pattern Anal. Mach. Intell._ , vol. 41, no. 8, pp. 2008–2026, Aug. 2019. 

- [36] D.-J. Xin and L.-F. Shi, “Kalman filter for linear systems with unknown structural parameters,” _IEEE Trans. Circuits Syst. II._ , vol. 69, no. 3, pp. 1852–1856, Mar. 2022. 

- [37] J. Chung, C. Gulcehre, K. Cho, and Y. Bengio, “Empirical evaluation of gated recurrent neural networks on sequence modeling,” in _Proc. NIPS Workshop Deep Learn._ , Montreal, Canada, Dec. 2014, pp. 701–710. 

- [38] J. E. van Engelen and H. H. Hoos, “A survey on semi-supervised learning,” _Mach. Learn._ , vol. 109, no. 2, pp. 373–440, Feb. 2020. 

- [39] X. Yang, Z. Song, I. King, and Z. Xu, “A survey on deep semi-supervised learning,” _IEEE Trans. Knowl. Data Eng._ , vol. 35, no. 9, pp. 8934–8954, Sep. 2023. 

- [40] I. Goodfellow, Y. Bengio, and A. Courville, _Deep Learning._ Cambridge, MA, USA: MIT Press, 2016. 

- [41] G. Agamennoni, J. I. Nieto, and E. M. Nebot, “Approximate inference in state-space models with heavy-tailed noise,” _IEEE Trans. Signal Process._ , vol. 60, no. 10, pp. 5024–5037, Oct. 2012. 

- [42] J. Neri, P. Depalle, and R. Badeau, “Approximate inference and learning of state space models with Laplace noise,” _IEEE Trans. Signal Process._ , vol. 69, pp. 3176–3189, 2021. 

- [43] L. Zhuang and M. K. Ng, “Hyperspectral mixed noise removal by 1-norm-based subspace representation,” _IEEE J. Sel. Topics Appl. Earth Obs. Remote Sens._ , vol. 13, pp. 1143–1157, 2020. 

- [44] R. Sun, G. Huang, R. Xie, X. Wang, and L. Chen, “Diffusion augmentation and pose generation based pre-training method for robust visibleinfrared person re-identification,” _IEEE Signal Process. Lett._ , vol. 31, pp. 2670–2674, 2024. 

- [45] W. Gilpin, “Chaos as an interpretable benchmark for forecasting and data-driven modelling,” in _Proc. Neural Inf. Process. Syst. Track Datasets Benchmarks 1, NeurIPS Datasets Benchmarks_ , Dec. 2021, pp. 1–16. 

- [46] L. Xie, Y. C. Soh, and C. E. De Souza, “Robust Kalman filtering for uncertain discrete-time systems,” _IEEE Trans. Autom. Control_ , vol. 39, no. 6, pp. 1310–1314, Jun. 1994. 

- [47] S. Chen, Q. Zhang, T. Zhang, L. Zhang, L. Peng and S. Wang, “Robust state estimation with maximum correntropy rotating geometric unscented Kalman filter,” _IEEE Trans. Instrum. Meas._ , vol. 71, pp. 1–14, 2021. 

- [48] M. A. K. Gomaa, O. De Silva, G. K. I. Mann, and R. G. Gosine, “Observability-constrained VINS for MAVs using interacting multiple model algorithm,” _IEEE Trans. Aerosp. Electron. Syst._ , vol. 57, no. 3, pp. 1423–1442, Jun. 2021. 

- [49] Y. Bar-Shalom, X. R. Li, and T. Kirubarajan, _Estimation With Applications to Tracking and Navigation: Theory Algorithms and Software_ . Hoboken, NJ, USA: Wiley, Jan. 2004. 

**==> picture [73 x 91] intentionally omitted <==**

**Shanli Chen** received the B.Eng. degree in information and communication engineering from Chongqing University of Posts and Telecommunications, Chongqing, China, in 2023. He is currently working toward the M.Eng. degree with the College of Electronic and Information Engineering, Southwest University, Chongqing. His research interests include adaptive signal processing, machine learning, and optimization in machine learning. 

**==> picture [73 x 91] intentionally omitted <==**

**Yunfei Zheng** received the Ph.D. degree in control science and engineering from Xi’an Jiaotong University, Xi’an, China, in 2021. He was a Postdoctoral Researcher with the Southwest University, Chongqing, China, from 2021 to 2024. He has published more than 30 papers. Currently, he is a Lecturer with the College of Electronic and Information Engineering, Southwest University, Chongqing. His research interests include machine learning and adaptive signal processing. 

**==> picture [73 x 91] intentionally omitted <==**

**Dongyuan Lin** received the B.Eng. degree in mathematics and applied mathematics and the M.Eng. degree in systems science form Chongqing Jiaotong University, Chongqing, China, in 2018 and 2021, respectively. He is currently working toward the Ph.D. degree with the College of Electronic and Information Engineering, Southwest University, Chongqing, China. His research interests include the quaternion adaptive signal processing, state estimation, and quaternion-valued neural networks. 

**==> picture [73 x 91] intentionally omitted <==**

**Peng Cai** received the B.Eng. degree from the School of Electrical Engineering and Automation, Hubei Normal University, Huangshi, China, in 2020. She is currently working toward the Ph.D. degree with the College of Electronic and Information Engineering, Southwest University, Chongqing, China. Her research interests include distributed adaptive filtering, optimization, information theoretic learning, and nonlinear Kalman filtering. 

**==> picture [73 x 91] intentionally omitted <==**

**Yingying Xiao** received the B.Eng. and M.Eng. degrees from the College of Electronic and Information Engineering, Southwest University, Chongqing, China, in 2021 and 2024, respectively. Her research interest includes adaptive signal processing. 

**Shiyuan Wang** (Senior Member, IEEE) received the B.Eng. and M.Eng. degrees in electronic and information engineering from the Southwest Normal University, Chongqing, China, in 2002 and 2005, respectively, and the Ph.D. degree in circuit and system from Chongqing University, Chongqing, China, in 2011. From 2012 to 2013, he was a Research Associate with The Hong Kong Polytechnic University, Hong Kong. Currently, he is a Professor with the College of Electronic and Information Engineering, Southwest University, Chongqing, China. His research interests include adaptive signal processing, nonlinear dynamics, and simultaneous localization and mapping (SLAM). 

Authorized licensed use limited to: Technische Universitaet Berlin. Downloaded on April 30,2026 at 12:51:45 UTC from IEEE Xplore.  Restrictions apply. 

