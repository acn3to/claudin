# Project Profiles

Profiles are stack-specific presets that extend the base template with tailored rules, skills, and configurations.

## Available Profiles

| Profile | Stack | Key Features |
|---------|-------|-------------|
| `node-api` | Express/Fastify + MongoDB/PostgreSQL | REST patterns, test runner config, async error handling |
| `python` | Flask/FastAPI + SQLAlchemy | Linting standards, docstring conventions, venv handling |
| `monorepo` | Multi-service TypeScript | Service-scoped rules, workspace navigation, cross-service review |
| `frontend-react` | React + TypeScript | Component patterns, accessibility checks, state management |
| `serverless` | AWS Lambda + DynamoDB | Handler patterns, cold start awareness, IaC conventions |
| `generic` | Any | Base template only (default) |

## Using Profiles

### With the installer

```bash
bash scripts/setup.sh /path/to/project
# Select profile when prompted
```

### Manual application

```bash
# Copy base template first
cp -r template/.claude /path/to/project/

# Then overlay profile
cp -r profiles/node-api/.claude/* /path/to/project/.claude/
```

## What Profiles Add

Each profile extends the base template with:

- **Additional rules** — stack-specific coding standards
- **Tailored skills** — framework-aware capabilities
- **Custom agents** — specialized for your stack
- **Permission presets** — auto-allow common commands

The base template hooks (file protection, audit, context re-injection) are always included regardless of profile.

## Creating Custom Profiles

```bash
mkdir -p profiles/my-stack/.claude/{agents,hooks,rules,skills}

# Add your rules
cat > profiles/my-stack/.claude/rules/my-conventions.md << 'EOF'
## My Stack Conventions
...
EOF
```

Then use it: `cp -r profiles/my-stack/.claude/* /path/to/project/.claude/`
