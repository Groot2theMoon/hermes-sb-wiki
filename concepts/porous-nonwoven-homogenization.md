---
title: "Porous Nonwoven Homogenization — Computational Homogenization & Compression Modeling"
created: 2026-05-03
updated: 2026-05-03
type: concept
tags: [nonwoven, porous-media, homogenization, fem, fibrous-networks, compression-modeling]
sources:
  - raw/papers/kuts24-porous-nonwoven-homogenization.md
  - raw/papers/wan24-nonwoven-compression-microscale.md
confidence: high
---

# Porous Nonwoven Homogenization — Computational Homogenization & Compression Modeling

## 개요

다공성 부직포(porous nonwoven fibrous materials)는 필터, 단열재, 의료용 섬유 등 다양한 산업 분야에서 핵심적인 역할을 한다. 이들의 복잡한 미세구조로 인해 기계적 거동 예측은 어려운 과제이며, 본 페이지에서는 Kuts (2024)의 **FEM 기반 균질화**와 Wan (2024)의 **이산 압축 모델링** 두 접근법을 다룬다.

## Kuts (2024) — FEM 기반 선형 탄성 균질화

### 방법론

- **재료:** Polypropylene (PP) 섬유 네트워크 (등방성 탄성, E = 1.8 GPa, ν = 0.43)
- **수치 도구:** FEniCSx + GMSH (OpenCASCADE 기반 형상 생성) + PETSc (CG + multigrid preconditioner)
- **경계 조건:** Kinematic Uniform Boundary Conditions (KUBC)
- **RVE 구조:** quasi-BCC nanogrid (3방향 직교 섬유 삼중항, fillness ψ로 결함 제어)

### 영향 인자 분석

| 인자 | 탄성 계수 영향 | 전단 계수 영향 |
|:----|:----|:----|
| **Porosity (η)** 증가 | **↓** (가장 큰 영향) | **↓** |
| **Fiber intersection ratio (γ)** 증가 | **↑** | **↑** |
| **Fiber diameter (dƒ)** 증가 | 영향 **미미** | 영향 **미미** |
| **Fillness (ψ)** 증가 | **↑** | **↑** |

- **핵심 발견:** Porosity와 fiber intersection ratio가 기계적 물성에 가장 큰 영향을 미친다.
- **이방성:** 동일 fillness 조건에서도 6개의 독립적인 탄성 성분이 존재 (구조적 비대칭성)

### Computational Workflow

1. **Preprocessing:** GMSH로 RVE mesh 생성 (27-node 2차 hexahedral element, ~0.4M–1.8M DoFs)
2. **Solving:** FEniCSx로 weak form 구성 → PETSc linear solver (CG + multigrid)
3. **Postprocessing:** ParaView / PyVista로 시각화, 6개 변형 모드로 compliance matrix 산출

### Mesh Convergence

- 수렴 차수: **O(h²·⁶¹)** (참조 메시 h ≈ 1.0 μm 기준)
- Coarse mesh (h = 4.7 μm): L₂ error ≈ 3.85%
- Fine mesh (h = 1.5 μm): L₂ error ≈ 0.16%

## Wan (2024) — 비가교 섬유 시스템의 압축 모델링

### 문제 설정

- **대상:** 엉킨 비가교(non-crosslinked) 섬유 시스템 — needle-punching 공정의 압축 상태 모사
- **방법:** 분자 동역학(MD) 기반 이산 모델 (velocity Verlet algorithm)
- **섬유 표현:** Polygon line (중심선 이산화) — 선형 스프링 + 각도 스프링으로 Euler beam 탄성 재현

### 복원력 (Recovery Forces)

| 스프링 | 제어 대상 | 에너지 | 힘 |
|:----|:----|:----|:----|
| **Linear spring** | Arc length (인장) | Eℓ = ½EA·(d − D)²/D | 노드 간 단위 벡터 방향 |
| **Angular spring** | Curvature (굽힘) | Eθ = ½EI·(Δθ)²/D | 3개 노드에 분포 |

- **비틀림(Torsion)은 무시** — 원형 단면 섬유에서 기여도 미미 + 타 섬유 접촉에 의해 구속됨

### 접촉력 (Contact Forces)

- **Hertzian contact theory** 기반: 두 skew cylinder 접촉
- **Overlap δ**와 **skewness angle θ**에 의존
- Discrete reconstruction: 노드 쌍 (Pᵢ,ₖ, Pⱼ,ₗ) 단위로 접촉력 분배
  - Simple model (δ only) — θ 의존성 재현 불가
  - **Extended model** (δ + orientation) — 국소 섬유 방향으로 θ 추정 → 올바른 μ(θ) 재현
- **Friction:** 속도 교환 방식 (velocity exchange), c₁, c₂ calibration 필요
- k-d tree로 노드 쌍 검색 최적화

### 압축 알고리즘

각 압축 단계:
1. **Shifting** — 섬유 노드 압축 방향으로 이동
2. **Balancing** — velocity Verlet로 평형 상태 수렴 (복원력 + 접촉력 + 마찰 + damping)

- 두 가지 shifting scheme: **quasi-static top compression** vs **uniform compression**
- **결과:** 초기 SVF 36.2% → 최대 ~100%까지 압축 가능
- 압축-압력 관계: 초기에는 작은 압력 → packing limit 도달 후 급격한 stiffening

## 관련 개념

- [[fft-homogenization-composites]] — FFT 기반 균질화 (Willot discretization + 3D fibrous homogenization)
- [[fft-homogenization-polymer-composites]] — FFT 균질화 기본 (Moulinec-Suquet)
- [[deep-material-network]] — DMN: 균질화 surrogate model
- [[poroelastic-dmn-research]] — DMN 포로탄성 균질화
- [[fm-dem-pore-network]] — FEM-DEM coupled pore network

## References

- Kuts, M., Walker, J. & Newell, P. (2024). "Computational homogenization of linear elastic properties in porous non-woven fibrous materials." *Mechanics of Materials*, 190, 104849.
- Wan, C., Heider, Y. & Markert, B. (2024). "Microscale modelling of non-woven material compression." *PAMM*, e202400176.
- Cox, H.L. (1952). "The elasticity and strength of paper and other fibrous materials." *British J. Applied Physics*, 3, 72–79.
