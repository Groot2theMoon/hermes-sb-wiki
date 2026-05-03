---
title: "evoxels — Differentiable Voxel-Based Microstructure Simulation"
created: 2026-05-03
updated: 2026-05-03
type: concept
tags: [tool, materials, micromechanics, homogenization, differentiable-physics, surrogate-model, inverse-design, dmn]
sources: [raw/papers/daubner25-evoxels.md]
confidence: medium
---

# evoxels — Differentiable Voxel-Based Microstructure Simulation

## 개요

**evoxels**는 Daubner et al. (2025, JOSS)가 개발한 **Python/JAX 기반 differentiable physics 프레임워크**로, voxelized microstructure 데이터로부터 직접 물성 예측과 역설계(inverse design)를 가능하게 한다. ^[raw/papers/daubner25-evoxels.md]

핵심 특징:
- **Voxel-based**: FIB-SEM, X-ray CT 등 3D microscopy 데이터를 메싱 없이 직접 입력
- **Differentiable**: PyTorch/JAX backend로 end-to-end gradient 기반 최적화 지원
- **Fourier spectral timestepping**: GPU 가속 FFT로 수억 DOF까지 확장 가능
- **모듈형 설계**: VoxelFields + VoxelGrid + Solver 3계층 추상화

## 아키텍처

### 두 가지 핵심 추상화

1. **VoxelFields**: NumPy 기반 3D field 컨테이너 — 이미지 I/O (tifffile, h5py, napari, scikit-image) 및 시각화(PyVista, VTK)와 직접 호환
2. **VoxelGrid**: PyTorch 또는 JAX backend에 field를 연결 — 경계 조건, 유한 차분 stencil, FFT 라이브러리 제공

### Solver 설계

- **Semi-implicit Fourier spectral method**: Zhu & Chen (1999) 방식의 IMEX (IMplicit-EXplicit) timestepping
- **Exponential integrators**: Hochbruck & Ostermann (2010) 기반 고차 시간 적분
- **Smoothed boundary method (SBM)**: Yu, Chen & Thornton (2012) 방식으로 복잡한 경계 처리
- 단일 GPU(4GB)에서 400³ voxel Cahn-Hilliard 시뮬레이션 가능

## 미세구조 시뮬레이션

evoxels가 지원하는 주요 PDE 문제:

| 문제 유형 | 지배 방정식 | 응용 |
|:---------|:-----------|:-----|
| 반응-확산 (Fick) | ∂c/∂t = ∇·(D∇c) | Li-ion 배터리 전극 내 이온 수송 |
| Gray-Scott | 2종 coupled reaction-diffusion | 패턴 형성, morphogenesis |
| Cahn-Hilliard | 4차 위상장 방정식 | Spinodal decomposition, 상분리 |
| Allen-Cahn | 비보존 위상장 진화 | 결정립 성장, 곡률 구동 |
| Multi-phase field | N coupled PDEs | 다상 재료의 미세구조 진화 |
| Smoothed boundary diffusion | ψ∂c/∂t = ∇·(ψΓ∇c) | 기공 내 확산 + 불침투 경계 |

## RIGOR / DMN 생태계와의 연결점

evoxels는 **[[deep-material-network|DMN]]** 및 **RIGOR** 생태계와 다음과 같이 연결될 수 있다:

### DMN과의 관계

| 측면 | DMN | evoxels |
|:----|:----|:--------|
| **물성 예측 방식** | Binary tree + laminate homogenization | Voxel-based FFT/FD 직접 시뮬레이션 |
| **학습 가능성** | Building block 파라미터 학습 | **전체 solver가 differentiable** |
| **입력 데이터** | Phase 강성 쌍 | Segmented 3D microscopy volume |
| **비선형 확장** | Online Newton-Raphson extrapolation | **Gradient-based inverse design** |
| **계산 속도** | ~8100× DNS 대비 | GPU 가속 (~1024³ voxels) |

→ evoxels는 DMN의 **training data 생성기** 및 **검증 기준(gold standard)** 으로 활용 가능. DMN이 추상화한 laminate homogenization의 정확도를 voxel-level full-field simulation으로 평가.

### RIGOR와의 관계

RIGOR (Differentiable SR-UKF with Lur'e stability)는 상태 추정 프레임워크. evoxels는:
- **microstructure → 물성**의 forward mapping 제공
- **물성 → 최적 미세구조**의 inverse mapping (gradient descent)
- RIGOR의 상태 추정과 결합 시, **실시간 microstructure-informed estimation** 가능

## 응용 아이디어

1. **DMN Training Data Pipeline**: 다양한 가상 미세구조(voronoi, random field) 생성 → evoxels로 full-field homogenization → DMN 학습
2. **Differentiable Homogenization Chain**: evoxels solver를 neural network layer로 embedding → end-to-end 미세구조 최적화
3. **Image-to-Property Inverse Design**: 3D microscopy → evoxels forward → 물성 gradient → 최적 미세구조
4. **Battery Electrode Design**: Cahn-Hilliard + diffusion coupled simulation으로 충방전 과정 최적화
5. **FFT-Based Spectral Homogenization**: [[fft-homogenization-polymer-composites]]와 방법론적 유사성, GPU 가속으로 확장

## 관련 개념

- [[deep-material-network]] — DMN: 물리 기반 surrogate model, evoxels와 보완적 관계
- [[fft-homogenization-polymer-composites]] — FFT 기반 균질화 (Willot 2015, Moulinec-Suquet)
- [[thermoelastic-dmn]] — 열탄성 DMN (Shin 2024): building block 확장의 예
- [[surrogate-model]] — Surrogate modeling 패러다임
- [[physics-informed]] — 물리 기반 ML 일반
- [[monotone-operator-equilibrium-networks]] — monDEQ: 수렴 보장 implicit layer (voxel solver와 다른 접근이지만 differentiable physics의 또 다른 패러다임)

## References

- Daubner, S., Cohen, A. E., Dörich, B., & Cooper, S. J. (2025). evoxels: A differentiable physics framework for voxel-based microstructure simulations. *JOSS*, arXiv:2507.21748.
- Zhu, J., Chen, L. Q., Shen, J., & Tikare, V. (1999). Coarsening kinetics from a variable-mobility Cahn-Hilliard equation. *Phys. Rev. E*, 60(4), 3564.
- Yu, H.-C., Chen, H.-Y., & Thornton, K. (2012). Extended smoothed boundary method. *Modelling Simul. Mater. Sci. Eng.*, 20(7), 075008.
- Chen, L. Q. & Shen, J. (1998). Applications of semi-implicit Fourier-spectral method to phase field equations. *Comput. Phys. Commun.*, 108(2-3), 147-158.
