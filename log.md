# Wiki Log

> Chronological record of all wiki actions. Append-only.
> Format: `## [YYYY-MM-DD] action | subject`
> Actions: ingest, update, query, lint, create, archive, delete
> When this file exceeds 500 entries, rotate: rename to log-YYYY.md, start fresh.

## [2026-04-28] create | Wiki initialized
- Domain: AI/ML × Mechanical Engineering & Physics/Mechanics (융합)
- WIKI_PATH: /home/aero_groot/agent-workspace/wiki
- Structure: SCHEMA.md, index.md, log.md, raw/{articles,papers,transcripts,assets}, entities/, concepts/, comparisons/, queries/
## [2026-04-28] ingest | Batch 1: 5 papers (all concepts)
- Ingested files (alphabetical order):
  - raw/papers/10.1.1.441.7873.md  →  concepts/universal-approximation-theorem.md (new)
  - raw/papers/1312.6114v11.md      →  concepts/variational-autoencoder.md (new)
  - raw/papers/1402.0030v2.md       →  concepts/neural-variational-inference.md (new)
  - raw/papers/1412.3555v1.md       →  concepts/gated-recurrent-units.md (new)
  - raw/papers/1506.02640v5.md      →  concepts/yolo-object-detection.md (new)
- Files created: 5 concept pages
- Tags used: neural-network, model, training, inference, mathematics, paper, benchmark, comparison

## [2026-04-28] ingest | Batch 2: 5 papers (LRP, ResNet, DenseNet, Deep Ensembles, ML×Physics)
- raw/papers/1509.06321v1.md          → concepts/dnn-interpretability-lrp.md (new)
- raw/papers/1512.03385v1.md          → concepts/residual-networks.md (new)
- raw/papers/1608.06993v5.md          → concepts/densenet.md (new)
- raw/papers/1612.01474v3 (1).md     → concepts/deep-ensembles.md (new)
- raw/papers/1703.02435v2.md          → concepts/unsupervised-phase-transitions.md (new)
- Files created: 5 concept pages
- Key highlight: unsupervised-phase-transitions.md is in the user's AI/ML × Physics domain

## [2026-04-28] ingest | Batch 3: 4 new pages + 1 overlap
- raw/papers/1703.04977v2.md          → concepts/bayesian-uncertainty-vision.md (new)
- raw/papers/1706.03762v7.md          → concepts/transformer.md (new) ⭐
- raw/papers/1708.08296v1.md          → overlaps with existing dnn-interpretability-lrp.md (XAI survey)
- raw/papers/1802.05365v2.md          → concepts/elmo.md (new)
- raw/papers/1803.03635v5.md          → concepts/lottery-ticket-hypothesis.md (new)
- Files created: 4 new concept pages
- Total wiki pages now: 14

## [2026-04-28] ingest | Batch 8-9: 10 papers → 9 new concepts + 1 update
- Ingested files:
  - raw/papers/2102.04626v1.md          → concepts/hpinns-inverse-design.md (new) — hPINN with hard constraints for topology optimization
  - raw/papers/2104.06368v1.md          → concepts/unsupervised-phase-transitions.md (update) — VAE Ising model analysis added
  - raw/papers/2201.11967v3.md          → concepts/pseudo-differential-neural-operator.md (new) — PDNO generalizing FNO
  - raw/papers/2203.10989v2.md          → concepts/hierarchical-autoregressive-networks.md (new) — HAN for Ising model scaling
  - raw/papers/2207.00980v1.md          → concepts/conditional-normalizing-flow-lattice.md (new) — C-NF for lattice sampling
  - raw/papers/2281727.md               → concepts/deeponet.md (new) — Deep Operator Networks
  - raw/papers/2301.08243v3.md          → concepts/i-jepa.md (new) — I-JEPA self-supervised learning
  - raw/papers/2302.14082v2.md          → concepts/mode-collapse-flow-lattice.md (new) — Mode-collapse in flow sampling
  - raw/papers/2303.15093v2.md          → concepts/quadratic-iss-lyapunov.md (new) — ISS Lyapunov for linear analytic systems
  - raw/papers/2304.02034v1.md          → concepts/effective-theory-transformers.md (new) — Effective theory of Transformers
- Files created: 9 new concept pages
- Files updated: 1 existing page (unsupervised-phase-transitions.md)
- Total wiki pages now: 23
- Tags used: physics-informed, optimization, surrogate-model, control-system, neural-network, model, training, inference, benchmark, mathematics

## [2026-04-28] ingest | Batches 4-8: Consolidation of all subagent results
- Subagents processed batches 4-9, created ~24 new concept pages
- Missing pages from index.md have been consolidated
- Key additions: BERT, NTK, PINN theory papers (physics-constrained-surrogate, bayesian-pinns, pinn-failure-modes)
- ML × Physics: flow-based-mcmc, gan-lattice-simulations, variational-autoregressive-networks
- Total wiki pages now: 38

## [2026-04-28] schema | SCHEMA.md 확장 — 2개 하위 범주 + 12개 신규 태그 추가
- 하위 범주 1: 순수 물리/기계 역학 기반 이론 (추후 AI 융합을 위한 기초 재료)
- 하위 범주 2: AI 고전 기초 모델 (비교/대조군 설정용)
- 신규 태그: foundation, pure-mechanics, control-theory, FEM-pure, boundary-method, classic-ai, computer-vision, kernel-method, dimensionality-reduction, generative-model, optimization-method, survey

## [2026-04-28] ingest | Base Materials Batch: 31 skipped papers → 독립 개념 페이지 등록
- 31 unreferenced raw papers processed as lightweight independent concept pages
- Pages tagged with foundation, classic-ai, or control-theory tags
- No forced merging with existing fusion-domain pages
- Total wiki pages now: 72

## [2026-04-28] lint | Comprehensive health check
- Index incompleteness: 27 pages missing → **FIXED** (rebuilt index with 72 entries)
- Broken wikilinks: 8 links to non-existent pages (physics-informed, physics-informed-neural-networks, yoshua-bengio)
- Orphan pages (0 inbound): 36 pages — mostly base materials
- Pages with <2 outbound links: 35+ pages (SCHEMA requires min 2)
- Empty directories: entities/, comparisons/, queries/, raw/articles/, raw/transcripts/, raw/assets/
- Invalid tags: 8 pages use [[physics-informed]] and [[physics-informed-neural-networks]] as wikilinks (not tags)
- Large pages (>200 lines): none
- Stale content (>90 days): none (all created 2026-04-28)
- Log rotation: not needed (73 entries < 500)

## [2026-04-28] lint --fix | Resolved 5 issues from lint report
- Broken wikilinks: created physics-informed.md, physics-informed-neural-networks.md, entities/yoshua-bengio.md → 8 broken links FIXED
- Outbound link deficiency: added cross-links to 25+ pages → 8 pages remain with <2 (standalone base materials)
- Orphan inbound links: 36→16 improved by cross-linking (remaining 16 are isolated base materials)
- Empty directories: .gitkeep + README.md added to all 6 limbo directories
- Tag confusion fixed: physics-informed and physics-informed-neural-networks now exist as real pages
- Index: rebuilt with 75 entries (74 concepts + 1 entity)
