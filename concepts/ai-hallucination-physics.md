---
title: AI Hallucination in Fluid/Physics Simulation
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [physics-informed, fluid-dynamics, model, benchmark, paper]
sources: [raw/papers/trending/2026-04-28-01.md]
confidence: medium
---

# AI Hallucination in Fluid/Physics Simulation

## 개요

AI 기반 유체/물리 시뮬레이션 모델이 **시각적으로는 그럴듯하지만 물리적으로는 불가능한 결과(hallucination)**를 생성하는 현상. 이는 LLM의 hallucination과 유사하게, 모델이 훈련 데이터의 통계적 패턴을 학습했으나 물리적 보존 법칙을 위반하는 해를 생성하는 경우를 의미한다.

Wibawa & Jha (2026)는 점성 손가름(viscous fingering) 문제에서 AI 모델 hallucination의 **최초의 체계적 증거**를 보고했다^[raw/papers/trending/2026-04-28-01.md].

## 주요 발견

| 현상 | 설명 |
|------|------|
| **가짜 유체 경계면** | 존재하지 않는 유체 경계면을 생성 |
| **역확산 (reverse diffusion)** | 보존 법칙을 위반하는 물질 확산 방향 역전 |
| **Spectral bias 기원** | 고유속·고점도비에서 spectral bias가 지배적이 되어 hallucination 유발 |
| **LLM 유사성** | LLM의 hallucination과 메커니즘적 유사성 — "그럴듯하지만 틀린" 출력 |

## 기존 PINN Failure와의 차별성

기존 [[pinn-failure-modes]] 연구는 NTK 관점에서 PINN의 학습 실패(수렴 속도 불균형)를 분석한 반면, 이 연구는 AI 모델의 **추론 결과 자체가 물리 법칙을 위반**할 수 있음을 보여준다. 이는 PINN에 국한되지 않고 FNO, DeepONet 등 모든 surrogate model에 적용되는 근본적 한계이다.

## 해결 방안: DeepFingers

동일 논문에서 제안된 DeepFingers 프레임워크는 다음을 결합한다:
- **Fourier Neural Operator + Deep Operator Network** 조합
- **전체 공간 모드에 걸친 균형 학습** (balanced spectral learning)
- 시간 및 점도 대비(viscosity contrast)에 조건화된 진화 매핑

DeepFingers는 tip splitting, finger merging, channel formation을 정확히 포착하면서 global mixing metric을 보존한다.

## 융합 도메인 의미

- AI 기반 물리 시뮬레이션의 **신뢰성(trustworthiness)** 에 대한 근본적 의문 제기
- 공학 설계에 AI surrogate model 적용 시 **검증(validation) 프로토콜**의 중요성 부각
- [[fourier-neural-operator]]와 [[physics-informed]] 모델 간의 spectral 충실도 차이 실증

## References
- Wibawa & Jha, "AI models of unstable flow exhibit hallucination", *arXiv:2604.20372*, 2026
- [[pinn-failure-modes]] — PINN 학습 실패의 NTK 분석 (보완적 관점)
- [[fourier-neural-operator]] — Spectral 기반 연산자 학습
- [[deeponet]] — Deep Operator Network
