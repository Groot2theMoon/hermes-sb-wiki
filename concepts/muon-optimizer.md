---
title: Muon Optimizer for LLM Training
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [training, benchmark, paper, tool, optimization-method]
sources: [raw/papers/2502.16982.md]
confidence: high
---

# Muon Optimizer & Moonlight

## 개요

**Muon**은 **Jordan et al. (2024)**가 제안한 **행렬 직교화(matrix orthogonalization)** 기반의 최적화기로, **[[moonshot-ai|Moonshot AI]] (2025)**가 대규모 LLM 학습으로 확장했다^[raw/papers/2502.16982.md]. AdamW 대비 **약 2배의 계산 효율성**을 제공하며, 이를 기반으로 **Moonlight (3B/16B MoE, 5.7T tokens)** 모델이 학습되었다.

## Muon 업데이트 규칙

Muon의 핵심 아이디어: **가중치 행렬의 gradient를 SVD 직교화하여 업데이트 방향의 등방성(isotropy) 보장**

$$ \mathbf{M}_t = \mu \mathbf{M}_{t-1} + \nabla \mathcal{L}_t(\mathbf{W}_{t-1}) $$
$$ \mathbf{O}_t = \text{Newton-Schulz}(\mathbf{M}_t) \quad (\text{근사 SVD 직교화}) $$
$$ \mathbf{W}_t = \mathbf{W}_{t-1} - \eta_t \mathbf{O}_t $$

이때 $\mathbf{O}_t \approx \mathbf{U}\mathbf{V}^\top$ (where $\mathbf{M}_t = \mathbf{U}\Sigma\mathbf{V}^\top$), 즉 **$\mathbf{M}_t$를 가장 가까운 직교 행렬로 사영**한다.

## AdamW vs Muon 비교

| 차원 | AdamW | Muon |
|:---:|:----:|:----:|
| **핵심 메커니즘** | Adaptive learning rate (per-param) | Matrix orthogonalization |
| **업데이트 방향** | 정규화된 gradient | 직교화된 gradient momentum |
| **적용 대상** | 모든 파라미터 | 행렬 파라미터만 (2D 이상) |
| **계산 오버헤드** | 없음 | Newton-Schulz 반복 (5-6회) |
| **상대 FLOPs** | 1.0× (baseline) | **~0.52×** (약 2배 효율) |
| **대규모 안정성** | 검증됨 | Weight decay + scale 조정 필요 |

## 대규모 확장을 위한 핵심 기술

Moonshot AI가 Muon을 대규모로 확장하기 위해 식별한 두 가지 핵심 기술:

1. **Weight decay 추가:** Muon의 원래 설계에는 weight decay가 없었음 → scaling 시 **안정성 문제** 발생, AdamW 스타일의 **decoupled weight decay** 추가로 해결
2. **Per-parameter update scale 조정:** 행렬 차원에 따라 Newton-Schulz 출력의 norm이 달라지므로, **careful scaling** 필요 → hyper-parameter tuning 없이 out-of-the-box 작동

## Scaling Law 결과

- **Compute-optimal training**에서 Muon이 AdamW보다 **~2배 효율적**
- 동일한 성능에 도달하는 데 필요한 FLOPs가 절반 수준
- 124M → 1.5B 파라미터 규모의 scaling law 실험으로 검증됨

## Moonlight 모델

| 스펙 | 값 |
|:---|:---:|
| 파라미터 | 3B / 16B MoE |
| 학습 토큰 | 5.7T tokens |
| 최적화기 | Muon (분산 구현, ZeRO-1) |
| 벤치마크 | MMLU 등에서 Pareto frontier 개선 |
| 공개 | ✅ Pretrained + instruction-tuned + 중간 checkpoint |

## 융합 도메인 연결

- [[transformer]]의 학습 효율성을 높이는 최적화기 발전의 최신 동향
- [[bert]], [[gpt-1]] 학습에 사용된 Adam 계열 최적화기와의 비교 기준
- DMN 학습 시 손실 함수 최적화에 Muon 적용 가능성 — 복잡한 multi-scale physics loss의 효율적 최적화

## References
- Jordan, K. et al. (2024). Muon: An optimizer for matrix parameters. Blog post.
- Liu, J. et al. (2025). Muon is Scalable for LLM Training. arXiv:2502.16982.
- [[transformer]]
- [[bert]]
