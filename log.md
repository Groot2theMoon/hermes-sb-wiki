     1|# Wiki Log
     2|
     3|> Chronological record of all wiki actions. Append-only.
     4|> Format: `## [YYYY-MM-DD] action | subject`
     5|> Actions: ingest, update, query, lint, create, archive, delete
     6|

## [2026-05-12] deep-research | Koopman Lifting for RIGOR — A+NN UKF with Augmented State Dynamics

- **Deep-research 결과:** KKF (Neto 2025, arXiv:2511.04252), Deep-Koopman KF (Boscariol 2025), EKF-Koopman (2024) 등 조사
- **New concepts:** [[koopman-lifting-rigor]] — polynomial/kernel lifting으로 A matrix를 lifted space로 확장
- **Wikilink backfill:** [[rigor-design-philosophy-v3]] ← cross-linked
- **Key insight:** Koopman lifting + A+NN + differentiable SR-UKF의 3-way hybrid는 기존 연구에 없음. KKF가 가장 가깝지만 differentiable joint training, partial obs, A+NN 분할 모두 없음.
- **구현 계획:** Phase 1 — polynomial lifting (2차 다항식, 2→5D), Phase 2 — RFF, Phase 3 — differentiable kEDMD


## [2026-05-12] ingest | 5 papers — Variational Bayes Adaptive Kalman Filter

- **Raw sources (5):**
  - raw/papers/vb-adaptive-kf-sarkka13.md — Särkkä & Hartikainen (2013) VB nonlinear noise-adaptive KF (MLSP 2013)
  - raw/papers/vb-adaptive-kf-huang18.md — Huang et al. (2018) VBAKF with inaccurate Q,R (IEEE TAC)
  - raw/papers/variational-filtering-correlated-noise-srinivasan26.md — Srinivasan et al. (2026) Variational filtering, correlated noise (arXiv:2604.03001)
  - raw/papers/adaptive-noise-kf-akhlaghi17.md — Akhlaghi et al. (2017) Survey of adaptive noise covariance methods (arXiv:1702.00884)
  - raw/papers/variational-robust-kalman-li26.md — Li et al. (2026) Variational Robust KF, Student's t (arXiv:2512.15419)
- **Concept pages (1):**
  - concepts/variational-bayes-adaptive-kalman-filter.md — VB 기반 Adaptive KF 방법론 종합
- **Entity pages (5):**
  - entities/simo-sarkka.md — Simo Särkkä (Aalto)
  - entities/yulong-huang.md — Yulong Huang (Harbin Engineering)
  - entities/shilei-li.md — Shilei Li (BIT)
  - entities/ling-shi.md — Ling Shi (HKUST)
  - entities/harsha-honnappa.md — Harsha Honnappa (Purdue)
- **Backfill:** rigor-sigma-point-research, rigor-filter, auto-diff-data-assimilation, entity wikilinks
- **RIGOR 관련성:** VB 기반 adaptive Q/R noise covariance 학습 — RIGOR의 EM 기반 covariance learning 대체/보완 가능
- Total pages: 510 → 516
