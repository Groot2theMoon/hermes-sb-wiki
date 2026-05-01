---
title: GMT — Geometric Multigrid Transformer for Microstructure Homogenization
created: 2026-05-02
updated: 2026-05-02
type: concept
tags: [neural-operator, materials, surrogate-model, transformer, homogenization]
sources: []
confidence: medium
---

# GMT — Geometric Multigrid Transformer for Microstructure Homogenization

## 개요

Xing, Liu, Xue, Lu (2026, **SIGGRAPH 2026**)가 제안한 **GMT (Geometric Multigrid Transformer)**는 Point Transformer V3를 Geometric Multigrid (GMG) 계층 구조에 정렬하여 격자 메타물질(lattice metamaterial) 균질화(homogenization)를 위한 고정밀 신경 solver를 구현한다.

## 핵심 아이디어

### 구조적 설계
- Point Transformer V3를 sparse GMG hierarchy에서 작동하도록 재구성
- 장거리 의존성(long-range dependencies)과 교차 수준 상호작용(cross-level interactions) 포착
- 물리-인식 위치 인코딩으로 주기적 경계 조건(periodicity) 엄격 적용

### 성능
- 단일 GMG V-cycle refinement만으로 수렴 도달
- **$10^{-5}$** 상대 잔차 오차 달성
- 동등 정확도에서 최신 GPU 기반 solver 대비 **160× 속도 향상**
- $512^3$ 고해상도에서도 확장 가능

### 검증 범위
- 기계적(mechanical) 및 열적(thermal) 도메인 검증
- 보이지 않는 형상 및 비주기적 설정에서 강건한 일반화
- 실시간 설계 반복, 다중 스케일 시뮬레이션, 고처리량 재료 발견에 적용 가능

## 연결점
- [[deep-material-network]] — 동일 균질화 문제를 다른 접근법으로 해결
- [[fourier-neural-operator]] — 다른 neural operator 계열 방법론
- [[transformer]] — Transformer 기반 신경 구조 설계
- [[physics-informed]] — 물리 제약 조건(PBC, multigrid)을 신경망에 통합

## References
- arXiv:2604.26518 — "GMT: A Geometric Multigrid Transformer Solver for Microstructure Homogenization" (SIGGRAPH 2026)
