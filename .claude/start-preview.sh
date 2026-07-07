#!/usr/bin/env bash
set -euo pipefail

PORT="${MINT_PORT:-3000}"
LOG_FILE="${TMPDIR:-/tmp}/mintlify-preview.log"
URL="http://localhost:${PORT}"

if command -v curl >/dev/null 2>&1 && curl -s -o /dev/null "$URL"; then
  echo "Mintlify preview already running at $URL"
  exit 0
fi

if ! command -v mint >/dev/null 2>&1; then
  echo "Mintlify preview not started; run npm i -g mint"
  exit 0
fi

MINT_PORT="$PORT" nohup mint dev >"$LOG_FILE" 2>&1 &
disown >/dev/null 2>&1 || true

echo "Started Mintlify preview at $URL (logs: $LOG_FILE)"
