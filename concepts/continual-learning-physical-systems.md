---
title: "Continual Learning for Physical Systems — Particle Accelerator Case Study"
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [surrogate-model, digital-twin, control-system, uncertainty, training, paper]
sources: [raw/papers/NeurIPS_ML4PS_2025_155.md]
confidence: medium
---

# Continual Learning for Physical Systems

## 개요

Rajput et al. (JLab, ORNL, U. Houston, 2025)은 입자 가속기(particle accelerator) 환경에서 **continual learning (CL)**을 적용하여 data distribution drift에 강건한 ML 시스템을 구축하는 방법을 제시한다. Spallation Neutron Source (SNS)에서 memory-based CL을 통해 Conditional Auto-Encoder (CAE)의 안정적 성능을 입증했다.

## 핵심 문제: Data Drift in Physical Systems

입자 가속기는 동적으로 변화하는 조건(빔 설정 변경, 부품 열화 등)에서 작동하며, 이로 인해 ML 모델의 학습 데이터 분포와 실제 운영 데이터 간의 **distribution drift**가 발생한다. 전통적인 conditional model만으로는 미측정 요인(non-measured parameters)으로 인한 drift를 해결할 수 없다.

## Continual Learning 전략 매핑

| Application | Constraints | Recommended CL |
|:---|---:|:---|
| Anomaly Detection | Low latency, limited storage | Meta-learning + Regularization |
| Optimization & Control | Minimal downtime, multi-config | Memory replay / Gradient projection |
| Surrogate Models / Digital Twins | Offline, data available | Memory-based CL with priority replay |
| Virtual Diagnostics | Real-time, low-latency | Ensemble / Architecture growth |

## SNS 사용 사례: Memory-based CL

**설정**: 31개 unique beam setting vectors → 31 tasks. CAE 모델 (2.3M params)로 anomaly detection.

**방법론 — Quantile-based Replay**:
1. 각 task에서 reconstruction error 분포 기반 quantile sampling
2. Task당 20개 representative sample 선택 → small memory buffer
3. Traditional replay 대비 training time 단축 + 유사 성능 유지

**결과**:
- **Selective replay (growing)**: 모든 task에서 안정적 성능 유지, training time은 traditional replay 대비 현저히 감소
- **Online fine-tuning / Fixed-size replay**: catastrophic forgetting으로 인해 성능 저하

## AI/ML × Mechanics 관점

Continual learning은 디지털 트윈, [[surrogate-model]] 기반 예측, 가속기/플랜트 운영 등 물리 시스템의 **장기적 ML 배포**에 필수적인 기술이다. 특히 시간에 따라 drift하는 물리 시스템에서 안정적인 [[digital-twin]]을 유지하기 위한 핵심 enabler이다.

## 관련 개념

- [[digital-twin]] — 실시간 가상 복제본 (fleet learning)
- [[surrogate-model]] — ML 기반 계산 에뮬레이터
- [[kennedy-ohagan-calibration]] — 컴퓨터 모델 캘리브레이션 (KOH 프레임워크)
- [[uncertainty-quantification-deep-learning]] — DL에서 불확실성 정량화

## 참고

- Data drift 문제는 가속기뿐 아니라 풍력 터빈 모니터링, 구조 건전성 모니터링 등 다양한 물리 시스템에서도 동일하게 발생
- Algorithm 1의 quantile-based sample selection은 physics-informed 중요도 샘플링으로 볼 수 있음 — reconstruction error가 높은 영역과 낮은 영역을 균형 있게 유지
