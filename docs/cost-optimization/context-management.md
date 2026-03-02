# Context Management

The context window (200k tokens) is your most precious resource. Managing it well reduces costs and improves Claude's performance.

## How Context Fills

1. **System prompt** — CLAUDE.md, rules, skills, tool definitions
2. **Conversation history** — every message back and forth
3. **File contents** — files Claude reads during the session
4. **Tool results** — output from bash commands, searches, etc.

## Auto-Compaction

Claude Code automatically compacts context at ~80% capacity. It summarizes conversation history while preserving code and decisions.

### Custom compaction instructions

Add to your CLAUDE.md:

```markdown
## Compact Instructions
When compacting, preserve:
- The full list of modified files
- Test commands and their results
- Architectural decisions made
```

## Optimization Techniques

### 1. .claudeignore

Exclude files that waste context:
```
package-lock.json    # Saves 30k-100k tokens
coverage/            # Generated reports
*.min.js             # Minified code
```

### 2. Short, focused sessions

- **30-45 minute sessions** keep context at ~45% usage
- Use `/clear` between unrelated tasks
- Start fresh sessions for new features

### 3. Skills with `context: fork`

Skills that read many files should run in isolated subagents:

```yaml
---
name: codebase-explorer
context: fork
agent: Explore
model: haiku
---
```

### 4. Move detailed instructions to skills

Instead of bloating CLAUDE.md with 500 lines of standards, create skills that load on-demand:

```
CLAUDE.md (50 lines) → Always loaded
.claude/skills/review/ → Loaded only when reviewing
.claude/skills/deploy/ → Loaded only when deploying
```

### 5. Monitor with /context

Run `/context` to see what's consuming space. Disable unused MCP servers with `/mcp`.

## Status Line Indicator

Claudin's status line shows context usage with color coding:

- **Green** (< 70%) — plenty of room
- **Yellow** (70-89%) — getting full
- **Red** (90%+) — compaction imminent
