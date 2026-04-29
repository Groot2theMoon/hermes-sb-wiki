---
title: GRU-D — Gated Recurrent Unit with Missingness Patterns for Time Series
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [model, sequence-modeling, learning, neural-network, healthcare]
sources: [raw/papers/rnn-missing-values-timeseries.md]
confidence: high
---

# GRU-D (GRU with Missingness)

Che, Purushotham, Cho, Sontag, Liu (2018)이 제안한 **missing value가 있는 multivariate time series를 위한 GRU 변형**. Missing 패턴 자체가 label과 상관관계가 있다는 **"informative missingness"** 를 활용하여, 단순 imputation보다 더 나은 예측 성능을 달성한다.

## 동기

의료 데이터 (EHR)는 **missing value가 매우 흔함**:
- 환자가 특정 검사를 받지 않은 이유 자체가 정보 (informative missingness)
- 기존 방법: 단순 imputation (평균 대체, interpolation) → missing pattern 무시
- GRU-D의 핵심: **masking + time interval**을 GRU 구조에 통합

^[raw/papers/rnn-missing-values-timeseries.md]

## 핵심 아이디어: 3가지 Missingness Representation

### 1. Masking (m_t)
```
m_t^d = 1 if x_t^d is observed, 0 if missing
```

- 어떤 변수가 관측되었는지 여부 자체를 feature로 사용
- m_t의 패턴 자체가 target label과 correlated

### 2. Time Interval (δ_t)
```
δ_t^d = time since last observation of variable d
```

- 최근에 측정된 변수 vs 오래전에 측정된 변수 — 신뢰도 차이
- δ가 작을수록 최신 정보, δ가 클수록 uncertainty 증가

### 3. Missing Rate (γ)
```
γ^d = (total missing of d) / (total timesteps)
```

- 환자별/변수별 missing rate → patient-specific baseline

## GRU-D 구조

기존 GRU에 **decay mechanism**을 추가:

**① Input decay:**
```
x_t^d ← m_t^d · x_t^d + (1 - m_t^d) · γ_{x_t}^d · x_prev^d
```
- 관측된 값: 그대로 사용
- 결측된 값: **이전 관측값을 시간 간격에 따라 decay시켜 대체**

**② Hidden state decay:**
```
ĥ_{t-1} ← γ_h · h_{t-1}
```
- 정보가 오래될수록 hidden state의 영향력 감소
- γ_h = exp(-max(0, W_γ · δ_t + b_γ))

**③ GRU update (standard architecture에 decayed input + hidden 적용):**
```
r_t = σ(W_r · [ĥ_{t-1}, x_t, m_t] + b_r)
z_t = σ(W_z · [ĥ_{t-1}, x_t, m_t] + b_z)
ñ_t = tanh(W_n · [r_t ⊙ ĥ_{t-1}, x_t, m_t] + b_n)
h_t = (1 - z_t) ⊙ ĥ_{t-1} + z_t ⊙ ñ_t
```

## 성능

| Dataset | Task | GRU-D vs Baseline |
|---------|------|-------------------|
| **MIMIC-III** (ICU) | 사망 예측 | GRU-D가 GRU, GRU-simple, imputation-based 모두 outperform |
| **PhysioNet** | 심혈관 예측 | State-of-the-art |
| **Synthetic** | 결측률 변화 실험 | Missing rate ↑ → GRU-D의 우위 ↑ |

## 의의

1. **Informative missingness** 개념을 처음으로 RNN 구조에 내장
2. **Decay mechanism**: 시간에 따른 정보의 신뢰도 감소를 자연스럽게 모델링
3. **Two-step (imputation → prediction)이 아닌 end-to-end 학습**
4. MIMIC-III 벤치마크에서 이후 많은 논문의 baseline으로 사용

## 관련 페이지

- [[deep-kalman-filter]] — DKF도 EHR counterfactual inference로 temporal modeling
- [[square-root-unscented-kalman-filter]] — 고전적 state estimation
- [[kyunghyun-cho]] — GRU 공동 창시자 (Cho et al. 2014), 본 논문 공동 저자
- [[david-sontag]] — (예정) MIT 의료 AI, 두 논문 모두 공동 저자

## References

- Che, Z., Purushotham, S., Cho, K., Sontag, D., & Liu, Y. (2018). Recurrent Neural Networks for Multivariate Time Series with Missing Values. *Scientific Reports*, 8, 6085. doi:10.1038/s41598-018-24271-9
