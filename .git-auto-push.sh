#!/bin/bash
cd /home/aero_groot/agent-workspace/wiki

# 변경사항이 있는지 확인
if git diff --cached --quiet && git diff --quiet; then
    exit 0
fi

git add -A
git commit -m "bot: wiki updated by Hermes $(date +%Y-%m-%d_%H:%M)"

# Push 시도, 실패하면 Pull(rebase) 후 다시 Push 시도
if ! git push; then
    git pull --rebase origin main
    git push
fi