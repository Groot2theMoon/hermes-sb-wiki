---
title: Predictivity and Utility of Neural Surrogates of Multiscale PDEs — Critical Analysis
created: 2026-05-05
updated: 2026-05-05
type: concept
tags: [surrogate-model, theory, benchmark, physics-informed]
confidence: medium
---

# Predictivity of Neural Surrogates of Multiscale PDEs

## 개요
**Karthik Duraisamy (University of Michigan)**의 이 논문(arXiv:2604.20061, 2026)은 SciML의 "replace the solver" 및 "1000× speedup" 주장에 대한 **비판적 검토**를 제공한다. Neural surrogates는 spectral bias로 인해 고주파 성분을 체계적으로 under-resolve하며, coarse-graining은 비가역적 정보 손실을 통해 이 문제를 증폭시킨다.

## 핵심 아이디어
- Neural surrogates의 apparent success는 대부분 **benign manifold interpolation** 또는 **demonstration on self-similar problems**로 설명 가능
- "분수령" 문제: multiscale 문제에서는 어떤 architecture나 training procedure도 coarse representation이 버린 정보를 완전히 복원할 수 없음
- Medium-range weather prediction은 reanalysis data의 favorable 특성 덕분 — genuinely chaotic multiscale 시나리오로 일반화 불가

## 연결점
- [[pinn-failure-modes]] — PINN 실패 분석과의 연계: spectral bias 문제
- [[fourier-neural-operator]] — FNO의 spectral representation과 neural surrogate의 근본적 한계
- [[physics-informed]] — 물리 정보 활용의 실제적 한계점

## References
- arXiv:2604.20061 — Predictivity and Utility of Neural Surrogates of Multiscale PDEs
