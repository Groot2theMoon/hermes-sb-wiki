---
title: "RIGOR Research Roadmap — UKF + Sigma Cloud Conditioning"
created: 2026-05-07
updated: 2026-05-14
type: concept
tags: [rigor, research, roadmap, planning, ufi, sigma-cloud, paper, lorenz, state-dependent-dynamics]
confidence: high
---

# RIGOR Research Roadmap — UKF + Sigma Cloud Conditioning

## Core Novelty

**UKF sigma point cloud를 structured neural conditioning feature로 활용하는 최초의 접근.**

기존 differentiable filtering은 UKF의 sigma point를 dynamics propagation에만 사용하고, neural network conditioning에는 covariance (P_pred)나 innovation만 전달했다. RIGOR는 sigma point cloud 자체를 NN에 conditioning input으로 제공하여 UKF가 생성한 고차원 비선형 변형 정보를 dynamics 학습에 직접 활용한다.

### 근본적 한계 발견 (2026-05-08, Deep Research)

표준 UKF의 근본적 한계: **observation과 correlation이 있는 state만 추정 가능** (Grothe 2012). Bouc-Wen z는 observation y=x와 correlation 0 → UKF의 Kalman gain K_z ≈ 0 → z 추정 불가. ([[bouc-wen-filter-landscape]] 참조)

이것은 RIGOR의 UFI+TE 실패의 **근본 원인**이며, 단순한 engineering 문제가 아니다. 가능한 해결 방향:

1. **Pure NN (TE-only):** UKF 없이 Conv1D로 z 직접 추정. z corr 0.717 달성 (UFI+TE 0.416 대비 우수). 자유도는 높지만 UKF의 covariance 구조를 잃음.
2. **UKF + HOC-UKF regularizer:** Grothe (2012)의 higher-order correlation formula를 UFI loss에 통합. 가장 principled한 접근. (보류 — 우선 virtual measurement 검증)
3. **✅ UKF + Virtual Measurement (TE → pseudo-measurement):** [[higher-order-correlation-ukf|selected]] — TE가 z의 pseudo-measurement를 생성, UKF의 observation을 1D(y=x) → 2D([x, z_hat])로 augment. H = [[1,0,0],[0,0,1]]로 Kalman gain K_z가 자연스럽게 non-zero가 됨. 이론적 근거: Grothe (2012), 실험 검증: test_E 진행 중.

### Direction ③ 상세 설계 (Virtual Measurement Approach)

| 구성 요소 | 역할 |
|-----------|------|
| **Conv1DEncoder** | observation window → z_hat 예측 (TE-only와 동일 구조, ks=3) |
| **UKF (d_out=2)** | augmented observation [x, z_hat]으로 x, v, z 공동 추정 |
| **H matrix** | [[1,0,0],[0,0,1]] — x와 z에 직접 Kalman gain 할당 |
| **Loss** | MSE on x dim만 (z dim은 TE가 학습) |
| **UFI** | sigma cloud conditioning으로 x, v dynamics 개선 |

**TE vs UKF의 역할 분리:**
- TE → z의 temporal pattern 인식 (temporal context 활용)
- UKF → x, v의 covariance 구조 유지 (SR-UKF stable dynamics)
- UFI → sigma point cloud conditioning (x, v 비선형성 학습)

이 분리는 additive TE (Phase 1)와 residual carry (Phase 2) 사이의 중간적 접근. NN output(z_hat)이 UKF의 observation으로 자연스럽게 흘러들어가 "NN output이 다시 NN에 feedback"되는 문제 회피.

**Reference:** [[higher-order-correlation-ukf]], Grothe (2012), [[bouc-wen-dl-parameter-estimation]]

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

### Phase 4: State-Dependent Dynamics (2026-05-13~, 진행 중)
- **Lorenz63 2-lobe switching** — static A fails (\|ρ\|≈0.4); requires state-dependent A
- **LPV (MLP)** → OOM on CPU → abandoned (v5.8–v5.18)
- **Quadratic A(x) = A₀+A₁⊗x+xᵀA₂x** (v5.19) — pure einsum, Taylor expansion of J(x)·dt
- **K-step rollout VFE** — multi-step ELBO for dynamics consistency (v5.11–v5.15)
- Target: Demonstrate A(x) advantage over static A on chaotic systems
- See [[state-dependent-a-quadratic-form]], [[lorenz63-rigor-experiments]], [[k-step-rollout-vfe-loss]]

## Timeline

```
2026-05-07 (현재): VDP 최적화 완료, 방향성 확정
2026-05-13: Lorenz63 K-step rollout experiments (static A, single-lobe \|ρ\|=0.77)
2026-05-14: LPV → Quadratic A(x) evolution, CPU compilation battle
2026-05-17 (target): Lorenz63 2-lobe switching with Quadratic A(x) (±0.6+)
2026-06-01: Phase 2 완료 (UFI/ISAB ablation + Lorenz benchmark)
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
