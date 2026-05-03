---
title: "FFT-Based Homogenization for Composites — Willot Discretization & 3D Fibrous"
created: 2026-05-03
updated: 2026-05-03
type: concept
tags: [fft-homogenization, composites, willot-discretization, micromechanics, fibrous-materials, computational-homogenization]
sources:
  - raw/papers/willot15-fourier-fft-homogenization.md
  - raw/papers/karakoc-3d-fibrous-homogenization.md
confidence: high
---

# FFT-Based Homogenization for Composites — Willot Discretization & 3D Fibrous Homogenization

## 개요

FFT 기반 균질화(Fourier-based homogenization)는 Moulinec & Suquet (1994)가 제안한 이후 복합재료의 유효 물성 계산에 널리 사용되어 왔다. 이 방법은 **voxel 기반 미세구조 이미지를 직접 입력**으로 사용하며, **Lippmann-Schwinger 방정식**을 푸는 반복적 scheme을 통해 국소 응력/변형률 장과 유효 물성을 계산한다.

본 페이지는 두 가지 중요한 발전을 다룬다:
- **Willot (2015)** — 회전 격자(rotated grid) 기반 **Willot discretization (Gʀ)** 을 통한 국소장 정확도 및 수렴 속도 향상
- **Karakoc (2020)** — 3D 섬유 재료에 대한 **계산 균질화 프레임워크** (약 주기성 + Euclidean bipartite matching)

## Willot Discretization (Willot 2015)

### 배경

기존 FFT scheme의 문제점:
- **G** (Moulinec-Suquet 표준) — 계면에서 spurious oscillation, 고대비에서 느린 수렴
- **Gᴄ** (centered difference) — checkerboard 패턴, L이 짝수일 때 특이점
- **Gᴡ** (forward-backward) — 비대칭성, 대칭성을 깨는 field

### Rotated Scheme (Gʀ)

Willot (2015)는 **45° 회전 격자**에서 centered difference를 사용한 새로운 Green operator **Gʀ**를 제안:

- 변위장: **픽셀의 4개 꼭짓점**에서 평가
- 변형률/응력장: **픽셀 중심**에서 평가
- 2D: rotated basis (**f₁, f₂**)에서 centered discretization
- 3D: voxel 중심 + 모서리에서의 차분으로 자연 확장

**kʀ** 벡터 (2D):
```
kʀ(q) = i·[cos(q₁/2)·sin(q₂/2), sin(q₁/2)·cos(q₂/2)]
```

### 성능 비교

| 특성 | G (표준) | Gᴄ | Gᴡ | Gʀ (Willot) |
|:----|:----|:----|:----|:----|
| **Interface oscillation** | 심함 | 있음 | 적음 | **거의 없음** |
| **대칭성** | O | O | **X** (비대칭) | **O** |
| **공극(χ=0) 수렴** | 느림 (~1300 iter) | 빠름 | 빠름 | **가장 빠름 (~168 iter)** |
| **고대비(χ≫1) 수렴** | √χ scaling | √χ | √χ | **가장 빠름** |
| **유효 물성 정확도** | 낮음 | 중간 | 중간 | **가장 높음** |

### 수렴 속도

- **직접 scheme (DS)** — χ ≪ 1에서 DSʀ이 가장 빠름, χ ≫ 1에서도 DSʀ 우세
- **가속 scheme (AS)** — ASʀ이 porous(χ=0)에서 168 iterations 이내 수렴 (AS는 ~1300)
- **최적 reference** — ASʀ: E₀ = √(E₁E₂) for χ < 1 plateau

### 결론

**Gʀ는 FFT 균질화에서 가장 정확하고 빠른 discretization**으로, augmented Lagrangian 등 다른 solver와도 호환된다. 국소장 정확도의 향상은 계면 근처에서 특히 중요하며, 이는 대변형, 손상 등 복잡한 문제로의 확장에 필수적이다.

## 3D Fibrous Computational Homogenization (Karakoc 2020)

### 길이 스케일 분류

| 스케일 | 대상 | 특징 |
|:----|:----|:----|
| **Micro** | 개별 섬유 | 공간/형태/물성 (곡률, 길이, 단면), 섬유 간 bonding (cohesive zone model) |
| **Meso** | 섬유 네트워크 | RVE, 체적 분율, 방향성 분포, 섬유 침착 알고리즘 |
| **Macro** | 섬유 재료 | 연속체, 유효 물성 |

### 약 주기성 (Weak Periodicity)

CT 재구성 도메인 등 **비주기적·비정합 메시**에 대해 Karakoc는 약 주기성 경계 조건 + **Euclidean bipartite matching**을 적용:

1. 제어 노드 집합 **q** 정의 (∂Γ 상)
2. 경계 노드 집합 **p**와 **q** 간 Euclidean distance 최소화:
   ```
   T = min_{permutations P} Σ d(p, P(q))
   ```
3. 최적 permutation에 따라 kinematic coupling
4. Hill-Mandel 조건: σᴹ = ⟨σᵐ⟩ (volume average)

이 방법으로 비정합 메시 RVE에서도 정확한 균질화가 가능하다.

### Case Study: 섬유 체적 분율 & 방향성

- **Δθ 증가** (무작위성 증가) → in-plane 등방성 증가
- **Vf 증가** → in-plane 탄성계수, 전단계수 증가
- **EZ (out-of-plane)** — Δθ, Vf 모두에 둔감 (Z축 방향 하중은 네트워크 밀집화에 영향 없음)

## 관련 개념

- [[fft-homogenization-polymer-composites]] — FFT 균질화 기본 (Moulinec-Suquet, polarization scheme)
- [[deep-material-network]] — DMN: FFT 균질화의 surrogate model, FFT로 training data 생성
- [[porous-nonwoven-homogenization]] — 다공성 부직포 재료의 균질화 (Kuts 2024, Wan 2024)
- [[poroelastic-dmn-research]] — DMN 포로탄성 확장에서 FFT training data 검토
- [[francois-willot]] — François Willot (Mines ParisTech, FFT homogenization)

## References

- Willot, F. (2015). "Fourier-based schemes for computing the mechanical response of composites with accurate local fields." *Comptes Rendus Mécanique*, 343(3), 232–245.
- Moulinec, H. & Suquet, P. (1994). "A fast numerical method for computing the linear and nonlinear mechanical properties of composites." *C. R. Acad. Sci. Paris II*, 318, 1417–1423.
- Karakoc, A. (2020). "Computational homogenisation of three-dimensional fibrous materials." In *Mechanics of Fibrous Networks*, Elsevier.
- Willot, F., Abdallah, B. & Pellegrini, Y.-P. (2014). "Fourier-based schemes with modified Green operator for computing the electrical response." *Int. J. Numer. Meth. Engng.*, 98(7), 518–533.
