---
title: "Bouc-Wen in Estimator/Filter Research Landscape"
created: 2026-05-09
updated: 2026-05-09
type: concept
tags: [filtering, kalman-filter, bouc-wen, hysteresis, state-estimation, research-landscape]
sources: [raw/papers/phylstm-bouc-wen.md]
confidence: high
---

# Bouc-Wen Hysteresis in Estimator/Filter Research

Bouc-Wen hysteresis 모델이 **estimator/filter 연구** 맥락에서 어떻게 활용되어 왔는지 종합 정리. RIGOR 프로젝트의 Bouc-Wen $z$ 추정 문제 positioning을 위한 landscape 분석.

---

## 🎯 Executive Summary

Bouc-Wen 모델은 30년 이상 filter 연구의 testbed로 사용되어 왔으나, 대부분 **parameter identification**에 집중. Differentiable SR-UKF + neural sigma point conditioning을 Bouc-Wen에 적용한 사례는 **현재까지 단 한 건도 없음** — RIGOR가 완전히 새로운 패러다임.

---

## 💡 계열별 분석

### 계열 1: Classical Kalman Filtering for Bouc-Wen Parameter ID

Bouc-Wen 파라미터($A, \alpha, \beta, \gamma, n$)를 augmented state에 포함시켜 EKF/UKF로 joint state-parameter estimation. **내부 상태 $z$를 직접 추정하지는 않음.**

| Paper | Filter | 목적 | State Est.? |
|-------|--------|------|:----------:|
| Li & Wang (2021) | Constrained EKF | Parameter ID (differentiable BW) | ❌ param only |
| Sen & Bhattacharya (2015) | Adaptive EKF/UKF | Parameter ID | ❌ param only |
| Kim (2020) | Constrained UKF | Parameter ID (LLRE force-displacement) | ❌ param only |
| Tao, Li & Ma | Joint EKF+UKF | Decentralized param ID | ❌ param only |

### 계열 2: Neural/Hybrid Dynamics Learning (Bouc-Wen Testbed)

| Paper | Method | Filter 구조? |
|-------|--------|:----------:|
| Liu, Lai & Chatzi (SHM 2021) | Physics-guided Deep Markov Model | ❌ pure generative |
| Zhang, Liu & Sun (CMAME 2020) [6] | Physics-informed Multi-LSTM (PhyLSTM[2]/[3]) | ❌ metamodeling |
| Liu, Lai, Bacsa & Chatzi (2022) | Neural EKF (general structural) | ✅ EKF 구조 (Bouc-Wen 미테스트) |
| Jeon, Kwon & Song (EESD 2025) | Physics-encoded LSTM (Bouc-Wen emulation) | ❌ pure DL |

#### ⭐ PhyLSTM (Zhang, Liu & Sun, 2020) — Bouc-Wen 상세

이 논문은 **Section 4 전체**를 SDOF Bouc-Wen hysteresis model metamodeling에 할당. RIGOR 관점에서 중요한 발견:

- **Filter 구조 없음** — 순수 LSTM 기반 metamodel (predictive, not filtering/assimilative)
- **PhyLSTM[3]** (triple-LSTM)가 rate-dependent hysteresis에 가장 강력: worst-case $\gamma = 0.77$, best-case $\gamma \approx 0.99$
- **Latent hysteretic variable $r$** (restoring force)를 physics-constrained LSTM으로 추정 — 여기서는 $r$이 fully observed training data로 학습되지만, filter framework에서는 관측되지 않음
- **RIGOR와의 차이점:**
  - PhyLSTM: offline 학습, batch prediction (15개 training + 50개 collocation → 85개 test)
  - RIGOR: **online recursive filtering** (time step마다 update)
  - PhyLSTM: **displacement $u$ 예측**이 목적
  - RIGOR: **internal state $z$ + full state 추정**이 목적
  - **공통점:** "latent hysteretic variable" 예측의 motivation이 유사

**Parameters:** m=500kg, c=0.35kNs/m, k=25kN/m, α=2, β=2, n=3. Natural freq: 1.13Hz.

### 계열 3: Theoretical Core — Grothe (2012) HOC-UKF

[[higher-order-correlation-ukf]] — Bouc-Wen $z$ 추정 불가능의 **근본 원인 규명**:
- $P_{xy} \approx 0$ → Kalman gain $K_z \approx 0$ → $z$ 추정 불가
- 해결책: **3차/4차 moment matching (HOC-UKF)**으로 $z^2$-$y$ correlation 활용

### 계열 4: Particle Filter + Bouc-Wen
- Columbia (Smyth group): 강진 기록 data assimilation
- Non-differentiable, high cost → RIGOR 방향과 상이

---

## 🔍 Gap Analysis & RIGOR Positioning

| Gap | 설명 | RIGOR의 기회 |
|-----|------|:-----------:|
| **G1** Differentiable SR-UKF + Bouc-Wen | Bouc-Wen을 differentiable UKF의 end-to-end testbed로 사용한 연구 없음 | ✅ RIGOR가 최초 |
| **G2** Neural sigma point conditioning | $z$ 추정 위해 sigma cloud + NN conditioning 시도한 연구 없음 | ✅ UFI 접근법이 새로운 패러다임 |
| **G3** Grothe vs Neural 비교 | HOC-UKF와 neural approaches의 직접 비교 없음 | ✅ UFI 성능을 theoretical bound와 비교 가능 |
| **G4** Bouc-Wen + UKF + JAX AD | JAX 기반 AD 가능 UKF + Bouc-Wen 적용 없음 | ✅ RIGOR만의 기술 스택 |
| **G5** Joint param ID + state est. | Parameter ID와 z state estimation 동시 수행하는 differentiable filter 없음 | ✅ UFI가 모두 추정 가능 |

---

## 🚀 RIGOR 검증 Benchmark로서의 Bouc-Wen

Bouc-Wen이 RIGOR 검증에 가장 적합한 이유:

1. **$z$의 $P_{xy} \approx 0$ 문제** — 표준 UKF가 실패하는 가장 깔끔한 toy problem
2. **Grothe (2012)의 이론적 bound 존재** — UFI가 information-theoretic bound를 얼마나 극복하는지 정량적 비교 가능
3. **비선형성 강도 조절 가능** — $\alpha, \beta, \gamma, n$ 파라미터로 hysteresis 강도 조절
4. **실험 데이터 존재** — 다수의 논문에서 검증된 dynamics

**핵심 질문:** *Can neural sigma-point conditioning (UFI + TE/ISAB) learn the higher-order correlations that Grothe's HOC-UKF captures analytically?*

---

## 참고 문헌

1. Li, D. & Wang, Y. (2021). Parameter identification of a differentiable Bouc-Wen model using constrained extended Kalman filter. *Structural Health Monitoring*, 20(1), 360-378.
2. Sen, D. & Bhattacharya, B. (2015). Adaptive nonlinear Kalman filtering technique for parameter identification: an application to Bouc-Wen model.
3. Kim, S.-Y. (2020). Constrained Unscented Kalman Filter for Structural Identification of Bouc-Wen Hysteretic System.
4. Tao, D., Li, H. & Ma, Q. Decentralized identification of nonlinear structure under strong ground motions: Joint EKF and UKF with Bouc-Wen model.
5. Liu, W., Lai, Z. & Chatzi, E. (2021). A Physics-Guided Deep Learning Approach to Modeling Nonlinear Dynamics: A Case Study of a Bouc-Wen System. *SHM Conference*.
6. Zhang, R., Liu, Y. & Sun, H. (2020). Physics-informed multi-LSTM networks for metamodeling of nonlinear structures. *CMAME*, 369, 113226. arXiv:2002.10253.
7. Liu, W., Lai, Z., Bacsa, K. & Chatzi, E. (2022). Neural Extended Kalman Filters for Learning and Predicting Dynamics of Structural Systems. arXiv:2210.04165.
8. Jeon, J., Kwon, O.-S. & Song, J. (2025). Unified Hysteresis Modeling via Physics-Based Deep Learning and Data Augmentation. *Earthquake Engineering & Structural Dynamics*.
9. Grothe, O. (2012). A higher order correlation unscented Kalman filter. *Applied Mathematics and Computation*, 219(5), 2534-2547.

---

## Wikilinks
- [[higher-order-correlation-ukf]]
- [[rigor-sigma-point-research]]
- [[rigor-research-roadmap]]
- [[rigor-filter]]
- [[bouc-wen-dl-parameter-estimation]]
- [[neural-ekf-structural-systems]]
