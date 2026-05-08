---
title: "MetaSymbO — Multi-Agent Language-Guided Metamaterial Discovery"
created: 2026-05-08
updated: 2026-05-08
type: concept
tags: [engineering-design, inverse-design, generative-model, materials, architecture, paper, research-idea]
confidence: medium
---

# MetaSymbO — Multi-Agent Language-Guided Metamaterial Discovery

## 개요

**Han et al. (2026)** ^[arXiv:2604.27300]이 제안하는 **MetaSymbO**는 **3개의 LLM 기반 에이전트(Designer, Generator, Supervisor)** 를 활용하여 자연어 설계 의도(natural language design intent)를 메타물질(metamaterial) 미세구조(microstructure)로 변환하는 프레임워크다. 기존 생성 모델이 학습 데이터에 국한된 샘플만 재현하는 한계를 넘어, **symbolic-driven latent evolution**을 통해 추론 시점(inference time)에서 새로운 구조를 합성/변형/정제한다.

## 핵심 아이디어

1. **Designer Agent:** 자유 형식의 자연어 설계 의도를 해석하고 의미적으로 일관된 scaffold를 검색
2. **Generator Agent:** Disentangled latent space에서 후보 미세구조를 합성
3. **Supervisor Agent:** 빠른 property-aware 피드백을 제공하여 반복 정제

**Symbolic-driven latent evolution** — disentangled latent factor에 프로그래머블 연산자를 적용하여 추론 시점에서 구조를 구성, 수정, 정제. 실험 결과: 구조 유효성 34% 향상, 주기성 98% 향상, 언어 정합도 6-7% 향상.

## 연결점
- [[inverse-design]] — MetaSymbO는 자연어 기반 역설계(inverse design) 접근법
- [[diffusion-metamaterial-inverse-design]] — 기존 diffusion 기반 메타물질 설계와 비교하여 언어-구조 정합 접근
- [[generative-models-physics]] — 생성 모델의 메타물질 설계 적용 확장
- [[deepseek]] — LLM 기반 에이전트 아키텍처 활용 가능성 (참조)

## References
- arXiv:2604.27300 — MetaSymbO: Multi-Agent Language-Guided Metamaterial Discovery via Symbolic Latent Evolution
