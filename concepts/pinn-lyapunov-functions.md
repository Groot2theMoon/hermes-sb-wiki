---
title: PINN Lyapunov Functions — PDE Characterization, Learning, and Verification
created: 2026-04-30
updated: 2026-04-30
type: concept
tags: [physics-informed, control-theory, lyapunov, safety, optimal-control]
sources: [raw/papers/pinn-lyapunov-functions.md]
confidence: medium
---

# PINN Lyapunov Functions

Liu, Meng, Fitzsimmons, Zhou (Automatica, 2025) — **PINN을 이용해 Lyapunov 함수를 학습**하고, **PDE로 특성화(characterization)**하며, **형식 검증(formal verification)**까지 수행하는 프레임워크.

## 승원님 아이디어와의 연결

바로 전에 논의한 **"PINN에 Lipschitz/Lyapunov 임베드"** 아이디어의 정확한 구현:

1. **PDE characterization:** Lyapunov 조건을 PDE residual로 변환 → PINN loss에 통합
2. **Learning:** PINN이 Lyapunov 함수 V(x)를 근사하면서 dV/dx·f(x) ≤ 0 만족하도록 학습
3. **Verification:** SMT/satisfiability 기반으로 학습된 V(x)가 실제로 Lyapunov 조건을 만족하는지 검증

## 관련 페이지
- [[iss-lyapunov-theory]] — Lyapunov 이론의 기초
- [[physics-informed]] — PINN 프레임워크
- [[lyapunov-neural-network]] — Richards 2018 선행 연구
- [[pinn-failure-modes]] — PINN 최적화 난이도
