# Agent Teams

Agent teams enable multiple Claude instances to work on a project simultaneously, coordinating through shared task lists and messaging.

## When to Use Teams

Teams are worth the token cost when:

- You have **truly parallel work** (one codes, one tests, one reviews)
- Tasks are **independent** and don't share state
- You can **run things** (tests, builds, linters) — not just read code

Teams are NOT worth it when:

- Work is sequential (read → write → review)
- You can't run tests or builds locally
- Tasks are small enough for a single agent
- You're optimizing for cost

!!! warning "Token cost"
    Agent teams use ~7x more tokens than single-agent sessions. Each teammate maintains its own full context window.

## Setup

```bash
# Enable agent teams
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1

# Set teammate mode
# In ~/.claude/settings.json:
{
  "teammateMode": "tmux"   # or "auto"
}
```

## Modes

| Mode | How teammates run |
|------|------------------|
| `tmux` | Each teammate in a tmux pane (visible) |
| `auto` | Auto-detects tmux, falls back to in-process |

## Usage

Once enabled, Claude can spawn teammates when given complex parallel tasks:

```
"Set up the authentication module. Have one agent write the code,
another write the tests, and another update the documentation."
```

## Best Practices

- Keep teams small (2-3 teammates)
- Use Sonnet for teammates (balance of capability and cost)
- Clean up teams when work is done
- Give clear, independent tasks to each teammate
