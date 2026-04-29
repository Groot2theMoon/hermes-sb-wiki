---
title: DIFFUSOLVE — Diffusion-based Solver for Non-Convex Trajectory Optimization
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [model, paper, trajectory-optimization, generative-model, optimal-control]
sources: [raw/papers/2403.05571v4.md]
confidence: high
---

# DIFFUSOLVE: Diffusion-based Trajectory Optimization

## 개요

**Li, Ding, Dieng & Beeson** (Princeton, 2024)는 **Diffusion Model을 비볼록 궤적 최적화(non-convex trajectory optimization)의 global search**에 활용하는 **DIFFUSOLVE**와 제약 조건을 diffusion 학습에 통합한 **DIFFUSOLVE+**를 제안했다^[raw/papers/2403.05571v4.md].

## 문제 설정

### 기존 방법의 한계

비선형 동역학 시스템의 최적 궤적 설계:
- Non-convex → 다수의 local optima 존재
- Numerical solver (e.g., direct collocation, iLQR): 초기 추측(initial guess)에 민감
- Global search 비용이 큼

### DIFFUSOLVE 접근법

**Two-stage pipeline:**
1. **Diffusion model**로 global하게 좋은 초기 궤적 생성 (warm-start)
2. **Numerical solver**로 feasibility/optimality fine-tuning

## 핵심 방법론

### DIFFUSOLVE: Standard Diffusion Warm-start

- **데이터셋:** 기존 numerical solver의 locally optimal 궤적들
- **Diffusion model:** 이 분포를 학습하여 새로운 task 조건에 맞는 초기 궤적 샘플링
- **Fine-tuning:** 생성된 궤적을 numerical solver의 초기치로 사용 → local optimum 수렴

### DIFFUSOLVE+: Constrained Diffusion

Diffusion 학습 과정에 **제약 조건(constraint) 위반 패널티**를 추가:

$$\mathcal{L}_{\text{DiffuSolve+}} = \mathcal{L}_{\text{diffusion}} + \lambda \cdot \mathcal{L}_{\text{constraint}}$$

- $\mathcal{L}_{\text{constraint}}$: 생성된 궤적이 동역학 및 경로 제약을 위반하는 정도
- 학습 중 constraint-aware 생성 → solver warm-start 시 더 적은 violation

### Condition Encoding

Task 조건 (시작/목표 상태, 장애물 등)을 diffusion model에 embedding하여 conditional generation:
- 시작 상태, 목표 상태, 환경 정보 → conditioning vector
- Classifier-free guidance로 조건-궤적 정렬 강화

## 성능 및 응용

- **비볼록 궤적 최적화 벤치마크:** Random initialization, expert initialization 대비 우수한 global optimum 도달률
- **다중 솔루션:** 하나의 task에 대해 다양한 locally optimal 궤적 생성 가능 (multimodal distribution)
- **Constraint satisfaction:** DIFFUSOLVE+가 standard diffusion 대비 constraint violation 감소

## 융합 도메인 연결

- [[diffusion-transformers-dit]] — Diffusion model의 backbone 아키텍처 (U-Net 대신 Transformer 적용 가능성)
- [[score-based-generative-modeling-sde]] — Diffusion 기반 궤적 최적화의 이론적 기반
- [[diffusion-metamaterial-inverse-design]] — Diffusion의 engineering inverse design 응용

## References

- Li, A., Ding, Z., Dieng, A.B., & Beeson, R. (2024). DIFFUSOLVE: Diffusion-based Solver for Non-Convex Trajectory Optimization. L4DC.
- [[denoising-diffusion-probabilistic-models]]
