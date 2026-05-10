#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
DATE=$(date +%Y-%m-%d)
LOG_DIR="$ROOT/src/logs"
FILE="$LOG_DIR/$DATE.md"

mkdir -p "$LOG_DIR"

# Create today's log from template if it doesn't exist
if [ ! -f "$FILE" ]; then
  sed "s/{{DATE}}/$DATE/g" "$ROOT/template.md" > "$FILE"
  echo "Created: $FILE"
else
  echo "Log exists: $FILE"
fi

# Regenerate src/SUMMARY.md so the sidebar stays in sync
SUMMARY="$ROOT/src/SUMMARY.md"
{
  echo "# Summary"
  echo ""
  echo "[Overview](README.md)"
  echo ""
  echo "# Daily Logs"
  echo ""
  find "$LOG_DIR" -name "*.md" | sort -r | while read -r f; do
    name=$(basename "$f" .md)
    echo "- [$name](logs/$name.md)"
  done
} > "$SUMMARY"

echo "Updated SUMMARY.md"

# Open the file
if command -v code &>/dev/null; then
  code "$FILE"
elif [ -n "${EDITOR:-}" ]; then
  "$EDITOR" "$FILE"
else
  open "$FILE"
fi
