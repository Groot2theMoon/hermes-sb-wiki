---
title: AI Research Automation (Nature 2026)
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [classic-ai, benchmark, survey, paper, landmark-paper]
sources: [raw/papers/s41586-026-10265-5-1.md]
confidence: medium
---

# End-to-End Automation of AI Research

## 개요

**Lu, Lu, Lange et al.** ([[sakana-ai|Sakana AI]] / Oxford / Foerster Lab / Clune Lab, *Nature* 2026)는 AI 연구의 **end-to-end 자동화**를 최초로 실현했다^[raw/papers/s41586-026-10265-5-1.md]. **The AI Scientist**는 아이디어 생성 → 코드 작성 → 실험 실행 → 분석 → 논문 작성 → 피어 리뷰까지 전 과정을 자율적으로 수행한다.

## 주요 구성 요소

| 모듈 | 기능 | 비고 |
|:---|:------|:----:|
| **Ideation** | 연구 아이디어 생성 + 문헌 검색 | LLM 기반 |
| **Coding** | 실험 코드 작성 및 실행 | Foundation model 활용 |
| **Experiment** | 실험 설계 → 실행 → 결과 수집 | Template mode / Open-ended mode |
| **Analysis** | 결과 분석 + 시각화 | Plot + 데이터 분석 |
| **Manuscript** | 전체 논문 작성 | Introduction → Conclusion |
| **Automated Reviewer** | 자체 피어 리뷰 | 인간 리뷰어 수준 일치 |

## 평가 결과

- **ICLR 워크샵 (70% acceptance rate)** 에서 **1차 리뷰 통과** — AI 생성 논문이 인간 심사자를 통과한 최초 사례
- Automated Reviewer의 성능이 **실제 인간 리뷰어와 유사** (conference acceptance 예측 정확도)
- **Test-time compute 증가 → 논문 품질 향상** — 확장 법칙 확인
- **기반 모델 개선 → 생성 논문 품질 직접 향상** — 미래 성능 향상 기대

## 한계 및 리스크

| 리스크 | 설명 |
|:-----|:------|
| **리뷰 시스템 과부하** | AI가 대량 논문 생성 시 리뷰어 수요 폭증 |
| **과학적 노이즈 추가** | 저품질 논문 범람 가능성 |
| **Open-ended 모드** | Template 없이 넓은 탐색 시 아이디어 분산 |
| **재현성** | LLM 기반 코드의 불안정성 |

## 융합 도메인 연결

- 본 위키의 **자동 Ingest/Obsidian 연동 파이프라인** 방향의 최신 연구 동향
- AI 연구 자동화 = AutoML + Hyperparameter Search의 진화된 형태 → [[deep-learning-nature-survey]] 비교
- [[ai-scientific-taste]] (Sci Taste) — 과학적 판단력 학습과의 연결

## References
- Lu, C. et al. (2026). Towards end-to-end automation of AI research. *Nature*.
- [[kennedy-ohagan-calibration]]
- [[ai-scientific-taste]]
