---
title: ISS Lyapunov Theory for Infinite-Dimensional Systems
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [foundation, pure-mechanics, control-theory, mathematics, paper]
sources: [raw/papers/2406.17909v1.md, raw/papers/2512.24880v2.md]
confidence: high
---

# ISS (Input-to-State Stability) Lyapunov Theory

## 개요

**ISS (Input-to-State Stability)** 는 **E. Sontag** (1989)가 제안한 비선형 제어의 핵심 개념으로, 외란(disturbance)에 대한 **강건 안정성(robust stability)** 을 보장한다. 기존의 Lyapunov 안정성 이론(외란이 없을 때의 점근 안정성)을 외란이 존재하는 실제 환경으로 확장한 개념이다. Heni, Mironchenko, Wirth, Damak, Hammami는 시간 가변 무한 차원 시스템으로 ISS/Lyapunov 이론을 확장했다^[raw/papers/2512.24880v2.md].

## ISS 정의

시스템 $\dot{x} = f(x, u)$ (여기서 $u$는 외란/입력)가 **ISS**라는 것은 다음을 만족하는 $\beta \in \mathcal{KL}$, $\gamma \in \mathcal{K}$가 존재함을 의미한다:

$$|\phi(t, x, u)| \leq \beta(|x|, t) + \gamma(\|u\|_\infty) \quad \forall t \geq 0$$

| 의미 | 구성 요소 | 역할 |
|------|:--------:|:----:|
| $\beta(|x|, t)$ | $\mathcal{KL}$ 함수 | 초기 조건의 영향 — 시간에 따라 소멸 |
| $\gamma(\|u\|_\infty)$ | $\mathcal{K}$ 함수 | 외란의 영향 — 영구적 잔차 |

**비특성:** $u \equiv 0$이면 $\beta(|x|, t)$만 남아 **UGAS (Uniform Global Asymptotic Stability)** 와 일치하고, $t \to \infty$이면 외란 크기에 비례한 잔차 $\gamma(\|u\|_\infty)$로 수렴한다.

## 비교 함수 클래스 (Comparison Functions)

| 함수 클래스 | 정의 | 예 |
|:----------:|------|:--:|
| $\mathcal{K}$ | Strictly increasing, $\gamma(0)=0$ | $\gamma(r) = r$ |
| $\mathcal{K}_\infty$ | $\mathcal{K}$ + unbounded | $\gamma(r) = r^2$ |
| $\mathcal{L}$ | Strictly decreasing, $\lim_{t\to\infty}=0$ | $\beta(t) = e^{-t}$ |
| $\mathcal{KL}$ | $\beta(\cdot, t) \in \mathcal{K}$, $\beta(r, \cdot) \in \mathcal{L}$ | $\beta(r, t) = re^{-t}$ |

## ISS Lyapunov 함수

연속 함수 $V: \mathbb{R}^n \to \mathbb{R}_+$가 **dissipative form**의 ISS Lyapunov 함수라면:

$$\psi_1(|x|) \leq V(x) \leq \psi_2(|x|), \quad \dot{V}_u(x) \leq -\alpha(V(x)) + \xi(\|u\|_\infty)$$

즉, $V$가 큰 값일 때는 **negative definite** ($-\alpha(V)$)로 감소하지만, 외란 $\xi(\|u\|_\infty)$에 의해 완전히 0으로 수렴하지는 않는다. 이 dissipative form은 물리계의 저장 함수(storage function)와 유사하다.

**정리 (Sontag & Wang, 1995):** 시스템이 ISS일 필요충분조건은 **매끄러운 ISS Lyapunov 함수**가 존재하는 것이다.

## Small-Gain 정리

feedback interconnection에서 각 서브시스템이 ISS이면, **small-gain 조건**이 만족될 때 전체 시스템도 ISS이다.

$$(\text{id} + \rho) \circ \gamma_{12} \circ (\text{id} + \rho) \circ \gamma_{21}(r) < r \quad \forall r > 0$$

최근(Kawan, Mironchenko, Zamani, 2023)에는 **무한 네트워크**(countable infinity of subsystems)로 확장되어, Lyapunov 기반 small-gain 정리가 증명되었다:

$$V(x) := \sup_{i \in \mathbb{N}} \sigma_i^{-1}(V_i(x_i))$$

## 응용: Event-Triggered Control

ISS는 **event-triggered control**의 이론적 기반을 제공한다. 디지털 컨트롤러가 연속적이 아닌 **이산 시점**에서만 업데이트될 때, 측정 오차 $e$가 임계값을 초과할 때만 제어기를 갱신하는 조건:

$$\xi(|e|) \geq \sigma\alpha(|x|)$$

이 조건 아래에서는 제어기가 Zeno 현상 없이 시스템을 안정화할 수 있음이 보장된다 (Tabuada, 2007).

## 융합 도메인 연결

- **ML 기반 제어기**의 안정성 보장 장치로 활용 가능 — PINN 기반 제어, RL 제어 정책이 ISS 조건을 만족하는지 검증
- [[pseudo-hamiltonian-neural-networks]] — PHNN이 보존하는 Hamiltonian 구조와 ISS의 연결
- [[quadratic-iss-lyapunov]] — ISS 역 Lyapunov 정리 (구체적 확장)
- [[control-system]] 태그 하의 **ML-based control** 연구의 이론적 기반
- DMN 기반 공정 제어에서 외란(원료 편차, 온도 변동)에 대한 시스템 안정성 보장

## References
- Sontag, E. D. (1989). Smooth stabilization implies coprime factorization. *IEEE TAC*, 34(4): 435-443.
- Mironchenko, A. (2023). *Input-to-State Stability: Theory and Applications*. Springer.
- Mironchenko & Prieur (2020). ISS of infinite-dimensional systems: Recent results and open questions. *SIAM Review*, 62(3): 529-614.
- [[quadratic-iss-lyapunov]]
- [[pseudo-hamiltonian-neural-networks]]
