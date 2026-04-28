---
title: "Neural Thermodynamic Integration (Neural TI)"
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [physics-informed, surrogate-model, paper, CFD, fluid-dynamics]
sources: [raw/papers/2406.02313v4.md]
---

# Neural Thermodynamic Integration (Neural TI)

## 개요

**Neural Thermodynamic Integration (Neural TI)** 는 2024년 Balint Mate, Francois Fleuret, Tristan Bereau가 제안한 방법으로, **Energy-based Diffusion Model**을 이용해 열역학적 자유에너지 차이(free-energy difference)를 효율적으로 계산하는 기법이다. 기존 Thermodynamic Integration(TI)이 coupling parameter lambda를 따라 수십~수백 개의 중간 앙상블을 각각 시뮬레이션해야 했던 반면, Neural TI는 **단 한 번의 reference 계산**만으로 자유에너지 차이를 추정할 수 있다.

> **핵심 아이디어:** Diffusion model의 score function을 time-dependent potential의 gradient로 parametrize (= conservative score)해서, diffusion process 자체를 alchemical pathway로 활용하는 것

---

## 배경: Thermodynamic Integration (TI)

통계역학에서 두 상태 간 자유에너지 차이는 다음과 같이 coupling parameter lambda를 통한 적분으로 표현된다:

```
beta * DeltaF_0→1 = integral_0^1 dlambda * ⟨partial U_lambda / partial lambda⟩_lambda
```

여기서 lambda=0은 비상호작용계(이상기체), lambda=1은 실제 관심계(interacting system)이다. 전통적 TI는 lambda를 50~100개 구간으로 나누고 각 구간에서 별도의 분자동역학/MC 시뮬레이션을 수행해야 하므로 계산비용이 매우 높다. 또한 인접한 lambda 앙상블 간 충분한 위상공간 중첩(conformational-space overlap)이 필요하다.

---

## 방법론

### Denoising Diffusion Model (DDM)

DDM은 데이터에 점진적으로 노이즈를 추가하는 forward process와, 이를 역으로 따라가 노이즈를 제거하는 reverse process를 학습하는 생성모델이다.

- **Forward SDE:** dX = f_t * X * dt + g_t * dW (data -> noise)
- **Reverse SDE:** dY = (f_t * Y + g_t^2 * grad_x log rho_t) * dt + g_t * dW (noise -> data)

여기서 **score function** grad_x log rho_t 가 핵심이며, neural network s_theta(x,t)가 이를 근사하도록 score matching objective로 학습된다.

### Conservative Score Parametrization (핵심 innovation)

기존 DDM은 score를 free-form neural network s_theta(x,t)로 학습한다. Neural TI는 score를 **time-dependent potential U^theta_t의 gradient**로 제약한다:

```
s(x,t) = -beta * grad_x * U^theta_t(x)
```

이렇게 하면:
1. U^theta_t는 log-likelihood의 근사값이 된다 (normalization constant 제외)
2. Partial_t U^theta_t가 automatic differentiation으로 바로 계산 가능
3. Partition function 추정이 가능해진다:

```
Z_hat_N = Z^ideal_N * exp( beta * integral_0^1 dt * ⟨partial_t U^theta_t⟩_t )
```

4. Normalizing Flow와 비교: NF는 Jacobian determinant 계산이 O(D^3)으로 비싸지만, 이 방법은 scalar energy의 time derivative만 계산하면 되어 훨씬 가볍다

### 주기적 경계조건 (Periodic Boundary) 처리

분자 시뮬레이션의 주기적 경계조건을 위해 configurational space를 hypertorus T^(dN)로 모델링한다. Wrapped Gaussian의 score를 닫힌 형태로 유도하여 사용한다.

---

## 실험: Lennard-Jones Fluid

### 설정
- 3D box, N=216 입자, 주기적 경계조건
- beta=1, epsilon=0.8, sigma=1, m=1
- 밀도: rho in {0.19, 0.37, 0.56, 0.74, 0.93} (기체~고체 영역)
- 훈련: Canonical MC로 각 밀도에서 수집된 샘플로 단일 DDM 학습

### 결과
- **Radial Distribution Function (RDF):** 모든 밀도에서 정확, 기체-액체 상전이도 포착
- **과잉 화학퍼텐셜 mu_ex:** 밀도 함수로 정확, 상전이 구간 일치
- **자유에너지 차이 DeltaF:** 최대 200 k_B T까지 정확 — 기존 TI가 50~100개 중간 시뮬레이션 필요한 것과 대비

### 한계
- Score가 conservative (potential-based)해야 한다는 제약이 표현력을 제한할 수 있음
- 고밀도 영역에서 약간의 underestimation
- 분자내 자유도(intramolecular)로의 확장 필요

---

## 관련 개념

- `thermodynamic-integration` — 전통적 TI 방법
- `score-based-diffusion-models` — 생성모델로서의 diffusion model
- `energy-based-models` — 에너지 기반 모델
- [[physics-informed-neural-networks]] — 물리 정보를 활용한 신경망
- `lennard-jones-fluid` — LJ 유체 시스템
- `free-energy-computation` — 자유에너지 계산 방법론

---

## 참고문헌

- Mate et al., "Neural Thermodynamic Integration: Free Energies from Energy-based Diffusion Models", J. Phys. Chem. Lett. 2024, arXiv:2406.02313
- Code: https://github.com/balintmate/neural-thermodynamic-integration

---

## Further Reading

- Frenkel & Smit, "Understanding Molecular Simulation" Ch.7 — TI 기초
- Yang Song, "Score-Based Generative Modeling" blog (https://yang-song.net/blog/2021/score/) — DDM 기초
- Ho et al., "Denoising Diffusion Probabilistic Models" (DDPM, 2020) — DDPM 원 논문
