# Headless Mode

The `-p` (print) flag runs Claude Code non-interactively, perfect for scripts and CI pipelines.

## Basic Usage

```bash
# Simple query
claude -p "Explain this project"

# With JSON output
claude -p "List all API endpoints" --output-format json | jq -r '.result'

# Restrict tools
claude -p "Review auth.py" --allowedTools "Read,Glob,Grep"

# Budget limit
claude -p "Refactor utils.py" --max-budget-usd 0.50
```

## Key Flags

| Flag | Purpose |
|------|---------|
| `-p "prompt"` | Non-interactive mode |
| `--output-format json` | Structured JSON output |
| `--output-format stream-json` | Real-time streaming |
| `--allowedTools "Read,Grep"` | Auto-approve specific tools |
| `--max-turns N` | Limit agentic turns |
| `--max-budget-usd N` | Stop at cost limit |
| `--model NAME` | Use specific model |
| `--json-schema 'SCHEMA'` | Validate output against schema |
| `--continue` | Continue last conversation |
| `--resume ID` | Resume specific session |

## Structured Output

```bash
claude -p "Extract function names from auth.py" \
  --output-format json \
  --json-schema '{
    "type": "object",
    "properties": {
      "functions": {"type": "array", "items": {"type": "string"}}
    }
  }'
```

## CI Pipeline Example

```bash
#!/bin/bash
# review.sh — Run Claude review in CI

RESULT=$(claude -p "Review the changes in this PR for security issues" \
  --output-format json \
  --allowedTools "Read,Glob,Grep" \
  --max-turns 5 \
  --max-budget-usd 1.00)

# Extract result
echo "$RESULT" | jq -r '.result'

# Check cost
COST=$(echo "$RESULT" | jq -r '.cost_usd')
echo "Review cost: \$$COST"
```
