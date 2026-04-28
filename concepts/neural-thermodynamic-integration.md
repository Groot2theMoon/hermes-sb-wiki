---
title: Neural Thermodynamic Integration
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [physics-informed, model, paper, mathematics]
sources: [raw/papers/2406.02313v4.md]
confidence: high
---

# Neural Thermodynamic Integration (Neural TI)

Máté, Fleuret, Bereau (Heidelberg/Geneva, 2024)는 **energy-based diffusion model**을 사용해 열역학적 적분(Thermodynamic Integration)을 수행하는 Neural TI를 제안했다^[raw/papers/2406.02313v4.md].

- 시간 의존 Hamiltonian $U_t^\theta$을 score matching으로 최적화
- 상호작용/비상호작용 Hamiltonian 사이의 **alchemical pathway** 학습
- 단일 참조 계산만으로 Lennard-Jones 유체의 **과잉 화학 퍼텐셜** 정확 계산
- [[variational-autoencoder]]와 [[unsupervised-phase-transitions]]의 확장으로 볼 수 있는 ML × Physics 연구