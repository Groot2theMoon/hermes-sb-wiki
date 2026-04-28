---
title: AI/ML Applications in Wind Energy
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [physics-informed, CFD, surrogate-model, fluid-dynamics, optimization]
sources: [raw/papers/trending/2026-04-28-03.md, raw/papers/trending/2026-04-28-01.md]
confidence: medium
---

# AI/ML Applications in Wind Energy

## 개요

AI/ML 기술은 풍력 에너지 분야에서 **후류(wake) 모델링, 출력 예측, 구조 하중 평가, 설계 최적화** 등에 활발히 적용되고 있다. 특히 부유식 해상 풍력 터빈(FOWT)의 복잡한 유체-구조 상호작용과 난류 후류 예측에 딥러닝 기반 surrogate model이 기여하고 있다.

## FNO+PINN 기반 FOWT 후류 모델링

Dong, Qin, Xu (2026)는 **Fourier Neural Operator(FNO)와 Physics-Informed Neural Networks(PINN)을 최초로 FOWT 후류 예측에 적용**했다^[raw/papers/trending/2026-04-28-03.md].

### 주요 결과

| 비교 항목 | FNO | PINN |
|-----------|-----|------|
| 난류 구조 포착 | 고주파수 구조 정확 재현 | smooth, low-pass filter 역할 |
| 훈련 속도 | 약 8배 빠름 | 상대적 느림 |
| 고조파 포착 | 2St, 3St까지 포착 | 기본 St만 포착 |
| 후류 중심 변동 | 강도 정확 모사 | 과소 평가 |

- 실험 조건: coupled surge + pitch 운동, Strouhal number 범위 St=[0, 0.6]
- FNO는 wake meandering, large/small-scale coherent structure 모두 정확히 재현
- PINN은 사실상 시공간적 low-pass filter로 작용 ([[ai-hallucination-physics]] spectral bias 문제와 연결)

## Multi-Fidelity Surrogate for Wind Loads

Fiore, Bresciani, Mendez, van Beeck (2026)는 컨테이너 선박의 **바람 하중 예측을 위한 multi-fidelity surrogate modeling 프레임워크**를 제안했다^[raw/papers/trending/2026-04-28-03.md]. 기존 실험적 모델의 한계(현대 대형 선박의 큰 windage area 미반영, 주변 구조물 영향 무시)를 극복하기 위해 고충실도 CFD 데이터와 저충실도 경험식을 결합한다.

## 관련 연구 방향

- **Wake steering** — 풍력 발전단지 최적 제어에 AI 기반 후류 예측 활용
- **FOWT 제어** — 실시간 제어를 위한 경량 surrogate model (ROM)
- **구조 건전성 모니터링** — AI를 활용한 블레이드/타워 손상 감지
- **풍력 발전량 예측** — 시계열+기상 데이터 기반 초단기 예측

## References
- Dong, Qin, Xu, "Multi-scale Dynamic Wake Modeling of FOWTs via FNO and PINN", *arXiv:2604.23937*, 2026
- Fiore et al., "Predicting Wind Loads on Container Ships through Multi-Fidelity Modeling", *arXiv:2604.22882*, 2026
- [[fourier-neural-operator]] — FNO의 수학적 기반
- [[physics-informed-neural-networks]] — PINN의 기본 원리
- [[ai-hallucination-physics]] — AI 모델 spectral bias의 근본 문제
