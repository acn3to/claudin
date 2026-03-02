# Agents (Subagents)

Agents are specialized AI assistants with isolated context, custom prompts, and restricted tools. They handle delegated tasks without polluting the main conversation.

## Location

```
.claude/agents/
├── code-reviewer.md
├── documenter.md
└── your-agent.md
```

## Agent Definition

```yaml
---
name: code-reviewer
description: "Reviews code for quality and security. Use after modifying code."
tools:
  - Read
  - Grep
  - Glob
  - Bash
model: sonnet                    # sonnet, opus, haiku, inherit
permissionMode: default          # default, acceptEdits, dontAsk, plan
maxTurns: 50                     # Max agentic turns
---

Your agent instructions in markdown...
```

## Key Fields

| Field | Purpose |
|-------|---------|
| `name` | Agent identifier |
| `description` | When Claude should delegate to this agent |
| `tools` | Allowed tools (inherits all if omitted) |
| `disallowedTools` | Explicitly denied tools |
| `model` | Model override (save costs with `haiku` for simple agents) |
| `permissionMode` | How permissions are handled |
| `maxTurns` | Limit on agentic turns |
| `memory` | `user`, `project`, or `local` for persistent learning |

## Permission Modes

| Mode | Behavior |
|------|----------|
| `default` | Standard permission prompts |
| `acceptEdits` | Auto-accept file edits |
| `dontAsk` | Auto-deny prompts (pre-approved tools still work) |
| `bypassPermissions` | Skip all checks (use cautiously) |
| `plan` | Read-only exploration mode |

## Claudin's Included Agents

### code-reviewer

Read-only agent that checks security, code quality, naming, and test coverage. Uses `Read`, `Glob`, `Grep`, `Bash`. Never modifies files.

### documenter

Generates PR descriptions and release notes from git diffs. Uses `Read`, `Glob`, `Grep`, `Write`.

## Creating Custom Agents

Think about:

1. **What task** does this agent handle?
2. **What tools** does it need? (minimize for safety)
3. **What model** is appropriate? (haiku for simple, sonnet for medium, opus for complex)
4. **Read-only or read-write?** (prefer read-only when possible)

!!! tip "Cost optimization"
    Set `model: haiku` on agents that do simple lookups or formatting. This is 5x cheaper than Sonnet and 25x cheaper than Opus.

!!! warning "Tool restrictions matter"
    An agent with `Write` and `Bash` can do anything. Only grant the tools the agent actually needs.
