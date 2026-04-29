---
title: Isentropic Relations — Thermodynamic Derivation for Gas Dynamics
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [thermodynamics, fluid-dynamics, foundation, pure-mechanics]
sources: [raw/papers/gasdynamic-thermodynamics-review.md, raw/papers/gasdynamic-lecture-3-compressibility-sound.md, raw/papers/gd1-tutorial-1-isentropic-relations-matlab.md]
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

## MATLAB 실습 — GD1 Tutorial 1 (Isentropic Flow Relations)

### 개요

Gas Dynamics 1 튜토리얼의 MATLAB 실습으로, 등엔트로피 관계식을 수치적으로 계산하고 시각화한다. Part 1은 기초 MATLAB 입문(음속 vs 온도 그래프), Part 2와 Part 3이 본격적인 등엔트로피 관계식 계산이다.

### Part 2: Isentropic Relations 계산 및 플로팅

Mach 수 M = 0~10 범위에서 4가지 무차원 관계식을 계산:

| 관계식 | 수식 | MATLAB |
|--------|------|--------|
| T/T₀ | (1 + (γ-1)/2 · M²)⁻¹ | `(1 + (g-1)/2 .* M.^2).^(-1)` |
| P/P₀ | (1 + (γ-1)/2 · M²)^(-γ/(γ-1)) | `... .^(-g/(g-1))` |
| ρ/ρ₀ | (1 + (γ-1)/2 · M²)^(-1/(γ-1)) | `... .^(-1/(g-1))` |
| a/a₀ | √(T/T₀) | `sqrt(T_ratio)` |

**비교적 특성:**
- P/P₀가 가장 급격히 감소 (지수 γ/(γ-1) = 3.5)
- a/a₀가 가장 완만히 감소 (제곱근 의존성)
- 모든 관계식은 M → ∞에서 0으로 수렴

**물리적 의미:** 유동이 가속될수록 내부에너지가 운동에너지로 전환되어 정온도/정압/정밀도가 감소. Mach 수만 알면 모든 정온도 특성이 결정됨.

### Part 3: 함수화 (Function-based Refactoring)

순차적 계산 → 재사용 가능한 함수 분리:

```matlab
function Tr = isentropic_T(M, g)
    Tr = (1 + (g-1)/2 * M.^2).^(-1);
end
```

4개 관계식 각각을 별도 함수로 정의하여 코드 모듈화. 같은 폴더의 다른 튜토리얼에서도 재사용 가능.

### 핵심 인사이트

1. **등엔트로피 관계식의 통일성:** 하나의 공통 분모 `(1 + (γ-1)/2 · M²)`에서 모든 관계식이 파생됨
2. **지수의 차이:** 온도비(-1), 압력비(-γ/(γ-1)), 밀도비(-1/(γ-1)) — 지수만 다르고 같은 구조
3. **음속 감소의 원리:** a ∝ √T이므로 M 증가 → T감소 → a 감소. 충격파 형성의 물리적 배경
