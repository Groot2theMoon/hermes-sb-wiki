---
title: Variational Autoregressive Networks for Statistical Mechanics
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, paper, physics-informed, mathematics]
sources: [raw/papers/1809.10606v2.md]
confidence: high
---

# Variational Autoregressive Networks for Statistical Mechanics

Wu, Wang, Zhang (2018)이 제안한 방법으로, **변분 자동회귀 네트워크(Variational Autoregressive Network)**를 사용해 통계역학의 어려운 문제(유한계 자유 에너지 계산, #P-hard)를 해결한다^[raw/papers/1809.10606v2.md]. ML × Physics의 또 다른 중요한 사례.

- **자동회귀(autoregressive) 구조**로 $q_\theta(\mathbf{s}) = \prod_i q_\theta(s_i | s_{<i})$ 인수분해
- **변분 자유 에너지** $F_q = \mathbb{E}_q[E] - T \cdot H[q]$ 최소화 (KL 발산 최소화와 동등)
- Ising 모델, Edwards-Anderson 스핀 글라스 등에서 정확한 통계역학 계산
- [[unsupervised-phase-transitions]]과 함께 물리 문제에 딥러닝을 적용한 선도적 연구
- [[unsupervised-phase-transitions]] — ML×Physics 상전이 탐지
- [[generative-models-physics]] — 물리 생성 모델
