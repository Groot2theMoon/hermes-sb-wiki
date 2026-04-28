---
title: "Poroelasticity–Thermoelasticity Correspondence ([[andrew-norris|Norris]] 1992)"
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [paper, poroelasticity, thermoelasticity, homogenization, micromechanics, theory]
sources: [raw/papers/1992_JAppliedPhysics_71_1138-1141.md]
confidence: high
---

# Poroelasticity–Thermoelasticity Correspondence ([[andrew-norris|Norris]] 1992)

## 개요

[[andrew-norris|Andrew Norris]] (Rutgers University)가 *J. Appl. Phys.* 71(3), 1992, pp.1138–1141에 발표.

정적(static) 포로탄성(poroelasticity)과 정적 열탄성(thermoelasticity) 사이의 **완전한 수학적 대응 관계**를 증명한 논문. 이 대응 덕분에, 비균질(inhomogeneous) 열탄성 매질에 대해 알려진 유효 물성 결과들을 **직접적으로** 비균질 포로탄성 매질에 적용할 수 있음.

DOI: [10.1063/1.351276](https://doi.org/10.1063/1.351276)

## 대응 관계

### 변수 매핑

| 열탄성 (Thermoelastic) | 기호 | 포로탄성 (Poroelastic) | 기호 |
|:----------------------|:---:|:----------------------|:---:|
| 응력 텐서 | τ, σ | 응력 텐서 | τ, σ |
| 변형률 텐서 | e, ε | 변형률 텐서 | e, ε |
| **온도 변화** | **θ** | **간극 압력** | **p** |
| **엔트로피(단위체적)** | **s** | **유체 함량 변화** | **ζ** |
| 정압 비열 | c_σ | 저류 계수의 역수 | 1/M |
| 등온 강성 (isothermal) | C (frame) | **배수(drained) 강성** | C (frame) |
| 등엔트로피 강성 (isentropic) | C_σ | **포화(saturated) 강성** | C_c |
| 열팽창 텐서 | β | α/3K (Biot 계수/체적 탄성률) | α/3K |

### constitutive equation 대응

**포로탄성 (Biot formulation, 배수 변수 기준):**
```
τ = C : e - α p I
ζ = p/M + α tr(e)
```

**열탄성 (등온 변수 기준):**
```
τ = C : e - C:β θ    [또는 τ = C : (e - β θ)]
s = c_ε θ + tr(C:β : e)
```

### 핵심 통찰

이 correspondence가 놀라운 이유:
- 두 물리 현상이 전혀 다른 미시적 메커니즘(열 vs 유체)을 가졌음에도 **constitutive equation의 수학적 구조가 동일**
- 비균질 매질에서 **균질화된 유효 계수**의 결정 문제도 서로 대응됨
- 즉, 유효 열팽창 계수 β*를 구하는 방법 → 유효 Biot 계수 (α/3K)*를 구하는 방법으로 직접 변환 가능

## 응용: Deep Material Network (DMN) 확장

이 correspondence는 **Shin et al. (2024)의 thermomechanical DMN**과 **포로탄성 DMN** 사이의 직접적인 이론적 연결고리를 제공:

1. Shin(2024)은 열탄성 building block의 homogenization을 유도
2. [[andrew-norris|Norris]] 대응 정리에 의해, 같은 수학적 구조를 **Biot 포로탄성**으로 직접 변환 가능
3. 즉, 준정적(quasi-static) Biot consolidation 문제라면, Shin(2024)의 thermomechanical DMN 코드가 거의 수정 없이 포로탄성 DMN으로 확장 가능

### 7×7 Matrix Formulation

포로탄성의 경우, 응력-변형률-압력 관계는 7×7 시스템으로 표현:

```
[ σ ]   =   [ C_6×6    -α_6×1 ] [ ε ]
[ ζ ]       [ α_1×6ᵀ    β_1×1 ] [ p ]
```

- C_6×6: 배수(drained) 강성 텐서 (Mandel notation)
- α_6×1: Biot-Willis 계수 벡터
- β_1×1: M 계수 관련 스칼라 (1/M)
- **p와 θ의 대응**으로 인해, 회전 변환은 6×6 block에만 적용되고 p는 스칼라로서 회전 불변

## 한계

- **정적(static) correspondence** — 동적 효과(관성, 파동 전파)는 포함되지 않음
- 단상(single-phase) 유체 포화 가정
- 선형 탄성 → 포로-소성(poro-plasticity)으로의 확장은 이 correspondence로 직접 다뤄지지 않음

## 관련 개념

- `thermoelastic-dmn` — Shin 2024: 열팽창을 building block에 통합한 thermomechanical DMN
- `deep-material-network` — DMN 기본 아키텍처와 building block
- `poroelastic-dmn-research` — 7×7 DMN 연구 아이디어: 병목과 로드맵

## 참고 문헌

- [[andrew-norris|Norris]], A. (1992). "On the correspondence between poroelasticity and thermoelasticity." *J. Appl. Phys.*, 71(3), 1138–1141.
- Biot, M. A. (1941). "General theory of three-dimensional consolidation." *J. Appl. Phys.*, 12, 155–164.
- Cheng, A. H.-D. (2016). *Poroelasticity*. Springer.
