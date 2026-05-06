---
title: Action-Conditional Recurrent Kalman Network — ac-RKN for Forward/Inverse Dynamics
created: 2026-05-06
updated: 2026-05-06
type: concept
tags: [kalman-filter, state-estimation, sequence-modeling, latent-dynamics, neural-kalman, robotics, hybrid-modeling]
sources:
  - raw/papers/2010.10201v2.md
confidence: high
---

# Action-Conditional Recurrent Kalman Network (ac-RKN)

**Shaj, Becker, Büchler, Pandya, van Duijkeren, Taylor, Hanheide, Neumann** (KIT, Lincoln, MPI-IS, Bosch, Lancaster, 2020). CoRL 2020.

## 개요

Recurrent Kalman Network (RKN)을 **action-conditional prediction/inverse dynamics**로 확장. 표준 RNN (LSTM/GRU) 대비 principled uncertainty + action conditioning으로 복잡한 로봇 dynamics (유압, 공압, soft robotics)에서 우수한 성능.

## RKN 복습

RKN ([Becker et al., ICML 2019](https://arxiv.org/abs/1905.12414])은 **Kalman filter + deep encoder/decoder** 구조:
- Factorized latent state $\mathbf{z}_t = [\mathbf{p}_t; \mathbf{m}_t]$ (observation part + memory part)
- Factorized covariance $\boldsymbol{\Sigma}_t$ (3 diagonal matrices) → scalar Kalman update
- Locally linear transition $\mathbf{A}_t = \sum_k \alpha^{(k)}(\mathbf{z}_t) \mathbf{A}^{(k)}$
- Encoder: $\mathbf{o}_t \mapsto \mathcal{N}(\mathbf{w}_t, \boldsymbol{\sigma}^{\text{obs}}_t)$ (probabilistic observation embedding)
- Posterior $\mathcal{N}(\mathbf{z}_t^+, \boldsymbol{\Sigma}_t^+)$ via Kalman gain $\mathbf{Q}_t$

장점: LSTM보다 data-efficient, uncertainty quantification 가능, missing observation 처리 능력.

## ac-RKN의 3가지 혁신

### ① Principled Action Conditioning

표준 RNN: action을 observation에 단순 concatenation ("fake observation") → suboptimal.

ac-RKN: **latent state transition에 additive control model** $\mathbf{b}(\mathbf{a}_t)$를 추가:

$$\mathbf{z}_{t+1}^- = \mathbf{A}_t \mathbf{z}_t^+ + \mathbf{b}(\mathbf{a}_t) + \boldsymbol{\epsilon}_t$$

세 가지 variant:
| Variant | 수식 | 특성 |
|---------|------|------|
| **Linear** | $\mathbf{b}_l(\mathbf{a}_t) = \mathbf{B}\mathbf{a}_t$ | Simple, 제한적 표현력 |
| **Locally-linear** | $\mathbf{b}_m(\mathbf{a}_t) = \sum_k \beta^{(k)}(\mathbf{z}_t)\mathbf{B}^{(k)}\mathbf{a}_t$ | Interpolation, state-dependent |
| **Non-linear** | $\mathbf{b}_n(\mathbf{a}_t) = \text{MLP}(\mathbf{a}_t)$ | **Best performance**, 가장 유연 |

**중요:** action은 known, uncertain하지 않으므로 covariance propagation에 영향 없음 → $\mathbf{b}(\mathbf{a}_t)$에 선형성/국소선형성 제약 불필요. Non-linear variant가 ablation에서 best.

### ② Forward Dynamics Learning (Prediction Mode)

기존 RKN은 **filtering** (posterior $\mathbf{z}_t^+$ 사용), ac-RKN은 **prediction** (prior $\mathbf{z}_{t+1}^-$ decode):

$$\hat{\mathbf{o}}_{t+1} = \mathbf{o}_t + \text{dec}(\mathbf{z}_{t+1}^-)$$

핵심 아이디어:
- **Difference prediction:** $\hat{\mathbf{o}}_{t+1} = \mathbf{o}_t + \Delta\hat{\mathbf{o}}_{t+1}$ → copy-previous-state 문제 방지 (고주파 1kHz에서 특히 중요)
- **Missing observation handling:** observation이 없으면 Kalman update 생략 → prior = posterior → 장기 예측 가능
- Training with RMSE loss (Gaussian log-likelihood 대신; uncertainty 불필요시 slightly better)

### ③ Inverse Dynamics Learning (Joint Forward+Inverse)

Action decoder $\text{dec}_{\text{action}}(\mathbf{z}_t^+)$를 추가하여 latent posterior에서 action 추정:

$$\hat{\mathbf{a}}_t = \mathbf{a}_{t-1} + \text{dec}_{\text{action}}(\mathbf{z}_t^+)$$

**Causal action feedback:** estimated action $\hat{\mathbf{a}}_t$가 다음 step의 predict stage에 feeding → forward model과 inverse model이 joint training:
- Forward loss: observation prediction error
- Inverse loss: action reconstruction error
- Combined: $\mathcal{L}_{\text{total}} = \mathcal{L}_{\text{inv}} + \lambda \mathcal{L}_{\text{fwd}}$ ($\lambda$ via GPyOpt)

→ Action feedback의 causal structure가 inverse model 성능을 크게 향상 (ablation 확인).

## 실험 결과

### Forward Dynamics
| Robot | Actuator | Freq. | ac-RKN vs LSTM | ac-RKN vs RKN |
|-------|----------|-------|----------------|----------------|
| **BROKK-40** | Hydraulic (piston) | 100Hz | ~2× lower RMSE | ~30% lower RMSE |
| **Pneumatic Arm** | Pneumatic muscle | 100Hz | ~3× lower RMSE | ~40% lower RMSE |
| **Franka Panda** | Electric (1kHz) | 1kHz | ~1.5× lower RMSE | ~25% lower RMSE |

Multi-step prediction (5-10 step ahead):
- Analytical rigid-body model ≤ ac-RKN at 1-step, but **ac-RKN dominates at 3+ steps**
- Hydraulic/pneumatic robots: hysteresis 비모수 효과를 ac-RKN이 잘 포착
- Ablation: non-linear action conditioning > locally-linear > linear

### Inverse Dynamics
| Robot | ac-RKN RMSE | LSTM RMSE | Analytical RBD RMSE |
|-------|-------------|-----------|---------------------|
| **Franka Panda** | **~0.04** (joint 1-3) | ~0.06-0.08 | ~0.30-0.36 |
| **Barrett WAM** | **~0.08** | ~0.15 | - |

→ **ac-RKN이 analytical model 대비 7-8× 정확** (w/wo action feedback 모두).
Cable-driven WAM의 variable stiffness dynamics 포착.

## RIGOR 연결점

### ① Action-Conditioned State Transition
RIGOR의 DNN modulator ($\Delta \boldsymbol{\mu}_{\text{mod}}$)는 action-conditional structure와 유사:
- ac-RKN: $\mathbf{b}(\mathbf{a}_t)$를 latent transition에 additive
- RIGOR: $\Delta \boldsymbol{\mu}_{\text{mod}}$가 action-conditional로 확장 가능? → modulator가 action의 함수가 되도록 설계

### ② Probabilistic State Representation
RIGOR의 KKL observer 기반 latent state vs ac-RKN의 factorized latent state:
- ac-RKN: learned latent space에서 Kalman filtering
- RIGOR: KKL observer로 deterministic embedding → uncertainty propagation 부재
- **ac-RKN의 learned transition + uncertainty propagation을 RIGOR adaptive modulation에 결합?**

### ③ Decoder Architecture
ac-RKN의 difference prediction (prior decode) = RIGOR의 residual prediction과 유사한 철학.
Inverse dynamics decoder는 RIGOR의 parameter estimation head로 확장 가능.

## 관련 연구
- [[kalmannet]] — KalmanNet (Revach et al.): model-based + data-driven hybrid filtering, gain GRU
- [[deep-kalman-filter]] — DKF (Krishnan et al.): VAE + Kalman filter temporal structure
- [[recursive-kalmannet]] — Recursive KalmanNet (Mortada et al.): Joseph's formula covariance consistency
- [[rnn-enhanced-ukf]] — RNN-enhanced UKF: LSTM으로 UKF innovation 예측
- [[adaptive-neural-ukf]] — ProcessNet: adaptive noise covariance

## 관련 엔티티
- [[vaisakh-shaj]] — First author
- [[philipp-becker]] — RKN creator
- [[gerhard-neumann]] — ALR Lab @ KIT
- [[autonomous-learning-robots-kit]] — ALR Lab @ KIT
