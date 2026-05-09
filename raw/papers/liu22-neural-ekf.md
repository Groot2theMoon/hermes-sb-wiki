---
source_url: https://arxiv.org/abs/2210.04165
ingested: 2026-05-08
sha256: LIU22_FIXME
---

# Neural Extended Kalman Filters for Learning and Predicting Dynamics of Structural Systems

**Wei Liu, Zhilu Lai, Kiran Bacsa, Eleni Chatzi** (ETH Zürich, 2022/2023). arXiv:2210.04165. Structural Health Monitoring, 2023. DOI: 10.1177/14759217231179912.

## Abstract

Accurate structural response prediction forms a main driver for structural health monitoring and control applications. This often requires the proposed model to adequately capture the underlying dynamics of complex structural systems. In this work, we utilize a learnable Extended Kalman Filter (EKF), named the Neural Extended Kalman Filter (Neural EKF) throughout this paper, for learning the latent evolution dynamics of complex physical systems. The Neural EKF is a generalized version of the conventional EKF, where the modeling of process dynamics and sensory observations can be parameterized by neural networks, therefore learned by end-to-end training. The method is implemented under the variational inference framework with the EKF conducting inference from sensing measurements. Typically, conventional variational inference models are parameterized by neural networks independent of the latent dynamics models. This characteristic makes the inference and reconstruction accuracy weakly based on the dynamics models and renders the associated training inadequate. In this work, we show that the structure imposed by the Neural EKF is beneficial to the learning process. We demonstrate the efficacy of the framework on both simulated and real-world structural monitoring datasets, with the results indicating significant predictive capabilities of the proposed scheme.
