#!/bin/bash
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# ffmpeg/ffprobe are hard requirements for the video-use skill.
if ! command -v ffmpeg >/dev/null 2>&1; then
  apt-get update -qq
  apt-get install -y -qq ffmpeg
fi

# Sync video-use's Python deps (requests, librosa, matplotlib, pillow, numpy).
if [ -f "$CLAUDE_PROJECT_DIR/.claude/skills/video-use/pyproject.toml" ] && command -v uv >/dev/null 2>&1; then
  (cd "$CLAUDE_PROJECT_DIR/.claude/skills/video-use" && uv sync)
fi
