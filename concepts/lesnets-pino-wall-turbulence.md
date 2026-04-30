---
title: LESnets — Physics-Informed Neural Operator for Wall-Bounded Turbulence
created: 2026-04-30
updated: 2026-04-30
type: concept
tags: [neural-operator, physics-informed, CFD, fluid-dynamics, turbulence, pinn]
sources: []
confidence: medium
---

# LESnets — Physics-Informed Neural Operator for Wall-Bounded Turbulence

## 개요

Zhao, Wang, Yang, Guo, Wang (2026)가 제안한 **Large-Eddy Simulation Nets (LESnets)** 는 **LES 방정식을 factorized Fourier Neural Operator (F-FNO)에 통합**한 물리-정보 신경 연산자 프레임워크이다. 3차원 벽면 난류(wall-bounded turbulence)의 안정적이고 정확한 장기 예측을 위해 설계되었다.

## 핵심 아이디어

### LES 방정식의 신경 연산자 통합

기존 PINO 접근법은 multi-scale vortex 구조와 높은 Reynolds 수에서 장기 예측이 불안정한 한계가 있었다. LESnets는 이 문제를 다음과 같이 해결한다:

1. **레이블 데이터 불필요**: LES 방정식을 직접 F-FNO에 통합하여 별도의 레이블링 없이 학습 가능
2. **가변 시간 범위 예측**: 훈련 과정에서 유연한 시간 지평(time horizon)에 걸쳐 해 생성
3. **Law of the Wall 통합**: 벽면 모델(wall model)을 물리-정보 손실 함수에 포함시켜 coarse grid에서도 고 Reynolds 수 벽면 난류 신뢰성 확보

### 수학적 구조

LESnets는 F-FNO (factorized Fourier Neural Operator)를 백본으로 사용하며, LES 필터링 방정식의 residual을 physics loss로 추가한다:

$$u_{t+1} = u_t + \\mathcal{G}_\\theta(u_t; \\gamma) + \\mathcal{L}_{\\text{LES}}(\\tilde{u}_t)$$

여기서 $\\mathcal{G}_\\theta$는 F-FNO 연산자, $\\mathcal{L}_{\\text{LES}}$는 LES 방정식 기반 물리 제약 항, $\\tilde{u}$는 필터링된 속도장이다.

## 실험 결과

| Reynolds 수 ($Re_\\tau$) | 방법 | 정확도 | 효율성 |
|:---|:---|:---|:---|
| 180, 590, 1000 | LESnets | 전통 LES와 유사 | **높음** (coarse grid) |
| 180, 590, 1000 | IUFNO | LESnets와 유사 | 유사 |
| 180, 590, 1000 | F-FNO | LESnets와 유사 | 유사 |

- LESnets는 전통적 LES와 동등한 정확도 + 더 높은 계산 효율성 달성
- 세 가지 friction Reynolds 수 ($Re_\\tau = 180, 590, 1000$)에서 검증
- 데이터 기반 모델(IUFNO, F-FNO)과도 경쟁력 있는 성능

## 연결점

- [[fourier-neural-operator]] — F-FNO가 LESnets의 백본 연산자
- [[physics-informed]] — LES 방정식을 물리 제약으로 통합하는 PIML 패러다임
- [[physics-constrained-surrogate]] — 데이터 없이 PDE 손실만으로 학습하는 surrogate
- [[pinn-high-speed-flows]] — 고속/난류 유동에서 PINN 적용의 공통 난제
- [[pinn-failure-modes]] — LESnets가 해결하려는 multi-scale 난류 예측의 근본 문제

## References
- arXiv:2604.26621 — "Large-eddy simulation nets (LESnets) based on physics-informed neural operator for wall-bounded turbulence"
