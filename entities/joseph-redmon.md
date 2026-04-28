---
title: Joseph Redmon
created: 2026-04-28
updated: 2026-04-28
type: entity
tags: [person, computer-vision, neural-network]
sources: [raw/papers/1506.02640v5.md]
---

# Joseph Redmon

**YOLO (You Only Look Once) 창시자.** Single-shot 실시간 객체 탐지(object detection)의 선구자.

## 주요 기여

### YOLO — You Only Look Once
**Redmon**, Divvala, Girshick, Farhadi (2015, CVPR 2016)가 제안한 [[yolo-object-detection]]는 객체 탐지를 **단일 회귀 문제(single regression problem)**로 프레임화하여, CNN이 한 번의 평가로 바운딩 박스와 클래스 확률을 동시에 예측한다. Fast YOLO는 **155 FPS**, YOLO는 **45 FPS**를 달성하며 실시간 탐지를 현실화했다.

### YOLOv2 ~ YOLOv3
Redmon은 YOLO 시리즈를 지속적으로 발전시켜 (YOLOv2: Darknet-19, anchor boxes; YOLOv3: Darknet-53, multi-scale detection), 객체 탐지의 표준 파이프라인으로 자리잡게 했다.

### 연구 분야
- Real-time object detection
- Single-shot computer vision
- Darknet 프레임워크 개발

## 관계

- [[ross-girshick]] — YOLO 공동 연구자
- [[yolo-object-detection]] — Redmon의 대표 업적
- [[ls-yolo]] — YOLO의 경량 확장
- [[residual-networks]] — YOLO backbone 발전
