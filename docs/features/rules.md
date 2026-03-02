# Rules

Rules are markdown files in `.claude/rules/` that Claude loads automatically based on file glob patterns. They provide file-specific or domain-specific coding standards.

## Location

```
.claude/rules/
├── code-standards.md          # Loaded for all files
├── backend/
│   └── api-patterns.md        # Loaded for backend files
├── frontend/
│   └── component-standards.md # Loaded for frontend files
└── testing/
    └── test-standards.md      # Loaded for test files
```

## How Rules Load

Rules load automatically when Claude works with files matching the rule's glob pattern. If no glob is specified, the rule loads for all files.

## Writing Rules

Rules are plain markdown files. Keep them focused and concise:

```markdown
## API Response Standards

All API endpoints must return responses in this format:

\`\`\`json
{
  "success": true,
  "data": {},
  "error": null
}
\`\`\`

- Always include `success` boolean
- `data` is null on error, `error` is null on success
- HTTP status codes: 200 (ok), 400 (bad request), 401 (unauthorized), 500 (server error)
```

## Claudin's Included Rules

### code-standards.md

General coding standards: self-documenting code, single responsibility, explicit error handling, input validation at boundaries, security practices, git conventions.

## Best Practices

!!! tip "Rules vs CLAUDE.md"
    Use **CLAUDE.md** for project-wide context (what the project is, how to run it). Use **rules** for specific coding standards (how to write API responses, how to structure tests).

!!! tip "Keep rules focused"
    One rule file per topic. A `security.md` and a `testing.md` are better than a `everything.md`.

!!! warning "Rules load automatically"
    Every rule adds to context. Don't create rules for obvious things Claude already knows.
