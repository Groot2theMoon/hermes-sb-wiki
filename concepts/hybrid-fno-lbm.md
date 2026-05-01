---
title: Hybrid FNO-LBM — Fourier Neural Operator-Lattice Boltzmann Method Coupling
created: 2026-05-02
updated: 2026-05-02
type: concept
tags: [neural-operator, fluid-dynamics, cfd, surrogate-model, hybrid-method]
sources: []
confidence: medium
---

# Hybrid FNO-LBM — Fourier Neural Operator-Lattice Boltzmann Method

## 개요

Junk, Winter, Tütken, Schmidt, Adams (TUM, 2026)가 제안한 **FNO-LBM 하이브리드 프레임워크**는 FNO를 Lattice Boltzmann Method (LBM) solver와 결합하여 정상/비정상 약압축성 유동을 가속한다. 순수 autoregressive FNO rollout의 오차 누적 문제를 LBM solver와의 hybrid coupling으로 해결하는 것이 핵심이다.

## 핵심 아이디어

### 정상 유동 가속
FNO 기반 초기화로 LBM 정상 상태 수렴 가속 — 밀도 70%, 압력 강하 40% 이상의 수렴 속도 향상 달성.

### 비정상 유동 하이브리드 커플링
FNO rollout을 LBM time advancement 내에 super-time-stepping 방식으로 삽입. 경량 2.6M-parameter FNO가 순수 autoregressive rollout에서는 발산하지만, hybrid coupling에서는 96-99.8% 오차 감소 달성 — 11.2M-parameter 대형 모델과 동등한 예측 성능.

### 주요 발견
- 소형 surrogate 모델이 hybrid coupling에서 대형 모델과 동등한 오차 영역에서 작동 가능
- Hybrid coupling이 오차 누적을 효과적으로 억제
- LBM의 물리적 일관성을 유지하면서 계산 효율성 확보

## 연결점
- [[fourier-neural-operator]] — FNO가 hybrid coupling의 backbone 연산자
- [[physics-constrained-surrogate]] — 물리 solver와 결합된 surrogate의 대표 사례
- [[deeponet]] — 다른 operator learning 접근법과의 비교 대상

## References
- arXiv:2604.27158 — "Hybrid Fourier Neural Operator-Lattice Boltzmann Method"
