---
title: ALE-Consistent GNO-Transformer Framework for Fluid-Structure Interaction
created: 2026-05-15
updated: 2026-05-15
type: concept
tags: [paper, neural-operator, fluid-dynamics, surrogate-model, fsi, cfd]
confidence: medium
sources: []
---

# ALE-Consistent GNO-Transformer for FSI

## 개요
**Shihang Zhao, Martín Saravia, Haokui Jiang, Zhiyang Xue, Shunxiang Cao** (2026) — arXiv:2605.00937 (physics.flu-dyn, cs.LG). 비정형 변형 격자(deforming unstructured mesh)에서 장기 **유체-구조 연성(FSI)** 예측을 위한 ALE-일관 ML 프레임워크.

## 핵심 아이디어
- **유체 서로게이트:** GNO + Vision Transformer (ViT) 결합으로 시공간 예측
- **구조 역학:** 경량 LSTM 네트워크로 인터페이스에서 구조 운동학 예측
- **ALE-일관 경계 보정:** 각 커플링 업데이트마다 유체측 인터페이스 속도를 예측된 구조 속도로 갱신하여 근-인터페이스 정확도 및 장기 rollout 안정성 향상
- **2단계 학습:** 단일-step 지도 사전학습 → 장기 autoregressive fine-tuning
- **검증:** 원주 후류에서의 유연 보(flexible beam) 진동 벤치마크
- **소거 실험:** ViT 모듈, ALE 경계 보정, 장기 학습 각각의 기여도 평가

## 연결점
- [[graph-neural-operator]] — GNO 기반 유체 동역학 서로게이트
- [[fluid-dynamics]] — 유체-구조 연성 문제의 공학적 맥락
- [[digital-twin]] — 장기 rollout 예측의 디지털 트윈 응용 가능성
- [[operator-learning]] — Operator learning의 FSI 응용

## References
- arXiv:2605.00937 — An ALE-Consistent Graph Neural Operator-Transformer Framework for Fluid-Structure Interaction
