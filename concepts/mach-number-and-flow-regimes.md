---
title: Mach Number and Flow Regimes — Subsonic to Hypersonic
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [fluid-dynamics, foundation, pure-mechanics]
sources: [raw/papers/gasdynamic-lecture-3-compressibility-sound.md]
confidence: high
---

# Mach Number and Flow Regimes

## Mach Number

Mach 수(M)는 유동 속도와 국소 음속의 비로 정의된다:

$$ M = \frac{U}{a}, \quad M_\infty = \frac{U_\infty}{a_\infty} $$

- **Local Mach number M:** 유동장 내 각 지점에서 속도와 국소 음속의 비 — 지점마다 다름
- **Free-stream Mach number M∞:** 자유류 속도와 자유류 음속의 비

## Flow Regimes

| Regime | M∞ 범위 | 특징 |
|--------|---------|------|
| **Subsonic** | M∞ ≤ 0.8 | 국소 M이 모든 지점에서 1 미만 (에어포일 기준) |
| **Transonic** | 0.8 ≤ M∞ ≤ 1.2 | M∞는 아음속이나 일부 영역에서 국소 M > 1 (국소 초음속 포켓) |
| **Supersonic** | M > 1 | 모든 지점에서 국소 M > 1 |
| **Hypersonic** | M∞ > 5 | 경사 충격파가 물체 표면에 근접, 충격파-물체 사이 유동 극고온 |

## Mach Cone

점음원이 유동 내에서 방출하는 구형 압력파의 전파 패턴:

| M | 거동 |
|---|------|
| M < 1 (subsonic) | 구형 파면이 하류로 변위되나 모든 유체가 결국 교란됨 |
| M = 1 (sonic) | 파면이 상류로 전파되지 않음 — "zone of silence" 형성 |
| M > 1 (supersonic) | 구형 파면이 하류로 쓸려 **Mach cone** 형성 |

**Mach angle μ:**
$$ \sin\mu = \frac{1}{M} = \frac{a}{U} $$

Mach cone은 음원의 영향이 미치는 횡방향 범위를 정의하며, Mach wave는 cone의 표면이다.

## Speed of Sound as Information Speed

음속 a는 미소 교란(small disturbance)에 대한 압력 정보의 최대 전파 속도이다. 강한 압력 펄스(충격파, 폭발)는 음속보다 빠르게 이동할 수 있다.

## Practical Example — Concorde

Concorde는 M = 2.02–2.04로 순항, 고도 55,000–60,000ft에서 주변 공기 온도 T = −56.5°C (≈217 K):

$$ T_0 = T\left(1 + \frac{\gamma-1}{2}M^2\right) = 217\left(1 + \frac{1.4-1}{2} \times 2.02^2\right) \approx 394\text{ K} \approx 121\text{°C} $$

기체 재질인 Hiduminium RR58의 임계 온도가 127°C였기 때문에, **순항 Mach 수는 실질적으로 stagnation temperature T₀에 의해 결정**되었다.

## References

- [[compressibility-and-speed-of-sound]] — 음속의 물리적 유도
- [[stagnation-properties]] — 전온도/전압과 Mach 수의 관계
- [[compressible-flow-governing-equations]] — 압축성 유동 지배 방정식
- [[knudsen-number-and-continuum]] — 연속체 가정의 타당성 (hypersonic 영역에서 중요)
