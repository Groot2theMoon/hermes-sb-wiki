---
title: Kolmogorov-Arnold Networks (KAN) — Learnable B-Spline Activations on Edges
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [model, neural-network, mathematics, landmark-paper]
sources: [raw/papers/2404.19756v5.md]
confidence: high
---

# Kolmogorov-Arnold Networks (KAN)

## 개요

**KAN (Kolmogorov-Arnold Networks)** 는 Liu et al. (MIT/Caltech, 2024)이 제안한 신경망 아키텍처로, 기존 MLP가 **노드(node)**에 고정된 활성화 함수를 사용하는 것과 달리 **엣지(edge)**에 학습 가능한 B-spline 활성화 함수를 배치한다. Kolmogorov-Arnold representation theorem에 이론적 기반을 두어 더 작은 모델로 더 높은 정확도를 달성한다.

## 핵심 아이디어

**MLP vs KAN 비교:**

| | MLP | KAN |
|---|-----|-----|
| 활성화 함수 위치 | Node (고정) | Edge (학습 가능, B-spline) |
| 이론적 기반 | Universal Approximation Theorem | Kolmogorov-Arnold Theorem |
| 파라미터 | weight 행렬 | B-spline 제어점 + scale |
| 해석성 | 낮음 (black box) | 높음 (spline 시각화 가능) |
| catastrophic forgetting | 있음 | 지역적 spline으로 더 견고 |

## 주요 특징

1. **B-spline 활성화:** 각 edge는 학습 가능한 B-spline 곡선으로 표현 — 국소적이고 부드러운 함수 근사
2. **Kolmogorov-Arnold 정리:** "모든 다변수 연속함수는 1변수 함수의 합성으로 표현 가능" — KAN의 이론적 정당성
3. **스케일링 장점:** 동일한 표현력에서 MLP보다 파라미터 수가 적음
4. **해석성**: 각 edge의 spline 곡선을 직접 시각화하여 학습된 함수 형태를 해석 가능
5. **Neurological inspiration:** 실제 뉴런 시냅스의 비선형 전달 특성을 반영

## 성능

- 작은 KAN(2-layer, ~200 파라미터)이 300-파라미터 MLP를 초월
- PDE 해법, 데이터 피팅에서 MLP 대비 우수한 scaling law
- 특히 고차원 함수 근사에서 강점

## 한계 및 도전 과제

- 학습 속도: B-spline 평가가 MLP보다 느림 (현재 B-spline 구현 최적화 중)
- B-spline knot 최적화 필요
- Wasserstein-2 거리 측면에서 MLP 연속 근사 가능 (Li & Zhang, 2024)

## 융합 도메인 연결

KAN은 [[physics-informed-neural-networks|PINN]]의 대체 아키텍처로 유망: B-spline 기반의 물리 법칙 인코딩이 용이하고, spline 시각화로 물리적 해석이 가능. [[fourier-neural-operator|FNO]]와의 결합 가능성도 연구되고 있다.

## References

- [[residual-networks]] — Skip connection vs spline-based activation
- [[transformer]] — 대안적 아키텍처 혁신 사례
- [[physics-informed-neural-networks]] — KAN-based PINN 가능성
- [[nn-tricks]] — Practical training tips
- [[fourier-neural-operator]] — Operator learning의 또 다른 접근
