---
title: Variational Kolosov–Muskhelishvili Network for Elasticity and Fracture
created: 2026-05-11
updated: 2026-05-11
type: concept
tags: [paper, physics-informed, pinn, solid-mechanics, mechanics]
confidence: medium
sources: []
---

# Variational Kolosov–Muskhelishvili Network

## 개요
arXiv:2605.02310 (cs.CE, May 2026)은 **2D 선형 탄성 및 균열 문제**를 위한 새로운 PINN 프레임워크를 제안한다. Kolosov–Muskhelishvili (KM) 복소 포텐셜을 신경망의 출력 표현으로 사용하고, 최소 포텐셜 에너지 원리에서 유도된 에너지 기반 loss function으로 학습한다.

## 핵심 아이디어
- **KM 포텐셜 인코딩:** 변위장을 직접 학습하는 대신, 두 개의 정칙(holomorphic) KM 포텐셜로 해를 표현 — 2D 탄성 문제의 해석적 구조를 네트워크에 내장
- **불연속 응력 포텐셜:** 균열 문제를 위해 crack face 조건과 crack tip 특이성을 해 ansatz에 직접 임베딩
- **에너지 기반 loss:** 최소 포텐셜 에너지 원리(principle of minimum total potential energy)에서 유도 — PDE 잔차 + 경계 조건 패널티 불필요
- **결과:** 응력, 변위장, 응력 확대 계수(stress intensity factors)를 높은 정확도로 예측

## 연결점
- [[physics-informed]] — 기존 PINN (변위장 직접 학습) 대비 KM 포텐셜 기반 구조 인코딩의 차별점
- [[physics-informed]] — 기존 PINN과의 차별점: KM 포텐셜 기반 구조 인코딩 vs. 변위장 직접 학습
- [[mechanics]] — 2D 선형 탄성 및 균열 문제, 응력 확대 계수

## References
- arXiv:2605.02310 — A Variational Kolosov–Muskhelishvili Network for Elasticity and Fracture
