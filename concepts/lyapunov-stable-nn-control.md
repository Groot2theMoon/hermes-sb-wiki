---
title: Lyapunov-Stable Neural Network Control — Certified Stability via NN + Quadratic Programming
created: 2026-04-30
updated: 2026-04-30
type: concept
tags: [control-theory, lyapunov, safety, robotics, learning, optimization]
sources: [raw/papers/lyapunov-stable-nn-control.md, raw/papers/lyapunov-nn-mpc.md]
confidence: medium
---

# Lyapunov-Stable NN Control

[[hongkai-dai|Hongkai Dai]], Benoit Landry, Lujie Yang, [[marco-pavone|Marco Pavone]], [[russ-tedrake|Russ Tedrake]] (TRI/Stanford/MIT) — NN controller의 출력 후처리(post-processing)를 통해 **Lyapunov 안정성을 사후 보장**하는 방법.

## 핵심 아이디어 (2109.14152)

NN controller π_θ(x)의 출력을 **quadratic programming (QP)** 으로 후처리:
```
u(x) = arg min_u ‖u - π_θ(x)‖²   (최소 변경)
  s.t. dV/dx · f(x, u) ≤ -α V(x)   (Lyapunov 조건)
```

- NN은 자유롭게 학습 (성능 최대화)
- QP가 안정성을 보장 (안전성 보장)
- **Lyapunov 함수 V는 미리 알고 있다고 가정**

## 관련 페이지
- [[lyapunov-neural-network]] — Lyapunov 함수 자체를 NN으로 학습 (Richards 2018)
- [[pinn-lyapunov-functions]] — PINN 기반 Lyapunov 학습 (Liu 2025)

## Lyapunov NN MPC (s41598-024)

같은 맥락: **Model Predictive Control 프레임워크에 Lyapunov 안정성 제약**을 통합.
- NN이 cost function 근사
- MPC의 optimization horizon 내에서 Lyapunov 조건 만족

## 관련 페이지
- [[lyapunov-neural-network]] — Lyapunov 함수를 NN으로 학습 (Richards)
- [[pinn-lyapunov-functions]] — PINN으로 Lyapunov 학습 (Automatica 2025)
- [[iss-lyapunov-theory]] — Lyapunov 기초
- [[neural-mpc-terminal-constraint]] — MPC + NN
