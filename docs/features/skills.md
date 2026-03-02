# Skills

Skills are reusable capabilities that teach Claude how to perform specific tasks. They can activate automatically when Claude detects a relevant context, or be invoked manually with `/skill-name`.

## Structure

```
.claude/skills/
└── my-skill/
    └── SKILL.md          # Required — defines the skill
    ├── examples/          # Optional — example outputs
    ├── templates/         # Optional — templates to reference
    └── references/        # Optional — lookup data
```

## SKILL.md Format

```yaml
---
# YAML Frontmatter (configuration)
name: my-skill
description: "When and how Claude should use this skill"
allowed-tools: Read, Grep, Glob          # Restrict tool access
user-invocable: true                      # Show in / menu
argument-hint: "[file] [options]"         # Autocomplete hint
context: fork                             # Run in isolated subagent
agent: Explore                            # Agent type for forked context
model: sonnet                             # Model override: sonnet, opus, haiku, inherit
---

# Markdown Content (instructions for Claude)
Your skill instructions here...
```

## Key Frontmatter Fields

| Field | Required | Purpose |
|-------|----------|---------|
| `name` | No | Display name (uses directory name if omitted) |
| `description` | Recommended | When/how Claude uses the skill |
| `allowed-tools` | No | Comma-separated list of allowed tools |
| `user-invocable` | No | Show in `/` autocomplete menu |
| `disable-model-invocation` | No | Prevent Claude from auto-triggering |
| `argument-hint` | No | Hint shown during autocomplete |
| `context` | No | `fork` runs in isolated subagent |
| `agent` | No | Agent type: `Explore`, `Plan`, etc. |
| `model` | No | Override model per skill |

## Invocation

**Manual:** Type `/skill-name` in Claude Code
**Automatic:** Claude reads the `description` and activates when relevant
**With arguments:** `/skill-name my-file.ts --verbose` (accessible via `$ARGUMENTS`)

## Dynamic Content

Skills support shell command injection with `!` backtick syntax:

```markdown
## Current Changes
- Modified files: !`git diff --name-only`
- Branch: !`git branch --show-current`
```

Shell commands execute before Claude sees the skill content.

## String Substitutions

| Variable | Purpose |
|----------|---------|
| `$ARGUMENTS` | All arguments passed to the skill |
| `$1`, `$2`, ... | Positional arguments |
| `${CLAUDE_SESSION_ID}` | Current session ID |

## Best Practices

!!! tip "Keep skills focused"
    One skill, one job. A "review" skill and a "document" skill are better than a "review-and-document" skill.

!!! tip "Use `context: fork` for expensive skills"
    Skills that read many files should run in an isolated subagent to avoid polluting the main context window.

!!! tip "Use `model: haiku` for simple skills"
    Skills that do basic lookups or formatting don't need Opus. Set `model: haiku` to save tokens.

!!! warning "Skills > 500 lines"
    Large skills consume context. If your skill is huge, split it into a main SKILL.md with reference files in subdirectories.
