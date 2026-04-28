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

## [2026-04-28] create | 10 entity pages — key researchers & labs
- Created entities/ pages for major figures and organizations central to the wiki domain:
  - entities/maziar-raissi.md — PINN 창시자 (융합 도메인 핵심)
  - entities/george-em-karniadakis.md — PINN, DeepONet 공동 창시자 (융합 도메인 핵심)
  - entities/zongyi-li.md — FNO 창시자 (융합 도메인 핵심)
  - entities/kaiming-he.md — ResNet 창시자 (ML 핵심)
  - entities/ashish-vaswani.md — Transformer 제1저자 (ML 핵심)
  - entities/yann-lecun.md — CNN 아버지, JEPA/I-JEPA (ML 핵심)
  - entities/albert-gu.md — Mamba 공동 창시자 (차세대 아키텍처)
  - entities/diederik-kingma.md — VAE, Adam Optimizer (ML 핵심)
  - entities/openai.md — GPT series, AGI 연구 기관
  - entities/google-deepmind.md — Transformer, BERT, AlphaFold
- Total entities now: 11 (1 existing + 10 new)
- Tags used: person, model, neural-network, company, physics-informed, computer-vision

## [2026-04-28] create | 5 comparison pages — side-by-side analyses
- Created comparisons/ pages for key concept pairs:
  - comparisons/pinn-vs-deeponet.md — PINN vs DeepONet: 함수 vs 연산자 접근법 비교
  - comparisons/transformer-vs-mamba.md — Transformer vs Mamba: Attention vs SSM
  - comparisons/lstm-vs-gru.md — LSTM vs GRU: 게이트 RNN 비교
  - comparisons/vae-vs-gan.md — VAE vs GAN: 생성 모델 패러다임 비교
  - comparisons/resnet-vs-densenet.md — ResNet vs DenseNet: Skip Connection 비교
- Each comparison includes: table comparison, architecture comparison, use-case guidance
- Tags used: comparison, neural-network, model, physics-informed, benchmark

## [2026-04-28] update | index.md — entities + comparisons 채움
- Entities section: filled with 11 entity entries
- Comparisons section: filled with 5 comparison entries
- Total pages: updated to 90 (74 concepts + 11 entities + 5 comparisons)

## [2026-04-28] create | 3 new entities + 3 new comparisons (Structural Backfill)
- **BUG FIX:** zongyi-li was on disk but missing from index.md → added to index
- **New entity pages:**
  - entities/anima-anandkumar.md — FNO 공동 창시자, Caltech AI×Science 리더 (융합 도메인 핵심)
  - entities/juergen-schmidhuber.md — LSTM/GRU 창시자 (sequence modeling 근간)
  - entities/geoffrey-hinton.md — 딥러닝의 대부, Backpropagation, t-SNE, Nature Survey 공저
- **New comparison pages:**
  - comparisons/fno-vs-deeponet.md — FNO vs DeepONet: operator learning 2대 접근법 비교
  - comparisons/pca-vs-tsne-vs-lle.md — PCA vs t-SNE vs LLE: 3-way 차원 축소 방법 비교
  - comparisons/pinn-vs-hpinn.md — PINN vs hPINN: Soft vs Hard Constraint 비교
- **Index rebuilt:** Total pages updated to 96 (74 concepts + 14 entities + 8 comparisons)
- Tags used: person, surrogate-model, physics-informed, mathematics, neural-network, classic-ai, comparison, dimensionality-reduction, optimization, kernel-method

## [2026-04-28] create | 8 new entity pages + wikilink backfill (Tier 1 Entity Backfill)
- Created entity pages for key researchers missing from wiki:
  - entities/paris-perdikaris.md — Paris Perdikaris — PINN 공동 창시자, UPenn
  - entities/lu-lu.md — Lu Lu — DeepONet + hPINN 공동 창시자, DeepXDE/SciANN
  - entities/andrew-stuart.md — Andrew Stuart — Neural Operator 수학적 기반, Caltech
  - entities/kaushik-bhattacharya.md — Kaushik Bhattacharya — 고체역학 × AI 융합, Caltech
  - entities/steven-g-johnson.md — Steven G. Johnson — hPINN, 위상 최적화, MIT
  - entities/laurens-van-der-maaten.md — Laurens van der Maaten — t-SNE + DenseNet 창시자
  - entities/sepp-hochreiter.md — Sepp Hochreiter — LSTM 원조 창시자
  - entities/ian-goodfellow.md — Ian Goodfellow — GAN 창시자
- Added wikilinks from 11 concept pages → 8 new entities:
  - physics-informed-neural-networks.md → [[paris-perdikaris]], [[maziar-raissi]], [[george-em-karniadakis]]
  - pinn-failure-modes.md → [[paris-perdikaris]]
  - physics-constrained-surrogate.md → [[paris-perdikaris]]
  - deeponet.md → [[lu-lu]], [[george-em-karniadakis]]
  - hpinns-inverse-design.md → [[lu-lu]], [[steven-g-johnson]]
  - fourier-neural-operator.md → [[zongyi-li]], [[kaushik-bhattacharya]], [[andrew-stuart]], [[anima-anandkumar]]
  - t-sne.md → [[laurens-van-der-maaten]], [[geoffrey-hinton]]
  - densenet.md → [[laurens-van-der-maaten]]
  - gated-recurrent-units.md → [[sepp-hochreiter]]
  - lstm-forget-gate.md → [[juergen-schmidhuber]], [[sepp-hochreiter]]
  - gan-lattice-simulations.md → [[ian-goodfellow]]
  - generative-models-physics.md → [[ian-goodfellow]]
- Index rebuilt: Total pages updated to 104 (74 concepts + 22 entities + 8 comparisons)
- Tags used: person, mechanics, photonics, dimensionality-reduction, classic-ai, generative-model

## [2026-04-28] create | 7 new entity pages + wikilink backfill (Tier 2 Entity Backfill)
- Created entity pages for additional researchers and institutions:
  - entities/joseph-redmon.md — Joseph Redmon — YOLO 창시자
  - entities/ross-girshick.md — Ross Girshick — R-CNN/Fast R-CNN 창시자, YOLO 공동 연구자
  - entities/kyunghyun-cho.md — Kyunghyun Cho — GRU 창시자
  - entities/felix-gers.md — Felix Gers — LSTM Forget Gate 공동 창시자
  - entities/caltech.md — Caltech — AI × Mechanics 융합 연구 중심
  - entities/brown-university.md — Brown CRUNCH Group — PINN/DeepONet 탄생지
  - entities/nvidia.md — NVIDIA — GPU 컴퓨팅, AI × Science 인프라
- Added wikilinks from 6 concept pages → 7 new entities:
  - yolo-object-detection.md → [[joseph-redmon]], [[ross-girshick]]
  - gated-recurrent-units.md → [[kyunghyun-cho]]
  - lstm-forget-gate.md → [[felix-gers]]
  - fourier-neural-operator.md → [[caltech]]
  - deeponet.md → [[brown-university]]
  - pinn-high-speed-flows.md → [[brown-university]]
- Index rebuilt: Total pages updated to 111 (74 concepts + 29 entities + 8 comparisons)
- Tags used: person, computer-vision, institution, hardware, infrastructure

## [2026-04-28] git | commit and push to GitHub

## [2026-04-28] rewrite | 6 concept pages — 중요도 대비 빈약한 문서 전면 재작성 (Content Deepening)
- **hmm-tutorial** (14→53 lines): Rabiner 1989 완전 재작성 — HMM 3대 문제(평가/디코딩/학습) 알고리즘 수식, Rabiner 정리표, 한계/발전 관계, 융합 도메인 연결
- **deep-learning-nature-survey** (14→46 lines): LeCun/Bengio/Hinton Nature 2015 전면 재작성 — 딥러닝 3축(CNN/RNN/사전학습) 정리, 역사적 의의 표, 융합 도메인 개념 매핑
- **lenet-5** (14→52 lines): LeCun 1998 전면 재작성 — 7층 아키텍처 상세표, 핵심 혁신(weight sharing / 계층적 특징/end-to-end), MNIST 성능, 역사적 계보(AlexNet→ResNet) 추가
- **gpt-1** (15→51 lines): Radford 2018 전면 재작성 — 2단계 학습 패러다임(사전학습+미세조정), 태스크별 입력 변환 표, 12개 NLP 태스크 성능표, GPT→GPT-4 계보 추가
- **mc-dropout** (14→56 lines): Gal & Ghahramani 2016 전면 재작성 — Dropout=Bayesian VI 증명, MC Dropout 알고리즘, UQ 방법 비교표(계산비용/PINN 호환성), 융합 도메인(BNN/구조-UQ/배터리 surrogate) 연결
- **kernel-pca** (13→53 lines): Schölkopf 1998 전면 재작성 — PCA 한계→Kernel trick→KPCA 알고리즘, 대표적 커널(RBF/Polynomial/Sigmoid) 표, 차원 축소 방법 4-way 비교, 격자 시뮬레이션 활용
- 각 페이지에 수식(LaTeX), 비교표, References + wikilink 포함
- Total wikilinks: 74→84 (+10)

## [2026-04-28] ingest | Marker API — How to Read a Paper (S. Keshav)
- **Source:** raw/papers/how-to-read-a-paper.md (3 pages, 1-pass via Marker API, quality 4.8/5.0)
- **Concept:** [[how-to-read-a-paper]] — Three-Pass Method (3-pass approach, literature survey guide)
- **Entity:** [[s-keshav]] — S. Keshav, Waterloo CS 교수, 15년 연구 방법론 경험
- **Schema:** SCHEMA.md에 research-skills 태그 카테고리 추가

## [2026-04-28] create | Neural Thermodynamic Integration
- **Source:** [[raw/papers/2406.02313v4]] (Mate, Fleuret, Bereau, J. Phys. Chem. Lett. 2024)
- **Concept:** [[neural-thermodynamic-integration]] — Energy-based diffusion model을 이용한 TI, LJ fluid 성능 검증
- **Seminar:** TU Berlin "Data-Driven Modelling in Statistical Physics" (SoSe 2026, Dr. Ankur Singha)
