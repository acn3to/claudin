# Cost Optimization

Claude Code costs depend on model selection, context usage, and session patterns. Here's how to get the most value per token.

## Cost Overview

| Model | Input (per MTok) | Output (per MTok) | Best For |
|-------|------------------|-------------------|----------|
| **Opus 4.6** | $5 | $25 | Architecture, complex reasoning |
| **Sonnet 4.6** | $3 | $15 | Daily coding (90% of tasks) |
| **Haiku 4.5** | $1 | $5 | Subagents, exploration, formatting |

Typical usage: **$6/developer/day** (Sonnet), 90% of users under $12/day.

## Quick Wins

1. **Use Sonnet as default** — handles 90% of tasks at 60% the cost of Opus
2. **Set subagents to Haiku** — `model: haiku` on reviewer/explorer agents (85-92% savings)
3. **Use .claudeignore** — excluding lock files saves 30k-100k tokens per session
4. **Keep sessions focused** — `/clear` between unrelated tasks
5. **Use `context: fork` in skills** — isolate expensive lookups from main context
