---
title: Hamiltonian Neural Networks — Physics-Embedded Dynamics with Energy Conservation
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [model, physics-informed, neural-network, dynamics, hybrid-modeling]
sources: [raw/papers/hamiltonian-neural-networks.md]
confidence: high
---

# Hamiltonian Neural Networks (HNN)

Greydanus, Dzamba, Yosinski (NeurIPS 2019) — 물리 법칙(Hamiltonian mechanics)을 neural network에 직접 임베드하여 에너지 보존을 보장.

## 핵심 아이디어

고전적 NN dynamics predictor: x_{t+1} = f_NN(x_t) → 에너지 보존 안됨

HNN: Hamiltonian H(q,p)를 신경망으로 학습
- Hamiltonian = total energy (kinetic + potential)
- **Symplectic integrator**로 적분 → 에너지 보존 자동 보장

## A+NN 구조와의 연결

승원님 사이드 프로젝트 아이디어:
- DKF: A free-form (black-box dynamics)
- HNN: A = Hamiltonian structure (physics embedded)
- A+NN 중 A의 구조로 Hamiltonian mechanics를 채택하는 방안 검토 가능

## 관련 페이지
- [[neural-odes]] — 시간 연속 동역학 변형
- [[deep-kalman-filter]] — 블랙박스 temporal dynamics
- [[orthogonal-projection-regularization]] — 물리 + NN 하이브리드에서 비식별성 해결
