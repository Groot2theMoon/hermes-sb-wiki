---
title: "CLDNet: Conditional Latent Dynamics Network for Flood Digital Twins"
created: 2026-05-17
updated: 2026-05-17
type: concept
tags: [model, surrogate-model, fluid-dynamics, digital-twin]
sources: [raw/papers/cldnet-flood-digital-twin-swe-surrogate.md]
confidence: high
---

# CLDNet — Conditional Latent Dynamics Network for Flood Digital Twins

**Phillip Si, Yuan Qiu, Omar Sallam, Jeremy Feinstein, Ziang He, Eugene Yan, Peng Chen** — *arXiv:2605.13761 (2026)*

## 개요

AI 기반 홍수 디지털 트윈(flood digital twin)은 앙상블 예보(ensemble forecasting)와 관측 자료 동화(observation assimilation)를 위해 고속의 수리동역학 서로게이트(surrogate)를 필요로 한다. 그러나 GPU 가속 2차원 천수방정식(SWE, Shallow Water Equations) 솔버조차 대도시 유역(~420만 활성 셀)에서 96시간 시뮬레이션에 약 55분이 소요되어, 실시간 디지털 트윈 애플리케이션에는 실용적이지 않다. 본 논문은 이러한 문제를 해결하기 위해 압축된 잠재 공간(latent space)에서 조건부 신경 ODE(neural-ODE)를 통해 SWE의 잠재 동역학(latent dynamics)을 학습하는 **CLDNet(Conditional Latent Dynamics Network)**을 제안한다.

## 핵심 아이디어

- **Conditional Latent Dynamics Network (CLDNet)**: SWE의 시뮬레이션을 고차원 그리드에서 직접 학습하는 대신, 오토인코더(autoencoder) 기반의 ROM(Reduced Order Model)을 통해 저차원 잠재 공간으로 압축한 후, 그 잠재 공간에서 **조건부 신경 ODE(conditional neural-ODE)**로 시간적 진화를 학습
- **Latent space compression**: Autoencoder를 활용해 약 420만 셀의 고해상도 공간 상태를 저차원 잠재 변수로 인코딩하여 차원의 저주(curse of dimensionality) 회피
- **Conditional neural-ODE**: 강우 조건(rainfall forcing)을 조건(condition)으로 받아들여 잠재 공간에서 연속적 동역학을 모델링 — 고정된 시간 간격이 아닌 임의 시간에서의 상태 예측 가능
- **압축 + 동역학 학습의 분리**: (1) Autoencoder가 공간적 압축을 담당하고 (2) Neural-ODE가 시간적 예측을 담당하는 **decoupled architecture**로 각 구성요소의 학습 효율성 극대화

## 결과

| 항목 | 값 |
|------|-----|
| 속도 향상 | **1,435배** (55분 → 2.3초) |
| 수심 예측 오차 (Water depth error) | **2.1%** |
| 적용 대상 | 대도시 유역 (~420만 활성 셀) |
| 평가 기간 | 96시간 홍수 이벤트 |
| 일반화 | 보지 못한 강우 시나리오(unseen rainfall patterns)에서도 강건한 성능 |

- GPU SWE solver보다 **1,435배 빠른** 추론 속도 (55분 → 2.3초)로 실시간 디지털 트윈 워크플로우에 적합한 속도 달성
- 평균 수심 예측 오차 2.1%로 높은 정확도 유지
- 학습 중 보지 못한 강우 패턴에 대해서도 일반화 성능 유지

## 의의

- **실시간 홍수 디지털 트윈의 viable backbone** 제시: CLDNet은 기존 물리 기반 솔버를 대체할 수 있는 AI 기반 서로게이트 모델로, 대도시 규모의 실시간 예보 및 데이터 동화를 가능하게 함
- **Latent space + neural-ODE 접근법**은 기존의 CNN-only surrogate나 FNO 기반 방법보다 긴 시간적 예측에서 더 안정적이고 빠름
- **Conditional formulation**으로 다양한 강우 시나리오에 대응 가능 — 기후 변화 대비 홍수 위험 평가 및 조기 경보 시스템에 활용 기대
- **Digital twin 패러다임**에서 "물리 솔버 → AI surrogate"로의 전환을 가속화하는 핵심 방법론

## Wikilinks

- [[digital-twin]] — AI 기반 디지털 트윈을 위한 핵심 서로게이트 모델
- [[neural-ode]] — 잠재 공간에서 연속적 동역학 학습에 사용
- [[surrogate-model]] — 고속 수리동역학 서로게이트
- [[fluid-dynamics]] — 천수방정식(SWE) 기반 홍수 모델링
- [[physics-informed]] — 물리 정보 활용 여부 및 비교
- [[autoencoder-rom]] — 오토인코더 기반 차수 축소 모델(ROM)
