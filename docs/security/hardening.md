# Hardening Guide

## 1. Deny Dangerous Commands

In `.claude/settings.json`:

```json
{
  "permissions": {
    "deny": [
      "Bash(git push --force:*)",
      "Bash(git push -f:*)",
      "Bash(rm -rf /:*)",
      "Bash(rm -rf /*:*)",
      "Bash(chmod 777:*)",
      "Bash(curl:* | bash)",
      "Bash(wget:* | bash)"
    ]
  }
}
```

## 2. Protect Sensitive Files

The `protect-files.sh` hook (included in Claudin) blocks edits to:

- `.env`, `.env.*` files
- `.pem`, `.key`, `.p12` certificates
- `credentials`, `secrets` files
- SSH keys (`id_rsa`, `id_ed25519`)

## 3. Audit All Changes

The `audit-edits.sh` hook logs every file modification with timestamp to `.claude/hooks/audit.log`.

## 4. Context Re-injection

The `context-reinject.sh` hook reminds Claude of security constraints after context compaction.

## 5. CLAUDE.md Security Section

Always include:

```markdown
## Security Rules
- NEVER read, edit, or commit `.env` files or credential files
- NEVER hardcode API keys, tokens, or passwords
- All credentials in docs must be placeholders
- NEVER git push --force to main/master
```

## 6. Additional Hardening

For high-security environments, add:

```bash
#!/bin/bash
# block-secrets.sh — PreToolUse hook for Bash
INPUT=$(cat)
CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# Block commands that might expose secrets
if echo "$CMD" | grep -qiE '(printenv|env|set|export).*KEY|TOKEN|SECRET|PASS'; then
    echo "BLOCKED: Command may expose secrets" >&2
    exit 2
fi

exit 0
```
