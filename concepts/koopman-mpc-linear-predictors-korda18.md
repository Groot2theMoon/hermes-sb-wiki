---
title: "Linear Predictors for Nonlinear Dynamical Systems — Koopman Operator Meets MPC"
created: 2026-05-14
updated: 2026-05-14
type: concept
tags: [koopman-operator, model-predictive-control, dynamical-systems, linearization, data-driven]
sources: [raw/papers/koopman-mpc-linear-predictors-korda18.md]
confidence: high
---

# Koopman Operator Meets MPC

**Korda & Mezić** (CNRS / UCSB, Automatica 2018). arXiv:1611.03537.

## 개요

Koopman operator를 **controlled system**으로 확장한 논문. Lifting function으로 nonlinear dynamics를 lifted space에서 **linear controlled system**으로 근사 → MPC에 적용.

## 핵심 방법론

- **Extended Dynamic Mode Decomposition (EDMD):** Lifting functions $\psi(x)$로 데이터를 lifted space로 매핑 → linear least squares로 Koopman matrix 학습
- **Controlled Koopman:** 입력 $u$를 포함한 lifted space $[\psi(x)^	op, u^	op]^	op$에서 선형 근사
- **Koopman MPC:** Lifted space에서 선형 MPC로 문제 단순화 — nonlinear constraint도 lifted space에서 선형화 가능

## RIGOR와의 차별점

| 요소 | Korda & Mezić | RIGOR |
|------|--------------|-------|
| Approach | Lifting + linear LS | A+NN + UKF |
| Dynamics | $\psi(x_{k+1}) = A\psi(x_k) + Bu_k$ | $x_{k+1} = Ax_k + 	ext{NN}(x_k, \sigma)$ |
| State space | Lifted ($\psi(x)$), black-box | Physical ($x$), interpretable |
| Uncertainty | 없음 | UKF covariance |
| Loss | Prediction error only | VFE (KL + NLL) |
| Online | No (EDMD is batch) | Yes (differentiable filter) |

**주요 차이:** Korda & Mezić는 lifting으로 **비선형 → 선형** 근사. RIGOR는 **A+NN 그대로** learning. Lifting은 해석 불가능한 black-box latent state를 만드는 반면, RIGOR의 physical state는 interpretable.

## Wikilinks
- [[koopman-lifting-rigor]] — Koopman lifting for RIGOR
- [[koopman-operator-theory]] — Koopman theory 기초
- [[rigor-filter]] — RIGOR의 A+NN 구조
