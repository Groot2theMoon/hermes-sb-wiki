---
title: Deep Learning-Based Bouc-Wen Parameter Estimation — Oh, Song & Kim (2024)
created: 2026-05-08
updated: 2026-05-08
type: concept
tags: [hybrid-modeling, system-identification, cnn, structural-analysis, state-estimation]
sources: [raw/papers/oh24-bouc-wen-dl-parameter.md]
confidence: high
---

# DL-Based Bouc-Wen Parameter Estimation

**Sebin Oh, Junho Song, Taeyong Kim** (Seoul National University, 2024). arXiv:2411.02776.

## 개요

Bouc-Wen class 모델의 파라미터 추정을 위한 **modularized deep learning loading protocol**. 표준 시스템 ID 접근 (full loading history → optimization) 대신, CNN이 loading history의 path-dependent 특성을 학습하여 Bouc-Wen 파라미터를 직접 예측.

## 접근법

```
Loading history optimization
  → minimal loading sequences (loading history modules)
  → CNN-based parameter estimation
  → 각 CNN: basic hysteresis / degradation / pinching 전담
```

## RIGOR 관련성

- **Loading history → CNN** 접근은 **RIGOR UKF의 K-step rollout과 유사**: 둘 다 temporal history에서 z의 path-dependent 특성을 추론.
- Oh et al.은 **offline parameter ID** (실험 후 분석), RIGOR는 **online state estimation** (실시간 추정).
- Oh et al.의 성공은 **Bouc-Wen의 z가 temporal pattern에서 추론 가능하다**는 증거 → RIGOR의 TE-only (z corr 0.717) 결과와 일관.

## 한계
- Filtering이 아닌 parameter estimation
- CNN 기반 → 실시간 적응 불가
- Loading history 전체가 필요 (K-step보다 긴 horizon)

## Wikilinks
- [[rigor-filter]] — Bouc-Wen 실험: z correlation 문제
- [[rigor-development]] — RIGOR framework
- [[neural-ekf-structural-systems]] — Chatzi Neural EKF (동일 SHM domain)
