---
title: Verification, Validation, and Uncertainty Quantification (VV&UQ) Framework
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [benchmark, inference, fluid-dynamics, uncertainty, mathematics, paper]
sources: [raw/papers/1-s2.0-S0045782511001290-main.md]
confidence: high
---

# VV&UQ Framework for Scientific Computing

## 개요

**VV&UQ (Verification, Validation, and Uncertainty Quantification) Framework**는 Christopher J. Roy (Virginia Tech)와 William L. Oberkampf가 제안한 **과학 컴퓨팅 예측 불확실성 종합 평가 프레임워크**이다^[raw/papers/1-s2.0-S0045782511001290-main.md]. 모든 불확실성 원천(모델 입력, 수치 근사, 모델 형태)을 체계적으로 식별, 정량화, 결합하여 의사결정자에게 총 예측 불확실성을 제시한다.

## 핵심 분류: Aleatory vs Epistemic Uncertainty

| 구분 | Aleatory (우연) | Epistemic (인식론적) |
|------|-----------------|---------------------|
| 본질 | 내재적 변동성 | 지식 부족 |
| 특성 | 불가측 (irreducible) | 가측 (reducible) |
| 표현 | 정밀 확률분포 (PDF/CDF) | 구간 (interval) |
| 예시 | 제조 공차, 난류 변동 | 이산화 오차, 모델 가정 |

## 프레임워크 6단계

### 1. 불확실성 원천 식별
- 모델 입력 (기하, 물성, 초기/경계 조건)
- 수치 근사 (이산화, 반복 수렴, 반올림, 코딩 오류)
- 모델 형태 (가정, 개념화, 수학적 공식화)

### 2. 불확실성 특성화
- Aleatory → 정밀 PDF/CDF
- Epistemic → 구간 (interval)
- 혼합 → Imprecise distribution (P-box)

### 3. 수치 근사 오차 추정 (Verification)
- **Code verification**: Method of Manufactured Solutions (MMS)
- **Solution verification**: Richardson extrapolation, Grid Convergence Index (GCI)
- 수치 오차 → Epistemic uncertainty로 변환
- $U_{NUM} = U_{DE} + U_{IT} + U_{RO}$ (구간 합산)

### 4. 입력 불확실성 전파
- Aleatory: Monte Carlo, Polynomial Chaos, Stochastic Collocation
- Epistemic: 구간 해석 (interval arithmetic)
- 혼합: **Double-loop (nested) sampling** → P-box 생성

### 5. 모델 형태 불확실성 정량화 (Validation)
- **Area Validation Metric**: 실험 CDF와 시뮬레이션 CDF 간 면적 차이 ($L_1$ norm)
- 검증 영역에서 검증 메트릭의 회귀 적합
- Application domain으로 **외삽 (extrapolation)** → 예측 구간(prediction interval) 계산

### 6. 총 불확실성 결정
- 입력 불확실성 P-box + 모델 형태 불확실성 + 수치 오차 = **최종 P-box**
- 의사결정자에게 명확한 불확실성 범위 제시

## Probability Box (P-box)

P-box는 aleatory + epistemic 불확실성을 통합 표현하는 이중 경계 CDF이다:
- 좌/우 경계 사이의 영역이 **지식 부족**을 나타냄
- 특정 SRQ 값에 대해 **구간 확률 (interval-valued probability)** 제시

## Example: Hypersonic Nozzle Flow

- SRQ: 시험부(test section) 정온도
- 목표: 95% 신뢰도로 $T \geq 80$ K
- 결과: $T < 80$ K일 확률 구간 $[0, 0.25]$ (95% 신뢰)
- → 조건 미달, 노즐 설계 변경 필요

## References

- C.J. Roy, W.L. Oberkampf, "A comprehensive framework for verification, validation, and uncertainty quantification in scientific computing", *CMAME* 2011
- W.L. Oberkampf, C.J. Roy, "Verification and Validation in Scientific Computing", Cambridge University Press, 2010
- [[bayesian-uncertainty-vision]] — Aleatory vs Epistemic 불확실성
- [[uncertainty-quantification-deep-learning]] — 딥러닝에서의 UQ 기법