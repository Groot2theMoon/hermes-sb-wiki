---
title: "Rocket Apogee AI Pipeline (PSIntelligence)"
created: 2026-05-03
updated: 2026-05-03
type: concept
tags: [rocket, apogee, kalman-filter, ekf, ukf, pinn, gru, uq, mamba, onnx, postech, psi]
confidence: high
sources:
  - raw/papers/psintelligence.md
related:
  - entities/seungwon-lee
---

# Rocket Apogee AI Pipeline (PSIntelligence)

POSTECH PSI (Project for Space & Intelligence)에서 개발한 **로켓 실시간 원지점(apogee) 예측 AI 파이프라인** 교육 자료. 안전 중심(safety-first) 설계와 물리 법칙 준수, 불확실성 정량화(UQ)에 중점을 둠.

## 개요

- **목적:** 로켓 비행 중 실시간으로 최대 고도(원지점)를 예측하여 낙하산 전개 시점 결정
- **대상:** 온보드 항공전자(avionics) 하드웨어에서 경량 추론
- **저자:** 이승원 (Seungwon Lee) — POSTECH PSI

## 파이프라인 (6 Steps)

| Step | 방법 | 목적 |
|:----:|------|------|
| 1 | **Kalman Filter** | 선형 상태 추정 — 센서 노이즈 제거 |
| 2 | **EKF / UKF** | 비선형 로켓 동역학 처리 (추력, 항력, 중력) |
| 3 | **PINN** | 물리 법칙 준수 — sparse data에서도 물리적 일관성 유지 |
| 4 | **GRU** | 시계열 맥락 학습 — 과거 fault 이력이 현재 apogee에 미치는 영향 |
| 5 | **UQ (MC Dropout)** | OOD 감지 → 안전 모드 전환 (`고도 ≥ 예측 apogee - 2σ`) |
| 6 | **Mamba + ONNX** | 양자화 및 엣지 배포 — 제한된 메모리/전력 환경 |

## 핵심 설계 철학

- **Safety-first:** 정확도보다 불확실성 인지 + fail-safe 로직 우선
- **Physical law compliance:** AI 예측이 에너지 보존, 운동 방정식을 위반하지 않도록 PINN 적용
- **Uncertainty awareness:** 신뢰 구간 기반 의사결정 (Gal & Ghahramani 2016)

## 코드 구조

- `main.py` — inference 엔트리 포인트 (placeholder)
- `step*-*.ipynb` — Jupyter 노트북 기반 단계별 실습
- `data/` — 모의 비행 데이터, 모터 데이터

## RIGOR 관련성

본 파이프라인의 Step 1-2 (KF/EKF/UKF)는 RIGOR의 핵심 필터링 방법론과 직접 연결됨. 특히 Step 5의 MC Dropout 기반 UQ는 RIGOR의 uncertainty quantification 접근법과 비교 가능. Step 3의 PINN은 RIGOR의 물리 기반 제약 조건(physical constraint) 아이디어와 공통점.

## 참고 문헌

- Kalman (1960) — Linear filtering
- Raissi et al. (2019) — PINN (J. Comput. Phys.)
- Chung et al. (2014) — GRU (arXiv:1412.3555)
- Gal & Ghahramani (2016) — MC Dropout (ICML)
- Gu & Dao (2023) — Mamba (arXiv:2312.00752)

## 관련 개념

- [[kalman-filter]] — 선형 칼만 필터
- [[unscented-kalman-filter]] — UKF
- [[physics-informed-neural-networks]] — PINN
