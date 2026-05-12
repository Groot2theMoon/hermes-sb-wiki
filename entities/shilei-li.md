---
title: "Shilei Li"
created: 2026-05-12
updated: 2026-05-12
type: entity
tags: [person, robust-Kalman-filter, variational-inference, Student-t-distribution]
sources: [raw/papers/variational-robust-kalman-li26.md]
confidence: high
---

# Shilei Li

Shilei Li is a researcher at the School of Automation, Beijing Institute of Technology (BIT), China, specializing in robust Kalman filtering, variational inference, and state estimation under non-Gaussian noise. He developed a unified framework combining robustness and adaptivity in Kalman filters.

## 주요 기여

### Variational Robust Kalman Filters: A Unified Framework (2026)
- Proposed a **unified framework** that can recover standard KF, robust KF, adaptive KF, or any hybrid combination through hyperparameter tuning
- Built the filter on a **Student's t-distribution** induced loss function with variational inference, solved via efficient fixed-point iteration
- Demonstrated that **robustness is a prerequisite for adaptivity**, merging the two competing objectives through a probabilistic switching rule
- Provided **sufficient conditions for convergence** of fixed-point iteration under a class of robust losses (Theorem 3) and showed VB state inference reduces to MAP estimation (Theorem 4)
- RIGOR 관련성: Directly addresses the robustness-adaptivity trade-off in KF — a key challenge in the RIGOR project's work on reliable filtering under complex noise conditions

## 소속
- School of Automation, Beijing Institute of Technology, Beijing, China

## Wikilinks
- [[rigor-filter]]
- [[variational-bayes-adaptive-kalman-filter]] — VB 기반 Robust + Adaptive KF
