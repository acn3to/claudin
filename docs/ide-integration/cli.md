# CLI

The Claude Code CLI is the most feature-complete surface, with access to all commands, agent teams, and scripting capabilities.

## Installation

```bash
npm install -g @anthropic-ai/claude-code
```

## Essential Commands

| Command | Purpose |
|---------|---------|
| `claude` | Start interactive session |
| `claude -p "prompt"` | Headless mode (non-interactive) |
| `claude --resume` | Resume last conversation |
| `claude --model opus` | Start with specific model |
| `/help` | Show all commands |
| `/model` | Switch model mid-session |
| `/cost` | Show session cost |
| `/context` | Show context usage |
| `/compact` | Manually compact context |
| `/clear` | Clear conversation |
| `/mcp` | Check MCP server status |
| `/doctor` | Diagnose issues |

## Shell Aliases

Add to your `~/.bashrc` or `~/.zshrc`:

```bash
# Quick launch aliases
alias cc='claude'
alias ccs='claude --model sonnet'
alias cco='claude --model opus'
alias cch='claude --model haiku'

# Claude with tmux for agent teams
ct() {
  local session_name="${1:-$(basename "$PWD")}"
  session_name=$(echo "$session_name" | tr '.' '-')
  if tmux has-session -t "$session_name" 2>/dev/null; then
    tmux attach -t "$session_name"
  else
    tmux new-session -s "$session_name" -d
    sleep 0.5
    tmux send-keys -t "$session_name" \
      "export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 && claude" Enter
    tmux attach -t "$session_name"
  fi
}
```

## Environment Variables

| Variable | Purpose |
|----------|---------|
| `ANTHROPIC_API_KEY` | API authentication |
| `ANTHROPIC_MODEL` | Default model |
| `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` | Enable agent teams |
| `CLAUDE_CODE_SUBAGENT_MODEL` | Default model for subagents |
| `CLAUDE_CODE_EFFORT_LEVEL` | Thinking effort (low/medium/high) |
| `ENABLE_TOOL_SEARCH` | MCP tool search threshold |
