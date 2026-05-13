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

## [2026-05-13] trending-scan | Script timeout recovery | 5 new concept(s), 0 updated
- **스크립트:** `trending-papers-wrapper.py` 타임아웃 (110s) → MCP arXiv + web_search로 수동 복구
- **스캔한 카테고리:** cs.CE, cs.LG, cs.RO, cs.AI, physics.comp-ph
- **신규 개념 (5):**
  - [[crash-assessment-mesh-gnn-surrogate]] — Crash Assessment via Mesh-GNN + Physics-Aware Attention
  - [[hs-fno-history-space-fno]] — HS-FNO: History-Space FNO for Non-Markovian PDEs
  - [[eqod-pde-identification]] — EqOD: Symmetry-Informed Stability Selection for PDE Discovery
  - [[cato-charted-attention-operator]] — CATO: Charted Attention for Neural PDE Operators
  - [[physpring-gnn-twin-reduction]] — PhySPRING: Structure-Preserving Reduction of Physics-Informed Twins via GNN
- **기존 페이지 확인됨:** VMLFN (arXiv:2605.02280), multi-fidelity-surrogate-composites (arXiv:2605.02871) — 이미 존재하므로 업데이트 생략
- Total pages: 516 → 521
