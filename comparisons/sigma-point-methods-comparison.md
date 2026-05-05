---
title: Sigma-Point Methods Comparison — Learning-Based vs Adaptive vs Minimal vs Multi-Scale
created: 2026-05-05
updated: 2026-05-05
type: comparison
tags: [comparison, sigma-point, ukf, ckf, nonlinear-filtering]
sources:
  - raw/papers/optimized-sigma-points-ukf.md
  - raw/papers/ukf-scaling-adaptive-setting.md
  - raw/papers/aas-2015-423-ukf.md
  - raw/papers/turras10.md
  - raw/papers/2604.04792v1.md
  - raw/papers/2603.04360v1.md
confidence: high
---

# Sigma-Point Methods Comparison

## Overview

UKF의 핵심 설계 자유도 — **sigma point placement와 weighting** —를 최적화하는 6가지 접근법의 비교.

## 비교 표

| 차원 | UKF-L (Turner) | MA-UKF (Majewski) | MS-UKF (Levy) | Adaptive Scaling (Duník) | Minimal SP (Cheng) | GGC (Linares) |
|:----|:----|:----|:----|:----|:----|:----|
| **핵심 아이디어** | Sigma point 위치 학습 | RNN으로 weight 동적 합성 | State별 scaling 분리 | Scaling 파라미터 적응 설정 | n+1개 최소점 사용 | 임의 차수 cubature |
| **학습 방식** | Offline marginal likelihood | Online RNN meta-learning | Offline/수동 설정 | Online χ² consistency | 사전 정의 | 사전 최적화 |
| **Sigma point 수** | 2n+1 (고정) | 2n+1 (고정) | 2n+1 (고정) | 2n+1 (고정) | **n+1** | 자유 (2n~m) |
| **파라미터** | Point 위치+weight | Weight (RNN context) | λ₁,...,λₙ (per-state) | κ (매 step) | 없음 (닫힌 형태) | Point 위치+weight |
| **비선형 대응** | Good (learned) | Excellent (adaptive) | Good (per-state) | Good (adaptive) | Moderate (minimal) | **Excellent** (high-order) |
| **계산량** | O(n³) | O(n³) | O(n³) | O(n³) | **O(n²)** (n+1 points) | O(n³) |
| **수치 안정성** | Good | Good | Better | Good | **Best** (radius O(√n)) | Good |
| **학습 필요** | ✅ (데이터 필요) | ✅ (meta-training) | ❌ | ❌ | ❌ | ✅ (1회 최적화) |
| **OOD 일반화** | Limited | **Excellent** (RNN context) | N/A | Robust | N/A | Limited |

## 선택 가이드

| 사용 사례 | 권장 방법 |
|:---------|:---------|
| 온라인 적응이 필요한 경우 | **MA-UKF** (RNN context encoder로 non-Gaussian glint noise에 강건) |
| State별 특성이 다른 경우 | **MS-UKF** (position vs velocity 등 다른 time scale) |
| 계산량 최소화가 필요한 경우 | **Minimal SP** (n+1 points, 40-50% 계산 감소) |
| 임의 정확도가 필요한 경우 | **GGC** (고차 모멘트 matching까지 가능) |
| Heuristic-free 구현 | **Adaptive Scaling** (χ² test로 κ 설정) |
| 데이터 기반 offline 최적화 | **UKF-L** (sigma point placement 학습) |

## Wikilinks
- [[ukf-learning-sigma-points]] — UKF-L
- [[ma-ukf-meta-adaptive]] — MA-UKF
- [[multi-scaled-ukf]] — MS-UKF
- [[ukf-scaling-adaptive-dunik]] — Adaptive scaling
- [[optimized-sigma-points-n-plus-1]] — Minimal sigma points
- [[generalized-gaussian-cubature]] — GGC
- [[differentiable-sigma-point-quadrature]] — RIGOR sigma point framework
