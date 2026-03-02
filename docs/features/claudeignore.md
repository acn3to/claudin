# .claudeignore

The `.claudeignore` file excludes files from Claude's context window, similar to `.gitignore` but specifically for Claude Code. Claude already respects `.gitignore` — use `.claudeignore` for files that are git-tracked but shouldn't be read by Claude.

## When to Use

- **Lock files** — `package-lock.json`, `yarn.lock` (large, auto-generated)
- **Build outputs** — `dist/`, `build/` (compiled, not source)
- **Coverage reports** — `coverage/` (generated HTML/JSON)
- **Binary assets** — images, fonts, media files
- **Minified files** — `*.min.js`, `*.min.css`

## Claudin's Default

```
# Package lock files
package-lock.json
yarn.lock
pnpm-lock.yaml

# Build outputs
dist/
build/
.esbuild/
.serverless/
.next/
out/

# Coverage reports
coverage/
.nyc_output/
*.lcov
htmlcov/

# Test snapshots
__snapshots__/

# Binary assets
*.png
*.jpg
*.jpeg
*.gif
*.svg
*.ico
*.woff
*.woff2
*.ttf
*.eot

# Minified files
*.min.js
*.min.css
*.map

# Infrastructure state
*.tfstate
*.tfstate.backup
.terraform/
.dynamodb/
```

## Impact

Excluding `package-lock.json` alone saves **30,000-100,000 tokens** per session on a typical Node.js project. Multiple lock files in a monorepo can save even more.
