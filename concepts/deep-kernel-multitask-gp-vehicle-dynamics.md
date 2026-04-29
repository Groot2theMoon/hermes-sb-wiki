---
title: "Deep Kernel Multi-Task GP for Vehicle Dynamics in Autonomous Racing"
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [model, inference, engineering-design, paper, robotics]
sources: [raw/papers/2411.13755v1.md]
confidence: medium
---

# Deep Kernel Multi-Task GP (DKMGP) for Vehicle Dynamics

## 개요

Ning & Behl (U. Virginia, 2024)은 자율주행 레이싱에서 **simplified model (E-kin)과 실제 차량 dynamics 간의 residual을 학습**하는 multi-task Gaussian Process 모델 DKMGP를 제안한다. Indy Autonomous Challenge (CES 2024)의 230 km/h+ 실차 데이터로 검증.

## 핵심 아이디어

### Problem Setting
- Single-track / E-kin model의 단순화로 인한 residual:
  $$r_{t+1} = s_{t+1} - f_{E\text{-kin}}(s_t, u_t)$$
- Residual은 base states $\{v_x, v_y, \omega\}$에만 존재
- Goal: $\hat{s}_{t+1} = f_{E\text{-kin}}(s_t, u_t) + \mathbf{e}_{t+1}$

### DKMGP Architecture
- **Multi-task variational GP:** 하나의 모델로 3개 state residual 동시 예측
- **Deep kernel learning:** DNN으로 GP kernel parameter 학습 → nonlinear dynamics 포착
- **Adaptive Correction Horizon (ACH):** 주행 조건에 따라 multi-step correction horizon 동적 조정

### 성능
- DKL-SKIP (single-task) 대비 **99% 예측 정확도**
- **1752x 실시간 계산 효율성 향상** (multi-step inference 최적화)
- Pacejka tire model 같은 복잡한 subsystem calibration 없이 동작

## 의의
- Learning-based dynamics model의 real-time closed-loop control 적용 가능성
- GP의 interpretability + deep learning의 expressiveness 결합
- Full-size autonomous racecar에서 최초의 multi-task GP 적용

## 융합 도메인 연결
- [[square-root-unscented-kalman-filter]] — 상태 추정과 dynamics modeling
- [[neural-mpc-terminal-constraint]] — MPC에서 dynamics model의 역할
- [[kennedy-ohagan-calibration]] — GP calibration framework
