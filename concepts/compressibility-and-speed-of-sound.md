---
title: Compressibility and Speed of Sound — Newton vs Laplace
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [fluid-dynamics, thermodynamics, foundation, pure-mechanics]
sources: [raw/papers/gasdynamic-lecture-3-compressibility-sound.md, raw/papers/gasdynamic-thermodynamics-review.md]
confidence: high
---

# Compressibility and Speed of Sound

## Compressibility

Compressibility β는 유체 요소가 압력 변화에 반응하여 체적이 상대적으로 변화하는 정도로 정의된다:

$$ \beta = -\frac{1}{V}\frac{dV}{dp} = \frac{1}{\rho}\frac{d\rho}{dp} $$

두 가지 중요한 유형:

| Type | Definition | Condition |
|------|-----------|-----------|
| Isothermal | $$\beta_T = -\frac{1}{V}\left.\frac{dV}{dp}\right\|_T$$ | T = const |
| Isentropic | $$\beta_S = -\frac{1}{V}\left.\frac{dV}{dp}\right\|_S$$ | S = const (adiabatic + reversible) |

**예시 — 공기 (표준 조건, p = 101,325 Pa):**

| | β_T | β_S |
|---|-----|-----|
| 공기 | 9.87×10⁻⁶ Pa⁻¹ | 7.05×10⁻⁶ Pa⁻¹ |
| 물 | 4.6×10⁻¹⁰ Pa⁻¹ | 4.4×10⁻¹⁰ Pa⁻¹ |

이상 기체의 경우:
$$ \beta_T = \frac{1}{p}, \quad \beta_S = \frac{1}{\gamma p} $$

## Speed of Sound — Derivation

음속은 압력 펄스가 매질을 통해 전파되는 속도이다. 1D 정상 유동에서 압력 펄스를 정지 프레임으로 변환하여 연속 방정식과 운동량 방정식을 적용:

**Continuity:** $$ \rho a = (\rho + d\rho)(a + du) \Rightarrow a\,d\rho + \rho\,du = 0 $$

**Momentum:** $$ -dp = 2\rho a\,du + d\rho\,a^2 $$

연속 방정식에서 $$\rho\,du = -a\,d\rho$$ 를 대입:
$$ a^2 = \frac{dp}{d\rho} \quad\Rightarrow\quad a = \sqrt{\frac{dp}{d\rho}} $$

## Newton's Error — Isothermal Assumption (1687)

Newton은 음파 전파 과정이 등온적이라고 가정하고 Boyle의 법칙(p = Cρ)을 적용:

$$ a = \sqrt{\frac{dp}{d\rho}} = \sqrt{\frac{p}{\rho}} \approx 287.6\text{ m/s (표준 조건)} $$

→ 실제 측정값(~340 m/s)과 약 15% 오차.

## Laplace's Correction — Isentropic Process (1816)

Laplace는 음파 전파가 **단열적(adiabatic)**이고 **가역적(reversible)**인 등엔트로피 과정임을 제시. 이상 기체의 등엔트로피 관계 p = Cρ^γ 사용:

$$ a = \sqrt{\left.\frac{dp}{d\rho}\right\|_S} = \sqrt{\frac{\gamma p}{\rho}} $$

이상 기체 법칙(p = ρR_sT)을 적용:
$$ a = \sqrt{\gamma R_s T} $$

**공기 표준 조건 (γ = 1.4, R_s = 287 J/(kg·K)):**
$$ a = \sqrt{1.4 \times 287 \times 288.15} \approx 340.3\text{ m/s} $$

## 음속과 압축성의 관계

$$ a = \sqrt{\frac{v}{\beta_S}} $$

→ 비압축성 유동(β_S → 0)에서는 음속이 무한대(a → ∞)

## References

- [[compressible-flow-governing-equations]] — 지배 방정식 시스템
- [[mach-number-and-flow-regimes]] — Mach 수 기반 유동 분류
- [[isentropic-relations]] — 등엔트로피 과정의 열역학적 유도
- [[stagnation-properties]] — 음속과 연계된 전온도/전압 개념
