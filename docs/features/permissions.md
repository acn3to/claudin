# Permissions

Permissions control which tools Claude can use without asking. They're the first line of defense.

## Configuration

Permissions are set in `settings.json` at any scope:

```json
{
  "permissions": {
    "allow": [
      "Read",
      "Glob",
      "Grep",
      "Bash(git status:*)",
      "Bash(npm test:*)"
    ],
    "deny": [
      "Bash(git push --force:*)",
      "Bash(rm -rf:*)"
    ]
  }
}
```

## Rule Syntax

| Pattern | Matches |
|---------|---------|
| `Read` | All Read tool calls |
| `Bash(git:*)` | Any Bash command starting with `git` |
| `Bash(npm test:*)` | Bash commands starting with `npm test` |
| `Bash(git push --force:*)` | Specific dangerous command |
| `Edit` | All Edit tool calls |

## Priority

**Deny rules always win.** If a command matches both allow and deny, it's denied.

Settings hierarchy (highest to lowest):

1. Managed settings (enterprise)
2. Local settings (`.claude/settings.local.json`)
3. Project settings (`.claude/settings.json`)
4. User settings (`~/.claude/settings.json`)

## Claudin Defaults

### Project-level (safe for any project)

```json
{
  "allow": [
    "Read", "Glob", "Grep", "WebFetch", "WebSearch",
    "Bash(ls:*)", "Bash(cat:*)", "Bash(head:*)", "Bash(tail:*)",
    "Bash(wc:*)", "Bash(git diff:*)", "Bash(git status:*)",
    "Bash(git log:*)", "Bash(git branch:*)", "Bash(git show:*)",
    "Bash(find:*)", "Bash(tree:*)", "Bash(echo:*)"
  ],
  "deny": [
    "Bash(git push --force:*)",
    "Bash(git push -f:*)",
    "Bash(rm -rf /:*)"
  ]
}
```

### Extending for your stack

```json
{
  "allow": [
    "Bash(npm test:*)",
    "Bash(npm run lint:*)",
    "Bash(npm run build:*)",
    "Bash(docker compose:*)"
  ]
}
```

!!! tip "Start restrictive, loosen as needed"
    Begin with the Claudin defaults and add specific commands as you need them. It's easier to allow more than to recover from an accident.
