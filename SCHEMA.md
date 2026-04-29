# Wiki Schema

## Domain

**AI/ML + Mechanical Engineering & Physics/Mechanics 융합**

머신러닝, 딥러닝 등 인공지능 기술을 전통적인 기계공학 및 물리/역학 분야에 적용하는 학제 간 연구를 다룹니다. PINN, surrogate modeling, digital twin, sim-to-real transfer, FEM/CFD 최적화, 제어 시스템 등이 핵심 주제입니다.

### 하위 범주 1: 순수 물리/기계 역학 기반 이론 (추후 AI 융합을 위한 기초 재료)
AI 기술과의 즉각적 융합 없이도, 추후 융합 연구의 기반이 될 순수 물리학, 역학, 기계공학 이론을 포괄합니다. FEM 경계 조건 처리, 제어 이론(Lyapunov, ISS), 유체 역학 리뷰, 재료 역학 등이 포함됩니다. 이 범주의 자료는 현재 시점에서는 독립적으로 존재하나, 향후 AI 기반 예측/최적화와 결합될 가능성이 있는 '기초 재료(Base Materials)'로 관리합니다.

### 하위 범주 2: AI 고전 기초 모델 (비교/대조군 설정용)
현대 AI/Mechanics 융합 연구의 비교 기준(baseline) 및 대조군으로 활용되는 고전적 AI/ML 모델과 기법을 포괄합니다. LeNet, PCA, HMM, LLE, kernel methods, RBF networks, 초기 RNN/LSTM 등이 포함됩니다. 이 모델들은 융합 연구의 성능 비교, trade-off 분석, 그리고 "왜 딥러닝이 필요한가"를 입증하는 대조군 역할을 합니다.

## Conventions

- File names: lowercase, hyphens, no spaces (e.g., `physics-informed-neural-networks.md`)
- Every wiki page starts with YAML frontmatter (see below)
- Use `[[wikilinks]]` to link between pages (minimum 2 outbound links per page)
- When updating a page, always bump the `updated` date
- Every new page must be added to `index.md` under the correct section
- Every action must be appended to `log.md`
- **Provenance markers:** On pages that synthesize 3+ sources, append `^[raw/articles/source-file.md]` at the end of paragraphs whose claims come from a specific source.
- **Language:** Pages can be written in Korean or English (or mixed). Use consistent language within a single page. Prefer English for technical terms (PINN, FEM, CFD, etc.) even on Korean pages.

## Frontmatter

```yaml
---
title: Page Title
created: YYYY-MM-DD
updated: YYYY-MM-DD
type: entity | concept | comparison | query | summary
tags: [from taxonomy below]
sources: [raw/papers/filename.md]
# Optional:
confidence: high | medium | low
contested: true
contradictions: [other-page-slug]
---
```

### raw/ Frontmatter

Raw sources also get a small frontmatter block:

```yaml
---
source_url: https://arxiv.org/abs/XXXX.XXXXX   # if applicable
ingested: YYYY-MM-DD
sha256: <hex digest of the raw content below the frontmatter>
---
```

## Tag Taxonomy

### AI/ML Domain
- **model:** Neural network architectures, foundation models
- **training:** Training techniques, loss functions, optimizers
- **inference:** Deployment, serving, edge inference
- **benchmark:** Evaluation metrics, datasets, leaderboards
- **neural-network:** Specific NN concepts (CNN, Transformer, GNN, etc.)
- **sequence-modeling:** Sequence models (HMM, RNN, SSM, etc.)
- **nlp:** Natural Language Processing — text models, language understanding, generation
- **transformer:** Transformer-based architectures, self-attention, multi-head attention
- **learning:** General ML learning paradigms — supervised, unsupervised, self-supervised
- **continual-learning:** Continual/lifelong learning, catastrophic forgetting, incremental learning
- **architecture:** Neural network architecture design, NAS, macro/micro search
- **theory:** Theoretical ML foundations — proofs, bounds, convergence analysis

### Mechanics/Physics Domain
- **mechanics:** Classical mechanics, statics, dynamics
- **fluid-dynamics:** CFD, Navier-Stokes, turbulence modeling
- **thermodynamics:** Heat transfer, thermal analysis, energy
- **materials:** Material science, composites, properties
- **structural-analysis:** FEM, stress/strain, vibration
- **dynamics:** Multi-body dynamics, rigid/flexible body
- **photonics:** Photonic devices, nanophotonics, metamaterials
- **solid-mechanics:** Solid mechanics, elasticity, plasticity, failure
- **poroelasticity:** Poroelasticity, Biot theory, fluid-saturated porous media
- **thermoelasticity:** Thermoelasticity, thermal stress, entropy coupling
- **homogenization:** Homogenization, effective material properties, upscaling
- **micromechanics:** Micromechanics, microstructure-property relations
- **thermomechanics:** Thermomechanics, coupled thermal-mechanical problems
- **acoustics:** Acoustics, sound absorption, wave propagation in porous media
- **mechanical-engineering:** Broad mechanical engineering — design, manufacturing, systems
- **aerospace:** Aerospace engineering, aeronautics, propulsion, RDE, detonation
- **acoustoelasticity:** Acousto-elastic coupling, elastic wave propagation in porous media
- **inverse-design:** Inverse design, design-by-specification, generative engineering

### Fusion Domain (AI × Engineering)
- **physics-informed:** PINN, physics-constrained ML, PIML
- **pinn:** PINN — specific PINN implementations and variants (shorthand alias)
- **surrogate-model:** ML-based emulators replacing expensive simulations
- **digital-twin:** Real-time virtual replica, fleet learning
- **sim-to-real:** Sim-to-real transfer, domain randomization
- **FEM:** Finite Element Method enhanced with ML
- **CFD:** Computational Fluid Dynamics enhanced with ML
- **control-system:** ML-based control, MPC, reinforcement learning for control
- **optimization:** Topology optimization, multi-objective optimization, design optimization
- **reinforcement-learning:** RL for robotics, control, manipulation
- **neural-operator:** Neural operator learning (FNO, DeepONet, etc.)
- **operator-learning:** Operator learning — FNO, DeepONet, KAN, PDNO specific
- **deeponet:** DeepONet — Deep Operator Network specific (shorthand alias)
- **uncertainty:** Uncertainty quantification, Bayesian methods, confidence estimation
- **dmn:** Deep Material Network — binary tree surrogate for multiscale composites, physics-based ML
- **engineering-design:** Engineering design automation, simulation-based inference, conceptual design
- **robotics:** Robot control, legged locomotion, safety-critical control
- **koopman:** Koopman operator theory, DMD, data-driven spectral analysis
- **hybrid-modeling:** Hybrid physics-ML models, gray-box, physics-augmented learning
- **trajectory-optimization:** Trajectory optimization, path planning, motion planning
- **optimal-control:** Optimal control theory, MPC, LQR, dynamic programming
- **system-identification:** System identification, data-driven dynamics discovery
- **lyapunov:** Lyapunov functions, stability analysis, ISS
- **kalman-filter:** Kalman filter, state estimation, sensor fusion, UKF
- **state-space-model:** State-space models, SSM, linear dynamical systems
- **sequence-model:** Sequence models for dynamics — autoregressive, neural ODE
- **safety:** Safety-critical systems, verification, safe RL
- **certificate-functions:** Control barrier functions (CBF), control Lyapunov functions (CLF)
- **state-estimation:** State estimation, observers, filtering theory

### Meta
- **person:** Researcher, professor, industry leader
- **company:** Corporate R&D, startup
- **lab:** Academic lab, research group
- **tool:** Software, framework, library, platform
- **dataset:** Benchmark dataset, collection
- **paper:** Published research
- **comparison:** Side-by-side analysis
- **conference:** Venue (NeurIPS, ICML, ICLR, ICRA, IROS, etc.)
- **institution:** Academic institution, university, research center
- **hardware:** Hardware infrastructure, GPU, TPU, specialized chips
- **infrastructure:** Computing infrastructure, cloud, cluster, platform
- **landmark-paper:** Seminal/landmark research paper — high-impact, field-defining
- **research-idea:** 연구 아이디어, 제안, 로드맵 — 개발 중인 개념
- **postech:** POSTECH — Pohang University of Science and Technology
- **dslab:** DSLab — Data Science Lab @ POSTECH

### 수학/기초
- **mathematics:** Underlying math (PDEs, ODEs, numerical methods)
- **algorithms:** Core algorithmic concepts

### 순수 물리/기계 역학 기반 이론 (Foundation Materials for Future AI Fusion)
- **foundation:** 기초 재료 — 추후 AI 융합을 위한 순수 이론 기반
- **pure-mechanics:** 순수 기계공학 이론 (ML 결합 없는 상태)
- **control-theory:** 제어 이론 — Lyapunov, ISS, small-gain 정리
- **FEM-pure:** 순수 유한요소법 (ML 결합 없는 FEM 이론)
- **boundary-method:** 경계 조건 처리 기법 — SBM, immersed boundary 등
- **classic-control:** Classic control — PID, root locus, frequency domain, Bode/Nyquist
- **stability-theory:** Stability theory — Lyapunov, ISS, small-gain theorems
- **feedback-systems:** Feedback systems — closed-loop analysis, sensitivity, robustness
- **nonlinear-control:** Nonlinear control — backstepping, sliding mode, feedback linearization

### AI 고전 기초 모델 (Classic AI Baselines for Comparison)
- **classic-ai:** 고전 AI/ML 모델 — baseline 및 대조군
- **computer-vision:** 컴퓨터 비전 classic 모델 (LeNet, YOLO 계열 등)
- **kernel-method:** 커널 방법 — SVM, kernel PCA, Gaussian process
- **dimensionality-reduction:** 차원 축소 — PCA, LLE, t-SNE 등
- **generative-model:** 생성 모델 classic — VAE, GAN 초기
- **optimization-method:** 최적화 알고리즘 — SGD, Adam 초기
- **survey:** 리뷰/서베이 논문 — 특정 분야 종합 정리

### 연구 방법론 (Research Meta-Skills)
- **research-skills:** 연구 방법론, 논문 읽기/쓰기 기법, 리뷰 방법 — AI/ML × Mechanics 도메인 간접 지원

### 응용 도메인 (Applied Domains)
- **healthcare:** Healthcare, biomedical engineering, medical AI applications
- **upcycling:** Upcycling, recycling, waste-to-resource, circular economy
- **building-materials:** Building materials, construction, architectural acoustics
- **korea-market:** Korean market, domestic regulations, policy context

## Page Thresholds

- **Create a page** when an entity/concept appears in 2+ sources OR is central to one source
- **Add to existing page** when a source mentions something already covered
- **DON'T create a page** for passing mentions, minor details, or things outside the domain
- **Split a page** when it exceeds ~200 lines
- **Archive a page** when fully superseded — move to `_archive/`, remove from index

## Entity Pages

One page per notable entity (person, lab, company, product/model). Include:
- Overview / what it is
- Key facts and dates
- Relationship to AI/ML × Engineering
- Relationships to other entities ([[wikilinks]])
- Source references

## Concept Pages

One page per concept or topic. Include:
- Definition / explanation (in context of the fusion domain)
- Current state of knowledge
- Major papers or applications
- Open questions or debates
- Related concepts ([[wikilinks]])

## Comparison Pages

Side-by-side analyses. Include:
- What is being compared and why
- Dimensions of comparison (table format preferred)
- Verdict or synthesis
- Sources

## Update Policy

When new information conflicts with existing content:
1. Check the dates — newer sources generally supersede older ones
2. If genuinely contradictory, note both positions with dates and sources
3. Mark the contradiction in frontmatter: `contradictions: [page-name]`
4. Flag for user review in the lint report