#!/bin/bash
# Protect Sensitive Files Hook
# Blocks edits to files containing secrets or credentials.
# Registered as PreToolUse hook with matcher "Edit|Write"
#
# Exit codes:
#   0 = allow
#   2 = block

INPUT=$(cat)

FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.file // empty' 2>/dev/null)

[ -z "$FILE_PATH" ] && exit 0

BASENAME=$(basename "$FILE_PATH")
LOWER=$(echo "$BASENAME" | tr '[:upper:]' '[:lower:]')

# Allow template/example files
case "$LOWER" in
    *.example|*.sample|*.template) exit 0 ;;
esac

# Block sensitive files
case "$LOWER" in
    .env|.env.*) ;;
    *.pem|*.key|*.p12|*.pfx|*.jks) ;;
    credentials*|secrets*|*secret*) ;;
    *password*|*token*|*.keystore) ;;
    id_rsa|id_ed25519|id_ecdsa) ;;
    *) exit 0 ;;
esac

echo "BLOCKED: Cannot edit sensitive file '$BASENAME'. Use the actual system to manage credentials, not Claude." >&2
exit 2
