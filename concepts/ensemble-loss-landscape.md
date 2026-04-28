---
title: Deep Ensembles — Loss Landscape Perspective
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [classic-ai, training, benchmark]
sources: [raw/papers/1912.02757v2.md]
confidence: high
---

# Deep Ensembles: Loss Landscape View

Fort, Hu, Lakshminarayanan (Google/Stanford, 2019)은 **loss landscape 관점**에서 deep ensembles의 성공 원인을 분석했다^[raw/papers/1912.02757v2.md].

- **대조군:** [[deep-ensembles]]의 이론적 보충 — "왜 앙상블이 잘 작동하는가"를 loss landscape의 다중 모드(multi-mode) 특성으로 설명
16|- 서로 다른 random seed → 다른 loss basin → 다양한 예측 패턴 → 앙상블 이점

- [[mc-dropout]] — MC Dropout
