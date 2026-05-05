---
title: RIGOR Filter — Differentiable SR-UKF
created: 2026-05-04
updated: 2026-05-05
type: concept
tags: [kalman-filter, state-estimation, system-identification]
sources: []
confidence: high
---

# RIGOR Filter

A differentiable Square-Root Unscented Kalman Filter with A+NN dynamics. Implements Lur'e contractivity LMI constraints and EM-based noise covariance learning. See [[square-root-unscented-kalman-filter|SR-UKF]] for the base algorithm.

Closely related to [[auto-diff-data-assimilation|Auto-differentiable Data Assimilation]] (co-learning states + dynamics + filtering) and [[observability-nssm|Observability for NSSM]] (theoretical conditions for unobserved state recovery).

## Related Dynamics Approaches

- [[skanode]] — Structured KAN Neural ODEs for interpretable symbolic discovery of nonlinear dynamics; relevant for interpretable dynamics in RIGOR
- [[buisson-fenet-kkl-observer]] — KKL observer-based recognition models for NODEs under partial observations; directly foundational for DeltaObserver

This filter addresses the same learning-based state estimation problem as [[miao-robust-observer|Miao & Gatsis (2023)]], which learns KKL observers via Neural ODEs. Key differences: RIGOR uses SR-UKF with contractivity LMI for robustness, while Miao uses Neural ODE latent dynamics with D-eigenvalue regularization.

## Sigma Point Innovation Research

[[rigor-sigma-point-research|RIGOR Sigma Point Innovation Research]] 문서에서 5가지 sigma point 개선 아이디어의 연구 현황과 RIGOR-specific novelty를 분석:

| Priority | Idea | Key Reference | Impact |
|----------|------|---------------|--------|
| ✅ 즉시 | ① Differentiable sigma point spread | MS-UKF (Levy 2026), Turner & Rasmussen (2010) | 가장 높음 |
| ✅ 병행 | ③ Sigma point trajectory as feature | Novel (선행연구 없음) | medium |
| ⚠️ 결합 | ④ Learnable sigma weights | MA-UKF (Majewski 2026) | ①+③과 결합 시 시너지 |
| ❌ 보류 | ② LMI-aware adaptive point count | Novel | 낮음 |
| 📌 장기 | ⑤ Per-sigma-point correction | Novel | 매우 높음 (risk 높음) |
