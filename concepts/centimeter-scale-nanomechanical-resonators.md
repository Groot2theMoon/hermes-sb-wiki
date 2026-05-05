---
title: "Centimeter-Scale Nanomechanical Resonators with Low Dissipation"
created: 2026-05-05
updated: 2026-05-05
type: concept
tags: [mechanics, solid-mechanics, structural-analysis, surrogate-model, micromechanics]
sources:
  - raw/papers/cupertino-2024-centimeter-resonators.md
confidence: high
---

# Centimeter-Scale Nanomechanical Resonators with Low Dissipation

## 개요

Andrea Cupertino†, [[dongil-shin|Dongil Shin]]†, Leo Guo, Peter G. Steeneken, [[miguel-bessa|Miguel A. Bessa]], [[richard-norte|Richard A. Norte]]가 *Nature Communications* (2024, 15(1), 4255)에 발표. (†공동 1저자)

**cm 길이 × nm 두께**의 고종횡비 나노기계 공진기를 Bayesian optimization 기반 설계로 구현. 상온에서 10^9(Q·f)에 근접하는 품질계수 달성.

## 배경

고종횡비 기계 공진기는 정밀 센싱에 핵심적이나:
- 제작 공정의 한계로 길이-두께 비율 제한
- 고해상도 시뮬레이션의 계산 비용이 매우 높음
- 기존 접근법: 저온/진공 조건에서만 고성능 달성 가능

## 핵심 접근법

### 1. 이중 스케일 최적화 전략

```
mm-scale 빠른 FEM 시뮬레이션
  ↓ (coarse search: 설계 공간 탐색)
Bayesian Optimization (Gaussian Process surrogate)
  ↓ (fine-tuning: 최적 형상 식별)
cm-scale 고해상도 FEM 시뮬레이션 (선별적 적용)
```

- **Multi-fidelity Bayesian optimization**으로 계산 비용 획기적 절감
- 저충실도(mm-scale) 모델로 넓은 설계 공간 탐색
- 고충실도(cm-scale) 모델은 최종 검증에만 사용

### 2. Spiderweb 형상 공진기

- 자연의 거미줄에서 영감을 받은 방사형/원형 구조
- **Torsional soft-clamping** 메커니즘:
  - 방사형 빔의 비틀림 모드를 활용한 에너지 트래핑
  - 지지부로의 열탄성 감쇠(thermoelastic dissipation) 최소화
- Bayesian optimization이 발견한 최적 형상

### 3. 정밀 나노제작

- 실리콘 나이트라이드(Si₃N₄) 박막 기반
- 전자빔 리소그래피 + 건식 식각 공정
- 고수율 제작 공정 개발

## 주요 결과

### 성능 지표

| 파라미터 | 값 | 비고 |
|:---------|:---|:-----|
| 공진기 길이 | **cm 스케일** | 기존 대비 10-100배 증가 |
| 두께 | **nm 스케일** | 수십 nm |
| 품질계수 (Q) | **상온 ~10^9** | 냉각 공진기/levitated nanosphere와 유사 |
| 주파수 | **kHz 영역** | 저주파수 고감도 센싱 |

### 기존 기술 대비

| 기술 | 조건 | Q·f |
|:----|:----|:----:|
| 본 연구 (상온) | 300K, 대기압 | **~10^9** |
| 극저온 공진기 | 10mK | ~10^9 |
| Levitated nanosphere | 고진공 | ~10^9 |

→ **온도 및 진공 조건이 훨씬 덜 까다로운 상태에서 동등한 성능 달성**

## 적용 분야

- **초고감도 힘/질량 센싱** — 단분자 검출
- **양자 광기계 (Quantum optomechanics)** — 상온 양자 한계 측정
- **관성 센싱** — 가속도계, 자이로스코프
- **기본 물리 탐색** — 미세 힘, 카시미어 효과

## 의의

- Bayesian optimization과 multi-fidelity 설계 전략의 효과적 결합 사례
- 머신러닝 기반 설계가 전통적인 나노제작의 한계를 극복할 수 있음을 실증
- [[dongil-shin|Dongil Shin]]의 연구 범위: **DMN (재료) → Bayesian optimization (설계 최적화) → 나노공진기 (응용)**

## 관련 개념

- [[dongil-shin]] — 신동일 교수 (공동 1저자, Bayesian optimization 담당)
- [[miguel-bessa]] — Miguel A. Bessa (TU Delft, 공동 교신저자)
- [[richard-norte]] — Richard A. Norte (TU Delft, 공동 교신저자)
