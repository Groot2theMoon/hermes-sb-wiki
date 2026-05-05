---
title: Density Functional Theory (DFT)
created: 2026-05-04
updated: 2026-05-05
type: concept
tags: [foundation, physics-informed, quantum-mechanics, electronic-structure]
sources: []
confidence: low
---

# Density Functional Theory (DFT)

## 개요

Density Functional Theory (DFT)는 **전자 밀도(electron density)** 를 기본 변수로 사용하여 다전자 계의 전자 구조를 계산하는 양자역학적 방법. Hohenberg-Kohn 정리 (1964)와 Kohn-Sham 방정식 (1965)에 기반.

## 핵심 정리

- **Hohenberg-Kohn 제1정리:** 외부 퍼텐셜 $V_{ext}$는 전자 밀도 $n(r)$에 의해 유일하게 결정됨
- **Hohenberg-Kohn 제2정리:** 바닥 상태 에너지는 $E[n(r)]$의 범함수 최소화로 얻어짐
- **Kohn-Sham:** 상호작용하는 다전자 문제를 가상의 비상호작용 입자 문제로 변환

## Kohn-Sham 방정식

$$\left[-\frac{\hbar^2}{2m}\nabla^2 + V_{eff}(r)\right]\psi_i(r) = \epsilon_i\psi_i(r)$$
$$V_{eff}(r) = V_{ext}(r) + V_H(r) + V_{xc}(r)$$

여기서 $V_{xc}$는 **exchange-correlation functional** — 유일한 근사가 필요한 항.

## 주요 근사법

| 방법 | 설명 | 특징 |
|:----|:-----|:-----|
| LDA | Local Density Approximation | 위치별 균일 전자 기체 가정 |
| GGA | Generalized Gradient Approximation | 밀도 구배 포함 (PBE, BLYP) |
| Meta-GGA | Kinetic energy density 추가 | SCAN 등 |
| Hybrid | Exact exchange 일부 포함 | B3LYP, PBE0 |
| DFT+U | 강상관계 보정 | Transition metal oxides |

## AI/ML과의 융합

- **ML force fields:** DFT 데이터로 학습된 interatomic potentials
- **DeepMD, SchNet, MACE:** DFT 수준 정확도의 surrogate
- **SCF acceleration:** 초기 추측(initial guess) 개선으로 수렴 가속
- **Functional discovery:** Neural network으로 $V_{xc}$ 직접 학습

## Wikilinks
- [[dm-phisnet-scf-acceleration]] — Equivariant NN for SCF acceleration
- [[riemannian-optimization]] — Riemannian optimization
- [[deep-material-network]] — Data-driven surrogate for mechanics (유사 패러다임)
- [[pinode-physics-informed-neural-ode]] — Physics-informed NODE

## References
- Hohenberg, P. & Kohn, W. (1964). *Phys. Rev.*, 136, B864.
- Kohn, W. & Sham, L. J. (1965). *Phys. Rev.*, 140, A1133.
