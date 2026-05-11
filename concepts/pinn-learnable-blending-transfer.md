---
title: PINNs with Learnable Loss Balancing and Transfer Learning
created: 2026-05-11
updated: 2026-05-11
type: concept
tags: [paper, physics-informed, pinn, learning]
confidence: medium
sources: []
---

# PINN Learnable Blending & Transfer Learning

## 개요
arXiv:2605.05217 (cs.LG, May 2026)은 물리 잔차와 데이터 손실의 가중치를 **학습 가능한 blending neuron**으로 동적으로 조절하는 PINN 프레임워크를 제안한다. 또한 transfer learning을 통합하여 데이터가 부족한 새로운 물리 시스템에 빠르게 적응한다.

## 핵심 아이디어
- **Learnable blending neuron:** 물리 잔차(physics residual)와 데이터 손실(data loss) 간의 상대적 기여도를 불확실성(uncertainty) 기반으로 자동 조절 — 고정/휴리스틱 가중치 불필요
- **Transfer learning:** 관련 도메인에서 사전 학습된 표현을 재사용하여 제한된 데이터로 새로운 물리 시스템에 적응
- **검증 사례:** 액체 금속 미세 방열판(liquid-metal miniature heat sink)의 열전달 예측 — 단 87개 CFD 데이터포인트만으로 <8% 오차 달성
- **비교 대상:** 얕은 신경망, 커널 방법, 물리-only baseline 대비 우수

## 연결점
- [[physics-informed]] — 기존 PINN 손실 가중치 방식(고정/휴리스틱)과의 차별점
- [[continual-learning-physical-systems]] — Transfer learning 접근법과 replay 기반 CL의 비교

## References
- arXiv:2605.05217 — Physics-Informed Neural Networks with Learnable Loss Balancing and Transfer Learning
