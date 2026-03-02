---
name: serverless-deploy-prep
description: "Prepares a deployment checklist for serverless functions. Use before deploying to staging or production."
allowed-tools: Read, Glob, Grep, Bash
user-invocable: true
argument-hint: "[stage: dev|staging|prod]"
---

## Deployment Preparation

When invoked, perform a pre-deployment check for the specified stage (`$ARGUMENTS` or default to `dev`).

### Steps

1. **Check serverless.yml / template.yml** — verify the deployment config exists and is valid

2. **Environment variables** — verify all required env vars are referenced (not hardcoded):
   - Check for any hardcoded ARNs, endpoints, or credentials
   - Verify stage-specific config uses `${self:provider.stage}` or equivalent

3. **Dependencies** — check `package.json` for:
   - No dev dependencies that shouldn't be in production
   - Lock file exists and is up to date

4. **Code quality** — quick scan for:
   - `console.log` statements (should use structured logging)
   - TODO/FIXME comments in modified files
   - Disabled tests (`it.skip`, `describe.skip`)

5. **Recent changes** — run `git diff --name-only HEAD~5` to show what changed recently

### Output

Provide a deployment checklist:
```
## Deploy Checklist: [stage]

### Pre-deploy
- [ ] Environment variables verified
- [ ] No hardcoded credentials
- [ ] No console.log in production code
- [ ] Tests passing
- [ ] Lock file up to date

### Post-deploy
- [ ] Smoke test endpoints
- [ ] Check CloudWatch for errors
- [ ] Verify DynamoDB table access
```
