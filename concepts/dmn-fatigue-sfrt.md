---
title: "DMN for Short Fiber-Reinforced Thermoplastics — Fatigue & Creep"
created: 2026-05-05
updated: 2026-05-05
type: concept
tags: [dmn, materials, surrogate-model, fatigue, sfrt, micromechanics]
sources:
  - raw/papers/dey24-dmn-sfrt-effectiveness.md
confidence: high
---

# DMN for Short Fiber-Reinforced Thermoplastics — Fatigue & Creep

**Dey, Welschinger, Schneider, Köbler, Böhlke** (Bosch × KIT × Fraunhofer, 2024)  
*Archive of Applied Mechanics* 94:1177–1202

## 개요

Short fiber-reinforced thermoplastics (SFRTs)의 다중 스케일 가상 특성화를 위해 DMN을 확장한 연구. 기존 DMN이準정적(quasi-static) 하중에 국한되었던 한계를 넘어 **고주기 피로(high-cycle fatigue)** 와 **크리프(creep)** 까지 포괄하는 장기 비선형 하중 시나리오로 DMN 적용 범위를 확장.

## 핵심 기여

### 1. A Posteriori FOT Interpolation

기존의 a priori 접근법(Gajek et al.)과 달리, **각 FOT(fiber orientation tensor) 노드에 대해 개별 DMN을 학습**하고 macro-scale에서 응력을 보간하는 **a posteriori 접근법**을 사용.

- FOT 삼각형을 **15개 노드**로 이산화 (16개 sub-triangle)
- 각 노드에 SAM 알고리즘으로 생성한 미세구조 이미지 할당
- 각 노드에서 **탄성 FFT 균질화 데이터로 DMN 학습** (노드당 400 training + 100 validation = 7,500회 FFT)
- 모든 DMN: depth 7, rotation-free laminate binary tree

### 2. 피로 손상 모델 (Magino et al. 기반)

GSM (generalized standard material) 프레임워크 기반 피로 손상 모델:

- **대수 사이클 공간(logarithmic cycle space)** 에서 손상 변수 d 진화
- 자유 에너지: ψ(ε, d) = (1-d) · ½ ε : C : ε
- 손상 진화: d′ = α · ψ(ε, d) / (1-d) (linear in log cycle space)
- PBT 매트릭스 + 30% E-glass fiber, 17.8% 부피 분율

### 3. Power-Law 피로 손상 확장

Linear fatigue-damage law의 한계를 발견하고 **New power-law 손상 모델** 도입:

- 기존 linear 모델: 실험 결과와의 정합성 부족 (특히 high cycle 영역)
- Power-law 확장: nonlinear 항 추가로 inverse characterization 개선
- DMN의 **quasi-model-free 특성** 활용 — 미세구조 형상과 재료 모델의 분리

### 4. Coupled Plasticity-Creep 모델

단기(소성) + 장기(크리프) 변형을 동시에 모델링하는 GSM 기반 coupled model:

- 변형률 분해: ε = εᵉ + εᵖ + εᶜ
- Voce-type 경화 + Norton creep 결합
- Implicit Euler + return-mapping 알고리즘

## FOT Interpolation Framework

```
[Micro-scale]
  15 FOT nodes → 각각 SAM microstructure → FFT full-field → DMN 학습 (PyTorch + AMSGrad)
  
[Macro-scale]
  Macro 요소의 FOT → 가장 가까운 3개 노드 선택 → convex combination 응력 보간
  → 각 노드 DMN online phase (Newton iteration) → 내부 변수 독립적 저장
```

**DMN의 장점:** 재료 모델과 미세구조의 분리 → 동일한 DMN으로 다양한 구성 법칙(피로, 소성, 크리프) 평가 가능. MOR 기반 접근법(Magino et al.)과 달리 재료 모델 변경 시 DMN 재학습 불필요.

## 실험 검증

| 항목 | 내용 |
|:----|:-----|
| 대상 재료 | PBT + 30% E-Glass (Bosch 산업용) |
| 미세구조 | 625μm cubic, fiber 285μm×10μm, 512³ voxels → 256³ |
| DMN depth | 7 layers (127 nodes) |
| Accuracy | Energy equivalence residual 10⁻⁴ → 0.02% error |
| 검증 | Composite 실험 vs DMN 예측 비교 |
| Inverse ID | Macro-scale 실험 → matrix 재료 파라미터 역추정 |

## Wikilinks
- [[deep-material-network]] — DMN 기본 아키텍처
- [[dmn-overview-wei25]] — DMN 서베이 (직접 DMN, IMN 등)
- [[fft-homogenization-composites]] — FFT 균질화 (training data 생성)
- [[thermoelastic-dmn]] — 열탄성 DMN 확장
- [[porous-nonwoven-homogenization]] — 부직포 균질화
- [[dmn-jca-conversion-impossibility]] — DMN↔JCA 변환

## References
- arXiv/D OI: [10.1007/s00419-024-02558-w](https://doi.org/10.1007/s00419-024-02558-w)
- Bosch × KIT × Fraunhofer ITWM × Univ. Duisburg-Essen
- DMN online phase: Fortran UMAT (Abaqus), LAPACK 기반
