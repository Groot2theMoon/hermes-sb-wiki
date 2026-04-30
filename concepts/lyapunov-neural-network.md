---
title: Lyapunov Neural Network — Adaptive Stability Certification for Safe Learning
created: 2026-04-30
updated: 2026-04-30
type: concept
tags: [control-theory, lyapunov, safety, learning, robotics]
sources: [raw/papers/lyapunov-neural-network.md]
confidence: medium
---

# Lyapunov Neural Network (LNN)

Richards, Berkenkamp, Krause (ETH Zürich, 2018) — **Lyapunov 함수 자체를 neural network로 모델링**하여 동역학 시스템의 안정성 인증(stability certification)을 학습.

## 핵심 아이디어

Neural network V_θ(x)를 Lyapunov 함수로 학습:
- V(0) = 0, V(x) > 0 for x ≠ 0
- dV/dx · f(x) ≤ 0 (along system trajectories)

이를 만족하면 제어 정책 π_θ의 안정성이 **구조적으로 보장**됨.

## Lipschitz/Lyapunov/PINN 연결

승원님 아이디어의 관점:
- LNN은 Lipschitz 제약 없이도 Lyapunov 조건을 NN에 임베드
- PINN Lyapunov (Automatica 2025)는 이걸 PDE residual + verification으로 확장
- 승원님의 "Lipschitz로 에너지 발산 무력화"는 LNN의 한 축소 사례로 볼 수 있음

## 관련 페이지
- [[pinn-lyapunov-functions]] — PINN Lyapunov (Automatica 2025, 후속 발전)
- [[iss-lyapunov-theory]] — Lyapunov 기초 이론
- [[lyapunov-guided-exploration]] — Lyapunov를 RL에 활용
