# VS Code Extension

## Installation

1. Open VS Code
2. `Ctrl+Shift+X` → search "Claude Code"
3. Install the Anthropic extension
4. Requires VS Code 1.98.0+

## Key Features

- **Inline diffs** — side-by-side comparison of changes
- **@-mentions** — reference files with line ranges (`@file.ts#5-10`)
- **Checkpoints** — rewind code to previous conversation states
- **Plan mode** — review Claude's plan before accepting
- **Auto-accept mode** — skip permission prompts for edits

## Shortcuts

| Action | Mac | Windows/Linux |
|--------|-----|---------------|
| Focus input | `Cmd+Esc` | `Ctrl+Esc` |
| New conversation | `Cmd+N` | `Ctrl+N` |
| Insert file reference | `Option+K` | `Alt+K` |
| New tab | `Cmd+Shift+Esc` | `Ctrl+Shift+Esc` |

## Settings

Access via VS Code settings (`Cmd+,` / `Ctrl+,`) → search "Claude":

| Setting | Purpose |
|---------|---------|
| `selectedModel` | Default model for new conversations |
| `useTerminal` | Launch in CLI-style instead of graphical panel |
| `initialPermissionMode` | Control approval prompts |
| `preferredLocation` | Open in `sidebar` or `panel` |

## CLI in VS Code

You can run the CLI inside VS Code's integrated terminal for advanced features not available in the extension (agent teams, all slash commands, shell shortcuts).

## Shared Configuration

The extension reads the same config files as the CLI:

- `CLAUDE.md` — project instructions
- `.claude/settings.json` — permissions, hooks
- `.claude/skills/` — skills
- `.claude/agents/` — agents
- `.mcp.json` — MCP servers

Changes made in one surface are immediately available in the other.
