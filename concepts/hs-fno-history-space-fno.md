---
title: "HS-FNO: History-Space Fourier Neural Operator for Non-Markovian PDEs"
created: 2026-05-13
updated: 2026-05-13
type: concept
tags: [neural-operator, surrogate-model, mathematics, pde, paper]
confidence: medium
sources: [arXiv:2605.09523]
---

# HS-FNO: History-Space Fourier Neural Operator for Non-Markovian PDEs

## 개요

**Lennon J. Shikhman (2026)** ^[arXiv:2605.09523]은 **비마르코프(non-Markovian) 편미분방정식(PDE)** — 지연 방정식(delay equations), 분산 메모리 시스템 — 을 위한 새로운 neural operator를 제안한다. 표준 FNO의 자동회귀 사용은 현재 상태 $u(t,\cdot)$가 완전한 상태라고 가정하지만, 지연 PDE에서는 과거 이력이 미래를 결정한다.

## 핵심 아이디어

과거 이력을 lifted state $u_t(\theta,x)=u(t+\theta,x), \theta\in[-\tau,0]$로 인코딩한다. 핵심 연산은 **학습된 predictor**로 새로 노출된 미래 슬라이스를 예측하고, 이미 알려진 과거 윈도우 부분은 **정확한 shift-append transport**로 전달하는 분해다. 이는 자연스러운 이산 이력 업데이트 구조를 강제하는 유도 편향(inductive bias)이다.

다섯 가지 벤치마크(지연 reaction-diffusion, 공간 역학, 비국소 neural-field, 지연파, 분산 메모리 클로저)에서 HS-FNO는 rollout error를 0.185→0.094로 감소시키며 더 적은 파라미터로 더 나은 성능을 달성했다.

## 연결점
- [[fourier-neural-operator]] — 기존 FNO의 마르코프 가정 한계를 극복
- [[neural-operator-stability-receptivity]] — Neural operator 안정성 연구와의 연결점
- [[state-space-model]] — 상태 표현(state representation)에서의 마르코프 vs 비마르코프 구분

## References
- arXiv:2605.09523 — HS-FNO: History-Space Fourier Neural Operator for Non-Markovian Partial Differential Equations
- GitHub: https://github.com/lennonshikhman/hs-fno/
