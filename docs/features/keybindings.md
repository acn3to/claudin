# Keybindings

Customize keyboard shortcuts for the Claude Code CLI. Keybindings apply to CLI and Desktop only — VS Code uses its own native keybinding system.

## Configuration

File: `~/.claude/keybindings.json`

```json
{
  "$schema": "https://www.schemastore.org/claude-code-keybindings.json",
  "bindings": [
    {
      "context": "Chat",
      "bindings": {
        "ctrl+e": "chat:externalEditor",
        "ctrl+p": "chat:modelPicker",
        "ctrl+t": "chat:thinkingToggle",
        "ctrl+s": "chat:stash"
      }
    }
  ]
}
```

## Useful Actions

| Action | Default | Purpose |
|--------|---------|---------|
| `chat:submit` | Enter | Submit message |
| `chat:cancel` | Escape | Cancel input |
| `chat:externalEditor` | Ctrl+G | Open in external editor (vim, nano) |
| `chat:modelPicker` | Ctrl+P | Switch models |
| `chat:thinkingToggle` | Ctrl+T | Toggle extended thinking |
| `chat:stash` | Ctrl+S | Stash current prompt |
| `chat:cycleMode` | Shift+Tab | Cycle permission modes |

## Reserved Keys

These cannot be rebound:

- `Ctrl+C` — interrupt
- `Ctrl+D` — exit

## tmux Conflicts

If using tmux, beware of `Ctrl+B` (tmux prefix). Consider rebinding or using a different tmux prefix.

## Setup

```bash
cp global/keybindings.json ~/.claude/
```

Run `/doctor` inside Claude Code to check for keybinding warnings.
