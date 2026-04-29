---
title: Isentropic Relations — Thermodynamic Derivation for Gas Dynamics
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [thermodynamics, fluid-dynamics, foundation, pure-mechanics]
sources: [raw/papers/gasdynamic-thermodynamics-review.md, raw/papers/gasdynamic-lecture-3-compressibility-sound.md]
confidence: high
---

# Isentropic Relations

## Isentropic Process 정의

**Isentropic process:** 단열(adiabatic, δq = 0) + 가역(reversible, no dissipative phenomena) 과정.

$$ ds = 0 $$

엔트로피 변화가 없는 과정이므로, 이상 기체의 경우 압력, 온도, 밀도 사이에 고정된 관계식이 성립한다.

## 열역학적 유도

1st law + 2nd law + ideal gas EOS에서 출발:

$$ \delta q = de + \delta W \quad\text{(1st law)} $$
$$ \delta q = T\,ds \quad\text{(2nd law, reversible)} $$
$$ pv = R_s T \quad\text{(ideal gas)} $$

미분 및 정리:
$$ T\,ds = c_v\,dT + p\,dv = c_p\,dT - v\,dp $$

$$ ds = c_p\frac{dT}{T} - R_s\frac{dp}{p} $$

위치 1→2로 적분:
$$ s_2 - s_1 = c_p\ln\frac{T_2}{T_1} - R_s\ln\frac{p_2}{p_1} $$

## Isentropic Relations

등엔트로피 조건 (s₂ − s₁ = 0):

$$ 0 = c_p\ln\frac{T_2}{T_1} - R_s\ln\frac{p_2}{p_1} $$

$$ \frac{p_2}{p_1} = \left(\frac{T_2}{T_1}\right)^{c_p/R_s} = \left(\frac{T_2}{T_1}\right)^{\frac{\gamma}{\gamma-1}} $$

$$ \frac{p_2}{p_1} = \left(\frac{\rho_2}{\rho_1}\right)^\gamma $$

## 요약

등엔트로피 과정에서 압력, 온도, 밀도는 다음 관계를 만족한다:

$$ \frac{p_2}{p_1} = \left(\frac{T_2}{T_1}\right)^{\frac{\gamma}{\gamma-1}} = \left(\frac{\rho_2}{\rho_1}\right)^\gamma $$

여기서 γ = c_p/c_v (공기: γ = 1.4).

## 응용

- **Speed of sound:** $$ a = \sqrt{(\partial p/\partial\rho)_s} $$ — Laplace correction의 기초
- **Stagnation properties:** $$p_0/p = (T_0/T)^{\gamma/(\gamma-1)}$$ 유도에 사용
- **Isentropic flow tables:** 주어진 M에 대해 p/p₀, T/T₀, ρ/ρ₀, A/A* 계산의 기반

## Perfect Gas Model Summary

| Model | 조건 | 적용 |
|-------|------|------|
| Thermally perfect | e = e(T), h = h(T), de = c_v dT | 화학 반응 없음, 분자간 힘 무시 |
| Calorically perfect | e = c_v T, h = c_p T (c_v, c_p 상수) | 보통 온도 범위, 공기 γ=1.4 |

R_s = c_p − c_v 관계는 thermally/calorically perfect gas에서 성립하며, chemically reacting gas에서는 성립하지 않는다.

## References

- [[compressibility-and-speed-of-sound]] — 등엔트로피 compressibility β_S와 음속 관계
- [[stagnation-properties]] — total/stagnation 조건 유도
- [[compressible-flow-governing-equations]] — 에너지 방정식의 열역학적 폐쇄
