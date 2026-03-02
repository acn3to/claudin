# Status Line

The status line is a customizable bar at the bottom of Claude Code that displays real-time session information. It runs locally and does not consume API tokens.

## Claudin's Status Line

```
[Opus] my-project | main ~3 | [====------] 42% | $1.37 | 3m 5s
```

Shows: **model**, **directory**, **git branch + changes**, **context usage** (color-coded), **session cost**, **duration**.

## Setup

```bash
# Copy the script
cp global/statusline.sh ~/.claude/
chmod +x ~/.claude/statusline.sh
```

Add to `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline.sh"
  }
}
```

## Available Data

Your status line script receives JSON via stdin with these fields:

| Field | Example |
|-------|---------|
| `model.display_name` | `"Opus"` |
| `context_window.used_percentage` | `42.5` |
| `cost.total_cost_usd` | `1.37` |
| `cost.total_duration_ms` | `185000` |
| `workspace.current_dir` | `"/home/user/project"` |
| `session_id` | `"abc-123-..."` |
| `vim.mode` | `"NORMAL"` or `"INSERT"` |

## Customization

Edit `~/.claude/statusline.sh` to change what's displayed. The script can be written in any language (bash, python, node).

### Color Codes

```bash
CYAN='\033[36m'    # Model name
GREEN='\033[32m'   # Git branch, low usage
YELLOW='\033[33m'  # Cost, modified files, medium usage
RED='\033[31m'     # High context usage (90%+)
DIM='\033[2m'      # Separators, duration
RESET='\033[0m'
```

### Context Bar Colors

| Usage | Color | Meaning |
|-------|-------|---------|
| < 70% | Green | Plenty of context remaining |
| 70-89% | Yellow | Getting full, consider `/compact` |
| 90%+ | Red | Near limit, compaction imminent |

## Quick Alternative

Use the built-in `/statusline` command to generate a script interactively:

```
/statusline show model name and context percentage with a progress bar
```
