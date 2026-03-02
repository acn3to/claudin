# Installation

## Prerequisites

| Tool | Purpose | Install |
|------|---------|---------|
| Claude Code CLI | Core tool | `npm install -g @anthropic-ai/claude-code` |
| jq | Used by hooks for JSON parsing | `sudo apt install jq` / `brew install jq` |
| git | Version control | Usually pre-installed |

## Install Claudin

### Method 1: Interactive Setup (Recommended)

```bash
git clone https://github.com/acn3to/claudin.git
cd claudin
bash scripts/setup.sh /path/to/your-project
```

### Method 2: Manual Copy

```bash
git clone https://github.com/acn3to/claudin.git

# Copy template to your project
cp -r claudin/template/.claude /path/to/your-project/
cp claudin/template/CLAUDE.md /path/to/your-project/
cp claudin/template/.claudeignore /path/to/your-project/
cp -r claudin/template/.github /path/to/your-project/

# Make hooks executable
chmod +x /path/to/your-project/.claude/hooks/*.sh

# Add .claude/ to gitignore
echo ".claude/" >> /path/to/your-project/.gitignore
```

### Method 3: Global Config Only

If you just want the status line and keybindings:

```bash
cp claudin/global/statusline.sh ~/.claude/
cp claudin/global/keybindings.json ~/.claude/
chmod +x ~/.claude/statusline.sh
```

## Verify Installation

```bash
cd /path/to/your-project
claude

# Inside Claude Code:
/doctor              # Check for issues
/mcp                 # Check MCP servers
```

## Next Steps

1. [Quick Start](quick-start.md) — configure your project
2. [Profiles](profiles.md) — choose a stack-specific preset
