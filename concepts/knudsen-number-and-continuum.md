---
title: Knudsen Number and Continuum Assumption — Flow Regime Classification
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [fluid-dynamics, foundation, pure-mechanics]
sources: [raw/papers/gasdynamic-lecture-2-governing-equations.md]
confidence: high
---

# Knudsen Number and Continuum Assumption

## Knudsen Number

Knudsen 수(Kn)는 분자 평균 자유 행로(mean free path)와 특성 길이 스케일의 비로, 유동의 연속체 정도를 나타내는 무차원수:

$$ Kn = \frac{\lambda}{L} $$

- λ — mean free path (분자 충돌 간 평균 이동 거리)
- L — characteristic length scale

고도가 증가함에 따라 밀도가 감소하고 λ가 증가하므로 Kn 수가 커진다.

## Flow Regime Classification

| Kn 범위 | 유동 영역 | 기술 |
|---------|-----------|------|
| Kn ≤ 0.01 | **Continuum flow** | 연속체 가정 유효, Navier-Stokes 방정식 적용 가능 |
| 0.01 < Kn < 0.1 | **Slip flow** | 벽면에서 slip 경계 조건 필요 |
| 0.1 ≤ Kn < 10 | **Transitional flow** | 연속체와 자유 분자 흐름 사이 전이 영역 |
| Kn ≥ 1 | **Free molecular flow** | 분자 간 충돌 무시, 개별 분자 궤적 추적 |

## Gas Dynamics 1의 범위

Gas Dynamics 1 과정에서는 **Kn ≤ 0.01 (continuum flow)** 인 경우만 다룬다. 즉, Navier-Stokes/Euler 방정식 기반의 연속체 해석이 유효한 영역이다.

## 대기 고도별 적용

| 고도 | 밀도 | Mean free path | L = const 기준 |
|------|------|----------------|----------------|
| Low (< 50 km) | 높음 | 작음 | Kn ≪ 0.01 — fully continuum |
| Mid (50–200 km) | 중간 | 중간 | Kn ~ 0.01–0.1 — slip/transitional |
| High (> 200 km) | 낮음 | 큼 | Kn > 0.1 — rarefied flow |

## Hypersonic 영역에서의 중요성

극초음속(M∞ > 5)에서는 충격파 뒤의 고온으로 인해 공기 분자의 해리(dissociation), 이온화가 발생하고 γ가 더 이상 상수가 아니며, 복사 열전달이 중요해진다. 실제 Space Shuttle의 최대 stagnation temperature는 약 1650°C로, 단순 단열 관계식으로 예측한 22,000 K보다 훨씬 낮다.

## References

- [[compressible-flow-governing-equations]] — 연속체 기반 지배 방정식
- [[mach-number-and-flow-regimes]] — hypersonic 영역에서 continuum 가정의 한계
- [[stagnation-properties]] — 고속 비행체 열 설계와의 연관
