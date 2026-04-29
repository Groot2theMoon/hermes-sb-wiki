---
title: Zames — Input-Output Stability of Time-Varying Nonlinear Feedback Systems
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [classic-control, stability-theory, feedback-systems, foundation, nonlinear-control]
sources: [raw/papers/On_the_input-output_stability_of_time-varying_nonlinear_feedback_systems_Part_one_Conditions_derived_using_concepts_of_loop_gain_conicity_and_positivity.md]
confidence: high
---

# Zames Input-Output Stability Theory (1966)

## 개요

**G. Zames** (MIT, 1966)는 **함수해석적(functional) 방법**을 사용하여 **비선형 시변 피드백 시스템**의 입출력 안정성 이론을 정립한 기념비적 논문이다. Nyquist criterion의 일반화로, loop gain, conicity, positivity라는 세 가지 개념을 통해 피드백 시스템의 boundedness와 continuity를 판정한다.

## 핵심 개념

### 입력-출력 안정성 정의

1. **Bounded:** 유계 입력 → 유계 출력
2. **Continuous:** 작은 입력 변화에 출력이 연속적으로 반응 (noise 민감성 없음)

두 조건을 모두 만족하면 **input-output stable**.

### 확장 노름 공간 $X_e$

- $L_p$ 공간을 확장하여 "폭발하는(exploding)" 함수도 포함
- Truncation $x_t$의 norm이 유한 → $x \in X$, 무한으로 발산 → $x \notin X$

## 세 가지 주요 정리

### Theorem 1: Small Gain

**$g(H_1) \cdot g(H_2) < 1$ → closed loop bounded**

$$\|(Hx)_t\| \leq g(H) \cdot \|x_t\|$$

- Incremental gain $\bar{g}$로 continuity도 보장
- Contraction Principle에서 영감 — 가장 기본적인 안정성 조건

### Theorem 2: Conic Relations

**$-H_2$가 sector $\{a+\Delta, b-\Delta\}$ 내부에 있을 때, $H_1$의 허용 sector 조건**

- Interior conic: $\|(Hx)_t - cx_t\| \leq r\|x_t\|$ (sector $\{c-r, c+r\}$ 내부)
- Exterior conic: 부등호 반대 (sector 외부)
- **3가지 case** ($a>0$, $a<0$, $a=0$)에 대해 $H_1$이 만족해야 할 sector 조건 제시

### Theorem 3: Positivity (Passivity)

**$H_1$과 $-H_2$가 positive (passive)이고, 하나가 strongly positive이며 finite gain → 안정**

- Positive: $\langle x_t, (Hx)_t \rangle \geq 0$ (에너지를 흡수만 함)
- Strongly positive: $H - \sigma I$가 positive (strict passivity)
- 수동(passive) 네트워크의 안정성 이론적 기반

## 역사적 의의

- **Lyapunov 방법의 대안:** 상태 공간이 아닌 입출력 관계로 안정성 판정
- **Circle Criterion의 기초:** Part II에서 단일 비선형 요소를 포함한 루프의 circle condition으로 발전
- **Robust Control의 선구자:** Gain/Conicity/Positivity 개념은 현대 $H_\infty$ 제어, passivity-based control, small-gain theorem의 기원

## 피드백 방정식

Positive feedback configuration:

$$e_1 = w_1 + a_1x + y_2, \quad y_2 = H_2e_2$$
$$e_2 = w_2 + a_2x + y_1, \quad y_1 = H_1e_1$$

Relation 기반 formulation — 해의 존재성/유일성보다 안정성에 집중.

## References

- Zames, G. (1966). On the Input-Output Stability of Time-Varying Nonlinear Feedback Systems — Part I. IEEE Trans. Automatic Control, AC-11(2), 228-238.
- Sandberg, I.W. (1964). On the $L_2$-boundedness of solutions of nonlinear functional equations.
