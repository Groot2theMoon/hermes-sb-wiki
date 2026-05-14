---
title: IRC-Safe Jet Clustering with Lorentz-Equivariant Geometric Algebra Transformer
created: 2026-05-14
updated: 2026-05-14
type: concept
tags: [physics-informed, model, transformer]
sources: [raw/papers/NeurIPS_ML4PS_2025_59.md]
confidence: medium
---

# IRC-Safe Jet Clustering with L-GATr

Lorentz-equivariant Geometric Algebra Transformer (L-GATr) + Object Condensation loss +
IRC Safety loss를 결합한 입자물리 jet clustering 알고리즘.

## 개요

- **저자:** Gregor Kržmanc et al. (ETH Zürich / CERN)
- **NeurIPS ML4PS 2025 Workshop**
- **문제:** LHC에서 생성된 쿼크/글루온의 hadronization으로 인한 jet을 IRC-safe하게 클러스터링
- **기존 baseline:** anti-$k_t$ 알고리즘 (고전적 방법)

## 방법론

**L-GATr + Object Condensation + IRC Safety Loss**

- **L-GATr:** Lorentz 기하 대수에 내장된 4-벡터를 multivector token으로 처리, Lorentz equivariance 보장
- **Object Condensation Loss:** particle $p_T$를 $q_i$로 사용하여 cluster center 학습, HDBSCAN으로 최종 클러스터링
- **IRC Safety Loss (novel):** collinear splitting ($T_{||}$)과 soft particle addition ($T_{\text{soft}}$) augmentation에 대한 MSE penalty
  - L-GATr_GP_IRC_S: $T_{||}$만 사용
  - L-GATr_GP_IRC_SN: $T_{||}$ + $T_{\text{soft}}$ 사용

## 결과

- QCD background 및 semi-visible jet (SVJ) signal 모두에서 anti-$k_t$ baseline 능가
- Generator-level (hadronization 전후) 성능 비교로 높은 IRC safety 입증
- ~500개의 low-$p_T$ ghost particle 추가가 성능 향상 (clustering step이 bottleneck임을 시사)

## AI×Mechanics 관점

- Lorentz equivariance를 보장하는 기하 대수 기반 아키텍처는 상대론적/고속 역학 시스템에도 적용 가능성
- IRC safety loss (augmentation invariance penalty)는 물리 시스템의 대칭성/불변성을 강제하는 일반적 패턴
- Object condensation + clustering 파이프라인은 particle/cluster 기반 역학 모델(예: DEM, 입자계)의 인스턴스 분할에 응용 가능

## 관련 페이지

- [[transformer]] — Transformer 아키텍처
- [[physics-informed]] — Physics-informed ML
- [[generative-models-physics]] — Physics generative models
