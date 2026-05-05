---
title: Deep Equilibrium Networks (DEQ)
created: 2026-05-04
updated: 2026-05-05
type: concept
tags: [model, architecture, deep-equilibrium-networks, implicit-layer, fixed-point]
sources: []
confidence: medium
---

# Deep Equilibrium Networks (DEQ)

## 개요

DEQ (Bai, Kolter, Koltun, 2019)는 명시적 layer stacking 없이 **고정점(fixed point)** 으로 출력을 정의하는 **implicit depth** 신경망. 무한한 깊이의 효과를 유한한 계산으로 달성.

## 핵심 아이디어

표준 신경망이 $z_{i+1} = f_\theta(z_i, x)$ ($i=1,\dots,L$)로 layer를 쌓는 반면:

**DEQ:** $\quad z^* = f_\theta(z^*, x)$

출력 $z^*$가 동일한 transformation $f_\theta$의 고정점이 되도록 학습. 역전파 시 고정점을 통해 미분 (implicit function theorem 사용).

## 장점

| 항목 | 설명 |
|:----|:-----|
| **메모리 효율** | 중간 activation 저장 불필요 ($O(L)$ → $O(1)$) |
| **표현력** | 무한 깊이의 귀결 — 유한 depth와 달리 이론적으로 universal |
| **매개변수 효율** | 단일 layer $f_\theta$만 학습 |
| **추론 적응** | 입력 복잡도에 따라 필요한 고정점 반복 횟수 조절 가능 |

## 변형 및 확장

| 모델 | 특징 |
|:----|:-----|
| **monDEQ** (Winston & Kolter, 2020) | Monotone operator 제약으로 **고정점 수렴 보장** |
| **DEQ Transformer** (Bai et al., 2021) | Transformer에 DEQ 적용 — weight-tied depth | 
| **Neural ODE ↔ DEQ** | Neural ODE는 연속 시간, DEQ는 이산 공간 implicit layer |
| **Multiscale DEQ** (MDEQ) | 여러 해상도의 고정점 동시 학습 |

## 학습 및 안정성

- **Anderson acceleration:** 고정점 반복 가속
- **Jacobian-free backprop:** Implicit function theorem으로 $dL/d\theta$ 직접 계산
- **Broyden's method:** 고정점 탐색에 사용
- **Spectral normalization:** 수렴 보장을 위한 Lipschitz 제약

## Wikilinks
- [[monotone-operator-equilibrium-networks]] — monDEQ (monotone operator)
- [[neural-odes]] — Neural ODE (연속 시간 implicit layer)
- [[lure-stability]] — Lur'e system (feedback + NN)
- [[spectral-normalization-gan]] — Spectral normalization

## References
- Bai, S., Kolter, J. Z., & Koltun, V. (2019). "Deep Equilibrium Models." *NeurIPS 2019*.
- Winston, E. & Kolter, J. Z. (2020). "Monotone Operator Equilibrium Networks." *NeurIPS 2020*.
- Bai, S. et al. (2021). "Multiscale Deep Equilibrium Models." *NeurIPS 2021*.
