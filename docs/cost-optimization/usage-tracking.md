# Usage Tracking

## In-Session Tracking

| Command | What it shows |
|---------|--------------|
| `/cost` | Total session cost, duration, lines changed |
| `/context` | Current context window usage |
| Status line | Real-time cost and context % |

## Prompt Caching

Claude Code automatically uses prompt caching to reduce costs:

- **Cache write** — first time seeing content (slightly more expensive)
- **Cache read** — subsequent turns (90% cheaper than base input)

### Maximize cache hits

1. Keep a consistent system prompt (stable CLAUDE.md)
2. Resume conversations (`claude --continue`) instead of starting fresh
3. Keep sessions open for extended work

### Cache pricing

| Model | Base Input | Cache Read (90% off) |
|-------|-----------|---------------------|
| Opus | $5/MTok | $0.50/MTok |
| Sonnet | $3/MTok | $0.30/MTok |
| Haiku | $1/MTok | $0.10/MTok |

## External Monitoring

- **Claude Console** — [platform.claude.com](https://platform.claude.com) for usage dashboards
- **Grafana** — Anthropic integration for cost visualization
- **LiteLLM** — Open-source tracking for Bedrock/Vertex deployments
