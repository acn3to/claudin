# GitHub Actions

The official [`anthropics/claude-code-action`](https://github.com/anthropics/claude-code-action) provides automated code review and PR interaction.

## Quick Setup

```bash
# Inside Claude Code
/install-github-app
```

This guides you through GitHub app installation and secret configuration.

## Workflow Template

Claudin includes a ready-to-use workflow at `template/.github/workflows/claude-review.yml`:

```yaml
name: Claude Code Review

on:
  pull_request:
    types: [opened, synchronize]
  issue_comment:
    types: [created]

jobs:
  claude-review:
    if: >
      github.event_name == 'pull_request' ||
      (github.event_name == 'issue_comment' &&
       contains(github.event.comment.body, '@claude'))
    runs-on: ubuntu-latest
    permissions:
      contents: read
      pull-requests: write
      issues: write
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - uses: anthropics/claude-code-action@v1
        with:
          anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
          claude_args: >
            --append-system-prompt "Review for security, quality,
            and adherence to CLAUDE.md conventions."
            --max-turns 10
```

## Configuration

| Parameter | Description |
|-----------|-------------|
| `anthropic_api_key` | API key (required) |
| `prompt` | Custom instructions |
| `claude_args` | CLI arguments |
| `trigger_phrase` | Custom trigger (default: `@claude`) |
| `use_bedrock` | Use AWS Bedrock |
| `use_vertex` | Use Google Vertex AI |

## Use Cases

- **Auto-review PRs** — trigger on `pull_request` events
- **@claude mentions** — respond to comments in issues/PRs
- **Scheduled audits** — cron-based security reviews
- **Path-specific reviews** — only review changes to critical directories
