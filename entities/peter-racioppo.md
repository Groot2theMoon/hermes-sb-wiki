---
title: Peter Racioppo — Robust Filter Attention & Uncertainty-Aware Self-Attention
created: 2026-05-06
updated: 2026-05-06
type: entity
tags: [person, researcher, attention, filtering, sde, transformer, positional-encoding]
sources: [raw/papers/robust-filter-attention-racioppo25.md]
confidence: medium
---

# Peter Racioppo

## 개요

Peter Racioppo는 Los Angeles, CA 기반의 독립 연구원(Independent Researcher)으로, **Transformer 아키텍처와 확률적 상태 추정의 연결**에 관한 독창적인 연구를 수행하고 있다.

## 주요 연구

- **Robust Filter Attention (RFA)** (2025) — [[robust-filter-attention]]: Self-attention을 LTI SDE prior 하의 병렬 robust 상태 추정으로 재정의
- **Spectrally-Coupled RFA (SC-RFA)** — 주파수 대역별 dissipation rate coupling을 통한 multi-resolution temporal filtering
- DLE (Differential Lyapunov Equation) 기반의 해석적 uncertainty propagation
- RoPE, ALiBi, xPos 등 기존 위치 인코딩을 RFA 프레임워크의 특수한 경우로 통합

## 연구 방향

Racioppo의 연구는 position encoding을 단순한 기하학적 변환이 아닌 **확률적 동역학 모델의 일부**로 이해하는 새로운 패러다임을 제시하며, attention 메커니즘과 (robust) Kalman filtering 간의 깊은 연결을 formalize한다.
