---
title: Hierarchical Autoregressive Networks (HAN) for Statistical Systems
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, neural-network, physics-informed, surrogate-model, paper]
sources: [raw/papers/2203.10989v2.md]
confidence: high
---

# Hierarchical Autoregressive Networks (HAN) for Statistical Systems

## 개요

Piotr Białas, Piotr Korcyl, Tomasz Stebel (2022)이 제안한 **Hierarchical Autoregressive Networks (HAN)**은 variational autoregressive networks (VAN)의 확장으로, **2차원 Ising 모델**의 확률 분포 근사에서 발생하는 $O(L^4)$~$O(L^6)$의 비용 스케일링 문제를 **계층적 분할**을 통해 $O(L^2)$~$O(L^3)$으로 극적으로 개선한다^[raw/papers/2203.10989v2.md].

## 핵심 아이디어

### 계층적 스핀 분할 (Hierarchical Partitioning)

Ising 모델의 nearest-neighbor 상호작용과 **Hammersley-Clifford 정리**를 활용하여 격자를 재귀적으로 분할:

1. **1단계**: 경계 스핀($B^{(0)}$)과 내부 스핀으로 분할 — 하나의 신경망 $\mathcal{N}^0$로 경계 생성
2. **2단계**: 각 sublattice를 다시 경계와 내부로 분할 — 동일한 $\mathcal{N}^1$ 네트워크 재사용
3. **재귀 반복**: $L = 2^m$에서 $m-2$ 단계까지 반복
4. **최종 단계**: 남은 단일 스핀들은 **heatbath algorithm**으로 처리

### 스케일링 개선

| 방식 | 파라미터 수 | 연산량 (샘플 생성) | 연산량 (확률 계산) |
|------|------------|-------------------|-------------------|
| VAN  | $O(L^4)$   | $O(L^6)$          | $O(L^4)$          |
| **HAN** | $O(L^2)$ | $O(L^3)$          | $O(L^2 \log L)$   |

### 주요 결과

- $128 \times 128$ 크기까지 시뮬레이션 성공 (기존 VAN은 $16 \times 16$ 한계)
- Variational free energy가 이론적 기대치에 더 근접
- Markov Chain Monte Carlo에서 autocorrelation time 감소
- GPU V100 기준 $L > 32$에서 VAN 대비 월등한 속도

## 관련 개념

- [[unsupervised-phase-transitions]] — ML로 상전이 탐지
- [[variational-autoencoder]] — 다른 생성 모델 접근법
- **Variational Autoregressive Networks (VAN)** — HAN의 기반
- **Neural Markov Chain Monte Carlo (NMCMC)** — 응용 분야