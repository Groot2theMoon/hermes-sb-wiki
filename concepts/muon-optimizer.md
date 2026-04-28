---
title: Muon Optimizer for LLM Training
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [training, benchmark, paper, tool]
sources: [raw/papers/2502.16982.md]
confidence: high
---

# Muon Optimizer & Moonlight

**Muon**은 행렬 직교화(matrix orthogonalization) 기반의 최적화기로, AdamW 대비 **약 2배의 계산 효율성**을 제공한다 (Moonshot AI, 2025)^[raw/papers/2502.16982.md].

- 핵심 기술: **(1) weight decay 추가** (2) **per-parameter update scale 조정**
- Scaling law 실험: compute-optimal training에서 Muon이 AdamW보다 ~2배 효율적
- **Moonlight:** Muon으로 학습된 3B/16B MoE 모델 (5.7T tokens)
- MMLU 등 벤치마크에서 **더 적은 FLOPs로 더 높은 성능** 달성
- [[transformer]] 및 [[bert]]의 학습 효율성을 높이는 최적화기 발전