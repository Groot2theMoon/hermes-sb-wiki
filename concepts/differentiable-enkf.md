---
title: Differentiable Ensemble Kalman Filter — Data-Driven State Estimation for Robotics
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [model, state-estimation, kalman-filter, robotics, system-identification]
sources: [raw/papers/enhancing-state-estimation-robots.md]
confidence: medium
---

# Differentiable Ensemble Kalman Filter (EnKF)

로봇 상태 추정을 위한 **미분 가능한 Ensemble Kalman Filter**. 승원님 사이드 프로젝트 (differentiable UKF in JAX)에 직접 참조 가능한 선행 연구.

## 핵심 기여

- **Ensemble KF + automatic differentiation:** 파라미터 end-to-end 학습
- **Data-driven dynamics:** 로봇 동역학을 EnKF 프레임워크에서 학습
- **JAX 호환:** 미분 가능한 필터링 파이프라인

## UKF 사이드 프로젝트 참조 포인트

| Feature | 이 논문 (EnKF) | 승원님 아이디어 (SR-UKF) |
|---------|---------------|------------------------|
| 필터 | Ensemble KF | Square-Root UKF |
| Sigma points | Monte Carlo ensemble | Deterministic (2L+1) |
| 미분 가능 | ✅ | ✅ (JAX) |
| 물리 임베드 | 한정적 | A+NN 구조 가능 |

## 관련 페이지
- [[square-root-unscented-kalman-filter]] — SR-UKF 기반
- [[deep-kalman-filter]] — Variational inference 대안
- [[deep-variational-smc]] — Particle filter + VI
- [[neural-odes]] — 연속시간 dynamics 대안
