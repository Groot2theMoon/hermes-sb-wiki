---
title: "Per-Loss Adapters for Gradient Conflict in Physics-Informed Neural Networks"
created: 2026-05-17
updated: 2026-05-17
type: concept
tags: [pinn, physics-informed, training, paper]
confidence: medium
sources: [arXiv:2605.10136]
---

# Per-Loss Adapters for PINN Gradient Conflict

## 개요

**Bum Jun Kim, Gnankan Landry Regis N'guessan (2026)** ^[arXiv:2605.10136]은 PINN의 **다중 손실 함수 기울기 간섭(gradient conflict)** 문제를 진단하고 해결하는 진단 우선(diagnostic-first) 프레임워크를 제안한다.

## 핵심 아이디어

- **PINN gradient conflict는 단일 보편 해법이 아님**: 세 가지 regime 식별
  - **Persistent directional conflict** → loss-indexed parameter subspaces (low-rank adapter per loss)
  - **Magnitude imbalance** → scalar reweighting
  - **Low/transient conflict** → 추가 조치 불필요
- **진단**: 1000-step unmodified PINN profiling 후 regime 판단
- **중재**: Low-rank adapter (LoRA-style)를 공유 PINN trunk에 부착, 각 loss에 직접 gradient 경로 제공
- **60+ PDE 설정 평가**: forward, inverse, multi-physics, parameter-varying, up to 50D
- **열탄성(thennoelastic) K=4 시스템**: directional conflict 우세 → adapters + reweighting 효과적

## 의의

- 기존 방법(단순 loss balancing 또는 full-parameter gradient surgery)이 특정 regime에서 실패하는 이유 규명
- PINN 최적화 안정성을 위한 lightweight architectural intervention 제시

## 연결점
- [[spectral-bias-pinn]] — PINN의 또 다른 근본적 문제 (spectral bias)
- [[physics-informed]] — PINN 학습 최적화의 일반적 맥락
- [[rigor-development]] — RIGOR의 VFE loss 구조와 gradient conflict 가능성

## References
- arXiv:2605.10136 — 49 pages, 10 figures
