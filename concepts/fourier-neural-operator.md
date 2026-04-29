---
title: Fourier Neural Operator (FNO)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, neural-network, fluid-dynamics, CFD, surrogate-model, mathematics, paper]
sources: [raw/papers/2010.08895v3.md, raw/papers/trending/2026-04-28-03.md]
confidence: high
---

# Fourier Neural Operator

## 개요

**Fourier Neural Operator (FNO)** 는 [[zongyi-li|Zongyi Li]], Nikola Kovachki, Kamyar Azizzadenesheli, Burigede Liu, [[kaushik-bhattacharya|Kaushik Bhattacharya]], [[andrew-stuart|Andrew Stuart]], [[anima-anandkumar|Anima Anandkumar]] ([[caltech|Caltech]])이 제안한 **함수 공간 간 매핑을 학습하는 신경 연산자(neural operator)** 이다^[raw/papers/2010.08895v3.md]. 적분 커널을 **Fourier 공간에서 직접 매개변수화**하여 PDE 계열 전체를 학습한다.

## 기존 방법과의 차별성

| 방법 | 특성 | 한계 |
|------|------|------|
| **Finite-dimensional operators** | CNN 등 discretization 의존 | 해상도 변경 시 재학습 필요 |
| **Neural-FEM (PINN)** | 함수 자체를 NN으로 매개변수화 | 새 파라미터마다 재학습 |
| **FNO** | 함수 공간 간 operator 학습 | 한 번 학습으로 모든 인스턴스 해결 |

## FNO 아키텍처

### 핵심: Fourier Layer

Fourier layer에서는 다음 연산을 수행:

1. **입력** $v(x)$를 Fourier 변환 $\mathcal{F}$
2. **저주파 모드만 선택적 유지** (truncation)
3. **Fourier 공간에서 선형 변환** $R_\theta$ 학습
4. **역 Fourier 변환** $\mathcal{F}^{-1}$
5. **Residual connection** + 비선형 활성화

$$(\mathcal{K}(v))(x) = \mathcal{F}^{-1}(R_\theta \cdot \mathcal{F}(v))(x)$$

### 장점
- **Zero-shot super-resolution**: 낮은 해상도로 학습 → 높은 해상도 평가 가능
- **Mesh-invariant**: 그리드 독립적
- **O(1) 평가**: 새 파라미터에 대해 단일 forward pass
- **FFT 활용**: 효율적인 연산 ($O(n \log n)$)

## 수치 실험

| 문제 | 성능 |
|------|------|
| Burgers' 방정식 | SOTA 대비 우수 |
| Darcy flow (2D) | 높은 정확도 |
| **Navier-Stokes (난류)** | **첫 ML 기반 성공적 모델링** |
| Zero-shot super-resolution | 64×64 → 256×256 해상도 전이 성공 |

속도: 기존 PDE 솔버 대비 **최대 1000배 빠름**.

## References

- Z. Li et al., "Fourier Neural Operator for Parametric Partial Differential Equations", *ICLR 2021*
- [[physics-informed-neural-networks]] — PINN (Neural-FEM 접근법)
- [[pseudo-hamiltonian-neural-networks]] — 구조 보존 신경망
- [[pinn-high-speed-flows]] — PINN for Euler equations

## 최신 응용: 부유식 해상 풍력 터빈(FOWT) 후류 예측

Dong, Qin, Xu (2026)는 FNO와 PINN을 최초로 FOWT 후류 예측에 적용하여 비교했다^[raw/papers/trending/2026-04-28-03.md]. 주요 결과:

- **FNO**는 PINN 대비 약 8배 빠른 훈련 속도
- **고주파 난류 구조**: FNO는 Strouhal 고조파(2St, 3St)까지 포착, PINN은 low-pass filter 역할
- **Wake meandering**: FNO가 large/small-scale coherent structure 모두 정확 재현
- PINN은 시공간적으로 과도하게 평활화된(smooth) 후류 생성

→ [[wind-energy-ml]] — 풍력 에너지 AI 응용 상세
→ [[ai-hallucination-physics]] — PINN smoothness의 spectral bias 문제와 연결
- [[nvidia]]
- [[fno-vs-deeponet-vs-kan]]
