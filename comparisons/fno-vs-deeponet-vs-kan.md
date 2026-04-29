---
title: FNO vs DeepONet vs KAN — Operator Learning 3-way 비교
created: 2026-04-29
updated: 2026-04-29
type: comparison
tags: [comparison, surrogate-model, neural-network, mathematics, physics-informed, model]
sources: [raw/papers/2010.08895v3.md, raw/papers/2281727.md, raw/papers/2404.19756v5.md]
---

# FNO vs DeepONet vs KAN — Operator Learning 3-way 비교

**Fourier Neural Operator (FNO)**, **DeepONet**, **Kolmogorov-Arnold Networks (KAN)**은 모두 함수 공간 간의 매핑을 학습하는 neural operator 접근법이다. FNO는 Fourier 공간에서 적분 커널을, DeepONet은 Branch-Trunk 분해를, KAN은 B-spline 기반 learnable activation을 사용한다.

## 비교 표

| 차원 | [[fourier-neural-operator|FNO]] | [[deeponet|DeepONet]] | [[kolmogorov-arnold-networks|KAN]] |
|------|----------------------------------|------------------------|--------------------------------------|
| **핵심 메커니즘** | Fourier 공간 적분 커널: $\mathcal{F}^{-1}(R_\theta \cdot \mathcal{F}(v))$ | Branch-Trunk 내적: $\sum b_k(f) \cdot t_k(y)$ | Edge-wise B-spline 활성화 함수 |
| **수학적 기반** | Fourier convolution 정리 + Green 함수 | Operator UAT (Chen & Chen, 1995) | Kolmogorov-Arnold representation theorem |
| **아키텍처** | 단일 네트워크 + Fourier Layer | 2개 서브네트워크 (Branch + Trunk) | MLP 구조, edge에 B-spline 배치 |
| **활성화 함수** | 고정 (GELU 등) | 고정 (GELU 등) | **학습 가능** (B-spline per edge) |
| **Discretization** | **불변** — zero-shot super-resolution | **의존적** — 센서 위치 고정 | 유연 — spline 기반 국소 근사 |
| **해석성** | 낮음 (Fourier mode만 시각화) | 중간 (Branch/Trunk 분리로 부분 해석) | **높음** (각 edge spline 직접 시각화) |
| **연산 복잡도** | $O(n \log n)$ (FFT) | $O(m + n)$ | B-spline 평가 비용 (최적화 중) |
| **입력 형태** | 균일 그리드 (FFT 필요) | 임의 위치 센서 샘플 | 임의 차원 함수 |
| **대표 응용** | CFD, 난류, 기상 예측 | ODE/PDE 식별, dynamical systems | PDE 해법, 데이터 피팅, symbolic regression |

## 핵심 차이: 3가지 패러다임

| 측면 | FNO | DeepONet | KAN |
|------|-----|----------|-----|
| **함수 표현** | 전역 주파수 기반 | 분해 기반 (Branch × Trunk) | 국소 spline 기반 |
| **이론적 보장** | 경험적 (이론 분석 진행 중) | 강력 (Operator UAT) | Kolmogorov-Arnold 정리 |
| **스케일링** | 해상도 확장 용이 | 센서 수에 민감 | 파라미터 효율적 (MLP 대비) |
| **물리 제약 통합** | Fourier feature 제약 | PI-DeepONet | B-spline로 물리 법칙 인코딩 |
| **Catastrophic forgetting** | 있음 | 있음 | **더 견고** (지역적 spline) |

## 성능 비교

| 벤치마크 | FNO | DeepONet | KAN |
|---------|-----|----------|-----|
| **Burgers 방정식** | ★★★ | ★★ | ★★★ |
| **Darcy flow** | ★★★ | ★★ | ★★★ |
| **Navier-Stokes (난류)** | ★★★ (검증됨) | ★★ | 미검증 |
| **고차원 함수 근사** | ★★ | ★★ | ★★★ |
| **적은 데이터** | ★★ | ★★★ | ★★★ |
| **해석성 필요** | ★ | ★★ | ★★★ |

## 언제 무엇을 쓸까?

| 사용 사례 | 권장 | 이유 |
|-----------|------|------|
| **균일 그리드 대규모 CFD** | FNO | FFT 효율성 + zero-shot super-resolution |
| **비정형 mesh / FEM** | DeepONet | 불균일 그리드 지원 |
| **물리 법칙 발견 (symbolic)** | KAN | spline 시각화로 학습된 함수 해석 |
| **적은 데이터 프로토타이핑** | DeepONet / KAN | 적은 샘플로 학습 가능 |
| **고차원 함수 근사** | KAN | MLP 대비 파라미터 효율적 |
| **기상 예측 / 난류** | FNO | 검증된 SOTA 성능 |
| **Continual learning** | KAN | 지역적 spline으로 catastrophic forgetting 완화 |

## 융합 전망

세 방법은 점점 융합되고 있다:
- **FNO + KAN:** Fourier layer를 KAN의 spline과 결합
- **DeepONet + KAN:** KAN을 branch/trunk network로 사용
- **FNO + DeepONet hybrid:** FFT를 DeepONet trunk에 통합
- **PDNO:** FNO와 DeepONet 모두를 일반화한 pseudo-differential operator 프레임워크

## 관련 페이지

- [[fourier-neural-operator]] — FNO 상세
- [[deeponet]] — DeepONet 상세
- [[kolmogorov-arnold-networks]] — KAN 상세
- [[fno-vs-deeponet]] — FNO vs DeepONet 2-way 비교
- [[pinn-vs-deeponet]] — PINN vs DeepONet 비교
- [[physics-constrained-surrogate]] — Surrogate modeling 개요
