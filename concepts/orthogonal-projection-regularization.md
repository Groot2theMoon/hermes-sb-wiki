---
title: Orthogonal Projection Regularization for Efficient Model Augmentation
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [model, paper, system-identification, physics-informed, hybrid-modeling]
sources: [raw/papers/gyorok25a.md]
confidence: high
---

# Orthogonal Projection Regularization for Model Augmentation

## 개요

**Győrök, Hoekstra, Kon et al.** (SZTAKI / TU Eindhoven, 2025)는 **first-principle (FP) 물리 모델 + additive neural network** 하이브리드 모델링에서 발생하는 **overparametrization과 비식별성(non-identifiability)** 문제를 해결하는 **직교 투영 기반 정규화(orthogonal projection regularization)** 기법을 제안했다^[raw/papers/gyorok25a.md].

## 문제: Additive Model Augmentation의 비식별성

### 모델 구조

$$\hat{x}_{k+1} = f_\theta(\hat{x}_k, u_k) + f_\eta^{\text{ANN}}(\hat{x}_k, u_k)$$

- $f_\theta$: 해석 가능한 물리 기반 FP 모델 (e.g., 단일 트랙 차량 모델)
- $f_\eta^{\text{ANN}}$: 잔차(residual)를 학습하는 신경망

### 비식별성 문제

FP 모델과 ANN이 병렬로 연결되어 있어, 동일한 입력-상태 거동을 생성하는 $(\theta, \eta)$ 쌍이 무수히 많음:
- $f_\theta$가 이미 학습할 수 있는 동역학을 $f_\eta^{\text{ANN}}$도 학습 → 물리 파라미터가 비현실적 값으로 수렴
- 물리 모델의 해석 가능성과 외삽(extrapolation) 능력 상실

## 핵심 방법: 직교 투영 정규화

### 아이디어

ANN의 출력을 FP 모델의 출력 공간과 **직교(orthogonal)**하도록 제약:
- $f_\eta^{\text{ANN}}$이 $f_\theta$가 이미 표현할 수 있는 성분을 학습하지 못하게 함
- $f_\eta^{\text{ANN}}$은 오직 FP 모델이 설명하지 못하는 **미지의 동역학**에 집중

### 선형 파라미터 경우 (원본 Kon et al.)

FP 모델이 $\theta$에 선형일 때: $f_\theta(x,u) = \phi(x,u)\theta$

1. 데이터 행렬 $\Phi(X,U)$의 SVD로 출력 공간의 기저(basis) $Q_{X,U}$ 계산
2. 투영 행렬 $\Pi_{X,U} = Q_{X,U}Q_{X,U}^\top$
3. 정규화 항: $\beta\|\Pi_{X,U}f_\eta^{\text{ANN}}(X,U)\|_2^2$을 손실 함수에 추가

### 비선형 파라미터로의 일반화 (본 논문의 기여)

Taylor 전개로 근사: $f_\theta(\hat{x},u) \approx \Phi_{\bar{\theta}}(\hat{x},u)\theta + \Gamma_{\bar{\theta}}(\hat{x},u)$

확장된 $\tilde{\Phi}_{\bar{\theta}} = [\Phi_{\bar{\theta}} \quad \Gamma_{\bar{\theta}}]$에 SVD 적용 → 동일한 직교화 프레임워크 적용 가능.

## 실험: F1Tenth 자율주행 차량

### 모델 구성
- **FP 모델:** Single-track vehicle dynamics (6D state, 9개 물리 파라미터)
- **ANN:** 2 hidden layers × 64 nodes, tanh activation
- **데이터:** MuJoCo 시뮬레이터로 15,985 포인트 수집

### 결과

| 방법 | NRMS Error |
|:-----|:----------:|
| FP only (nominal $\theta_0$) | 37.91% |
| FP only (co-est. w/o reg.) | 118.01% ❌ |
| FP only (co-est. w/ orth. reg.) | **36.07%** ✅ |
| Augmented (fixed $\theta_0$) | 3.61% |
| Augmented (co-est. w/o reg.) | 3.45% |
| Augmented (co-est. w/ orth. reg.) | **3.00%** ✅ |

**Key insight:** 직교 정규화 없이 co-estimation하면 FP 모델 단독 성능이 급락(118%)하지만, 직교 정규화 적용 시 FP 모델도 개선(36%).

## 실용적 가이드라인

- $\beta$ 값: $[10^{-7}, 10^{-5}]$ 범위에서 최적 (noiseless 기준)
- Noise 환경에서도 효과적 (30dB, 25dB SNR)
- Black-box 대비 약간의 정확도 손실(<1% NRMS) 대신 완전한 물리 해석 가능성 확보

## 융합 도메인 연결

- [[physics-informed-neural-networks]] — 물리 정보를 학습에 통합하는 대안적 접근
- [[deep-material-network]] — 물리+ML 하이브리드의 재료공학 응용
- [[physics-informed-temporal-unet]] — 시계열 물리 모델링

## References

- Győrök, B.M., Hoekstra, J.H., Kon, J., et al. (2025). Orthogonal projection-based regularization for efficient model augmentation. L4DC.
