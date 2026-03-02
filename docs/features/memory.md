# Memory

Claude Code has a persistent memory system that retains knowledge across sessions. It stores project-specific patterns, preferences, and architectural decisions.

## Location

```
~/.claude/projects/<project-hash>/memory/
└── MEMORY.md          # Main memory file (always loaded)
```

## How It Works

- `MEMORY.md` is loaded into every conversation context
- Lines after 200 are truncated — keep it concise
- Create separate topic files (`debugging.md`, `patterns.md`) for details
- Link to topic files from MEMORY.md

## What to Save

- Stable patterns confirmed across multiple interactions
- Key architectural decisions and file paths
- User preferences for workflow and tools
- Solutions to recurring problems

## What NOT to Save

- Session-specific context (current task, in-progress work)
- Information that might be incomplete
- Anything that duplicates CLAUDE.md
- Speculative conclusions

## Managing Memory

Claude updates memory automatically as it learns about your project. You can also ask Claude directly:

- "Remember that we always use pnpm, not npm"
- "Forget about the old API format"
- "Update memory with the new database schema"

## Relationship to CLAUDE.md

| | CLAUDE.md | MEMORY.md |
|---|----------|-----------|
| **Who writes it** | You | Claude (auto-updated) |
| **Scope** | Team-wide | Personal |
| **Content** | Instructions | Learned patterns |
| **Version controlled** | Yes | No |
