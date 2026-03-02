# Skill Design

## Principles

1. **One skill, one job** — don't combine review + documentation into one skill
2. **Load on demand** — use `context: fork` for skills that read many files
3. **Match model to task** — `model: haiku` for lookups, `model: sonnet` for reasoning
4. **Restrict tools** — only grant the tools the skill needs

## Anatomy of a Good Skill

```yaml
---
name: api-review
description: "Reviews API endpoints for REST conventions and security. Use when modifying controllers or routes."
allowed-tools: Read, Grep, Glob
user-invocable: true
argument-hint: "[file-or-directory]"
model: sonnet
---

## Steps
1. Identify the files to review
2. Check REST conventions (HTTP methods, status codes, response format)
3. Check security (input validation, authentication, authorization)
4. Report findings by severity

## Output Format
- Critical: [issue] at [file:line]
- Warning: [issue] at [file:line]
- Info: [suggestion] at [file:line]
```

## Common Patterns

### Explorer skill (cheap, fast)
```yaml
---
context: fork
agent: Explore
model: haiku
---
```

### Writer skill (controlled output)
```yaml
---
allowed-tools: Read, Glob, Grep, Write
---
```

### Background knowledge (not invokable)
```yaml
---
user-invocable: false
disable-model-invocation: false
---
```

## Anti-Patterns

- Skills over 500 lines (split into skill + reference files)
- Skills that do everything (break into focused skills)
- Skills without `description` (Claude doesn't know when to use them)
- Skills with `allowed-tools: *` (defeats the purpose of restriction)
