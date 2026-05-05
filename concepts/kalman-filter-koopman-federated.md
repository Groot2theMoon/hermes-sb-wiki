---
title: "Kalman Filter Aided Federated Koopman Learning — UKF for Partial Observations"
created: 2026-05-05
updated: 2026-05-05
type: concept
tags: [kalman-filter, koopman-operator, federated-learning, partial-observation, ukf, state-estimation, linearization]
sources:
  - raw/papers/2507.04808v1.md
confidence: high
---

# Kalman Filter Aided Federated Koopman Learning

**Chen & Chen** (Tsinghua University, 2025). arXiv:2507.04808.

## 개요

부분 관측(partial observation) 환경에서 Koopman operator를 federated learning으로 학습. 핵심: **UKF + Rauch-Tung-Striebel smoother를 state estimation에 사용**하여 관측 데이터로부터 full state 복원 → Koopman linearization 학습. RIGOR와 동일한 "partial obs → filter로 state 추정 → dynamics 학습" 패러다임.

## KFFedKL 아키텍처

```
Client i (병원 i):
  관측 y_t → UKF → state estimate x̂_t → Koopman encoder φ(x̂_t) → latent z_t
                                                      ↓
                                            K·z_t  =  z_{t+1} prediction
                                                      ↓
                                            loss = MSE(z_{t+1}, φ(x̂_{t+1}))
Server:
  FedAvg로 각 client의 Koopman network aggregation
```

## RIGOR와의 유사점/차이점

| 요소 | KFFedKL | RIGOR |
|------|---------|-------|
| Filter | UKF (standard) | **SR-UKF** |
| Dynamics | **Koopman** (global linear in latent) | **A+NN** (hybrid) |
| State 학습 | UKF는 pre-trained (고정) | **Jointly learned** |
| 관측 | Partial → UKF로 복원 | Partial → SR-UKF 안에서 end-to-end |
| 목적 | Linearization + collaboration | Dynamics ID + filtering |
| Loss | Koopman prediction MSE | Position NLL |

## RIGOR 맥락

**중요한 교훈:** KFFedKL는 "partial observation에서 UKF가 state를 충분히 복원할 수 있다"는 가정 하에 작동. 만약 UKF의 state 추정이 부정확하면 → Koopman 학습도 부정확.

RIGOR는 이 한계를 **end-to-end**로 해결: filter와 dynamics를 jointly 학습. 다만 RIGOR의 현재 bottleneck도 동일 — filter가 velocity를 잘 복원해야 dynamics가 잘 학습됨.

## Wikilinks
- [[koopman-operator-theory]] — Koopman operator 이론
- [[rigor-filter]] — RIGOR differentiable SR-UKF
- [[buisson-fenet-kkl-observer]] — KKL observer (partial obs 보완)
- [[observability-nssm]] — NSSM observability 조건

## References
- Chen, Y. & Chen, W. (2025). Kalman Filter Aided Federated Koopman Learning. arXiv:2507.04808.
