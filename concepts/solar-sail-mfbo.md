---
title: "Solar Sail MFBO (Multi-Fidelity Bayesian Optimization)"
created: 2026-05-03
updated: 2026-05-03
type: concept
tags: [solar-sail, mfbo, multi-fidelity, bayesian-optimization, abaqus, botorch, post-buckling, structural-optimization]
confidence: high
sources:
  - raw/papers/solar-sail-mfbo.md
related:
  - entities/seungwon-lee
  - concepts/centimeter-nanomechanical-resonators
---

# Solar Sail MFBO (Multi-Fidelity Bayesian Optimization)

태양돛(Solar Sail)의 형상 최적화를 위한 **Multi-Fidelity Bayesian Optimization** 프레임워크. 
POSTECH에서 개발되었으며, Abaqus 유한요소해석과 BoTorch 기반 MFBO를 결합하여 
고비용의 포스트버클링(post-buckling) 시뮬레이션을 최소화함.

## 최적화 문제

- **설계 변수:** 클램프 부착 위치 (x_c), 변위량 (d_c)
- **목적 함수:** 추력 손실 (Thrust Loss) 최소화

## Multi-Fidelity 설정

| 충실도 | Abaqus 해석 방법 | 출력 메트릭 | 상대 비용 |
|:------:|:----------------:|:----------:|:---------:|
| LF (저충실도) | 선형/비선형 정적 해석 | 압축 면적비 (Compression Area Ratio) | 1.0 |
| HF (고충실도) | 포스트버클링 (Static, General) | 추력 손실 (Thrust Loss) | 10.0 |

**핵심 가설:** 선형 해석(LF)에서 압축 응력이 넓게 분포하는 디자인은 실제 포스트버클링 해석(HF)에서도 주름이 크게 발생하여 추력 성능이 떨어진다.

## 시스템 아키텍처

```
mfbo.py (BoTorch)
   ↓ subprocess
run_abaqus.py (Abaqus scripting)
   ↓
eval_abaqus.py (Post-processing: NumPy, bulkDataBlocks)
```

- **mfbo.py** — PyTorch + BoTorch + GPyTorch 기반 MFBO 메인 루프
  - Checkpointing (`load_checkpoint()`)
  - MF acquisition: `qMultiFidelityLowerBoundMaxValueEntropy`
  - 파라미터: `N_ITERATIONS`, `LF_INIT`, `HF_INIT`
- **run_abaqus.py** — Abaqus CAE 시뮬레이션
  - LF: `Step-GlobalTension` → `Step-ClampTension` → `Step-HighTension`
  - HF: `Step-GlobalTension` → `Step-ClampTension` → `Step-Buckle` → `Step-GlobalTension` → `Step-Postbuckle`
  - 불완전성(imperfection)은 `*IMPERFECTION` 키워드로 추가
- **eval_abaqus.py** — 결과 후처리
  - LF 메트릭 (lf1, lf2, lf3) 및 HF 추력 손실 추출
  - SRP (Solar Radiation Pressure) 모델 상수는 `RA_calc.py`로 사전 계산

## 기존 MFBO 연구와의 연결

동일한 방법론인 [[centimeter-nanomechanical-resonators]]에서도 MFBO가 사용됨:
- Ghadimi et al. (2024) — 나노기계 공진기 Q-factor 최적화에 Transformed MFBO 적용
- 본 SolarSail-MFBO는 구조 최적화(structural optimization) 영역에 MFBO를 적용한 점에서 차별화

## 코드 구조

| 파일 | 설명 |
|------|------|
| `코드/mfbo.py` | MFBO 메인 최적화 루프 |
| `코드/run_abaqus.py` | Abaqus 시뮬레이션 스크립트 |
| `코드/eval_abaqus.py` | 결과 후처리 및 추력 손실 계산 |
| `코드/RA_calc.py` | SRP 모델 상수 계산 (nk_data.csv) |
| `코드/solution_space.py` | 해 공간 탐색 |
| `코드/run_abaqus_cable.py` | 케이블 모델 Abaqus 스크립트 |

## RIGOR 관련성

- MFBO의 **multi-fidelity** 개념은 RIGOR의 gate-based EM Q,R 활성화 전략과 유사 (저비용 → 고비용 전환)
- BoTorch 기반 Gaussian Process surrogate modeling은 RIGOR의 uncertainty quantification과 방법론적 연결점

## 관련 개념

- [[centimeter-nanomechanical-resonators]] — 나노기계 공진기 MFBO
- [[bayesian-optimization]] — 베이지안 최적화 일반
- [[polyanskiy2024-refractiveindex-database]] — 태양돛 광학 특성 데이터베이스
