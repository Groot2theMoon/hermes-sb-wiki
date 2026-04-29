---
title: "Simulation-Based Inference for Conceptual Aircraft Design"
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [inference, model, engineering-design, paper, aerospace]
sources: [raw/papers/NeurIPS_ML4PS_2025_88.md]
confidence: medium
---

# Simulation-Based Inference (SBI) for Aircraft Conceptual Design

## 개요

Ghiglino et al. (NeurIPS ML4PS 2025)는 **eVTOL (electric Vertical Take-Off and Landing)** 항공기의 개념 설계에 Simulation-Based Inference (SBI)를 적용한 예비 연구다. SUAVE 시뮬레이터로 10,000개 설계를 생성하고, hierarchical diffusion-based SBI (Hierarchical Simformer)로 설계 공간을 모델링한다.

## 핵심 아이디어

### SBI for Engineering Design
- Likelihood-free inference: 복잡한 multiphysics 시뮬레이터에 대해 $p(\theta|\mathbf{x})$ 직접 추정
- Conditioning flexibility: 설계 파라미터와 성능 메트릭 모두 조건으로 사용 가능
- SUAVE 시뮬레이터: wing, battery, propeller 등 다중 컴포넌트 상호작용

### Hierarchical Simformer Architecture
- $C$개의 컴포넌트별 Simformer → score aggregation
  - **Covariance Aggregation (CA):** $\mathbf{L}\mathbf{L}^\top$로 cross-component 상관 학습
  - **Transformer Aggregation (TA):** final transformer로 score 결합
- Frozen component training 가능 → 모듈화, 재사용성

### Design Variables (18개)
- Battery (4): mass, energy density, efficiency, SoC
- Wing (6): thickness-to-chord, sweep, semi-span 등
- Propeller (3): design thrust, altitude, figure of merit
- Global (5): $C_L, C_D$, structural mass, Mach number, observation noise

## 결과
- MMD, C2ST metrics에서 baseline Simformer와 동등 성능
- $C_L$–$C_D$ quadratic relationship 정확히 포착
- SUAVE 시뮬레이션 대비 ~50x 빠른 샘플링

## 융합 도메인 연결
- [[mach-number-and-flow-regimes]] — eVTOL 운용 조건
- [[kennedy-ohagan-calibration]] — simulator calibration framework
- [[physics-informed-neural-networks]] — 대안적 surrogate modeling
