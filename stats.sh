#!/usr/bin/env bash
set -euo pipefail

LOG_DIR="$(cd "$(dirname "$0")" && pwd)/src/logs"

echo "=== Job Hunt Stats ==="
echo ""

DAYS=$(find "$LOG_DIR" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
echo "Days logged: $DAYS"

TOTAL=$(grep -h '^\*\*Total:\*\*' "$LOG_DIR"/*.md 2>/dev/null \
  | grep -o '[0-9]*' | awk '{s+=$1} END {print s+0}')
echo "Total jobs applied: $TOTAL"

echo ""
echo "=== Recent Logs ==="
find "$LOG_DIR" -name "*.md" 2>/dev/null | sort -r | head -7 | while read -r f; do
  name=$(basename "$f" .md)
  count=$(grep '^\*\*Total:\*\*' "$f" 2>/dev/null | grep -o '[0-9]*' | head -1)
  printf "  %s  (%s jobs)\n" "$name" "$count"
done
