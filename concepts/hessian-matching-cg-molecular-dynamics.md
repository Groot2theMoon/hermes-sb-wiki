---
title: "Hessian Matching for ML Coarse-Grained Molecular Dynamics"
created: 2026-05-17
updated: 2026-05-17
type: concept
tags: [model, materials, training, surrogate-model]
sources: [raw/papers/hessian-matching-cg-molecular-dynamics.md]
confidence: high
---

# Hessian Matching for ML Coarse-Grained Molecular Dynamics

## 개요

Coarse-grained (CG) 분자동역학(MD)은 생체분자의 all-atom 시뮬레이션이 도달할 수 없는 시간 스케일을 가능하게 하지만, 기존 CG 신경망 포텐셜은 force matching만으로 학습되어 자유 에너지 표면의 기울기(gradient)만 포착하고 곡률(curvature)은 제약하지 못하는 한계가 있다.

## 핵심 아이디어

- **Force matching + Hessian-vector product (HVP) matching** 결합
- 전체 Hessian을 명시적으로 계산하지 않고 stochastic HVP를 통해 **2차 곡률 정보**를 CG 포텐셜에 주입
- HVP는 자유 에너지 표면의 곡률이 중요한 **conformational basin**에서 가장 큰 기여

## 결과

- 6개 peptide/small-protein benchmark (alanine dipeptide, chignolin, trp-cage, villin headpiece, BBA, WW domain):
  - **Mean force error 최대 28% 감소** (force matching 단독 대비)
  - 예측된 상대 자유 에너지 차이의 rank correlation 개선
  - 동적 특성 (확산 계수, 재배향 시간)이 all-atom reference에 더 충실히 복원

## 의의

- CG 신경망 포텐셜에 **2차 정보를 도입**한 첫 접근법
- 전체 Hessian 없이 HVP만으로 곡률 정보를 주입하는 **계산 효율적 방법**
- Force matching이 가장 덜 informative한 **고곡률 영역**에서 HVP가 결정적 기여

## 관련 페이지

- [[surrogate-model]] — Surrogate modeling for physical systems
- [[materials]] — Materials modeling and simulation
- [[neural-operator]] — Neural operator-based surrogate models
- [[training]] — Training techniques and loss design
- [[free-energy-principle]] — Variational free energy and energy-based learning

## 참고 문헌

- Murdeshwar et al. (2026). Hessian Matching for Machine-Learned Coarse-Grained Molecular Dynamics. arXiv:2605.12823
