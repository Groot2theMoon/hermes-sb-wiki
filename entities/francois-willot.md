---
title: "François Willot"
created: 2026-05-03
updated: 2026-05-03
type: entity
tags: [researcher, mines-paristech, fft-homogenization, micromechanics, green-operator, mathematical-morphology]
sources:
  - raw/papers/willot15-fourier-fft-homogenization.md
confidence: high
---

# François Willot

**소속:** Mines ParisTech, PSL Research University, Centre for Mathematical Morphology (CMM)

**연구 분야:**
- FFT 기반 균질화 (Fourier-based homogenization)
- Green operator discretization 방법론
- 수학적 형태학 (Mathematical morphology)
- 복합재료 및 다공성 재료의 미세역학
- Image-based mechanics (μCT → mechanical response)

## 주요 기여

### Willot Discretization (2015)
회전 격자(rotated grid)에서 centered difference 기반의 **Gʀ Green operator** 제안:
- 기존 Moulinec-Suquet operator (spurious oscillation) 문제 해결
- Forward-backward (Gᴡ)의 비대칭성 제거
- Porous (χ=0) 재료에서도 안정적 수렴 (~168 iterations)
- 균질화된 유효 물성에서 가장 정확한 추정

### Modified Green Operator for Conductivity (2014)
전기 전도도 문제에서도 동일한 접근법 확장 (Willot, Abdallah & Pellegrini, 2014)

### Morph-Hom Software
CMM에서 개발한 Morph-Hom 소프트웨어 기여자

## 주요 논문

- (2015) *Fourier-based schemes for computing the mechanical response of composites with accurate local fields.* CR Mécanique, 343(3), 232–245.
- (2014) *Fourier-based schemes with modified Green operator for computing the electrical response of heterogeneous media with accurate local fields.* Int. J. Numer. Meth. Engng., 98(7), 518–533.
- (2013) *Microstructure-induced hotspots in the thermal and elastic responses of granular media.* Int. J. Solids Struct., 50(10), 1699–1709.
- (2011) *Elastic and electrical behavior of some random multiscale highly-contrasted composites.* Int. J. Multiscale Comput. Eng., 9(3), 305–326.
- (2011) *Estimation of local stresses and elastic properties of a mortar sample by FFT computation.* Cem. Concr. Res., 41(5), 542–556.

## 관련 개념

- [[fft-homogenization-composites]] — Willot discretization 기반 FFT 균질화
- [[fft-homogenization-polymer-composites]] — FFT 균질화 기본 개념
- [[deep-material-network]] — DMN with FFT training data
