---
title: Micromechanics and Homogenization
created: 2026-05-04
updated: 2026-05-05
type: concept
tags: [micromechanics, homogenization, solid-mechanics, rve, multi-scale]
sources: []
confidence: medium
---

# Micromechanics and Homogenization

## 개요

미세역학(micromechanics)은 재료의 미세 구조(microstructure)가 거시적 유효 물성(effective properties)을 결정하는 메커니즘을 연구하는 분야. 균질화(homogenization)는 미시 스케일과 거시 스케일을 연결하는 수학적/수치적 프레임워크.

## 기본 개념

### RVE (Representative Volume Element)
- 통계적으로 균질한 미세구조를 대표하는 최소 단위 체적
- RVE 크기 $L$은 미세구조 특징 길이 $d$보다 충분히 커야: $L \gg d$
- $L$은 거시적 변형 구배보다 충분히 작아야: $L \ll \Lambda$

### 균질화 접근법

| 방법 | 원리 | 장점 | 단점 |
|:----|:-----|:-----|:-----|
| **Mori-Tanaka** | 평균장 이론 (Eshelby) | 매우 빠름 | 복잡한 형상 부정확 |
| **Self-consistent** | 각 상을 매질에 포함 | 다상 재료 가능 | 비선형 확장 복잡 |
| **FFT-based** | Unit cell의 FFT 해석 | 고해상도, 효율적 | 주기 경계 가정 |
| **FE²** | 각 Gauss point에서 RVE FEM | 가장 정확 | 계산 비용 극심 |
| **DMN** | 데이터 기반 surrogate | 실시간 예측 가능 | 학습 필요 |

### Scale Transition

**균질화 방향 (micro → macro):**
$$\bar{\sigma} = \frac{1}{|V|} \int_V \sigma(x) dV \quad \text{(응력 평균화)}$$

**국소화 방향 (macro → micro):**
$$\varepsilon(x) = \mathbb{A}(x) : \bar{\varepsilon} \quad \text{(변형 집중)}$$

## Wikilinks
- [[deep-material-network]] — DMN (데이터 기반 균질화)
- [[fft-homogenization-composites]] — FFT 균질화 (Willot discretization)
- [[fft-homogenization-polymer-composites]] — FFT 균질화 (생체 재료)
- [[thermoelastic-dmn]] — 열탄성 DMN
- [[poroelastic-dmn-research]] — 7×7 Acusto-Elastic DMN
- [[imn-porous-materials]] — IMN (다공질 재료)
- [[dmn-overview-wei25]] — DMN 서베이

## References
- Hill, R. (1963). "Elastic properties of reinforced solids." *J. Mech. Phys. Solids*, 11, 357-372.
- Moulinec, H. & Suquet, P. (1998). "A numerical method for computing the overall response of nonlinear composites." *Comput. Methods Appl. Mech. Eng.*, 157, 69-94.
