#!/bin/bash
# Audit Edits Hook
# Logs all file modifications with timestamp for traceability.
# Registered as PostToolUse hook with matcher "Edit|Write"
#
# Non-blocking — always exits 0.

INPUT=$(cat)

FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.file // "unknown"' 2>/dev/null)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // "unknown"' 2>/dev/null)
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

LOG_DIR="$(git rev-parse --show-toplevel 2>/dev/null)/.claude/hooks"
LOG_FILE="$LOG_DIR/audit.log"

[ -d "$LOG_DIR" ] && echo "[$TIMESTAMP] $TOOL: $FILE_PATH" >> "$LOG_FILE"

exit 0
