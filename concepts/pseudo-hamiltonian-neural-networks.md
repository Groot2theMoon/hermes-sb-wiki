---
title: Pseudo-Hamiltonian Neural Networks (PHNN) for PDEs
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, physics-informed, surrogate-model, fluid-dynamics, mathematics, paper]
sources: [raw/papers/1-s2.0-S0021999123008343-main.md]
confidence: high
---

# Pseudo-Hamiltonian Neural Networks for PDEs

## 개요

**Pseudo-Hamiltonian Neural Networks (PHNN)** 은 Sølve Eidnes와 Kjetil Olsen Lye (SINTEF Digital)가 제안한 방법으로, **편미분방정식(PDE)으로 표현되는 물리계의 역문제(inverse problem)** 를 해결하기 위한 구조화된 신경망 모델이다^[raw/papers/1-s2.0-S0021999123008343-main.md]. 기존의 Hamiltonian Neural Networks (HNN)를 PDE로 확장한 것으로, 보존(conservation), 소산(dissipation), 외력(external forces) 항을 각각 별도의 신경망으로 모델링한다.

## 핵심 아이디어

### Pseudo-Hamiltonian Formulation

PHNN은 다음 형태의 PDE를 학습한다:

$$u_t = S(u^\sigma, x) \frac{\delta H}{\delta u}[u] - R(u^\sigma, x) \frac{\delta V}{\delta u}[u] + f(u^\sigma, x, t)$$

여기서:
- $S$: 반대칭(skew-symmetric) 연산자 — 보존 항
- $R$: 양의 준정부호(positive semi-definite) 연산자 — 소산 항
- $H, V$: 적분 형태의 저장 함수(integral functionals)
- $f$: 외력 항

### 신경망 구조

PHNN 모델은 최대 6개의 학습 가능한 서브모델로 구성된다:

1. **$\hat{H}_\theta$, $\hat{V}_\theta$**: 적분 범함수(integral functional)를 근사하는 CNN (kernel size 2)
2. **$\hat{A}_\theta^{[k_1]}$, $\hat{S}_\theta^{[k_2]}$, $\hat{R}_\theta^{[k_3]}$**: 순환 합성곱 연산자(convolution operators) — 각각 대칭, 반대칭, 대칭 조건 부과
3. **$\hat{f}_\theta$**: 외력을 모델링하는 DNN

### 핵심 특징

- **구조 보존**: 각 서브모델에 물리적 제약조건(대칭성, 양의 정부호성 등)을 부과
- **모듈 분리**: 학습 후 보존/소산/외력을 분리하여 분석 가능
- **사전 지식 통합**: 계가 Hamiltonian이라는 것이 밝혀지면 재학습 없이 제약 부과 가능
- **외력 제거**: 외력이 있는 환경에서 학습 후 외력을 제거한 이상 조건 모델 획득 가능

## 수치 실험 결과

5가지 테스트 케이스에서 검증:
1. **KdV-Burgers 방정식** — 소산성 KdV
2. **BBM 방정식** — 장파 분산 모델
3. **이방성 확산 방정식** — 이미지 노이즈 제거
4. **Perona-Malik 방정식** — 에지 보존 확산
5. **Cahn-Hilliard 방정식** — 상분리 동역학

Informed PHNN 모델이 baseline (단일 NN으로 전체 동역학 모델링)보다 일관되게 우수한 성능을 보였다.

## 장점 및 한계

| 장점 | 한계 |
|------|------|
| 물리적 해석 가능성 | 초기화에 민감 |
| 데이터 효율성 | 여러 번 학습 필요 (최적 선택) |
| 외력/소산 분리 가능 | 일반 PHNN 모델이 baseline보다 초기화 민감도 높음 |
| 사전 지식 통합 용이 | 연산자 형태에 대한 가정 필요 |

## References

- S. Eidnes, K.O. Lye, "Pseudo-Hamiltonian neural networks for learning partial differential equations", *J. Comput. Phys.* 2023
- [[physics-informed-neural-networks]] — PINN도 PDE의 역문제 해결
- [[fourier-neural-operator]] — Neural operator 기반 PDE 해결