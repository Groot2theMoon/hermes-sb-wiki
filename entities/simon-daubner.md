---
title: Simon Daubner
created: 2026-05-03
updated: 2026-05-04
type: entity
tags: [person, imperial-college, materials, micromechanics, phase-field, differentiable-physics]
sources:
  - raw/papers/daubner25-evoxels.md
confidence: medium
---

# Simon Daubner

**소속:** Imperial College London, Department of Materials / Dyson School of Design Engineering  \n
**이메일:** `s.daubner@imperial.ac.uk`

## 전문 분야

- **Differentiable physics** — evoxels: PyTorch/JAX 기반 voxel-based 미세구조 시뮬레이션 프레임워크
- **Phase-field modeling** — Cahn-Hilliard, Allen-Cahn, multi-phase field 재료 시뮬레이션
- **Microstructure characterization** — 배터리 재료의 active surface area, tortuosity 계산 (Daubner & Nestler, 2024, *J. Electrochem. Soc.*)
- **Voxel-based digital materials science** — FIB-SEM, X-ray CT 이미지 기반 직접 시뮬레이션
- **Spectral/Fourier timestepping** — GPU 가속 semi-implicit 및 exponential integrators

## 주요 논문

| 논문 | 저널 | 연도 | 역할 |
|:----|:----|:----:|:----:|
| evoxels: A differentiable physics framework for voxel-based microstructure simulations | *JOSS*, arXiv:2507.21748 | 2025 | **Corresponding author** |
| Microstructure Characterization of Battery Materials Based on Voxelated Image Data | *J. Electrochem. Soc.*, 171(12):120514 | 2024 | Co-author |
| Simulation of intercalation and phase transitions in nano-porous, polycrystalline agglomerates | *npj Comput. Mater.*, 11(1):211 | 2025 | Co-author |
| Triple junction benchmark for multiphase-field and multi-order parameter models | *Comput. Mater. Sci.*, 219:111995 | 2023 | Co-author |

## 관계

- **Alexander E. Cohen** — MIT, evoxels 공동 저자
- **Benjamin Dörich** — KIT, evoxels 공동 저자
- **Samuel J. Cooper** — Imperial College, evoxels 공동 저자, taufactor 개발자
- **Britta Nestler** — KIT, phase-field 연구 협력
- **Imperial College London** — 소속 기관

## 관련 개념

- [[evoxels-differentiable-voxel]] — evoxels 프레임워크 개념 페이지
- [[deep-material-network]] — DMN (evoxels와 보완적 관계: training data 생성기 / 검증 기준)
- [[fft-homogenization-polymer-composites]] — FFT 균질화 (방법론적 연관)
