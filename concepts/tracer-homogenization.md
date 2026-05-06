---
title: "Tracer Homogenization — Permutation-Equivariant Encoding for Sets"
created: 2026-05-06
updated: 2026-05-06
type: concept
tags: [permutation-equivariant, set-encoding, lagrangian-data-assimilation, deep-learning, tracer-dynamics]
sources: [raw/papers/lagrangian-koopman-wang26.md]
confidence: high
---

# Tracer Homogenization

## 개요

Tracer Homogenization(추적자 균질화)은 [[lagrangian-koopman-network|LaCGKN]]에 도입된 **순열 동변성(permutation-equivariant) 인코딩 기법**으로, 모든 Lagrangian 추적자에 동일한 신경망 함수를 적용하여 추적자 수에 불변하는 모델을 구축한다.

## 수학적 정의

추적자 위치 `x_i^n`에 대해 관측 연산자 F1과 G1은 다음과 같이 정의:

```
F1(u1^n) = [f_θ(x_1^n), ..., f_θ(x_I^n)]
G1(u1^n) = [g_θ(x_1^n), ..., g_θ(x_I^n)]
```

여기서 `f_θ`와 `g_θ`는 모든 추적자에 걸쳐 **파라미터 공유**되는 신경망이다. 이 설계는 추적자 순열에 대해 surrogate dynamics가 **permutation-equivariant**함을 보장한다.

## 주요 특성

- **순열 동변성**: 추적자 레이블을 재배열해도 동일한 출력 (추적자는 교환 가능하다는 물리적 가정 반영)
- **추적자 수 불변성**: 학습 후 임의 개수의 추적자에 일반화 가능 (학습 중 랜덤 서브샘플링으로 더 강화)
- **파라미터 효율성**: 모든 추적자를 하나의 큰 텐서로 처리하는 방식보다 훨씬 적은 파라미터
- **계산 효율성**: 추적자 수에 선형적으로 확장 (O(I) 복잡도)

## 시그마 포인트 연구와의 연결성

이 개념은 **[[differentiable-sigma-point-quadrature|미분 가능 시그마 포인트 쿼드러처]]** 연구에서 시그마 포인트 집합을 처리하는 문제와 직접적으로 연결된다:

| 추적자 균질화 | 시그마 포인트 집합 |
|---|---|
| Lagrangian 추적자 위치 x_i | 시그마 포인트 σ_i |
| 동일한 물리 법칙 적용 | 동일한 상태전이 함수 적용 |
| 추적자 순열 불변 | 시그마 포인트 순열 불변 |
| 임의 개수 추적자 일반화 | 가변 개수 시그마 포인트 |

시그마 포인트 클라우드를 **permutation-invariant set**으로 처리하는 문제에 tracer homogenization의 방법론이 직접 적용 가능하다.

## 관련 개념

- [[lagrangian-koopman-network|LaCGKN]] — Tracer homogenization을 사용하는 프레임워크
- [[set-transformer|Set Transformer]] — 집합 처리용 트랜스포머 (존재 시 wikilink)
- [[auto-diff-data-assimilation|Auto-differentiable Data Assimilation]] — 데이터 기반 DA
- [[conditional-gaussian-koopman-network|CGKN]] — 기본 CGKN 프레임워크
