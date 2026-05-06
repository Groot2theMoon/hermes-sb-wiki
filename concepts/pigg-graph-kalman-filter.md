---
title: "PiGGO — Physics-Guided Graph Kalman Filter for Virtual Sensing"
created: 2026-05-06
updated: 2026-05-06
type: concept
tags: [graph-neural-network, kalman-filter, virtual-sensing, structural-health-monitoring, neural-ode, extended-kalman-filter]
sources: [raw/papers/pigg-graph-kalman-haywood26.md]
confidence: high
---

# PiGGO: Physics-Guided Graph Kalman Filter

**arXiv:** [2604.26593](https://arxiv.org/abs/2604.26593)
**Authors:** [[marcus-haywood-alexander|Marcus Haywood-Alexander]], [[gregory-duthe|Gregory Duthé]], [[eleni-chatzi|Eleni Chatzi]] (ETH Zurich)
**Year:** 2026

## 개요

PiGGO(Physics-Guided Graph Neural ODE)는 **Graph Neural ODE (GNODE)** 를 연속시간 상태전이 모델로 사용하고, 이를 [[extended-kalman-filter|Extended Kalman Filter (EKF)]]에 통합한 **물리 기반 그래프 베이지안 상태 추정 프레임워크**이다. 구조물의 비선형 동역학을 희소 센서만으로 가상 측정(virtual sensing)하는 문제를 해결한다.

## 핵심 아이디어

- **Graph Neural ODE (GNODE)** — 그래프 구조의 연속시간 동역학을 학습 가능한 미분방정식으로 모델링. 상태 전이는 그래프 컨볼루션 연산자를 통해 정의된 벡터장을 수치 적분하여 수행
- **Physics-guided inductive bias** — 구조 역학의 기하학적 비선형성(co-rotational kinematics)을 그래프 피처로 인코딩하고, 선형 복원력은 물리 기반 컨볼루션(C_phy)으로, 비선형 성분은 데이터 기반 블랙박스(C_bb)로 분리하여 학습
- **Graph Extended Kalman Filter (GEKF)** — 사전 학습된 GNODE 모델을 EKF의 상태전이 함수로 사용하여 온라인 상태 추정 수행. Jacobian은 자동 미분(auto-diff)으로 계산
- **Physics-guided loss** — 가속도 관측 기반 힘-평형 잔차(force-balance residual)를 최소화하여 관측 손실과 물리 손실의 중복 제거

## 아키텍처

1. **그래프 표현**: 각 노드는 질량(m), 위치(p0), 외력(f)을, 각 엣지는 스프링 강성(k), 감쇠(c), 연결 길이(ε), 각도(θ) 등을 특징으로 가짐
2. **PiGGO 상태진화**: `F_ev = C_phy(G) + C_bb(G; Θ)` 형태로 선형 물리 + 비선형 데이터 기반 결합
3. **GEKF**: 예측 단계에서 GNODE로 상태 prior 추정, 갱신 단계에서 EKF 관측 갱신 수행
4. **Two-stage 학습**: 먼저 offline GNODE 학습(Algorithm 1), 이후 사전학습 모델을 GEKF에 통합(Algorithm 2)

## 관련 개념

- [[graph-neural-ode-structural-dynamics|Graph Neural ODE]] — GNODE 기본 아키텍처
- [[kalmannet|KalmanNet]] — 다른 방식의 learnable Kalman filter (RNN 기반 gain 학습)
- [[auto-diff-data-assimilation|Auto-differentiable Data Assimilation]] — 미분 가능 필터링 패러다임
- [[rigor-filter|RIGOR Filter]] — 미분 가능 SR-UKF (다른 접근의 learnable filter)
- [[ensemble-kalman-filter|Ensemble Kalman Filter]] — 앙상블 기반 DA (비교 대상)

## 주요 특징

- **연속시간 모델링**: GNODE를 통한 continuous-time state transition (ODE integrator 사용)
- **그래프 귀납 편향**: topology-aware message passing으로 희소 센서에서도 일반화 가능
- **Model-form 불확실성 대응**: 물리 기반 + 데이터 기반 구성요소 분리로 알려진 물리와 미지의 비선형성을 동시에 처리
- **구조물 모집단 일반화**: 유사한 위상의 구조물 간 전이 학습 가능
