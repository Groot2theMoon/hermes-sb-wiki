---
title: "RopeDreamer — Kinematic Recurrent SSM for Deformable Linear Object Dynamics"
created: 2026-05-02
updated: 2026-05-02
type: concept
tags: [model, surrogate-model, robotics, architecture]
confidence: medium
---

# RopeDreamer — Kinematic RSSM for DLO Dynamics

## 개요
RopeDreamer (Missal et al., TU Darmstadt/DFKI)는 Deformable Linear Objects (DLOs) — 로프, 케이블, 와이어 같은 유연한 1차원 변형체 — 의 동역학을 예측하기 위한 잠재 상태 공간 모델입니다. Recurrent State Space Model (RSSM)과 **Quaternionic Kinematic Chain** 표현을 결합하여, 물리적으로 일관된 변형 예측을 가능하게 합니다.

## 핵심 아이디어
- DLO를 독립적인 Cartesian 좌표 대신 **상대 회전(quaternion)의 연속체**로 인코딩하여 링크 길이 불변성을 물리적으로 보장
- **이중 디코더 아키텍처** — 상태 재구성 디코더와 미래 예측 디코더를 분리해 잠재 공간이 변형의 물리적 법칙을 학습하도록 강제
- 기존 RNN/GNN 기반 방법이 겪는 자기 교차(self-intersection) 및 비물리적 변형 문제를 해결
- 50-step open-loop 예측에서 SOTA 대비 40.52% 오차 감소, 추론 시간 31.17% 단축

## 연결점
- [[state-space-model]] — RSSM 기반 잠재 동역학 모델링의 확장
- [[surrogate-model]] — 물리 제약을 내장한 데이터 기반 변형 예측
- [[physics-informed]] — Quaternion kinematic chain을 통한 물리적 귀결성 확보
- [[soft-robot]] (entity) — 유연체 로봇 조작과의 연결 가능성

## References
- arXiv:2604.28161 — RopeDreamer: A Kinematic Recurrent State Space Model for Dynamics of Flexible Deformable Linear Objects
