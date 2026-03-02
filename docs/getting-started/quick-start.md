# Quick Start

After [installation](installation.md), follow these steps to configure your project.

## Step 1: Edit CLAUDE.md

Open `CLAUDE.md` in your project root and fill in:

- **What the project is** — one paragraph
- **Tech stack** — runtime, framework, database
- **Project structure** — directory layout
- **Key conventions** — non-obvious patterns only
- **Common commands** — build, test, deploy
- **Security rules** — non-negotiable constraints

!!! tip
    Keep it under 200 lines. Move detailed standards to `.claude/rules/`.

## Step 2: Customize Hooks

Edit `.claude/hooks/context-reinject.sh` with project-specific reminders:

```bash
cat <<'EOF'
[Post-compaction] Check CLAUDE.md for conventions.
Never edit .env files. Always run tests before committing.
Our API uses snake_case for JSON keys.
EOF
```

## Step 3: Add Stack-Specific Rules

Create rules in `.claude/rules/` for your stack:

```bash
# Example: API conventions
cat > .claude/rules/api-conventions.md << 'EOF'
## API Conventions
- All endpoints return `{ success, data, error }` format
- Use HTTP status codes: 200, 400, 401, 403, 404, 500
- Validate request body with Zod/Joi at the handler level
EOF
```

## Step 4: Install Plugins

```bash
# Universal
claude plugin install security-guidance@claude-plugins-official --scope project
claude plugin install context7@claude-plugins-official --scope project

# TypeScript projects
claude plugin install typescript-lsp@claude-plugins-official --scope project
```

## Step 5: Start Coding

```bash
cd your-project
claude
```

You now have:

- Security hooks protecting sensitive files
- Audit logging for all file changes
- Context re-injection after compaction
- A code reviewer and documenter agent ready to delegate to
- A customized status line showing model, context, cost, and git info
