---
title: Matti Niskanen
type: entity
tags: [person, acoustics, bayesian, inverse-problem, poroelastic, mcmc]
sources:
  - raw/papers/niskanen20-bayesian-inversion-poroviscoelastic.md
---

# Matti Niskanen

Matti Niskanen is a researcher who completed his PhD jointly at Le Mans Université (France) and University of Eastern Finland (Finland). His doctoral dissertation introduced Bayesian inversion methods to the acoustical characterization of poroviscoelastic media, pioneering uncertainty quantification in this domain.

## 주요 기여 (Key Contributions)

### 베이지안 역산 기반 포로점탄성 매질 특성화 (Niskanen 2020)
- Le Mans Université / University of Eastern Finland 공동 박사학위 논문
- Publications of UEF, No. 369
- 결정론적(deterministic) 방법(Pompoli round-robin 2017)의 낮은 재현성 문제를 Bayesian 프레임워크로 해결
- 3편의 논문(Publication I-III)으로 구성:
  - **I:** Rigid frame 다공질 재료 (foam, felt, wool) — 표준 impedance tube 측정 + Bayesian MCMC vs LS 비교
  - **II:** Elastic frame (Biot 모델) — 초음파 반사/투과 데이터로 전 Biot 파라미터 추정, Adaptive Metropolis + Parallel Tempering 조합 MCMC 샘플러
  - **III:** 수중 침지 다공질 세라믹 — 복수 측정 지점별 역산으로 재료 불균질성(heterogeneity) 정량화

### MCMC 샘플링 방법론
- Adaptive Metropolis (AM): 제안 분산(proposal covariance) 온라인 적응
- Delayed Rejection Adaptive Metropolis (DRAM): 거절 시 재시도
- Parallel Tempering (PT): 다중 온도 체인으로 다중 모드 사후분포 탐색
- 순방향 모델 10만 회 이상 해석 — 고속 행렬 기반 Biot 솔버 활용

### 핵심 발견
- Bayesian 방법은 파라미터 간 비선형 상호작용(trade-off)을 사후분포(posterior)에 반영
- 결정론적 LS는 모델-데이터 불일치를 무시하고 파라미터를 과신
- PT가 다중 모드 사후분포 탐색에 필수적
- 복수 측정 역산으로 재료 내부 불균질성 정량화 가능

## 소속
- Le Mans Université, France
- University of Eastern Finland, Kuopio, Finland
- HAL: tel-04145308
