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

## [2026-05-14] ingest | 3 papers — Differentiable Filtering Landscape

- **Raw sources (3):**
  - raw/papers/dvbf-karl16.md — Deep Variational Bayes Filters (ICLR 2017, arXiv:1605.06432)
  - raw/papers/enkf-gpssm-lin23.md — EnKF Meets GP SSM (2023, arXiv:2312.05910)
  - raw/papers/bayesian-kalmannet-dahan23.md — Bayesian KalmanNet (2023, arXiv:2309.03058)
- **Concept pages (3):**
  - concepts/dvbf-karl16.md — DVBF: unsupervised SSM learning via variational inference
  - concepts/enkf-gpssm-lin23.md — EnKF-GPSSM: ensemble KF for variational GP state-space models
  - concepts/bayesian-kalmannet-dahan23.md — Bayesian KalmanNet: uncertainty quantification in DNN-augmented KF
- **Backfill:** rigor-filter, kalmannet, rigor-research-roadmap → wikilinks added
- Total pages: 548 → 551
- **RIGOR 관련성:** RIGOR의 UKF + sigma cloud conditioning과 직접 비교해야 할 3개 계열 — variational filtering (DVBF), ensemble filtering (EnKF-GPSSM), learned Kalman gain (Bayesian KalmanNet) — 의 방법론 및 차별점 정리.

## [2026-05-14] concept | ukf-enkf-gradient-variance-analysis — Lemma

- UKF의 deterministic sigma point가 EnKF의 random ensemble보다 gradient variance 측면에서 strictly superior함을 증명
- RIGOR의 UKF 선택에 대한 이론적 근거 제공
- Total pages: 554 → 555

## [2026-05-14] concept | a-plus-nn-svd-projection-analysis — Lemma 4-5

- Lemma 4: A+NN SVD projection으로 structural stability guarantee
- Lemma 5: Residual orthogonality — no expressivity loss proof
- Total pages: 556 → 557

## [2026-05-14] concept | Lemma 6-7 — UFI superiority + K-step rollout bound

- Lemma 6: UFI conditioning superiority — why sigma cloud > ensemble for NN conditioning
- Lemma 7: Option B K-step rollout error bound — exponential failure for rho > 1
- Total pages: 557 → 559

## [2026-05-14] patch | 4 Lemma fixes based on mathematical review

- Lemma 5: REMOVED invalid Eq (116) — replaced with triangle inequality + explicit Δ* decomposition
- Lemma 1: variance caveat — ∂ℓ/∂μ randomness acknowledged, O(1/N²) residual term added
- Lemma 6: Delta method validity condition explicitly stated
- Lemma 7: Assumption A4 (Gradient Regularity) added → bounded ∂x̂_K/∂θ

## [2026-05-14] ingest | Julier & Uhlmann (2004) — Unscented Filtering raw paper

- Source: raw/papers/julier-uhlmann-2004-unscented-filtering.md
- Proc. IEEE 2004, Vol 92(3), pp. 401-422 — UKF 원논문
- 오픈액세스 PDF (UBC)
- Backfill: unscented-kalman-filter.md → sources 추가

## [2026-05-14] ingest | 2 papers — Blei VI Review + Korda & Mezić Koopman MPC

- **Raw sources (2):**
  - raw/papers/variational-inference-review-blei17.md — Blei et al. (arXiv:1601.00670, JASA 2017)
  - raw/papers/koopman-mpc-linear-predictors-korda18.md — Korda & Mezić (arXiv:1611.03537, Automatica 2018)
- **Concept pages (2):**
  - concepts/variational-inference-review-blei17.md — VI Review — VFE loss의 정보이론적 기반
  - concepts/koopman-mpc-linear-predictors-korda18.md — Koopman MPC — RIGOR A+NN과의 비교
- **Backfill:** rigor-research-roadmap, variational-bayes-adaptive-kalman-filter
- Total pages: 561 → 563
