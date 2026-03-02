# Model Selection

## Strategy

| Task Type | Recommended Model | Why |
|-----------|-------------------|-----|
| Daily coding, bug fixes | **Sonnet** | Capable enough, 60% cost of Opus |
| Architecture decisions | **Opus** | Deep reasoning for complex tradeoffs |
| Code exploration | **Haiku** | Fast, cheap discovery |
| Subagent tasks | **Haiku** | Bounded scope, 5x cheaper than Sonnet |
| PR documentation | **Sonnet** | Needs understanding, not deep reasoning |
| Simple formatting | **Haiku** | No reasoning needed |

## Configuration

### Default model
```bash
claude --model sonnet              # At startup
/model sonnet                       # During session
export ANTHROPIC_MODEL=sonnet       # Environment variable
```

### Per-skill model
```yaml
---
name: explore-codebase
model: haiku                        # Cheap exploration
context: fork
---
```

### Per-agent model
```yaml
---
name: code-reviewer
model: haiku                        # Read-only review
tools: Read, Grep, Glob
---
```

### Global subagent model
```bash
export CLAUDE_CODE_SUBAGENT_MODEL=haiku
```

## Model Aliases

| Alias | Maps To |
|-------|---------|
| `sonnet` | Latest Sonnet (4.6) |
| `opus` | Latest Opus (4.6) |
| `haiku` | Latest Haiku (4.5) |
| `opusplan` | Opus for planning, auto-switches to Sonnet for execution |

## Cost Comparison

A task that costs **$1.00 with Opus** costs:
- **$0.60 with Sonnet** (40% savings)
- **$0.20 with Haiku** (80% savings)

Over a month of daily use, this difference compounds significantly.
