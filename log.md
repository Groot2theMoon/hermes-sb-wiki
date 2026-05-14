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


## [2026-05-13] ingest | GD1 Tutorial 2 — Laval Nozzle (MATLAB)

- **Raw source (1):**
  - raw/papers/gd1-tutorial-2-laval-nozzle.md — Gas Dynamics 1 Tutorial 2: Laval nozzle isentropic flow simulation (MATLAB)
- **New concept (1):**
  - concepts/laval-nozzle-quasi-1d-flow.md — Laval Nozzle — Quasi-1D Isentropic Flow with MATLAB tutorial
- **Wikilink backfill:**
  - Added [[laval-nozzle-quasi-1d-flow]] to related concept pages
- **Tags:** fluid-dynamics, thermodynamics, mechanics, exercise
- **Total pages:** 521 → 522

## [2026-05-14] lint-fix | Wiki Source Reference Audit & Repair

### Lint Results
- ✅ **Dangling sources (sources: → raw):** 0 (392개 참조 전부 실제 raw 파일과 일치)
- 📄 **Unreferenced raw files (raw/ but no wiki page link):** 64 → 0 (전부 처리 완료)

### Categories A+B: sources: frontmatter repair (55 concept pages, 71 raw links added)
- 51 pages had NO `sources:` field → inserted `sources:` with associated raw files
- 4 pages had existing `sources:` → appended additional raw files
- Key fixes: ensemble-kalman-filter (+2), differentiable-lmi-contractivity (+3), jca-inverse-parameter-estimation (+5), lure-stability (+3), rigor-sigma-point-research (+2), etc.

### Category C: New concept pages (5 created)
- [[sciml-schwarzschild-orbits]] — Neural ODE, UDE & Symbolic Recovery for Black Hole Orbits
- [[mars-bench]] — Benchmark for Foundation Models for Mars Science
- [[baryonic-feedback-continuous-representation]] — Flow Matching for Cosmology Simulations
- [[irc-safe-jet-clustering-gatr]] — IRC-Safe Jet Clustering with L-GATr
- [[platonic-universe-foundation-models]] — Representational Convergence of Foundation Models

### Index
- Rebuilt from filesystem: 521 → 548 pages (Entities: 181, Concepts: 351, Comparisons: 16)
- 22 previously unlisted pages now properly indexed
- Updated total count and last-updated date in header

### Note
- Original "duplicate file" claim withdrawn upon SHA256 re-verification — suspected pairs have different content

## [2026-05-14] update | RIGOR v5.x Wiki Backfill
- **New Concepts (3):** [[state-dependent-a-quadratic-form]], [[k-step-rollout-vfe-loss]], [[lorenz63-rigor-experiments]]
- **Updated Concepts (3):** [[rigor-filter]] (v5.x section, See Also), [[rigor-research-roadmap]] (Phase 4, updated timeline), [[rigor-development]] (v5.x changelog)
- **Summary:** Filled major gap — all v5.8–v5.19 work (LPV→Quadratic A, K-step rollout, Lorenz63 experiments) now documented. Total pages: 548→551.
