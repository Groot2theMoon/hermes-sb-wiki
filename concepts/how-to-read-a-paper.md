---
title: How to Read a Paper — Three-Pass Method (S. Keshav)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [research-skills, survey]
sources: [raw/papers/how-to-read-a-paper.md]
confidence: high
---

# How to Read a Paper — Three-Pass Method

## 개요

**S. Keshav**의 *"How to Read a Paper"* (2007, ACM SIGCOMM CCR)는 연구자가 논문을 **효율적이고 체계적으로** 읽는 방법을 제시한 고전적인 메타 논문이다. 핵심은 논문을 단순히 처음부터 끝까지 읽는 대신, **세 번의 패스(3-pass)** 로 점진적 깊이를 높여 읽는 방법론이다.

이 방법은 [[s-keshav]]가 15년 이상의 연구 및 리뷰 경험을 바탕으로 정립했으며, 특히 여러 논문을 빠르게 처리해야 하는 학회 리뷰어, 문헌 조사(literature survey)를 수행하는 대학원생, 그리고 시간을 절약하려는 연구자에게 실용적인 프레임워크를 제공한다.

## Three-Pass Method

### First Pass (5–10분) — 새 조감

논문의 **개요(bird's-eye view)** 를 빠르게 파악한다. 추가로 읽을 가치가 있는지 판단하는 데 목적이 있다.

1. 제목, 초록(abstract), 도입(introduction)을 주의 깊게 읽는다
2. 섹션 및 서브섹션 제목만 훑는다
3. 결론(conclusion)을 읽는다
4. 참고문헌(references)을 훑으며 이미 읽은 논문을 체크한다

**Five Cs** 질문에 답할 수 있어야 한다:
- **Category:** 이 논문의 유형은? (측정 논문, 시스템 분석, 프로토타입?)
- **Context:** 어떤 관련 논문이 있고, 어떤 이론적 기반을 사용했는가?
- **Correctness:** 가정(assumptions)이 타당한가?
- **Contributions:** 주요 기여는 무엇인가?
- **Clarity:** 글은 잘 쓰였는가?

### Second Pass (최대 1시간) — 내용 파악

논문의 **전체 내용을 이해**하되, 증명이나 세부 구현은 건너뛴다.

1. 그림, 다이어그램, 그래프를 주의 깊게 살펴본다 (축 레이블, 오차 막대 등 확인)
2. 관련 미확인 참고문헌에 표시해둔다 (추후 학습 자원)

이 수준이면 논문의 핵심 주장과 근거를 다른 사람에게 요약할 수 있다. 연구 분야가 아닌 관심 분야 논문에 적합한 수준이다.

### Third Pass (초보 4–5시간, 숙련자 1시간) — 심층 이해

논문을 **완전히 이해**하고, 사실상 **가상으로 재구현(virtually re-implement)** 하는 수준이다.

- 모든 가정을 식별하고 도전한다
- 모든 주장을 검증한다
- 논문의 혁신과 숨겨진 결점, 암묵적 가정을 찾아낸다
- 향후 연구 아이디어를 메모한다

끝나면 논문 전체 구조를 기억에서 재구성할 수 있어야 하며, 논문의 강점과 약점을 명확히 파악해야 한다.

## 문헌 조사(Literature Survey) 활용법

1. **키워드 검색**으로 최근 논문 3-5편 찾기 → 1-pass로 감 잡기 → Related Work 섹션에서 서베이 페이퍼 찾기
2. **공통 인용/저자 식별** → 핵심 논문/연구자 파악 → 주요 연구자 웹사이트 방문
3. **Top 컨퍼런스 프로시딩** 스캔 → 고품질 최신 논문 수집 → 2-pass 독서

## 연구 방법론으로서의 의의

이 논문은 **효율적인 논문 독해**가 가르쳐지지 않는 기술이라는 문제의식에서 출발했다. 딥러닝/ML 분야가 폭발적으로 성장하면서 매년 수천 편의 새 논문이 쏟아지는 현 상황에서, Keshav의 3-pass 방법은 연구자가 정보 홍수 속에서 생존하는 데 필수적인 도구가 되었다.

AI/ML × Mechanics 융합 연구자에게 특히 중요한 이유:
- 다양한 분야(PINN, operator learning, CFD, FEM, 위상 최적화)의 논문을 동시에 읽어야 함
- 각 논문을 어느 깊이까지 읽을지 효율적으로 판단할 필요
- 문헌 조사 시 여러 하위 분야의 핵심 논문을 빠르게 필터링

## References

- S. Keshav, "How to Read a Paper," ACM SIGCOMM Computer Communication Review, vol. 37, no. 3, pp. 83–84, 2007.
- [[s-keshav]] — 저자
- [[deep-learning-nature-survey]] — 대규모 문헌 조사의 예시
- [[hmm-tutorial]] — 고전적인 튜토리얼 논문
