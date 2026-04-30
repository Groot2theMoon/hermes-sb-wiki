---
title: Adaptive Online Smoother — Closed-Form Solutions with Information-Theoretic Lag Selection
created: 2026-04-30
updated: 2026-04-30
type: concept
tags: [model, smoothing, online-learning, state-estimation, conditional-gaussian]
sources: [raw/papers/adaptive-online-smoother-andreou24.md]
confidence: medium
---

# Adaptive Online Smoother

## 개요

Conditional Gaussian Nonlinear System (CGNS)을 위한 **forward-in-time online smoother**로, 전통적인 offline RTS smoother의 backward pass / 전체 저장소 요구를 제거. (Andreou, Chen & Li 2024)

## 핵심 아이디어

- 전통적인 smoothing은 모든 filter solution을 저장한 후 backward pass 필요 → **고차원에서 저장/계산 비용 큼**
- 이 논문의 adaptive online smoother는 **adaptive lag** window 내에서만 forward update 수행
- Lag는 **정보이론적 uncertainty reduction criterion**으로 실시간 결정
- CGNS의 closed-form analytic structure 덕분에 모든 계산이 **closed-form** (ensemble-free)

## 장점

- 저장소 요구량 대폭 감소 (고차원 Lagrangian DA에 필수)
- Adaptive lag는 turbulent system에서 temporal autocorrelation 변화에 대응
- 세 가지 응용:
  1. **Online causal inference** — 변수 간 인과 관계 실시간 탐지
  2. **Lagrangian data assimilation** — 고차원 flow recovery
  3. **Online parameter estimation** — extreme events가 convergence 가속

## RIGOR와의 연결점

- EM + smoother 조합의 **online 확장** 방향성
- 논문 comparison table에서 **Adaptive Online Smoother (2024)** 가 EM을 online으로 확장한 선행 연구로 언급됨
- RIGOR는 batch EM (offline)을 사용하지만, 향후 online variant의 기초가 될 수 있음

## 참고

- **arXiv:** 2411.05870
- 관련: [[em-kalman-smoother-noise-covariance]] — RIGOR의 EM 기반 접근
