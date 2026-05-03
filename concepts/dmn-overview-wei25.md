---
title: "DMN Overview — Wei et al. (2025) Survey"
created: 2026-05-03
updated: 2026-05-03
type: concept
tags: [paper, survey, dmn, imn, rotation-free, thermomechanical, multiphysics]
sources:
  - raw/papers/wei25-dmn-overview.md
confidence: high
---

# Deep Material Network: Overview, Applications, and Current Directions

## 개요

**Ting-Ju Wei**, Wen-Ning Wan, Chuin-Shan Chen이 *arXiv* (2504.12159, 2025)에 발표한 DMN 종합 서베이 논문. DMN 프레임워크의 이론적 기초, 훈련 방법론, 최신 확장을 망라하는 리뷰.

DOI: [10.1007/s42493-026-00146-4](https://doi.org/10.1007/s42493-026-00146-4)

## 핵심 내용

### DMN의 물리 기반 설계 원칙

DMN은 순수 데이터 기반 접근법과 달리 **학습 가능한 파라미터가 명확한 물리적 의미**를 가짐:

- 네트워크 파라미터는 미세구조의 **기하학적 특성**(체적 분율, 응력 평형 방향)을 인코딩
- **선형 탄성 데이터만으로 학습** → 비선형 응답으로 외삽(extrapolation) 가능
- 이진 트리 구조의 계층적 균질화로 RVE 응답을 압축 표현

### Thermodynamic Consistency (DMN 고유 특성)

DMN 아키텍처는 열역학 법칙을 외부 제약 없이 **구조 자체에 내장**:

| 특성 | 메커니즘 |
|:-----|:---------|
| **단조 응력-변형률** | 각 building block이 interfacial equilibrium 조건에서 유도 → 전체 네트워크가 단조성 보존 |
| **에너지 볼록성** | Helmholtz 자유에너지가 하위 phase 자유에너지의 가중 결합 → 전역 에너지 functional의 엄격한 볼록성 |
| **소산 부등식** | 각 구성 phase의 비음수 소산이 계층적 집계를 통해 전역적으로 보존 |

### Training 성능

- DMN depth N 증가 → 응력 예측 정확도 향상
- 동일 depth에서 비선형성 정도에 따라 오차 변동:
  - Elasto-plastic: < 1%
  - Viscoelastic: ~7% (loss function 조정으로 < 2%로 감소)
- 온라인 예측 속도: DNS 대비 **~8,100배** 향상 (N=8, particle-reinforced composite)

## 최신 확장 (Current Directions)

### Rotation-free DMN (Gajek et al.)

- 하단 노드의 회전 DOF가 비방향성 복합재에서 **중복**됨을 Volterra 급수 분석으로 증명
- 중복 DOF 제거 → 계산 효율성 향상, 다중상 재료로 자연 확장
- [[decoding-material-networks]] 참조

### Interaction-based Material Network (IMN)

- Rotation-free DMN 기반, **다공질 재료(porous materials)** 대상
- Material node와 material network를 명시적으로 분리
- 각 tree node → interaction mechanism:
  - **Interaction direction Gⱼ**: force-equilibrium direction
  - **Interaction incompatibility aⱼ**: deformation fluctuations
- **Hill-Mandel 조건**을 각 interaction set에서 강제
- De-homogenization을 **행렬 연산**으로 단순화 → DMN 대비 추가 속도 향상
- [[imn-porous-materials]] 참조

### Orientation-aware DMN (ODMN)

- IMN 프레임워크에 **orientation-aware mechanism** 도입
- 각 material node에 Tait-Bryan 각 (α, β, γ) 할당
- 결정질 재료의 **texture evolution** 예측 가능
- 기존 DMN과의 차이: building block에서 회전 미발생 → **Hill-Mandel 조건 유지**

### Micromechanics-informed Parametric DMN (MIpDMN)

- 열전도율 + 열팽창 계수의 균질화를 DMN building block에 통합
- Fourier 법칙 + thermoelastic constitutive equation 기반
- 다양한 미세구조(ellipsoidal inclusion, 다양한 fiber aspect ratio)에서 검증

### Thermomechanical DMN (Shin et al.)

- Isothermal DMN → **thermo-elasto-viscoplastic** 문제로 확장
- 각 building block에서 열팽창 효과 포함
- Levin's theorem 기반 Hill-Mandel 조건 확장
- [[thermoelastic-dmn]] 참조

### Thermal DMN (Shin et al.)

- 열전도율 전용: woven composite의 열전달 모델링
- Heat flux **q**와 temperature gradient ψ = -∇T를 building block에 통합

### DMN with Damage Effect

- Cohesive network 통합으로 손상 모델링
- Interface debonding, crack propagation 등

### FDMN

- DMN을 **비뉴턴 유체 역학**으로 확장
- 유체-고체 연성 문제

## DMN 모델 패밀리 요약

| 모델 | 주요 목적 | 특징 |
|:-----|:----------|:------|
| Rotation-free DMN | 회전 DOF 제거, 다중상 재료 | Volterra 급수 분석 기반 |
| **IMN** | **다공질 재료** | Interaction 기반, Hill-Mandel 조건 |
| ODMN | 다결정 재료, texture evolution | Orientation-aware nodes |
| MIpDMN | 열전도 + 열팽창 | Fourier 법칙 + thermoelastic |
| Thermomechanical DMN | 열-기계 연성 | Levin's theorem |
| Thermal DMN | 열전도율 (woven composite) | q, ψ building block |
| DMN + Damage | 손상/균열 | Cohesive network |
| FDMN | 비뉴턴 유체 | 유체역학 확장 |

## 관련 개념

- [[deep-material-network]] — DMN 기본 아키텍처
- [[imn-porous-materials]] — IMN 상세
- [[decoding-material-networks]] — DMN vs IMN 성능 비교
- [[thermoelastic-dmn]] — 열-기계 DMN
- [[deep-material-network-quilting]] — DMN explainability
- [[dey24-dmn-sfrt-effectiveness]] — SFRT 적용

## References

- Wei T-J, Wan W-N, Chen C-S. "Deep Material Network: Overview, Applications, and Current Directions." *arXiv:2504.12159*, 2025.
- Liu M, Wu J. "Exploring the 3D architectures of deep material network in data-driven multiscale mechanics." *J. Mech. Phys. Solids*, 2019.
