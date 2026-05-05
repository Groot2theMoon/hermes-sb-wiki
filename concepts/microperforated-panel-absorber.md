---
title: "Microperforated Panel (MPP) Absorber"
created: 2026-05-05
updated: 2026-05-05
type: concept
tags: [mpp, microperforated-panel, helmholtz-resonator, low-frequency, acoustics]
sources: [raw/papers/maa98-microperforated-panel.md]
confidence: high
---

# Microperforated Panel (MPP) Absorber

## 개요

Microperforated Panel (MPP, 미세천공판) 흡음체는 판재에 **서브밀리미터(sub-mm) 크기의 미세 구멍**을 뚫어 구멍 내부의 점성 경계층(viscous boundary layer) 효과만으로 충분한 음향 저항(acoustic resistance)을 확보하고, 별도의 다공성 흡음재 없이 광대역 흡음을 구현하는 기술. Dah-You Maa가 1970년대에 이론을 정립하고 1998년 완전해(exact solution)를 제시.

기존 천공판(perforated panel, 구멍 직경 수 mm)은 자체 저항이 거의 없어 배후에 유리면/암면 등의 다공성 재료가 필수였으나, MPP는 구멍 직경을 0.1-1.0 mm 수준으로 축소하여 구멍 자체의 점성 저항으로 흡음 가능.

## Maa 이론

### 기본 원리

MPP는 **짧은 관(short tube) 다발**로 모델링. Rayleigh의 관 내 음파 전파 이론 + Crandall의 short tube 근사를 기반으로 구멍의 비음향 임피던스(specific acoustic impedance) 유도.

**Perforate constant (천공 상수):**

k = r₀ √(ωρ₀/η)

- r₀: 구멍 반경 (m)
- ω: 각주파수 (rad/s)
- ρ₀: 공기 밀도 (1.21 kg/m³)
- η: 공기 점성 계수 (≈ 1.8×10⁻⁵ Pa·s)
- **k ∝ (구멍 반경) / (점성 경계층 두께)** — MPP 설계의 핵심 무차원 파라미터

실용 설계식: k = d √(f/10) (d in mm, f in Hz)

### 임피던스 공식

단일 구멍의 정규화 임피던스:

Z₁ = (32ηt / d²) √(1 + k²/32) + j ωρ₀ t [1 + 1/√(9 + k²/2) + 0.85 d/t]

MPP 전체의 상대 음향 임피던스 (특성 임피던스 ρ₀c₀ 기준):

z = r + j ωm

여기서:
- r (상대 음향 저항) = (32ηt)/(σρ₀c₀ d²) · k_r
- ωm (상대 질량 리액턴스) = (ωt)/(σc₀) · k_m
- σ: 천공률 (perforation ratio, 구멍 면적 / 전체 면적)
- k_r: 저항 계수 (k의 함수, Fig. 1 참조)
- k_m: 질량 리액턴스 계수 (k ≈ 0.1-5 범위에서 거의 일정, 2% 이하 변동)
- t: 판 두께 (일반적으로 t ≈ d)

근사식의 최대 오차: k = 1-10 범위에서 약 6%. 실험과의 오차: 저음압에서 약 10% 이내 (100 dB 이상 비선형 보정 필요).

### 흡음 피크 (공진 조건)

MPP를 강체 벽면 앞에 공동(cavity, 깊이 D)과 함께 설치하면 MPP 흡음체 구성:

흡음률: α = 4r / [(1+r)² + (ωm - cot(ωD/c))²]

**공진 조건 (최대 흡음):** ωm - cot(ωD/c) = 0 → 최대 흡음률 α₀ = 4r/(1+r)²

공진 주파수 f₀에서의 조건:
- ω₀m = cot(ω₀D/c)
- 공동 깊이비: D/λ = (1/2π) · arctan(1/ω₀m) (k → 0에서 D/λ = 1/4)

**최대 흡음률:** r = 1일 때 α₀ = 1.0 (perfect absorption). 실제로는 r ≈ 2 부근에서 α₀ ≈ 0.89, r = 1에서 α₀ = 1.0이 가능하나 공진 조건 제약 존재.

## 설계 파라미터

### 1. 구멍 직경 (Hole diameter, d)

가장 중요한 설계 변수. 작을수록 k ↓, 대역폭 ↑, 저항 ↑.
- 일반적인 범위: 0.1-1.0 mm
- 광대역 흡음 목표: d = 0.1-0.3 mm (k < 1 필요)
- 중간 성능: d = 0.3-0.5 mm
- k < 0.5에서 최대 대역폭 구현 가능 (Fig. 4 참조)

**k 값의 영향:**
- k < 1: 광대역 가능 (대역폭 거의 최대)
- k = 1-2: 대역폭 급격히 감소
- k > 2: 협대역, 높은 r 무의미

### 2. 천공률 (Perforation ratio, σ)

r과 ωm을 결정:

σ = (32ηt · k_r) / (r · ρ₀c₀ · d²)

- 일반적 범위: 0.5-3%
- 정방 배열 기준 구멍 간격 b와의 관계: σ = (π/4)(d/b)², b = d√(π/(4σ))
- r을 높이려면 σ ↓ (구멍 수 줄임)

### 3. 판 두께 (Panel thickness, t)

보통 t ≈ d (거의 같음). t/d의 정확한 값은 k_r에 큰 영향 없음 (보정항 내에만 존재).

### 4. 공동 깊이 (Cavity depth, D)

공진 주파수 결정:
- D/λ = 1/4 (k → 0, 고전적 λ/4 공진기)
- k 증가에 따라 D/λ 감소 (동일 f₀에서 더 얇은 흡음체 가능)
- 예: k = 2, r = 2에서 D/λ ≈ 0.14

## 주파수 튜닝

### 대역폭 (Bandwidth)

반흡음 주파수 간의 비 B = f₂/f₁:

B = cot⁻¹(1-r) / cot⁻¹(1+r) ≈ (1+r)/(1-r) (g → 0 근사)

| r | α₀ | (f₂-f₁)/f₀ | f₂/f₁ |
|:-:|:--:|:----------:|:-----:|
| 1 | 1.00 | 1.41 | 5.78 |
| 2 | 0.89 | 1.59 | 8.76 |
| 3 | 0.75 | 1.69 | 11.82 |
| 4 | 0.64 | 1.75 | 14.91 |
| 5 | 0.56 | 1.79 | 18.02 |

- r ↑: 대역폭 ↑, 최대 흡음률 ↓ (흡음률과 대역폭의 trade-off)
- k ↑: 대역폭 ↓ (특히 k > 1에서 급격히 감소)

### 설계 예시 (Maa 1998)

**광대역 흡음체 (250-2000 Hz):**
- 요구 f₂/f₁ = 8 → Fig. 4에서 k = 1.25, r ≈ 2 선택
- f₀ = 760 Hz (f₀/f₁ = 3.05)
- d = t = 0.144 mm, σ = 0.52%, b = 1.77 mm
- D = 0.064 m (D/λ = 0.14)
- α₀ = 0.88

**제작 용이 버전 (125-1000 Hz):**
- d = t = 0.2 mm, b = 2.5 mm, D = 0.12 m
- f₀ = 380 Hz
- 초미세 구멍(0.144 mm) 대신 0.2 mm로 완화

### 난반사 음장 (Diffuse Field)

경사 입사 시:
- MPP 자체 임피던스 불변 (국소 반응 가정)
- 공동 임피던스: (1/j cosθ) · cot((ωD/c)cosθ)
- 공진 주파수: 1/cosθ 배 증가 → 고주파 shift + 대역 확장
- cot 곡선의 다중 분기로 인해 다중 흡수 대역 형성 → 확산 음장에서 광대역 성능 향상

## 장점

- **별도 흡음재 불필요:** 다공성 재료(유리면, 암면) 없이 자체 저항으로 흡음 → 청결, 내환경성 우수
- **예측 정확도 높음:** 임피던스 이론이 정확(오차 < 10% 저음압 조건)
- **재질 자유도:** 판지, 플라스틱, 합판, 금속 등 어떤 재질로도 제작 가능
- **표면 마감/장식 자유로움:** 미적 요구 충족
- **넓은 대역폭:** 최대 3-4 옥타브 가능 (이론상), 단일 공진기 중 최고
- **저주파 흡음:** λ에 비해 얇은 공동(λ/7 이하)으로 저주파 흡음 가능

## 단점

- **초미세 구멍 가공의 어려움:** d = 0.1-0.3 mm의 미세 구멍 제조 기술 필요 (레이저 드릴링, MEMS 등)
- **고음압 비선형성:** 100 dB 이상에서 제트 형성으로 단부 보정 필요 (비선형 보정항 추가)
- **협대역 위험:** k가 커지면 급격히 협대역화 (k > 2에서는 거의 단일 공진)
- **이중 공진기 필요:** 4옥타브 이상 대역 확장을 위해 2중 MPP (tandem, double layer) 설계 필요
- **고음압용 단부 보정의 불확실성:** 선형/비선형 단부 보정이 단순 가산되지 않음

## 참고 문헌

- Maa, D.-Y. (1998). Potential of microperforated panel absorber. *J. Acoust. Soc. Am.*, 104(5), 2861-2866.
- Maa, D.-Y. (1975). Theory and design of microperforated-panel sound-absorbing construction. *Sci. Sin.*, XVIII, 55-71.
- Maa, D.-Y. (1987). Microperforated Panel wide-band absorber. *Noise Control Eng. J.*, 29, 77-84.
- Zwikker, C. & Kosten, C.W. (1949). *Sound Absorbing Materials*. Elsevier.

## Wikilinks

- [[low-frequency-absorption-technologies-comparison]] — LF 흡음 기술 비교
- [[delany-bazley-miki-empirical-models]] — 다공성 재료 경험적 모델
