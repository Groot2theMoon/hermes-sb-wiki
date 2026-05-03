---
title: "ML for Acoustic Metamaterials and Phononic Crystals — Review (2024)"
created: 2026-05-03
updated: 2026-05-03
type: concept
tags: [review, machine-learning, acoustic-metamaterials, phononic-crystals, deep-learning, inverse-design]
sources:
  - raw/papers/ml-acoustic-metamaterials-review24.md
confidence: high
---

# Application of Machine Learning on the Design of Acoustic Metamaterials and Phononic Crystals: A Review

## 개요

**Jianquan Chen**, Jiahan Huang, Mingyi An, Pengfei Hu, Yiyuan Xie, Junjun Wu, Yu Chen이 *Smart Materials and Structures* (Vol.33, 073001, 2024)에 발표한 종합 리뷰. ML/DL 기법을 음향 메타물질(AM) 및 포노닉 결정(PnC) 설계에 적용한 연구를 체계적으로 정리.

DOI: [10.1088/1361-665X/ad51bc](https://doi.org/10.1088/1361-665X/ad51bc)

## 음향 메타물질(AM)과 포노닉 결정(PnC) 기초

### AM 유형

| 유형 | 원리 | 특징 |
|:-----|:-----|:------|
| **공진형 (Resonant)** | 국소 공진 효과 | 주파수 선택성, 구조 가변성 |
| **멤브레인형 (Membrane)** | 박막 + 추가 질량의 negative mass 효과 | 저주파 차음, 경량 |
| **Helmholtz 공진형** | 공동 + 목 구조의 공진 | 흡음/반사/투과 제어 |
| **Space-coiling** | 음파 경로 연장 | 이중 음성, 고굴절률 |
| **복합 구조형** | 이종 구조 결합 | 고도 제어 가능성 |

### PnC vs AM

| 구분 | PnC | AM |
|:-----|:----|:----|
| 구성 | 두 개 이상 탄성 재료의 주기 구조 | 미세 구조 단위의 주기 구조 |
| 원리 | Bragg 산란 + 국소 공진 | 구조 기반 산란 + 특수 물성 + 공진 |
| 밴드갭 | 밴드갭 생성이 주 목적 | 특수 음향 특성 (negative refraction 등) |
| 주파수 | 초음파~가청 주파수 | 주로 저중간 주파수 |

## ML 기법 분류

### Traditional ML

| 알고리즘 | 적용 | 한계 |
|:---------|:-----|:-----|
| **유전 알고리즘 (GA)** | 위상 최적화, 광대역 negative refraction | 특정 문제에 특화, 일반화 제한 |
| **Gauss-Bayesian 모델 (G-BM)** | 역설계 (소수 평가로 최적화) | 복잡도 증가 시 성능 저하 |
| **Monte Carlo start-point (MCSP)** | 주기 메타물질 밴드갭 최적화 | 계산 비용 큼 |
| **RBF 신경망** | 저주파 밴드갭 진폭 최대화 | 고차원 문제에 취약 |

### Deep Learning 모델

#### DNN (Deep Neural Networks)

- 복잡한 비선형 관계 모델링
- **응용**: 1D 비주기 메타물질 시스템, 메타모델 표현, 역설계
- **예시**: Cheng et al. — Helmholtz 공진 + 다공질 재료 기반 흡음单元의 역설계

#### CNN (Convolutional Neural Networks)

- 그리드 구조 데이터 처리에 특화
- **응용**: 국소 음장 → 위상 구배 매핑, 흡수 스펙트럼 예측, 고차원 산란 음장 예측
- **예시**:
  - Zhao et al. — Dual-CNN으로 초표면(metasurface) 설계 (GA보다 높은 정확도)
  - Donda et al. — CNN 기반 초박형 흡수체 설계 (밀리초 스케일 응답)

#### GAN (Generative Adversarial Networks)

- 생성기 + 판별기의 적대적 학습 → 새로운 구조 생성
- **응용**: PnC/AM 구조 형상 생성 및 최적화
- **변형**: WGAN (Wasserstein GAN), CGAN (Conditional GAN)
- **예시**: Gurbuz et al. — CGAN 기반 차음 목적 단위 셀 생성

#### Autoencoder

- 인코더 + 디코더로 저차원 표현 학습
- **변형**: VAE (Variational AE), Sparse AE, Denoising AE
- **응용**: 구조-스펙트럼 응답 관계 학습, 온디맨드 역설계

#### Deep Reinforcement Learning (DRL)

- 환경과 상호작용하며 보상 최대화 정책 학습
- **알고리즘**: DQN, DDQN, DDPG, SAC
- **응용**: 산란 최소화 설계, 고차원 파라미터 공간 최적화
- **예시**: Shah et al. — DDQN으로 실린더 산란체의 위치/반경 최적화하여 TSCS 최소화

## 주요 응용 분야

### 1. AM 구조 최적화

| ML 모델 | 응용 | 성능 |
|:--------|:-----|:-----|
| GA | 사각 격자 subwavelength AM 설계 | 광대역 negative refraction |
| G-BM | AM 흡수체 역설계 | 37회 평가로 최적 달성 |
| CNN | 초표면(metasurface) 설계 | GA 대비 높은 정확도 |
| DRL | 산란 최소화 설계 | 전통 최적화 대비 우수 |
| CGAN | 차음 단위 셀 생성 | 소규모 데이터셋에서 효과적 |

### 2. AM 성능 예측

- 신경망 기반 **흡음 계수**, **차음 성능** 예측
- CNN 기반 TSCS (Total Scattering Cross Section) 예측
- 물리 내장 CNN (TLCNN, PGCNN)으로 2D 포노닉 메타물질의 **분산 곡선 예측**
- 회귀 트리 모델로 멤브레인 AM의 흡음 계수 예측 (지속 가능 건축 자재 설계)

### 3. AM 역설계 (Inverse Design)

- **Invertible Neural Network (INN)**: 주기/비주기 포노닉 구조의 주파수 응답 역설계
- **Forward + Backward Network**: 목표 흡음 곡선 → 만족하는 메타물질 구조 생성
- **DL + GA 결합**: 원하는 bandgap 경계를 가진 PnC를 초 단위로 생성
- **Q-learning**: 적층 PnC의 밴드갭 최대화/특정 범위 달성 역설계

### 4. PnC 설계

#### 성능 예측
- **DBP-NN / RBF-NN**: 1D PnC 분산 관계 예측
- **Surrogate DL model**: 분산 맵 초고속 예측 (FEM: 0.5~1.5h → DL: 10~100ms)
- **Autoencoder + FEM**: 위상 특징 추출 및 밴드갭 예측 → 원하는 밴드갭 PnC 설계
- **Random Forest**: 밴드갭 유무 스크리닝 + 중심 주파수/폭 예측

#### 역설계 및 위상 최적화
- **S-NN / U-NN**: 1D PnC 지능형 역설계 (GA보다 빠름)
- **DNN + GA**: 2D PnC 분산 엔지니어링을 위한 역설계
- **GAN + CNN**: PnC 밴드 구조 예측 및 역설계
- **DRL (DDQN, DDPG)**: 열탄성 PnC 빔의 밴드 구조 역설계

## 장점과 도전 과제

### 장점

- **효율성**: 전통 FEM 대비 10³~10⁵배 빠른 예측
- **비선형 문제 해결**: 복잡한 음향-구조 상호작용 모델링
- **데이터 기반 설계**: 대량 데이터에서 숨겨진 패턴 발견
- **비주기 구조 설계 가능**: 전통 방법의 주기성 제약 극복
- **다분야 융합**: 물리학, 재료과학, 공학 지식 통합

### 도전 과제

| 과제 | 설명 | 잠재적 해결 |
|:-----|:------|:------------|
| **데이터 품질/양** | 고품질 학습 데이터 확보 어려움 | 전이 학습, 데이터 증강 |
| **모델 선택/튜닝** | 최적 모델 구조/파라미터 탐색 복잡 | AutoML, Bayesian optimization |
| **해석 가능성** | 블랙박스 모델의 내부 결정 과정 이해 부족 | 물리 내장 NN, attention mechanism |
| **도메인 지식 융합** | 다분야 전문 지식 효과적 통합 필요 | Physics-informed NN, multi-fidelity |

## 향후 방향

- **Physics-Informed Neural Networks (PINNs)** 의 AM/PnC 설계 적용 확대
- **Multi-fidelity learning**으로 고비용 시뮬레이션 부담 완화
- **Transfer learning**으로 데이터 부족 문제 해결
- **Generative models** 발전을 통한 창의적 구조 생성
- **Explainable AI** 도입으로 설계 결과의 신뢰성 향상

## 관련 개념

- [[deep-material-network]] — 물리 기반 surrogate model (DMN, 유사 접근법)
- [[waste-fiber-acoustic-absorber]] — 음향 흡음 재료 개념
- [[diffusion-metamaterial-inverse-design]] — 확산 모델 기반 메타물질 역설계

## References

- Chen J, Huang J, An M, et al. "Application of machine learning on the design of acoustic metamaterials and phononic crystals: a review." *Smart Mater. Struct.*, 33, 073001, 2024.
- Kushwaha MS, et al. "Acoustic band structure of periodic elastic composites." *Phys. Rev. Lett.*, 1993.
- Li J, Chan CT. "Double-negative acoustic metamaterial." *Phys. Rev. E*, 2004.
