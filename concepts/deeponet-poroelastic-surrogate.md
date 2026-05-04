---
title: "DeepONet for Poroelastic Surrogate Modeling — Random Permeability Fields"
created: 2026-05-03
updated: 2026-05-04
type: concept
tags: [paper, deeponet, surrogate-model, poroelasticity, operator-learning, dmn, neural-operator, uncertainty]
sources: [raw/papers/park25-deeponet-poroelastic.md]
confidence: medium
---

# DeepONet for Poroelastic Surrogate Modeling — Random Permeability Fields

## 개요

Park, Shin & Choo (2025, arXiv:2509.11966)는 **[[deeponet|DeepONet]]**을 이용하여 random permeability field → transient poroelastic 응답의 **solution operator mapping**을 학습하는 surrogate modeling 프레임워크를 제안했다. ^[raw/papers/park25-deeponet-poroelastic.md]

핵심 특징:
- **Operator learning** 방식으로 permeability field realization → displacement/pressure field 직접 예측
- **Nondimensionalization**: governing equation의 수치적 안정성 향상
- **Karhunen–Loève (K–L) expansion**: 입력 차원 축소 (permeability field → 저차원 계수)
- **Two-step training**: branch/trunk network 분리 최적화로 학습 안정성 개선
- FEM 대비 **수 배에서 수백 배 속도 향상** (crossover threshold ~8,000–9,000 샘플)

## 문제 정의

### Poroelasticity (u–p Formulation)

Biot의 포로탄성 이론 — coupled fluid flow + elastic deformation:

- Primary variables: solid displacement **u**, excess pore pressure *p*
- Permeability *k*(**x**; ω) is modeled as **log-normal random field**: κ = ln(*k*) ~ Gaussian
- Governing: momentum balance (∇·σ' + ρ_b**g** = 0) + mass conservation (∇·**q** + ∂ζ/∂t = 0)
- Constitutive: σ' = **C**ᵉ:ε (linear elasticity), **q** = -(*k*/μ_f)·∇p (Darcy)

### Operator Learning Target

Solution operator G: k(**x**; ω) → f(**x**, *t*; ω)

여기서 f ∈ {u_x, u_z, p} — 각각에 대해 별도의 DeepONet 학습.

## DeepONet 프레임워크

### 3-Stage 전략

1. **Nondimensionalization**: 특성 시간/길이/투과율/하중 스케일 도입 → *T_*_*, s_*_*, k_*_*, u_*_*, p_*_*
   - Terzaghi consolidation 기준: t_* = t₀ (reference stress), c_v (coefficient of consolidation) 등
   - 목적: 파라미터 간 scale disparity 제거, generalizability 향상

2. **K–L Expansion 차원 축소**:
   - κ(**x**; ω) = μ_κ + Σⱼ √λⱼ · eⱼ(**x**) · ξⱼ(ω)
   - Truncation: 첫 M개 모드만 유지 (M ~ 20–60)
   - 최적 truncation: validation RMSE 기준 선정
     - Soil consolidation: M = 40 (u_z), M = 60 (p)
     - Ground subsidence: M = 20 (u_x, u_z, p)

3. **DeepONet Architecture + Two-Step Training**:
   - Branch net **c**(ξ^[M]; θ): K–L coefficients → latent coefficients (ℝ^M → ℝ^K)
   - Trunk net **ϕ**(**x**, *t*; μ): spatiotemporal coordinates → basis functions (ℝ^(d+1) → ℝ^(K-1), +1 constant basis)
   - Prediction: f^NN(**x**, *t*) = ⟨**c**(ξ^[M]), **ϕ**(**x**, *t*)⟩
   - Two-step: trunk 먼저 학습 (basis learning) → QR orthogonalization → branch 학습 (coefficient regression)

### Two-Step Training 상세

| 단계 | 내용 | 최적화 |
|:----|:-----|:------|
| 1. Trunk training | Trunk net **ϕ** + coeff matrix **A** 최소화 ∥**F** − **ΦA**∥² | AdamW + L-BFGS |
| 2. QR projection | **Φ*** = **Q*****R*** → projected targets **C**^*_proj = **Q**^*^T **F** | Post-processing |
| 3. Branch training | ∥**C**^*_proj − **C**(Ξ; θ)∥² 최소화 | AdamW + L-BFGS |

→ trunk이 먼저 좋은 basis를 찾고, branch는 그 basis에 대한 coefficient만 학습하면 되므로 최적화가 훨씬 쉬워짐.

## DMN과의 비교

| 측면 | [[deep-material-network|DMN]] | DeepONet (Park et al. 2025) |
|:----|:-----|:-----|
| **학습 대상** | 물리 building block 파라미터 (회전각, weight 등) | Operator: permeability → 응답 field |
| **물리 내장 방식** | **Architecture 내장** (laminate homogenization 해석해) | **Data-driven** (FEM 데이터로 학습) |
| **입력 차원** | Phase 강성 쌍 (저차원) | K–L coefficients (M ~ 20–60) |
| **출력** | Homogenized effective stiffness | **Full spatiotemporal field** |
| **비선형 확장** | Online Newton-Raphson (physical extrapolation) | 학습 범위 내 interpolation |
| **미세구조 표현** | Binary tree node = phase | Voxel-based permeability field |
| **계산 속도** | ~8100× DNS | ~10³–10⁴× FEM (추론) |
| **강점** | 비선형 extrapolation, 물리 일반화 | Full-field operator, 불확실성 전파 |
| **약점** | Full-field 출력 불가, topology 한정 | 외삽 성능 미보장, 데이터 의존 |

### 시너지 가능성

- **DMN + DeepONet Hybrid**: DMN이 저차원 물리 구조를 제공하고, DeepONet이 잔차(residual)를 full-field로 보정
- **DMN 훈련 데이터 생성**: DeepONet surrogate로 대량의 permeability realization → DMN 학습
- **DMN의 고정밀 검증**: DeepONet은 full-field 해를 제공하므로 DMN homogenization 정확도를 위치별로 평가 가능

## Benchmark Results

### Soil Consolidation

| 통계 (σ_κ, l_x, l_z) | u_z RMSE | p RMSE |
|:----------------------|:--------:|:------:|
| (1.5, 0.25, 0.125) | 3.83×10⁻² | 4.72×10⁻² |
| (0.5, 0.5, 0.25) | 1.38×10⁻³ | 4.10×10⁻³ |
| Crossover N_c | 8,442 | 9,246 |

### Ground Subsidence

| 통계 (σ_κ, l_x) | u_x RMSE | u_z RMSE | p RMSE |
|:---------------|:--------:|:--------:|:------:|
| (1.5, 0.125) | 1.85×10⁻² | 2.07×10⁻² | 2.64×10⁻² |
| (0.5, 0.5) | 4.60×10⁻³ | 2.50×10⁻³ | 4.88×10⁻³ |
| Crossover N_c | 9,351 (u_x+u_z) | 9,351 | 9,432 |

→ **High variance + short correlation length**에서 오차 증가 but 실용적 정확도 유지.

## 한계 및 향후 방향

| 한계 | 설명 | 개선 방향 |
|:----|:-----|:---------|
| **K–L truncation 한계** | 느린 spectral decay (exponential kernel)에 부적합 | Multi-resolution, wavelet basis |
| **고정 mechanical parameters** | E, ν 고정 → retraining 필요 | Multi-input operator networks |
| **단일 통계 설정** | (σ_κ, l_x, l_z)당 별도 DeepONet | 통계 파라미터를 추가 branch 입력으로 |
| **물리 제약 부재** | 물리 법칙 위반 가능성 | Physics-informed loss (PI-DeepONet) |
| **FEM 데이터 의존** | 학습 데이터 생성 비용 큼 | Self-supervised / weakly-supervised |

## 관련 개념

- [[deeponet]] — DeepONet 기본 아키텍처 (Lu Lu et al., 2019)
- [[deep-material-network]] — DMN: 물리 기반 multiscale surrogate
- [[thermoelastic-dmn]] — 열탄성 DMN (Shin 2024): poroelasticity-thermoelasticity correspondence 경유 연결
- [[poroelastic-dmn-research]] — 7×7 Acusto-Elastic DMN 연구 분석
- [[poroelasticity-thermoelasticity-correspondence]] — Norris (1992) 대응 정리
- [[fourier-neural-operator]] — FNO: 또 다른 neural operator 접근법
- [[surrogate-model]] — Surrogate modeling 일반
- [[physics-informed]] — PINN 패러다임
- [[fft-homogenization-polymer-composites]] — FFT 기반 균질화 (데이터 생성 대안)
- [[monotone-operator-equilibrium-networks]] — monDEQ: 수렴 보장 equilibrium network (operator learning의 또 다른 패러다임)

## References

- Park, S., Shin, Y., & Choo, J. (2025). Deep operator network for surrogate modeling of poroelasticity with random permeability fields. arXiv:2509.11966.
- Lu, L., Jin, P., & Karniadakis, G. E. (2021). DeepONet: Learning nonlinear operators for identifying differential equations based on the universal approximation theorem of operators. *Nat. Mach. Intell.*, 3, 218–229.
- Lee, S. & Shin, Y. (2024). On the training of DeepONet for operator regression. *J. Comput. Phys.*, 501, 112773.
- Wang, S., Wang, H., & Perdikaris, P. (2021). Learning the solution operator of parametric PDEs with physics-informed DeepONets. *Sci. Adv.*, 7(40), eabi8605.
