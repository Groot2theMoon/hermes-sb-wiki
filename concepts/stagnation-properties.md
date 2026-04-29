---
title: Stagnation Properties and Critical Conditions — Gas Dynamics
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [fluid-dynamics, thermodynamics, foundation, pure-mechanics]
sources: [raw/papers/gasdynamic-lecture-3-compressibility-sound.md, raw/papers/gasdynamic-thermodynamics-review.md]
confidence: high
---

# Stagnation Properties and Critical Conditions

## 개요

압축성 유동에서 유체 요소를 단열적/등엔트로피적으로 감속시켰을 때 도달하는 기준 상태를 정의한다. 두 가지 중요한 기준 상태가 있다:

| 상태 | 조건 | 정의 |
|------|------|------|
| **Critical (★)** | Adiabatic → M = 1 | 유동을 단열적으로 M = 1로 가속/감속시킨 상태 |
| **Stagnation (₀)** | Isentropic → U = 0 | 유동을 등엔트로피적으로 속도 0으로 감속시킨 상태 |

## Stagnation (Total) Temperature

1D 단열 에너지 방정식에서 출발 (calorically perfect gas, h = c_p T):

$$ c_p T + \frac{u^2}{2} = c_p T_0 $$

$$ \frac{T_0}{T} = 1 + \frac{u^2}{2c_p T} = 1 + \frac{\gamma - 1}{2}M^2 $$

여기서 $$c_p = \frac{\gamma R_s}{\gamma - 1}$$, $$a = \sqrt{\gamma R_s T}$$ 사용.

## Stagnation Pressure and Density

등엔트로피 관계 $$p_2/p_1 = (T_2/T_1)^{\gamma/(\gamma-1)} = (\rho_2/\rho_1)^\gamma$$ 를 적용:

$$ \frac{p_0}{p} = \left(1 + \frac{\gamma - 1}{2}M^2\right)^{\frac{\gamma}{\gamma-1}} $$

$$ \frac{\rho_0}{\rho} = \left(1 + \frac{\gamma - 1}{2}M^2\right)^{\frac{1}{\gamma-1}} $$

## Critical (Sonic) Conditions

M = 1 일 때의 조건 (★). Stagnation 조건과의 관계:

$$ \frac{T^*}{T_0} = \frac{2}{\gamma + 1}, \quad \frac{p^*}{p_0} = \left(\frac{2}{\gamma + 1}\right)^{\frac{\gamma}{\gamma-1}}, \quad \frac{\rho^*}{\rho_0} = \left(\frac{2}{\gamma + 1}\right)^{\frac{1}{\gamma-1}} $$

**공기 (γ = 1.4) 기준:**

| | T★/T₀ | p★/p₀ | ρ★/ρ₀ |
|---|-------|-------|-------|
| 값 | 0.833 | 0.528 | 0.634 |

## Characteristic Mach Number M★

$$ M^* = \frac{U}{a^*}, \quad a^* = \sqrt{\gamma R_s T^*} $$

M과 M★의 관계:

$$ M^2 = \frac{2}{(\gamma + 1)/M^{*2} - (\gamma - 1)} $$

- M★ = 1 iff M = 1
- M★ < 1 iff M < 1
- M★ > 1 iff M > 1
- M → ∞일 때 M★ → √((γ+1)/(γ-1)) ≈ 2.449 (유한값)

→ 충격파와 팽창파 해석에서 M★가 유용 (M → ∞에서도 유한값 수렴)

## General Energy Equation (Stagnation Enthalpy Form)

$$ \frac{a^2}{\gamma - 1} + \frac{u^2}{2} = \frac{a_0^2}{\gamma - 1} = \frac{\gamma + 1}{2(\gamma - 1)}a^{*2} = \text{const} $$

모든 지점에서 stagnation enthalpy는 보존된다 (단열 유동).

## 응용 — Concorde Skin Temperature

고속 비행 시 기체 표면의 stagnation temperature가 재료의 임계 온도를 초과하지 않도록 Mach 수를 제한해야 한다 ([[mach-number-and-flow-regimes]] 참조).

## References

- [[compressibility-and-speed-of-sound]] — 음속 a = √(γR_s T)
- [[isentropic-relations]] — 등엔트로피 관계식 유도
- [[mach-number-and-flow-regimes]] — M, M★, 유동 영역 분류
- [[compressible-flow-governing-equations]] — 에너지 방정식 기반
