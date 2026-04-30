---
title: Factorized Inference in Deep Markov Models — Multimodal Time Series
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [model, sequence-modeling, state-space-model, variational-inference]
sources: [raw/papers/factorized-inference-dmm.md]
confidence: medium
---

# Multimodal Deep Markov Models (MDMM)

DMM (Deep Markov Model = [[structured-inference-networks]])을 **멀티모달 시계열**로 확장. 여러 관측 채널을 동시에 모델링하고, missing modality 처리.

## 핵심 기여

- **Multimodal DMM:** 다중 시계열 관측 (EHR + imaging + lab results)
- **Factorized inference:** 모달리티별 partial inference 결합
- **Incomplete data:** 일부 모달리티가 missing이어도 작동

## 관련 페이지
- [[structured-inference-networks]] — 단일 모달리티 DMM 기반
- [[deep-kalman-filter]] — DKF 원조
- [[gru-d]] — missingness를 다루는 다른 접근
