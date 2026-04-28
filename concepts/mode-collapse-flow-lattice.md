---
title: Mode-Collapse in Flow-based Sampling of Lattice Field Theories
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, neural-network, physics-informed, training, paper]
sources: [raw/papers/2302.14082v2.md]
confidence: high
---

# Mode-Collapse in Flow-based Sampling of Lattice Field Theories

## 개요

Kim A. Nicoli, Christopher J. Anders, Tobias Hartung, Karl Jansen, Pan Kessel, Shinichi Nakajima (2023)은 **normalizing flow** 기반 격자 장론 샘플링에서 발생하는 **mode-collapse** 문제를 체계적으로 분석하고 완화 전략을 제시한다^[raw/papers/2302.14082v2.md].

## 핵심 문제

### Mode-Collapse in Normalizing Flows

- Normalizing flow는 reverse-KL divergence로 훈련할 때 **mode-seeking** 행동을 보임
- 다중 모드(multi-modal) 분포에서 일부 모드에 확률 질량을 거의 할당하지 않음 (mode-dropping)
- 물리 관측값(observables)에 상당한 bias 초래
- 이는 "tunneling problem"이 단순히 샘플링 단계에서 훈련 단계로 이동한 것과 같음

### Forward-KL vs Reverse-KL

| 특성 | Reverse-KL | Forward-KL |
|------|-----------|-----------|
| 샘플링 방식 | Self-sampling (flow에서 직접 샘플) | Target 분포에서 샘플 (HMC 등) |
| Mode Coverage | Mode-seeking (mode-drop 위험) | Mode-covering (안전) |
| 훈련 비용 | 낮음 (self-sampling) | 높음 (target 샘플 필요) |
| 열역학 관측값 | 부적합 | **적합** |

## 완화 전략

1. **Forward-KL 훈련 사용**: 열역학 관측값(자유 에너지 등) 추정 시 forward-KL 사용 권장
2. **p-estimator와 q-estimator 결합**: 두 estimator를 결합하여 bias 완화
3. **Mode-collapse 정량화 메트릭 제안**: Definition 1의 effective support 개념 도입

### 이론적 기여

- Mode-collapse로 인한 bias의 이론적 하한(bound) 유도
- Effective support와 mode-dropping set의 수학적 정의
- 2차원 $\phi^4$ scalar theory 실험으로 검증

## 관련 개념

- [[conditional-normalizing-flow-lattice]] — Lattice sampling의 다른 접근법 (C-NF)
- [[hierarchical-autoregressive-networks]] — 다른 sampling 접근법 (HAN)
- **Normalizing Flow** — 기본 생성 모델
- **Neural Importance Sampling (NIS)** — Free energy 추정 방법
- **Hybrid Monte Carlo (HMC)** — 기존 lattice 샘플링 알고리즘