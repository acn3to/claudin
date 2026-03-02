# CLAUDE.md

The `CLAUDE.md` file is the single most important configuration for Claude Code. It's read at the start of every session and tells Claude about your project.

## Location

| File | Scope |
|------|-------|
| `./CLAUDE.md` | Project root (most common) |
| `./CLAUDE.local.md` | Personal overrides (gitignored) |
| `~/.claude/CLAUDE.md` | Global (all projects) |

## What to Include

Include things Claude **can't infer from code alone**:

```markdown
# Project Name

## What This Project Is
Brief description: purpose, users, why it exists.

## Tech Stack
Runtime, framework, database, testing, CI/CD, infra.

## Project Structure
Directory layout with brief descriptions.

## Key Conventions
- Non-obvious coding patterns
- API response format standards
- Environment variable access patterns
- Branch naming conventions

## Common Commands
Only non-obvious commands (build, test, deploy).

## Security Rules
Non-negotiable constraints (no .env edits, no hardcoded secrets).
```

## What NOT to Include

- Standard language conventions (Claude already knows)
- Information Claude can infer from reading code
- Detailed API documentation (link to it instead)
- Self-evident practices

## Best Practices

!!! tip "Keep it under 200 lines"
    CLAUDE.md loads on every session. Every line costs tokens. Keep it concise — move detailed instructions to skills (loaded on-demand) or rules (loaded per-file).

!!! tip "Focus on the WHY, not the HOW"
    Instead of "Use async/await for database calls", write "Database calls are always async because we use connection pooling with a 5-second timeout."

!!! warning "No secrets"
    Never put credentials, API keys, or connection strings in CLAUDE.md. It's committed to git.

## Template

Claudin includes a customizable template at `template/CLAUDE.md`. Copy it to your project root and fill in the sections.
