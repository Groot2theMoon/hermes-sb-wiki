---
title: Physics-Informed Temporal U-Net — Fluid Interpolation
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [physics-informed, fluid-dynamics, model, CFD]
sources: []
confidence: medium
sources: []
---

# Physics-Informed Temporal U-Net for Fluid Interpolation

## 개요

Eshwar R. A., Thomas, Nehal G, Begam (2026)이 제안한 **시변 유체 데이터의 고충실도 보간을 위한 Temporal U-Net** 아키텍처. 기존 딥러닝 보간법이 sparse temporal observation에서 spatial blurring과 temporal strobing을 유발하는 문제를 해결한다.

## 핵심 아이디어

Temporal U-Net은 VGG 기반 perceptual loss와 **Physics-Informed Bridge**를 결합하여 parabolic 경계 조건 t(1 − t)를 강제한다. Time-weighted feature blending을 통해 endpoint에서 완벽한 consistency를 유지하면서 부드러운 transition을 보장한다.

- **MAE 0.015** (L1 baseline 0.085 대비 5.7배 향상)
- **Spatial Power Spectral Density (PSD)** 분석에서 고주파 난류 세부 구조 보존 확인
- RGB multi-channel fluid 데이터로 검증

## 연결점

- [[physics-informed]] — Physics-Informed Bridge의 제약 조건 부여 방식
- [[fourier-neural-operator]] — 고주파 유체 구조 포착의 대안적 접근법
- [[ai-hallucination-physics]] — temporal fluid 재구성에서 hallucination 방지와의 연관성

## References
- arXiv:2604.23372 — "Physics-Informed Temporal U-Net for High-Fidelity Fluid Interpolation"
