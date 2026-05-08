---
title: "The Geometry of Forgetting — Memory as Geometry, Not Biology"
created: 2026-05-08
updated: 2026-05-08
type: concept
tags: [memory, embedding, neural-network, interference, theory, paper, landmark]
sources: [raw/papers/2604.06222v1.md]
confidence: high
---

# The Geometry of Forgetting

**Barman, Starenky, Bodnar, Narasimhan, Gopinath (2026)** — Sentra + MIT
arXiv:2604.06222

## 개요

고차원 임베딩 공간에서 **기억의 망각과 오기억(false memory)이 생물학적 하드웨어의 버그가 아니라, 의미 기반 조직 기하학의 필연적 결과**임을 증명. 별도의 현상 공학(phenomenon-specific engineering) 없이, cosine similarity retrieval만으로 인간 인지 심리학의 정량적 패턴을 재현한다.

## 핵심 발견

1. **Power-law forgetting은 decay가 아니라 경쟁(interference) 때문**
   - 시간에 의한 단순 붕괴 → $b \approx 0.009$
   - 경쟁 기억 간 간섭 → $b = 0.460 \pm 0.183$ (인간 Ebbinghaus $b \approx 0.5$와 일치)
   - Time alone does not produce forgetting. Competition does.

2. **생산 임베딩 모델 (384–1,024차원 명목)의 유효 차원은 ~16에 불과**
   - 명목 차원 대비 극히 낮은 $d_{\text{eff}}$ → 간섭에 극도로 취약한 체제

3. **False memory는 공학이 아니라 발견된 현상**
   - DRM 패러다임 false alarm rate: 0.583 (인간 ~0.55) — **zero parameter tuning**
   - 사전 학습된 임베딩의 raw cosine similarity에서 자발적으로 출현

4. **인간 기억 현상의 공통 기반**
   - 망각 곡선, DRM false memory, tip-of-tongue 상태 모두 동일한 기하학적 메커니즘

## 의의

- 망각과 오기억을 **"생물학적 구현의 버그"에서 "의미 기반 검색 시스템의 필연적 특징"** 으로 재정의
- Embedding memory system의 설계에 근본적 제약 조건 제시

## 연결점
- [[price-of-meaning]] — 후속 impossibility theorem의 기하학적 토대
- [[geometry-of-consolidation]] — 동일한 $d_{\text{eff}}$ 기반의 압축 법칙
- [[deep-material-network]] — DMN의 자료 구조가 embedding memory와 유사한 간섭 문제를 가질 가능성
- [[rigor-sigma-point-research]] — RIGOR의 sigma point cloud가 본질적으로 embedding memory의 일종

## References
- arXiv:2604.06222 — The Geometry of Forgetting
- arXiv:submit/7412286 — The Price of Meaning (sister paper)
