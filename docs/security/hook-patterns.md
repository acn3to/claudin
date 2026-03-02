# Security Hook Patterns

## Pattern 1: File Protection

Block edits to sensitive files while allowing templates:

```bash
#!/bin/bash
INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
BASENAME=$(basename "$FILE_PATH" | tr '[:upper:]' '[:lower:]')

# Allow templates
case "$BASENAME" in *.example|*.sample|*.template) exit 0 ;; esac

# Block sensitive files
case "$BASENAME" in
    .env|.env.*|*.pem|*.key|credentials*|secrets*)
        echo "BLOCKED: Cannot edit sensitive file" >&2
        exit 2 ;;
esac
exit 0
```

## Pattern 2: Command Blocklist

Block dangerous bash commands:

```bash
#!/bin/bash
INPUT=$(cat)
CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# Block destructive operations
if echo "$CMD" | grep -qP 'rm\s+(-[a-zA-Z]*f|--force)'; then
    echo "BLOCKED: Force removal forbidden" >&2
    exit 2
fi

# Block piped installs
if echo "$CMD" | grep -qP 'curl.*\|\s*(bash|sh)'; then
    echo "BLOCKED: Piped installation forbidden" >&2
    exit 2
fi

exit 0
```

## Pattern 3: Audit Trail

Log all file modifications:

```bash
#!/bin/bash
INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // "unknown"')
TOOL=$(echo "$INPUT" | jq -r '.tool_name // "unknown"')
echo "[$(date '+%Y-%m-%d %H:%M:%S')] $TOOL: $FILE" >> .claude/hooks/audit.log
exit 0
```

## Pattern 4: Secret Detection in Prompts

Detect when user mentions sensitive terms:

```bash
#!/bin/bash
INPUT=$(cat)
PROMPT=$(echo "$INPUT" | jq -r '.prompt // empty')

if echo "$PROMPT" | grep -qiE 'password|secret|api.?key|token|credential'; then
    echo "Reminder: Never hardcode secrets. Use environment variables."
fi
exit 0
```

## Hook Registration

Register hooks in `settings.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      { "matcher": "Edit|Write", "hooks": [{"type": "command", "command": "bash .claude/hooks/protect-files.sh"}] },
      { "matcher": "Bash", "hooks": [{"type": "command", "command": "bash .claude/hooks/block-commands.sh"}] }
    ],
    "PostToolUse": [
      { "matcher": "Edit|Write", "hooks": [{"type": "command", "command": "bash .claude/hooks/audit-edits.sh"}] }
    ]
  }
}
```
