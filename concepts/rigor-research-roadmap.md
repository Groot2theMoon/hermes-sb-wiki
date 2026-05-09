---
title: "RIGOR Research Roadmap — UKF + Sigma Cloud Conditioning"
created: 2026-05-07
updated: 2026-05-07
type: concept
tags: [rigor, research, roadmap, planning, ufi, sigma-cloud, paper]
confidence: high
---

# RIGOR Research Roadmap — UKF + Sigma Cloud Conditioning

## Core Novelty

**UKF sigma point cloud를 structured neural conditioning feature로 활용하는 최초의 접근.**

기존 differentiable filtering은 UKF의 sigma point를 dynamics propagation에만 사용하고, neural network conditioning에는 covariance (P_pred)나 innovation만 전달했다. RIGOR는 sigma point cloud 자체를 NN에 conditioning input으로 제공하여 UKF가 생성한 고차원 비선형 변형 정보를 dynamics 학습에 직접 활용한다.

### 근본적 한계 발견 (2026-05-08, Deep Research)

표준 UKF의 근본적 한계: **observation과 correlation이 있는 state만 추정 가능** (Grothe 2012). Bouc-Wen z는 observation y=x와 correlation 0 → UKF의 Kalman gain K_z ≈ 0 → z 추정 불가.

이것은 RIGOR의 UFI+TE 실패의 **근본 원인**이며, 단순한 engineering 문제가 아니다. 가능한 해결 방향:

1. **Pure NN (TE-only):** UKF 없이 Conv1D로 z 직접 추정. z corr 0.717 달성 (UFI+TE 0.416 대비 우수). 자유도는 높지만 UKF의 covariance 구조를 잃음.
2. **UKF + HOC-UKF regularizer:** Grothe (2012)의 higher-order correlation formula를 UFI loss에 통합. 가장 principled한 접근.
3. **UKF + 분리된 z estimator:** UKF는 x, v 추정에 집중하고, TE가 z를 따로 추정.

### Three Information Sources (orthogonal)

| Source | Type | Content | Status |
|--------|------|---------|--------|
| **UFI** | Static geometry | Quadratic expansion of sigma points (state-independent basis) | ✅ VDP 검증 완료 |
| **Raw cloud** | Dynamic distortion | Per-step nonlinear spread from UKF propagation | ✅ VDP 검증 완료 |
| **ISAB encoder** | Permutation-invariant | Set Transformer over sigma cloud → compact embedding | 설계 완료, VDP 검증 필요 |

## Current Best Config (VDP μ=1.0, 2026-05-07)

| Parameter | Value | 비고 |
|-----------|-------|------|
| Activation | GELU (16, 16) | GELU > tanh > ELU 순 |
| UKF α | 0.01 | Wan & van der Merwe 권장값 검증 |
| Gating | OFF | 1000 iter에서는 불필요 |
| Norm bounding | Softsign | tanh 대비 gradient 30배 개선 |
| residual_scale | Learnable c ∈ (0,1) | Behrmann i-ResNet 스타일 |
| Loss | VFE + 0.5 × rollout MSE | 정보이론적 multi-step ELBO |
| **Results** | pos=0.9986, vel=0.9703, RMSE=0.320 | 🏆 역대 최고 |

## Roadmap

### Phase 1: Multi-System Validation (2~3주)
- Duffing oscillator (nonlinear stiffness, SHM 연결)
- Pendulum / cart-pole (control community baseline)
- **SHM benchmark**: Z24 bridge 또는 IASC-ASCE benchmark (DSLab 연결)
- 각 시스템별 config 자동 튜닝 or adaptive mechanism

### Phase 2: Ablation Study (1~2주)
- UFI only vs raw cloud only vs UFI+raw vs ISAB+raw
- 각 조합의 성능 비교 및 scaling 분석 (d_state ↑)
- ISAB의 d_state ≥ 10에서의 효용성 검증

### Phase 3: Paper Writing (2~3주)
- Target: ML4Dynamics / L4DC (conference) 또는 논문
- Core contribution: "Sigma Point Cloud Conditioning for Differentiable UKF"
- 시스템: VDP + Duffing + SHM benchmark

## Timeline

```
2026-05-07 (현재): VDP 최적화 완료, 방향성 확정
2026-05-14: Phase 1 완료 (multi-system benchmark)
2026-06-01: Phase 2 완료 (UFI/ISAB ablation)
2026-06-15: 논문 초안 완료
2026-07: DSLab 접촉, 실험실 방문
2026-08: POSTECH 대학원 지원
```

## Wikilinks
- [[rigor-development]] — Main RIGOR development page
- [[rigor-heuristics-analysis]] — Heuristic audit and theoretical fixes
- [[rigor-geometry-of-memory-integration]] — Geometry of Memory Trilogy 접목 분석
- [[gating-ablation-2026-05-07]] — Gating ON vs OFF ablation
- [[rigor-sigma-point-research]] — Research landscape and gap analysis
- [[square-root-unscented-kalman-filter]] — Standard SR-UKF formulation
- [[higher-order-correlation-ukf]] — Grothe (2012) HOC-UKF: 근본적 한계와 해결 방향
- [[polynomial-unscented-kalman-filter]] — Cherian & Servadio (2026) Polynomial UKF
