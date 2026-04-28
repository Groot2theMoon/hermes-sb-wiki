---
title: Dropout as Bayesian Approximation (Gal & Ghahramani)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [classic-ai, training, inference]
sources: [raw/papers/gal16.md]
confidence: high
---

# Monte Carlo Dropout

Yarin Gal & Zoubin Ghahramani (Cambridge, 2016)는 **Dropout을 Bayesian variational inference로 해석**할 수 있음을 증명했다^[raw/papers/gal16.md]. 이론적 토대는 [[bayesian-uncertainty-vision]]와 [[deep-ensembles]]의 전신.

- **대조군:** Dropout 기반 uncertainty 추정의 이론적 기준선
- Test time에 dropout을 유지한 MC sampling으로 epistemic uncertainty 추정
- 단순성 덕분에 PINN/Gaussian process 대비 baseline으로 널리 사용