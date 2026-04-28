---
title: FNO vs DeepONet — Operator Learning 접근법 비교
created: 2026-04-28
updated: 2026-04-28
type: comparison
tags: [comparison, surrogate-model, mathematics, neural-network, physics-informed]
sources: [raw/papers/2010.08895v3.md, raw/papers/2281727.md]
---

# FNO vs DeepONet — Operator Learning 접근법 비교

**Fourier Neural Operator (FNO, ICLR 2021)**와 **DeepONet (Deep Operator Networks, 2021)**는 모두 미분방정식 계열의 **solution operator**를 학습하는 신경 연산자(neural operator) 접근법이다. 목표는 동일하지만(함수 공간 간 매핑 학습), **수학적 기반과 아키텍처 설계**가 근본적으로 다르다.

## 비교 표

| 차원 | FNO (Fourier Neural Operator) | DeepONet (Deep Operator Networks) |
|------|-------------------------------|-----------------------------------|
| **핵심 메커니즘** | Fourier 공간에서 적분 커널 매개변수화: $\mathcal{F}^{-1}(R_\theta \cdot \mathcal{F}(v))(x)$ | Branch Net + Trunk Net의 내적: $\sum b_k(f) \cdot t_k(y)$ |
| **수학적 기반** | Fourier convolution 정리 + Green 함수 | Operator Universal Approximation Theorem (Chen & Chen, 1995) |
| **아키텍처** | 단일 네트워크 + Fourier Layer (FFT 공간 변환) | 2개 서브네트워크 (Branch: 함수 인코딩, Trunk: 위치 인코딩) |
| **입력 형식** | 함수 값을 균일 그리드에서 샘플링 (FFT 필요) | 함수 값을 센서 위치 $m$개에서 샘플링 (불균일 가능) |
| **Discretization 의존성** | **불변 (invariant)** — zero-shot super-resolution 가능 | **의존적** — 센서 개수/위치 고정 필요 |
| **출력 형식** | 전체 공간 동시 예측 | 단일 점 단위로 출력 위치 쿼리 |
| **장점** | • FFT로 효율적 연산 ($O(n\log n)$)<br>• Zero-shot resolution 확장<br>• 난류 Navier-Stokes에 첫 성공 | • 불균일 그리드 지원<br>• 임의 위치에서 쿼리 가능<br>• 적은 데이터로도 학습 가능 |
| **단점** | • 균일 그리드 필수 (비정형 mesh 부적합)<br>• 고주파 모드 truncation으로 해상도 한계 | • 센서 위치 $m$에 민감<br>• 점 단위 출력으로 전체 공간 예측에 $O(N)$ 비용 |
| **대표 응용** | Burgers, Darcy flow, Navier-Stokes (난류), Weather forecasting | ODE/PDE 식별, Parametric PDE surrogate, Dynamical systems |
| **창시 연구진** | Zongyi Li, Anima Anandkumar (Caltech) | Lu Lu, George Em Karniadakis (Brown) |

## 핵심 차이: 적분 변환 vs 분해 학습

| 측면 | FNO | DeepONet |
|------|-----|----------|
| 함수 표현 방식 | **전역 주파수 기반** — Fourier 모드로 함수 표현 | **분해 기반** — Branch(함수) × Trunk(위치)로 분해 |
| 그리드 유연성 | 균일 그리드만 가능 | 모든 그리드 유형 지원 |
| 이론적 보장 | 경험적 성공 (이론 분석 진행 중) | Operator UAT (강력한 이론적 근거) |
| 연산 복잡도 | $O(n\log n)$ (FFT 우위) | $O(m + n)$ (일반적으로 더 빠름) |
| 하이브리드 가능성 | FFT 계층을 DeepONet branch에 통합 가능 | PI-DeepONet, Physics-informed DeepONet |

## 언제 무엇을 선택할까?

| 사용 사례 | 권장 |
|-----------|------|
| **균일 그리드 기반 대규모 시뮬레이션 (CFD, 기상)** | FNO |
| **비정형/불균일 mesh (FEM, 구조 해석)** | DeepONet |
| **Zero-shot super-resolution 필요** | FNO |
| **적은 데이터로 빠른 프로토타이핑** | DeepONet |
| **임의 위치에서 쿼리 필요 (inverse design)** | DeepONet |
| **난류/고주파 현상 모델링** | FNO (검증됨) |

## 미래 방향

두 방법은 점점 융합되고 있다:
- **FNO + DeepONet hybrid:** FFT layer를 DeepONet의 trunk network에 통합
- **Fourier-DeepONet:** FNO의 Fourier feature를 DeepONet 입력으로 사용
- **PDNO:** FNO와 DeepONet 모두를 일반화한 pseudo-differential operator 프레임워크

## 관련 페이지

- [[fourier-neural-operator]] — FNO 상세
- [[deeponet]] — DeepONet 상세
- [[pseudo-differential-neural-operator]] — PDNO (FNO 일반화)
- [[physics-constrained-surrogate]] — Surrogate modeling 개요
- [[pinn-vs-deeponet]] — PINN vs DeepONet 비교 (operator vs function)
