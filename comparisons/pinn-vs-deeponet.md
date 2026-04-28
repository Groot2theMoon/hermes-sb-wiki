---
title: PINN vs DeepONet — Comparison
created: 2026-04-28
updated: 2026-04-28
type: comparison
tags: [comparison, physics-informed, surrogate-model, mathematics]
sources: [raw/papers/2281727.md, raw/papers/2010.08895v3.md]
---

# PINN vs DeepONet — 물리 기반 ML 접근법 비교

**PINN (Physics-Informed Neural Networks)**과 **DeepONet (Deep Operator Networks)**은 물리 법칙을 신경망에 통합하는 두 대표적 방법이지만, 접근 방식과 적용 범위가 근본적으로 다르다.

## 비교 표

| 차원 | PINN | DeepONet |
|------|------|----------|
| **입력-출력 매핑** | 공간/시간 좌표 $(x, t)$ → 해 $u(x, t)$ | 입력 함수 $f$ + 쿼리 위치 $y$ → $G(f)(y)$ |
| **최종 목적** | **PDE 하나의 해**를 근사 | **PDE 계열 전체**의 solution operator 학습 |
| **재학습 필요성** | 새 BC/IC/파라미터마다 재학습 | 한 번 학습으로 모든 인스턴스 해결 |
| **데이터 요구량** | 적음 (PDE residual만 있어도 가능) | 많음 (다양한 파라미터 조합의 해 필요) |
| **Discretization 의존성** | 없음 (연속적 좌표 기반) | 있음 (센서 위치 $m$개 필요) |
| **이론적 보장** | 보편 근사 정리 | Operator 보편 근사 정리 (Chen & Chen, 1995) |
| **주요 한계** | 새 파라미터마다 처음부터 학습 | 충분한 학습 데이터 필요 |
| **아키텍처** | Fully-connected NN + residual loss | Branch Net + Trunk Net 2개 subnet |
| **PDE 정보 사용** | Loss function에 직접 포함 (soft constraint) | Loss function에만 반영 or data만 |
| **역문제 (Inverse)** | 자연스럽게 가능 | 데이터 기반으로 확장 가능 |

## 핵심 차이: 함수 vs 연산자

| 개념 | PINN | DeepONet |
|------|------|----------|
| 학습 대상 | **함수** $u(x)$ | **연산자** $G: f \mapsto u$ |
| 예시 | $-\nabla^2 u = f$, $u=0$ on $\partial\Omega$에 대해 $u$ 학습 | 다양한 $f$에 대한 $G(f) = u$ 학습 |
| `입력` | $(x, y)$ 좌표 | $f$의 센서값 + 출력 위치 $y$ |

## 언제 무엇을 쓸까?

### PINN 선택
- 단일 PDE 문제 해결이 목표 (1~3개 파라미터)
- 실험 데이터가 거의 없거나 전혀 없음
- 역문제 (inverse problem) — 데이터로부터 PDE 파라미터 추정
- 빠른 프로토타이핑이 필요

### DeepONet 선택
- 동일 PDE를 다양한 파라미터/BC/IC로 반복 해결해야 함
- 학습에 사용할 충분한 데이터 (시뮬레이션 데이터 등)가 있음
- 실시간 surrogate model이 필요
- Operator learning (함수 공간 간 매핑)이 본질적 목표

## 융합/통합

최근 연구에서는 두 접근법을 결합하는 시도가 있다:
- **Physics-informed DeepONet:** DeepONet 학습 시 PDE residual을 추가 손실로 사용
- **Fourier Neural Operator**: DeepONet과 동일한 operator learning 목표지만, Fourier 공간에서 convolution으로 접근
- **PI-DeepONet:** DeepONet의 branch-trunk 구조에 물리 손실을 추가

## 관련 페이지

- [[physics-informed-neural-networks]] — PINN 상세
- [[deeponet]] — DeepONet 상세
- [[fourier-neural-operator]] — FNO (operator learning의 또 다른 축)
- [[physics-informed]] — 통합 개념