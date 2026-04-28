---
title: Flow-based MCMC for Lattice Field Theory
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [neural-network, model, physics-informed, surrogate-model, paper]
sources: [raw/papers/1904.12072v3.md]
confidence: high
---

# Flow-based MCMC for Lattice Field Theory

## 개요

**Flow-based MCMC**는 Albergo, Kanwar, Shanahan (MIT/Perimeter, 2019)이 제안한 방법으로, **normalizing flow (real NVP)**를 proposal distribution으로 사용하는 Metropolis-Hastings 알고리즘으로 lattice field theory의 샘플링 문제를 해결한다^[raw/papers/1904.12072v3.md]. **Autocorrelation time을 체계적으로 개선** 가능한 최초의 flow 기반 lattice sampler.

## 핵심 아이디어

### Normalizing Flow Proposal
- Prior $r(z)$ (simple distribution) → bijective map $f^{-1}$ → proposal $\\tilde{p}_f(\\phi)$
- **Real NVP** (Dinh et al., 2016): affine coupling layers로 구성, tractable Jacobian
- Change-of-variables: $\\tilde{p}_f(\\phi) = r(f(\\phi)) \\left| \\det \\frac{\\partial f(\\phi)}{\\partial \\phi} \\right|$

### Independence Metropolis-Hastings
- 각 제안 $\\phi' \\sim \\tilde{p}_f(\\phi)$ 는 이전 상태와 **독립적**
- Accept probability: $A(\\phi^{(i-1)}, \\phi') = \\min\\left(1, \\frac{\\tilde{p}(\\phi^{(i-1)}) p(\\phi')}{p(\\phi^{(i-1)}) \\tilde{p}(\\phi')}\\right)$
- $\\tilde{p}_f = p$ 일 때 acceptance rate = 1, autocorrelation = 0

### Self-training (Reverse KL)
- Shifted KL divergence 최소화:
  $$L(\\tilde{p}_f) = \\mathbb{E}_{\\phi \\sim \\tilde{p}_f}[\\log \\tilde{p}_f(\\phi) + S(\\phi)]$$
- **기존 샘플 불필요** — model이 스스로 생성한 샘플로 학습
- Lower bound: $-\\log Z$ (true partition function)

## 결과: $\\phi^4$ Theory

| Ensemble | $L$ | Acceptance | $\\tau_{\\text{int}}$ (magnetization) |
|----------|-----|-----------|--------------------------------------|
| HMC | 14 | - | 높음 (critical slowing down) |
| Flow-based | 14 | ~70% | **크게 감소** |

- Acceptance rate와 autocorrelation time의 **직접적 상관관계** 확인
- Loss 최소화 → acceptance 증가 → autocorrelation 감소
- **Critical slowing down 제거**: training cost로 CSD를 대체

## 장점
1. **Autocorrelation time을 체계적으로 개선** 가능 (training으로)
2. 각 step: model evaluation + action computation만 필요
3. **제안을 병렬 생성** 가능
4. **Self-training** — 기존 MCMC 샘플 불필요

## 관련 연구
- 현대 lattice QCD 및 통계역학 시뮬레이션에 적용 확장 중
- GAN 기반 방법보다 **정확한 likelihood 계산**이 가능하여 MH step에 직접 활용

## References
- M.S. Albergo, G. Kanwar, P.E. Shanahan. "Flow-based generative models for Markov chain Monte Carlo in lattice field theory", *Phys. Rev. D* 2019
- [[gan-lattice-simulations]] — GAN 기반 overrelaxation (대안적 접근)
- [[variational-autoregressive-networks]] — Autoregressive network 기반 통계역학