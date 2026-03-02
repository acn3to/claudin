---
name: project-review
description: "Reviews the current project for code quality, security, and conventions. Use when the user asks to review code or check quality."
allowed-tools: Read, Glob, Grep, Bash
user-invocable: true
argument-hint: "[file-or-directory]"
---

## Project Review

When invoked, perform a structured review of the specified file or directory.

### Steps

1. **Identify scope**: If a file is specified via `$ARGUMENTS`, review that file. Otherwise, check recent git changes with `git diff --name-only HEAD~1`.

2. **Security scan**: Check for:
   - Hardcoded secrets or API keys
   - Sensitive data in logs
   - Missing input validation

3. **Code quality**: Check for:
   - Unused imports or variables
   - Functions that are too long (>50 lines)
   - Missing error handling
   - Code duplication

4. **Conventions**: Verify the code follows patterns established in CLAUDE.md and `.claude/rules/`.

### Output

Provide a structured report with findings organized by severity:
- **Critical** — security issues, data leaks
- **Warning** — quality issues, missing tests
- **Info** — style suggestions, minor improvements
