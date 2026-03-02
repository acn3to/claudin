# Session Management

## Optimal Session Patterns

### Short, focused sessions (recommended)

- **30-45 minutes** per session
- One feature or task per session
- `/clear` between unrelated tasks
- Start fresh for new features

### Long sessions (when needed)

- Use for complex, multi-file refactors
- Monitor context with status line
- Compact manually with `/compact` when context hits yellow
- Resume with `claude --continue` if interrupted

## Session Commands

| Command | When to use |
|---------|------------|
| `/clear` | Switching to unrelated task |
| `/compact` | Context getting full (70%+) |
| `/cost` | Check session spending |
| `/context` | See what's consuming context |
| `claude --continue` | Resume last session |
| `claude --resume ID` | Resume specific session |

## Context Health

Watch the status line:

- **Green bar** (< 70%) — work freely
- **Yellow bar** (70-89%) — consider compacting or wrapping up
- **Red bar** (90%+) — auto-compaction imminent, may lose nuance

## Tips

1. **Start sessions with clear intent** — "Fix the auth bug in login.ts" is better than "Look at the code"
2. **Don't fight compaction** — if context is full, start fresh rather than losing quality
3. **Use subagents for research** — delegate exploration to Explore agents to keep main context clean
4. **Resume over restart** — `claude --continue` preserves cache, saving tokens
