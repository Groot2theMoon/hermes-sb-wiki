# Wiki Log

> Chronological record of all wiki actions. Append-only.
> Format: `## [YYYY-MM-DD] action | subject`
> Actions: ingest, update, query, lint, create, archive, delete
> When this file exceeds 500 entries, rotate: rename to log-YYYY.md, start fresh.

## [2026-04-29] ingest | Gas Dynamics 1 — Lecture 2, Thermodynamics Review, Lecture 3
- **Sources ingested (3 raw files):**
  - raw/papers/gasdynamic-lecture-2-governing-equations.md — Lecture 2 (28p): Knudsen, continuity, momentum, RTT, Euler equations
  - raw/papers/gasdynamic-thermodynamics-review.md — Thermodynamics Review (26p): Energy eq., perfect gas, 1st/2nd law, entropy, isentropic
  - raw/papers/gasdynamic-lecture-3-compressibility-sound.md — Lecture 3 (23p): Compressibility, speed of sound, Mach, stagnation conditions
- **Concept pages created (6):**
  - concepts/compressible-flow-governing-equations.md — 7-equation system, conservative/non-conservative, RTT
  - concepts/compressibility-and-speed-of-sound.md — β_T, β_S, Newton vs Laplace derivation
  - concepts/mach-number-and-flow-regimes.md — M, sub/trans/super/hypersonic, Mach cone
  - concepts/stagnation-properties.md — T0, p0, ρ0, T*, M* relation
  - concepts/isentropic-relations.md — Thermodynamic derivation, p-T-ρ relations
  - concepts/knudsen-number-and-continuum.md — Continuum assumption, flow regime classification
- **Tags used:** fluid-dynamics, thermodynamics, foundation, pure-mechanics
- **Total wiki pages:** 164 → 170 (+6)

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

## [2026-04-28] ingest | Marker API — 3 PGC/RDE Foundation Papers (batch)
- **Source 1:** raw/papers/wolanski-2013-detonative-propulsion.md (34p, cost=11)
  - P. Wolanski, "Detonative propulsion," Proc. Combust. Inst. 34(1), 125–158 (2013) — DOI: 10.1016/j.proci.2012.10.005
  - ~1,200회 인용, detonative propulsion 전반의 종합 리뷰
- **Source 2:** raw/papers/lu-braun-2011-rotating-detonation-wave.md (20p, cost=6)
  - F.K. Lu, E.M. Braun, "Rotating detonation wave propulsion," AIAA Paper 2011-6043 (2011) — DOI: 10.2514/6.2011-6043
  - RDE 실험 도전과제, 모델링, 엔진 개념에 관한 권위 리뷰
- **Source 3:** raw/papers/bykovskii-2006-continuous-spin-detonations.md (13p, cost=4)
  - F.A. Bykovskii, S.A. Zhdan, E.F. Vedernikov, "Continuous spin detonations," J. Propul. Power 22(6), 1204–1216 (2006) — DOI: 10.2514/1.17656
  - ~728회 인용, 회전 폭굉(continuous spin detonation)의 실험적 초석
- **Classification:** Foundation Materials (순수 역학/추진 기반 이론, 추후 AI 융합을 위한 기초 재료)
- **Tags:** foundation, fluid-dynamics, thermodynamics, survey
- **Total Marker API cost:** 21 credits

## [2026-04-28] create | 5 Wiki Entity Pages — RDE/PGC Researchers & Labs
- **Entity:** [[piotr-wolanski]] — Piotr Wolański, Warsaw University of Technology, detonative propulsion pioneer
- **Entity:** [[fedor-bykovskii]] — Fedor A. Bykovskii, LIH Novosibirsk, continuous spin detonation experimentalist
- **Entity:** [[frank-lu]] — Frank K. Lu, UT Arlington, RDE review author
- **Entity:** [[sergey-zhdan]] — Sergey A. Zhdan, LIH Novosibirsk, RDE theoretical modeler
- **Entity:** [[lavrentyev-institute-of-hydrodynamics]] — LIH, world-leading detonation physics center
- **Tags:** person, lab, foundation, survey
- **Total pages:** 121 (was 116)

## [2026-04-28] create | 4 Wiki Concept/Comparison Pages — RDE/PGC Core Topics
- **Concept:** [[rotating-detonation-engine]] — RDE 작동 원리, 역사, 장단점, 과제 (78줄)
- **Concept:** [[pressure-gain-combustion]] — PGC 열역학 사이클 비교 (Brayton/Humphrey/Fickett-Jacobs) (73줄)
- **Concept:** [[deflagration-to-detonation-transition]] — DDT 물리적 메커니즘, 촉진 장치, RDE vs PDE 역할 (89줄)
- **Comparison:** [[pde-vs-rde]] — 15개 차원 상세 비교 + 선택 가이드 (105줄)
- **Tags:** foundation, fluid-dynamics, thermodynamics, survey, comparison
- **Total pages:** 125 (was 121)

## [2026-04-28] update | ML2 Lecture Materials — 9 pages updated/created
- **Deepened (2):** [[lle]] (16→91줄), [[t-sne]] (19→90줄) — SNE→t-SNE gradient derivation, LLE 3-step algorithm, invariance properties, Sheet 01/02 내용 반영
- **Created Concepts (3):** [[multi-dimensional-scaling]], [[isomap]], [[stochastic-neighbor-embedding]]
- **Created Entities (3):** [[klaus-robert-muller]], [[sam-roweis]], [[lawrence-saul]]
- **Created Comparison (1):** [[pca-vs-mds-vs-lle-vs-isomap-vs-tsne]] (replaces old pca-vs-tsne-vs-lle)
- **Raw Sources (5):** ml2-lecture-01.md, ml2-lecture-02.md, ml2-sheet-01.md, ml2-sheet-02.md, ml2-lle-intro.md
- **Tags:** classic-ai, dimensionality-reduction, survey, person, comparison
- **Total pages:** 131 (was 125)

## [2026-04-28] ingest | Trending Scan — 3 new concept pages, 2 updated
- **Trending scan:** Script ran (300s timeout), 50 papers fetched, 14 Tier 2, 36 Tier 3
- **False positives filtered (4):** MoT-HRA robotics, Visual RL, vehicle path planning, PHIN-GAN particle physics
- **New concept pages (3):**
  - [[ai-hallucination-physics]] (31줄) — AI 모델 hallucination in fluid dynamics (Wibawa & Jha 2026)
  - [[in-context-modeling-physics]] (31줄) — ICM retrain-free paradigm (Li et al. 2026)
  - [[wind-energy-ml]] (28줄) — Wind Energy × AI/ML (FNO+PINN for FOWT wakes)
- **Updated (2):**
  - [[fourier-neural-operator]] — FOWT wake application section added (+12줄)
  - [[physics-informed]] — 2026 trends section (ICM, Temporal U-Net, AI hallucination) (+8줄)
- **Raw sources (4):** raw/papers/trending/2026-04-28-{01,02,03,04}.md
- **Tags used:** physics-informed, fluid-dynamics, model, surrogate-model, CFD, paper, benchmark
- **Total pages:** 134 (was 131)

## [2026-04-28] ingest | UMAP Paper — concept, entity, comparison expansion
- **Raw Source:** raw/papers/1802.03426-umap.md (63p, cost=19)
- **Created Concept:** [[umap]] (135줄) — Riemannian geometry framework, fuzzy simplicial sets, UMAP vs t-SNE 비교
- **Created Entity:** [[leland-mcinnes]] — UMAP 창시자, umap-learn, HDBSCAN
- **Updated Comparison:** [[pca-vs-mds-vs-lle-vs-isomap-vs-tsne]] → 6-way (+UMAP column)
- **Tags:** classic-ai, dimensionality-reduction, person
- **Total pages:** 136 (was 134)

## [2026-04-28] ingest | Marker API — 3 Papers Batch (Nanomechanics & DMN)
- **Source 1:** raw/papers/ghadimi-2024-centimeter-nanomechanical-resonators.md (10p, cost=3)
  - Andrea Cupertino et al., "Centimeter-scale nanomechanical resonators with low dissipation," Nature Communications (2024) — 10.1038/s41467-024-48183-7
  - Multi-fidelity Bayesian optimization for nanomechanical resonator design
- **Source 2:** raw/papers/shin-2023-deep-material-network-quilting.md (16p, cost=5)
  - Dongil Shin et al., "Deep material network via a quilting strategy: visualization for explainability and recursive training for improved accuracy," npj Computational Materials (2023) — 10.1038/s41524-023-01085-6
  - DMN quilting strategy for explainability + recursive training
- **Source 3:** raw/papers/wan-2024-decoding-material-networks.md (12p, cost=4)
  - Wen-Ning Wan et al., "Decoding material networks: exploring performance of deep material network and interaction-based material networks," Journal of Mechanics (2024) — 10.1093/jom/ufae053
  - DMN vs IMN systematic comparison
- **Created Concepts (3):** [[centimeter-nanomechanical-resonators]], [[deep-material-network-quilting]], [[decoding-material-networks]]
- **Tags:** materials, surrogate-model, optimization, mechanics
- **Total Marker API cost:** 12 credits
- **Total pages:** 139 (was 136)

## [2026-04-28] lint --fix | SCHEMA + Index 재구축
- **SCHEMA.md:** 9개 누락 태그 추가 (institution, hardware, infrastructure, landmark-paper, neural-operator, uncertainty, photonics, solid-mechanics, sequence-modeling)
- **Index:** README.md 2개 제거 (entities/, comparisons/) + filesystem 기반 재구축
- **Total pages:** 136 (정확 — concepts 88 + entities 39 + comparisons 9)
- **Tags in taxonomy:** 45→54 (+9)

## [2026-04-28] discuss | 7×7 Acusto-Elastic DMN 및 Norris Correspondence
- **New Concepts (2):** [[poroelasticity-thermoelasticity-correspondence]], [[poroelastic-dmn-research]]
- **Concept Updates (2):** [[deep-material-network]], [[thermoelastic-dmn]] (신규 생성)
- **Summary:** Shin(2024) thermomechanical DMN이 Norris(1992) 포로-열탄성 대응 정리에 의해 준정적 Biot-type poroelastic DMN으로 직접 확장 가능함을 분석. 7×7 행렬 확장의 6가지 병목 식별 및 연구 로드맵 제안.
- **Tags in taxonomy:** 45→54 (+9)

## [2026-04-29] ingest | 6 raw source papers → wiki 반영
- **Updated Concepts (3):**
  - [[poroelasticity-thermoelasticity-correspondence]] — Norris 1992 원본 논문 source 추가
  - [[lle]] — Saul & Roweis LLE intro source 추가
  - [[poroelastic-dmn-research]] — 3편 신규 포로탄성 논문 source + 내용 추가 (Mehrabian 다중공극, Gurevich interface 조건, Berryman 층상 이방성)
- **Created Concepts (1):**
  - [[fft-homogenization-polymer-composites]] — FFT 기반 균질화 (Colabella 2017, 생체 재료 적용) — foundation/base material
- **Raw frontmatter added:** 6개 raw 파일에 SHA256 frontmatter 추가
- **Tags used:** foundation, pure-mechanics, materials, mathematics, paper
- **Total pages:** 137 (was 136, +1 concept)

## [2026-04-29] rewrite | 3 concept pages deepened (Content Deepening)
- **[[physics-informed-neural-networks]]** (15→63 lines): PINN full formulation (PDE residual, loss 함수), Burgers/Schrödinger/NS 결과 표, 역사적 의의, 융합 도메인 연결 (7개 관련 페이지)
- **[[kernel-methods]]** (18→61 lines): Kernel trick 원리, Mercer 정리, 대표적 알고리즘(SVM/KFD/GP/KPCA) 비교표, Deep Learning과의 관계 분석
- **[[lstm-forget-gate]]** (18→58 lines): Continual prediction 문제, forget gate 수식 유도, 원조 LSTM vs forget gate LSTM 성능 비교표, GRU/Transformer로의 발전 연결
- **Total wikilinks:** improved cross-referencing across all 3 pages
- **Tags used:** landmark-paper, survey, sequence-modeling

## [2026-04-29] create | 2 entity pages (Entity Backfill)
- **[[andrew-norris]]** — Andrew Norris (Rutgers) — Norris Correspondence, 포로탄성 DMN 이론 기반
- **[[bernhard-scholkopf]]** — Bernhard Schölkopf (MPI Tübingen) — Kernel PCA, SVM, Causal Inference
- **Wikilink backfill:** Norris → 2 concept pages, Schölkopf → 2 concept pages (kernel-methods, kernel-pca)

## [2026-04-29] ingest | 6 raw source papers → wiki 반영 (Batch)
- **Updated Concepts (4):**
  - [[waste-fiber-acoustic-absorber]] — 재활용 섬유 흡음 논문 + 3건 폐원단 보도자료 source 추가
  - [[shifted-boundary-method]] — High-Order SBM (Atallah 2023) source + 내용 추가
  - [[deep-material-network-quilting]] — Shin 2023 npj 논문 중복 source 추가
  - [[fft-homogenization-polymer-composites]] — Colabella 파일명 인코딩 정합
- **Deferred (2):** Friston free-energy principle × 2 (기존 분류 유지)
- **Raw frontmatter added:** 6개 raw 파일에 SHA256 frontmatter 추가
- **Index fix:** daniel-wolpert 제거, dongil-shin + waste-fiber-acoustic-absorber 추가
- **Total pages:** 145 (94 concepts + 42 entities + 9 comparisons)

## [2026-04-29] lint --fix | 3 issues resolved
- **SCHEMA.md:** 7개 누락 태그 추가 (poroelasticity, thermoelasticity, homogenization, micromechanics, thermomechanics, acoustics, dmn, research-idea)
- **Orphan cross-linking:** 5개 wikilink 추가 — mamba→albert-gu, vae→diederik-kingma, DMN pages→dongil-shin
- **Index:** dongil-shin + waste-fiber-acoustic-absorber 추가 (total→145), daniel-wolpert ghost entry 제거

- **Total pages:** 139 (was 137, +2 entities)

## [2026-04-29] trending-scan | Temporal U-Net for fluid interpolation | 1 new concept
- **Scan result:** 6 Tier 2 papers (기존 2건 중복, 2건 false positive, 1건 skip, 1건 신규)
- **Covered (already in wiki):**
  - `2604.23937` — FOWT FNO+PINN (기존 [[wind-energy-ml]], [[fourier-neural-operator]])
  - `2604.20372` — AI hallucination in fluid (기존 [[ai-hallucination-physics]])
- **Skipped (false positive or tangential):**
  - `2604.23599` — PU-GKAN (rom/les false positive, KAN architecture)
  - `2604.25756` — Bayesian active learning for phase transitions (materials science, not core mechanics)
  - `2604.25568` — Bandgap benchmark (materials informatics, tangential)
- **Created Concepts (1):**
  - [[physics-informed-temporal-unet]] — Physics-Informed Temporal U-Net for High-Fidelity Fluid Interpolation
- **Script issue:** trending-papers.py timed out at 120s → 수동 재실행 (300s timeout) 성공
- **Total pages:** 146 (was 145, +1 concept)

## [2026-04-29] discuss | 시장 진입 전략 + 폐섬유 처리 제도 조사
- **New Concept (1):** [[waste-fiber-market-entry]] — 폐섬유 흡음재 한국 시장 진입 전략 및 규제 분석
- **조사 결과 요약:**
  - 연간 80만톤 폐섬유 발생, 실질 물질 재활용 4.7%
  - 폐기물 처리비용 소각 10~15만원/톤 + 처분부담금 별도
  - 배출업체 톤당 ~17.5만원 절감 가능한 구조
  - GR K 0004(재활용 섬유흡음재), GR K 0012(재활용 면섬유흡음재) 이미 존재
  - EPR(섬유 생산자책임재활용제도) 도입 임박
  - 44% 사후확인 불합격률 + 경쟁사 오슬로(Osllo) 슬로우넬 존재
  - 차별점: DMN 기반 60Hz 저주파 타겟 + MaaS 맞춤 생산

## [2026-04-29] rewrite | 16 concept pages deepened (Content Deepening)
- **Tier 1 (3 pages):** gap-sbm (13→47), kennedy-ohagan-calibration (16→60), iss-lyapunov-theory (14→53)
- **Tier 2 (4 pages):** linear-rnn-theory (13→48), ensemble-loss-landscape (14→54), muon-optimizer (16→52), nn-tricks (16→56)
- **Tier 3 (9 pages):** ai-research-automation (14→41), ai-scientific-taste (14→41), jepa-world-models (14→36), agent-scaling (14→33), mhc-deepseek (14→35), engram-sparse-memory (15→35), xai-surveys (15→43), diffusion-lattice (14→31), memory-caching-rnn (13→41)
- **Summary:** 229→706 lines (+477), 평균 14→44 lines
- **New tags used:** landmark-paper (kennedy-ohagan, ai-research-automation), sequence-modeling (linear-rnn, memory-caching-rnn), optimization-method (muon), uncertainty (ensemble-loss, kennedy-ohagan), generative-model (diffusion-lattice), infrastructure (agent-scaling)
- **Total pages:** 148 (was 146)

## [2026-04-29] backfill | Entity & Comparison backfill (16 new pages)
- **Entities created (14):**
  - Tier 1 (core domain): [[deepseek]], [[guglielmo-scovazzi]], [[andrii-mironchenko]], [[balaji-lakshminarayanan]], [[duke-university]]
  - Tier 2 (notable): [[eduardo-sontag]], [[anthony-ohagan]], [[moonshot-ai]], [[fudan-university]], [[allen-institute-for-ai]], [[university-of-sheffield]], [[penn-state-university]], [[stanislav-fort]], [[sakana-ai]]
- **Comparisons created (2):**
  - [[mc-dropout-vs-deep-ensembles]] — MC Dropout vs Deep Ensembles UQ 비교
  - [[koh-vs-deep-uq]] — KOH Bayesian Calibration vs Deep Learning UQ 방법 비교
- **Wikilink backfill:** 21 [[wikilinks]] added to concept pages
- **Tag/link confusion fix:** `[[control-system]]` → `` `control-system` `` in iss-lyapunov-theory.md
- **Index rebuilt:** entities 42→56, comparisons 9→11, total 148→164

## [2026-04-29] fix | Raw references & wikilink cleanup
- **engram-sparse-memory.md:** `engram.md` → `Engram_paper.md` (실제 파일명 반영)
- **diffusion-lattice.md:** `sources:` 복원 → `2311.03578v1.md` (파일 존재)
- **memory-caching-rnn.md:** `sources:` 복원 → `2602.24281v1.md` (파일 존재)
- **mhc-deepseek.md, xai-surveys.md:** 없는 raw 파일 참조 제거 (`sources: []`)
- **ssl-agent-skill-representation.md:** PDF 참조 제거
- **eduardo-sontag.md:** `[[control-system]]` → `` `control-system` `` (tag/link confusion)
- **전수검사 결과:** broken wikilinks 0, broken sources 0

## [2026-04-29] ingest | 4 news articles (층간소음 + 폐섬유 재활용)
- **raw/articles/aptn-202509-110157-경실련-층간소음-전수조사-촉구.md** — 경실련, 층간소음 사후확인제 미달 32%, 특별법 촉구 (아파트관리신문)
- **raw/articles/rcnews-32933-LH-층간소음-사후확인제-바닥구조.md** — LH의 층간소음 사후확인제 대응과 바닥구조 혁신 (주거환경신문)
- **raw/articles/dbr-274-제클린-폐섬유-100퍼센트-재활용.md** — 제클린, 폐수건→새수건 섬유 100% 재활용 성공 (동아일보 DBR)
- **raw/articles/socialimpactnews-5443-서울시-의류섬유순환-정책-포럼.md** — 연 80만톤 의류폐기물, 서울시 순환 정책 포럼 (소셜임팩트뉴스)

## [2026-04-29] ingest | Marker API — KEITI GR certification docs (2 PDFs)
- **raw/papers/keitri-gr-certification-announcement-8items.md** — 우수재활용제품(GR) 인증 대상품목 8개 선정 공고안 (12p, quality 4.6, cost 4)
- **raw/papers/keitri-gr-inspection-research-2025.md** — GR 인증 현장조사 연구용역 보고서 (201p, quality N/A, cost 61)
- **Total Marker API cost:** 65 credits


## [2026-04-29] ingest | GD1 Tutorial 1 — Isentropic Flow Relations (MATLAB)
- **Source:** raw/papers/gd1-tutorial-1-isentropic-relations-matlab.md — PDF from Telegram
- **Updated Concept:** [[isentropic-relations]] — MATLAB 실습 섹션 추가 (Part 2: 4개 관계식 수치 계산 및 플로팅, Part 3: 함수화 리팩토링, 핵심 인사이트)
- **Tags used:** thermodynamics, fluid-dynamics, foundation, pure-mechanics
- **Total pages:** 164 (unchanged)

## [2026-04-29] ingest | 대규모 인제스트 — 46개 미처리 raw 파일 → 28개 신규 개념 + 6개 업데이트
- **Full triage:** 46 file classified → 28 created + 6 updated + 11 deferred + 3 skipped
- **New concepts:** 28 pages (KAN, Score-SDE, SN-GAN, Deep Delta, DUAL-X, UDE, continual learning, neural MPC, PAC-Bayes EU, diffusion metamaterials, DiT, LYGE, predictive CBF, Koopman, DIFFUSOLVE, orthogonal projection, safety filters, UKF, Zames stability, Simformer, GFSVI, Bayesian UQ MDPs, spectral margin bounds, causal XAI, label-wise UQ, SSM emergence, DKMGP, Sinkhorn)
- **Updated:** xai-surveys, agent-scaling, t-sne, nn-tricks, dnn-interpretability-lrp (+1 cross-ref)
- **Deferred:** 2 astronomy, 2 HEP, 2 neuroscience, 1 cosmology, 1 physics-astro, 1 math textbook, 1 pure geometry, 1 neuromorphic hardware, 1 Korean law
- **Index rebuilt:** 131 concepts + 56 entities + 11 comparisons = 198 total
- **Tags:** model, training, neural-network, control-system, uncertainty, mathematics, generative-model, physics-informed, foundation

## [2026-04-29] rewrite | Deepen pass — 8 concept pages rewritten
- [[physics-informed]] (12→116 lines) — Full taxonomy, key papers timeline, PINN/B-PINN/DeepONet/FNO comparison
- [[bert]] (10→109 lines) — Masked LM/NSP, architecture table, RoBERTa/ALBERT variants
- [[mamba]] (10→152 lines) — SSM theory, selective scan, H3/S4 → Mamba evolution, efficiency benchmark
- [[neural-tangent-kernel]] (10→102 lines) — NTK definition, infinite-width limit, gradient flow, PINN failure connection
- [[deeponet]] (24→122 lines) — Branch/trunk architecture, universal approximation theorem, operator learning taxonomy
- [[bayesian-pinns]] (8→46 lines) — HMC posterior, aleatoric/epistemic uncertainty decomposition
- [[pinn-failure-modes]] (9→45 lines) — NTK eigenvalue imbalance, adaptive learning rate annealing
- [[ppi-no]] (8→38 lines) — Soft physics constraint, FNO-DeepONet-PINN spectrum middle ground
- **Index rebuilt:** 198 total pages (131 concepts + 56 entities + 11 comparisons)

## [2026-04-29] deepen | 6 페이지 추가 보강 (uq-aeroelasticity, variational-autoregressive, conditional-normalizing-flow, pseudo-differential-neural-operator, physics-informed-temporal-unet, physics-constrained-surrogate)
- Deepened 6 pages to 85-126 lines with tables, formulas, ASCII architecture diagrams
- Restored 7 previously-overwritten deepened pages from git

## [2026-04-29] backfill | 6 entities + 2 comparisons 생성
- **Entities:** [[ziming-liu]], [[max-tegmark]], [[marin-soljacic]], [[yang-song]], [[takeru-miyato]], [[yifan-zhang]]
- **Comparisons:** [[sn-gan-vs-gan-lattice]], [[fno-vs-deeponet-vs-kan]]
- Index rebuilt: 209 total (134 concepts + 62 entities + 13 comparisons)

## [2026-04-29] fix | Wikilink confusion + cross-link backfill
- Fixed 2 remaining broken wikilinks (control-system, roberta → plain text)
- SCHEMA.md: engineering-design + robotics 태그 추가
- Cross-link backfill: 33 wikilinks added from parent pages → orphan pages
- Index rebuilt: 209 total (134 C + 62 E + 13 CMP)
- Broken wikilinks: 9

## [2026-04-29] lint --fix | Comprehensive lint + auto-repair
- **Lint findings:** 28 broken wikilinks (trailing spaces/backslashes), 11 orphans, 8 dangling sources
- **Fixed broken wikilinks (28→0):**
  - Trailing space before `|` pipe: `[[lle | LLE]]` → `[[lle|LLE]]` (15 instances across entity pages)
  - Trailing backslash before `|` pipe: `[[deeponet\|DeepONet]]` → `[[deeponet|DeepONet]]` (13 instances)
- **Fixed orphans (11→0):** Added 12 cross-links — takeru-miyato, yang-song, yifan-zhang linked from concept pages; waste-fiber-* linked from poroelastic-dmn-research, etc.
- **Fixed dangling sources (3):** pinn-failure-modes → sources: [] (no matching raw), ppi-no → 4999_Pseudo_Physics_Informed_N.md, physics-informed-temporal-unet → trending/2026-04-28-04.md
- **Index rebuilt:** 209 total unchanged
- **Tag audit:** 35 non-taxonomy tags in use, 6 unused schema tags — pending SCHEMA update
- **Source drift:** 19 raw files have sha256 mismatch (content edited after ingest) — informational only
- **Unprocessed raw:** 25 files remain in raw/papers/

## [2026-04-29] schema | 35 non-taxonomy tags added to SCHEMA taxonomy
- **Added 35 tags** across 7 sections: AI/ML (4), Mechanics (3), Fusion (15), Foundation (4), Meta (2), Applied Domains (4)
- **New section:** 응용 도메인 (Applied Domains) — healthcare, upcycling, building-materials, korea-market
- Duplicate fusion tags removed, uncertainty & robotics restored
- **Tag audit now clean:** 0 non-taxonomy, 97 schema tags, 93 used

## [2026-04-29] ingest | 5 raw files processed (unprocessed backlog 25→20)
- **Updated (2):**
  - [[mhc-deepseek]] — source added: 2512.24880v1.md (DeepSeek mHC paper)
  - [[waste-fiber-market-entry]] — sources added: keitri-gr-* (2), 자원순환기본법-시행령 (Korean regulatory docs)
- **New concepts (2):**
  - [[rino]] — RINO: Renormalization Group Invariance with No Labels (NeurIPS ML4PS 2025)
  - [[hilbert-simplex-geometry]] — Non-linear Embeddings in Hilbert Simplex Geometry (Nielsen & Sun, ICML 2023)
- **Source fix:** [[pinn-failure-modes]] — sources updated to 1-s2.0-S002199912100663X-main.md (was empty, PINN NTK paper found in backlog)
- **Index rebuilt:** 209→211 total (136 C + 62 E + 13 CMP)
- **Deferred (3):** NeurIPS_ML4PS_2025_59(s), 362 (HEP/astro); 363_Scientific_Machine_Learnin (astro)
- **Skipped (3):** The free-energy principle, nrn2787 (neuroscience); Optimization on Matrix Manifolds (textbook)
- **Skipped (3):** keitri-gr-certification, keitri-gr-inspection, 자원순환기본법 (absorbed into waste-fiber-market-entry sources)

## [2026-04-29] ingest | 6 raw articles → waste-fiber wiki pages
- **Updated (2):**
  - [[waste-fiber-market-entry]] — sources +5: 층간소음 전수조사 촉구 (aptn), 폐기물처분부담금 (keco), LH ESG, LH 바닥구조 (rcnews), 서울시 의류섬유순환 (socialimpactnews)
  - [[waste-fiber-acoustic-absorber]] — sources +1: DBR 폐섬유 100% 재활용 기사
- **Footnotes added** to market-entry page for key claims with `[^source]` markers
- **Unprocessed backlog:** 16 → 10 (6 articles processed)
- **Index unchanged:** 211 total

## [2026-04-29] fix | lint follow-up — 3 minor issues
- **Broken wikilinks (2):** [[rino]] → sim-to-real/self-supervised-learning — changed to plain text (no page exists)
- **Dangling source (1):** [[ian-goodfellow]] — malformed `raw/papers/` → specific paper refs
- **Orphans (2):** [[hilbert-simplex-geometry]] linked from lle, isomap, mds, kernels (4 links); [[rino]] linked from physics-informed, generative-models-physics (2 links)

## [2026-04-29] ingest | Friston Free Energy Principle (deferred → wiki integration)
- **Changed status:** 기존 Deferred (2) Friston 논문 → wiki 통합
- **New Concepts (1):** [[free-energy-principle]] — Friston 2009 TiCS + 2010 nrn2787 통합 요약
- **New Comparison (1):** [[landauer-friston-connection]] — Landauer 원리 ↔ Friston FEP 정보-열역학적 연결
- **New Entity (1):** [[karl-friston]] — UCL 신경과학자, FEP/DCM/SPM 창시자
- **SCHEMA.md:** Adjacent/Foundational Domains 섹션 + 5개 신규 태그 추가 (information-theory, neuroscience, cognitive-science, self-organization, information-thermodynamics)
- **Total pages:** 214 (was 211, +3)

## [2026-04-29] ingest | Deep Kalman Filter + GRU-D (2 PDFs → wiki)
- **New Concepts (2):**
  - [[deep-kalman-filter]] — DKF (Krishnan, Shalit, Sontag 2015): VAE + Kalman filter variational inference
  - [[gru-d]] — GRU-D (Che et al. 2018): RNN with informative missingness for time series
- **Raw files (2):** raw/papers/deep-kalman-filters.md, raw/papers/rnn-missing-values-timeseries.md
- **Total pages:** 216 (was 214, +2)

## [2026-04-29] lint --fix | 15 issues resolved
- **New pages (3):**
  - [[state-space-model]] — SSM 일반 이론 개념 페이지 생성
  - [[optimal-control]] — Optimal control 개념 페이지 생성 (FEP 연결 포함)
  - [[david-sontag]] — MIT 교수 entity 페이지 생성
- **Fixed broken wikilinks (1):** `entities/karl-friston.md` — [[predictive-coding]] → plain text (page 없음)
- **Fixed frontmatter (3):** `dongil-shin.md` (sources 추가), `yoshua-bengio.md` (sources 추가), `deep-material-network.md` (중복 sources 제거)
- **Cross-linked orphan gru-d (2):** `deep-kalman-filter.md` + `gated-recurrent-units.md`에 [[gru-d]] wikilink 추가
- **SCHEMA.md (2):** `variational-inference`, `latent-dynamics` 태그 추가
- **Index:** filesystem에서 전체 재빌드 (219 pages, 0 broken links, 0 orphans)

## [2026-04-29] ingest | Epiplexity paper
- **New Concept (1):** [[epiplexity]] — Finzi et al. 2025: computationally bounded structural information measure
- **Raw file:** raw/papers/epiplexity.md (65 pages, 221K chars)
- **Relevance:** 우리 entropy 논의와 직접 연결 — Shannon entropy가 설명 못하는 "계산적으로 추출 가능한 구조적 정보" 정식화
- **Total pages:** 220 (was 219, +1)

## [2026-04-29] backfill | David Sontag entity
- **New Entity (1):** [[david-sontag]] — MIT, DKF + GRU-D 공동 저자, 의료 ML

## [2026-04-29] ingest | ML2 Lecture 03 — CCA, kCCA, tkCCA, CTA
- **Source:** raw/papers/ml2-lecture-03-cca.md — Klaus-Robert Müller, TU Berlin ML2 (2023)
- **New Concept (1):** [[canonical-correlation-analysis]] — CCA, kCCA, tkCCA, Canonical Trend Analysis
- **Tags used:** classic-ai, dimensionality-reduction, learning, algorithms, kernel-method, survey
- **Total wiki pages:** 221 → 222 (+1)
- **Total pages:** 221 (was 220, +1)
