# IDE Integration

Claude Code runs on multiple surfaces that share the same engine and configuration.

## Surfaces

| Surface | Best For |
|---------|---------|
| **CLI** (`claude`) | Full control, all features, tmux teams, scripting |
| **VS Code Extension** | Visual diffs, file references, inline review |

Both share: `CLAUDE.md`, `settings.json`, hooks, skills, agents, plugins, MCP servers, and conversation history.

## Which to Use

Use **CLI** when you want:

- All slash commands and features
- Agent teams (tmux mode)
- Shell shortcuts (`!` for bash)
- Tab completion
- Custom keybindings
- Headless/scripted usage

Use **VS Code** when you want:

- Visual side-by-side diffs
- Clickable `@file` references
- Checkpoints (visual rewind)
- Integrated with your editor workflow

Use **both** for maximum productivity — they can run simultaneously and even resume each other's conversations.
