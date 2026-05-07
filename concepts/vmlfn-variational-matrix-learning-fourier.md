---
title: "VMLFN — Variational Matrix-Learning Fourier Networks for Multiphysics Surrogates"
created: 2026-05-07
updated: 2026-05-07
type: concept
tags: [surrogate-model, neural-operator, neural-network, physics-informed, mathematics, paper, mechanics]
confidence: medium
sources: [arXiv:2605.02280]
---

# VMLFN — Variational Matrix-Learning Fourier Networks

## 개요

**Li, Zhang, Chen (2026)**^[arXiv:2605.02280]이 제안한 **VMLFN (Variational Matrix-Learning Fourier Network)** 은 **파라메트릭 멀티피직스(multiphysics) surrogate 모델링**을 위한 새로운 Fourier network 아키텍처다.

## 핵심 아이디어

### Log-Space Sine Representation

기존 Fourier feature encoding과 달리, **logarithmic space에서 주파수 점을 샘플링**하여 광범위한 주파수 스펙트럼을 효율적으로 커버한다. 주파수 의존적 감쇠 인자(frequency-dependent decay factor)로 각 spectral component의 기여도를 조절한다.

### Eigenvariational Weak Form

PDE를 **변분 약형(variational weak form)** 으로 재구성하여 zero-gradient stationarity condition으로부터 **선형 행렬 시스템**을 유도:

1. 1차 도함수만 필요 — 고차 자동 미분(high-order AD) 불필요
2. PDE residual과 boundary condition 간 페널티 계수 튜닝 불필요
3. Dirichlet BC를 trial solution에 직접 내장

### 검증 문제

| 문제 유형 | 설명 |
|-----------|------|
| **열전도 (Heat conduction)** | 선형 elliptic PDE |
| **고체 역학 (Solid mechanics)** | 선형 탄성 방정식 |
| **Helmholtz 파동 전파** | Helmholtz equation |

## 연결점
- [[fourier-neural-operator]] — FNO와의 방법론적 차이점 (log-space sampling, variational formulation)
- [[deeponet]] — Operator learning 접근법과의 비교
- [[physics-informed-neural-networks]] — PINN 대비 AD 부담 감소
- [[surrogate-model]] — Parametric surrogate의 일반적 맥락

## References
- arXiv:2605.02280 — VMLFN: Variational Matrix-Learning Fourier Networks for Parametric Multiphysics Surrogates
