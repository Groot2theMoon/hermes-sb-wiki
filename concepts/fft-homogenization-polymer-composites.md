---
title: "FFT-Based Homogenization for Composite & Biological Materials"
created: 2026-04-29
updated: 2026-05-04
type: concept
tags: [foundation, pure-mechanics, materials, mathematics]
sources: [raw/papers/Numer Methods Biomed Eng - 2017 - Colabella - Calculation of cancellous bone elastic properties with the polarization‐based.md]
confidence: medium
---

# FFT-Based Homogenization for Composite & Biological Materials

## 개요

Moulinec & Suquet (1994)가 제안한 **FFT 기반 균질화(FFT-based homogenization)** 방법은 복합재료의 유효 물성을 계산하는 강력한 대안으로 FEM을 보완한다. Colabella et al. (2017)은 이 방법을 **생체 재료(해면골)**에 최초로 적용하여, FFT 기법이 생체 역학에서도 효과적임을 입증했다.

## 기본 원리

- **주기적 경계 조건** 하에서 **Lippmann-Schwinger 적분 방정식**을 반복적으로 해결
- **Green 연산자**를 참조 선형 탄성 재료에 대해 정의
- 응력 평형: $$\text{div } \sigma = 0$$
- 변형률-변위 관계: $$\epsilon = \frac{1}{2}(\nabla u + \nabla u^\top)$$
- 구성 방정식: $$\sigma(\mathbf{x}) = \mathbb{C}(\mathbf{x}) : \epsilon(\mathbf{x})$$

## 핵심 장점

| 특성 | FFT | FEM |
|:----|:----|:----|
| **메싱** | 불필요 (segmented image 직접 사용) | 필수 |
| **병렬화** | FFT 기반, GPU 가속 용이 | domain decomposition 필요 |
| **μCT 호환성** | voxel 데이터 직접 입력 | 메싱 전환 필요 |
| **수렴 속도** | 고대비(high contrast) 상에서 느림 | 안정적 |
| **공극/강성** | 수렴 보장 어려움 | 가능 (augmented Lagrangian) |

## 편광 기반 scheme (Colabella et al. 사용)

Monchiet & Bonnet (2013)의 **polarization-based FFT scheme**은 기존 Moulinec-Suquet 방식의 수렴 문제를 개선:

- Eyre-Milton, Michel et al.의 augment Lagrangian 방식은 Monchiet-Bonnet scheme의 특수 경우
- 유한 contrast에 대한 최적 알고리즘 파라미터 존재
- 해면골 적용에서 실험 결과와 우수한 일치

## 해면골 적용 결과

- 소 대퇴골두(bovine femoral head)와 Hokkaido 쥐 대퇴골 분석
- Micro-CT + nanoindentation으로 재료 특성 측정
- 완전 이방성(fully anisotropic) 탄성 응답 정확히 예측
- 인공 해면골 미세구조(반복 가능한 모델)에서도 검증

## Willot Discretization과의 관계

[[fft-homogenization-composites]] 페이지에서 다루는 **Willot discretization (Gʀ)** 은 Moulinec-Suquet 표준 FFT scheme의 spurious oscillation 문제를 해결하고, 국소장 정확도와 수렴 속도를 획기적으로 향상시킨 발전이다. Colabella et al.의 polarization scheme과 달리, Willot 접근법은 Green operator 자체를 finite-difference 기반으로 변경한다.

- **Gʀ (rotated scheme)** — 계면에서의 oscillation 최소화, 대칭적 field
- **Porous 재료 (χ=0)** 에서도 안정적 수렴 보장
- 기존 polarization scheme과 **호환 가능** → 두 방법의 장점 결합 가능

## DMN과의 관계

FFT 균질화는 DMN의 **training data 생성 방법** 중 하나(Bottleneck 3 참조). DMN이 homogenization을 학습하는 surrogate라면, FFT는 직접 균질화를 수행하는 reference solver다.

- DMN 학습 시 reference solution으로 FFT 사용 가능
- 비선형 확장(소성, 손상) 시 FFT가 더 유연
- DMN은 FFT 대비 100~1000배 빠른 online prediction 가능

## 관련 개념

- [[fft-homogenization-composites]] — Willot discretization + 3D fibrous homogenization
- [[francois-willot]] — François Willot (Mines ParisTech, FFT homogenization researcher)
- [[deep-material-network]] — DMN: FFT 기반 homogenization의 surrogate
- [[poroelastic-dmn-research]] — DMN 포로탄성 확장에서 FFT 균질화를 training data 생성 방법으로 검토
- [[deep-material-network-quilting]] — DMN quilting 전략

## References
- Colabella, L. et al. (2017). "Calculation of cancellous bone elastic properties with the polarization-based FFT iterative scheme." *Numer. Methods Biomed. Eng.*
- Moulinec, H. & Suquet, P. (1994). "A fast numerical method for computing the linear and nonlinear mechanical properties of composites." *C. R. Acad. Sci. Paris II*, 318, 1417–1423.
- Monchiet, V. & Bonnet, G. (2013). "A polarization-based FFT iterative scheme for computing the effective properties of elastic composites." *Int. J. Numer. Meth. Engng.*, 96, 97–118.
