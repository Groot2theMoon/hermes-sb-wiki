---
title: Unsupervised Learning of Phase Transitions (ML × Physics)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, paper, physics-informed, mathematics]
sources: [raw/papers/1703.02435v2.md, raw/papers/2104.06368v1.md]
confidence: high
---

# Unsupervised Learning of Phase Transitions (ML × Physics)

## 개요

Sebastian J. Wetzel (Universität Heidelberg, 2017)은 **비지도 학습(unsupervised learning)**을 사용해 물리적 계의 **상전이(phase transition)**를 탐지하는 방법을 제시했다^[raw/papers/1703.02435v2.md]. Ising 모델과 XY 모델의 Monte-Carlo 샘플을 PCA부터 VAE까지 다양한 방법으로 분석하여 **사전 지식 없이도 상전이를 감지**할 수 있음을 증명했다.

이는 **AI/ML × 물리/역학 융합 도메인**의 대표적 사례이다.

## 핵심 아이디어

### PCA → Autoencoder → VAE 점진적 확장
- **PCA:** Ising 자화율과 선형 상관관계 (가장 정확하나 비선형 데이터에 한계)
- **Kernel PCA:** 비선형 확장
- **전통 Autoencoder:** 덜 정확 (latent space 규제 없음)
- **Variational Autoencoder (VAE):** 가장 안정적이고 일반적인 방법

### 잠재 변수(Latent Variable) = 질서 변수(Order Parameter)
- VAE의 latent parameter가 **자발적 대칭성 깨짐의 질서 변수**에 해당
- 강자성 Ising: latent param ≈ 자화율(magnetization)
- 반강자성 Ising: latent param ≈ staggered magnetization
- 3D XY 모델: 2개 latent dimension으로 연속 대칭성 깨짐 캡처

### 재구성 손실(Reconstruction Loss) = 보편적 상전이 식별자
- 질서 있는 상(ordered phase): 재구성 정확도 높음 → loss 낮음
- 무질서 상(disordered phase): 재구성 정확도 낮음 → loss 높음
- **임계 온도 $T_c$에서 재구성 손실의 급격한 변화 관찰**
- Hamiltonian이나 질서 변수에 대한 사전 정보 **전혀 없이** 상전이 탐지 가능

## 관련 물리 모델

### 2D Ising Model ($L=28$, $N=784$)
- Hamiltonian: $H = -J \sum_{\langle i,j \rangle} s_i s_j$, $s_i \in \{\pm1\}$
- $T_c = 2.269$ (Onsager, 1944)
- $\mathbb{Z}_2$ 대칭성 → 1개의 latent param으로 완벽 표현

### 3D XY Model ($L=14$, $N=2744$)
- $\mathbf{s}_i \in \mathbb{R}^2$, $\|\mathbf{s}_i\| = 1$
- $T_c = 2.2017$, 연속 대칭성(U(1)) → 2개의 latent param 필요

## 의의
- **Hamiltonian이나 질서 변수에 대한 사전 정보 없이 상전이 탐지**
- 재구성 손실은 물리 모델에 무관한 **보편적 상전이 식별자**
- ML이 물리학의 새로운 현상 발견에 도움될 수 있음을 시사
- 향후: quantum spin liquid, topological phases 등 미지의 상전이 탐지 가능성

## References
- S.J. Wetzel. "Unsupervised learning of phase transitions: from principal component analysis to variational autoencoders", *Physical Review E 96*, 2017
- [[variational-autoencoder]] — VAE가 상전이 탐지에 사용된 핵심 도구
- [[universal-approximation-theorem]] — 신경망이 물리적 함수를 근사하는 이론적 토대
- [[variational-autoregressive-networks]] — 통계역학에서 변분 자동회귀 네트워크
- J. Carrasquilla, R.G. Melko. "Machine learning phases of matter", *Nature Physics 2017* (동시대 관련 연구)

## 추가 연구: VAE의 Ising 모델 통계 분포 및 상전이 분석 (2021)

David Yevick (University of Waterloo, 2021)는 VAE의 **Ising 모델 통계 분포 재현 능력**을 체계적으로 분석했다^[raw/papers/2104.06368v1.md].

### 핵심 발견

- **Decoder의 확률적 해석**: Decoder 출력을 확률적으로 해석하여 synthetic spin 구성을 생성
- **에너지-자화율 공간 분포**: 정성적으로 훈련 샘플과 유사하지만, 저차원 잠재 변수 공간에서 **스핀 간 상관관계가 억제**되어 에너지가 비물리적으로 높아짐
- **온도 의존성**: VAE가 학습한 분포의 온도별 특성이 상전이 탐지에 유용한 정보 제공
- **정성적 일치**: 오토인코더의 synthetic 출력 열역학적 특성이 정성적으로 훈련 데이터와 일치

### 의의

- VAE가 상전이를 탐지할 뿐만 아니라 **통계적 앙상블을 재생성**할 수 있음을 입증
- 잠재 변수 차원이 물리적 상관관계 재현의 정확도를 결정하는 중요한 하이퍼파라미터임을 발견
- ML 기반 lattice sampling 접근법([[conditional-normalizing-flow-lattice]], [[hierarchical-autoregressive-networks]])과 보완적 관계