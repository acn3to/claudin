#!/bin/bash
# Validate Serverless Config Hook
# Warns when editing serverless.yml or SAM template files.
# Registered as PostToolUse hook with matcher "Edit|Write"
#
# Non-blocking — always exits 0. Adds a reminder to stdout.

INPUT=$(cat)

FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.file // empty' 2>/dev/null)

[ -z "$FILE_PATH" ] && exit 0

BASENAME=$(basename "$FILE_PATH")

case "$BASENAME" in
    serverless.yml|serverless.yaml|serverless.ts|serverless.js|template.yml|template.yaml|samconfig.toml)
        echo "Reminder: Infrastructure file modified ($BASENAME). Verify stage variables, IAM permissions, and resource naming before deploying."
        ;;
esac

exit 0
