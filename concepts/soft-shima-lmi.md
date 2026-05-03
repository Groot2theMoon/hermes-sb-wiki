---
title: "Soft Shima LMI — Train-Time Contractivity via P-learning"
created: 2026-05-02
updated: 2026-05-03
type: concept
tags: [shima-lmi, contractivity, p-learning, lur-e-system, a-plus-nn, soft-penalty]
sources:
  - raw/papers/shima-davydov-bullo-contractivity-lure-systems.md
  - raw/papers/bullo-nonlinear-separation-principle.md
confidence: high
---

# Soft Shima LMI — Train-Time Contractivity via P-learning

## 개요

RIGOR v2.3의 A+NN 동역학에 Shima Lur'e LMI를 적용하는 실용적인 접근법.
LMI를 hard constraint가 아닌 **soft penalty**로 사용하고, P(=L L^T)를 학습 가능한
파라미터로 추가하여 LMI solver 없이 end-to-end 학습 가능.

## 핵심 아이디어

### 기존 문제
- Level 1 (∥A∥₂ + L < ρ): P를 무시, 보수적
- rigor_334 heuristic: 방향별 leakage, P 효과 rank-1 근사, 이론적 엄밀성 부족
- Full Shima LMI: SDP solver 필요, 학습 중 사용 어려움

### 해결
```
1. P = L L^T (Cholesky) — 학습 가능한 SPD 행렬
2. λ = softplus(λ_raw) — 학습 가능한 LMI multiplier
3. LMI penalty = max(0, λ_max(M) + ε) — soft hinge
4. loss = NLL + inv_gamma + β · LMI_penalty
```

### 장점
- **P의 full rank state-space reshaping 효과** 포착 (∥A∥₂ → ∥A∥_P)
- **A와 직교하는 NN 방향은 자유** — dominant mode만 제약
- **A도 NN도 data-driven 학습** — A 고정 불필요
- **LMI solver 불필요** — eigvalsh 하나면 OK
- **Birkhoff + 기존 코드 유지** — SpectralDense 그대로

### 한계
- Soft penalty: 학습 중 잠시 LMI 위반 가능
- inference-time에 lmi.py로 최종 검증 필요

## 참고

- 자세한 구현은 RIGOR_v2.3_FINAL_GUIDELINE.md (rigor-filter repo)
- LMI penalty는 convergence에만 필요, inference-time은 verification만
- **대안 접근법:** [[monotone-operator-equilibrium-networks|monDEQ]]는 operator splitting으로 동일한 수렴 문제를 다른 각도에서 해결
