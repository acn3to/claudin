# Getting Started

This guide takes you from zero to a fully configured Claude Code environment.

## Prerequisites

- [Claude Code CLI](https://code.claude.com) installed and authenticated
- A project you want to configure
- `jq` installed (used by hooks): `sudo apt install jq` / `brew install jq`

## Setup Options

### Option 1: Interactive Installer (Recommended)

```bash
git clone https://github.com/acn3to/claudin.git
cd claudin
bash scripts/setup.sh /path/to/your-project
```

The installer will:

1. Ask you to select a [project profile](profiles.md)
2. Copy the template files (`.claude/`, `CLAUDE.md`, `.claudeignore`)
3. Apply profile-specific overrides
4. Optionally set up global config (status line, keybindings)
5. Add `.claude/` to your `.gitignore`

### Option 2: Manual Setup

```bash
# Copy base template
cp -r template/.claude /path/to/your-project/
cp template/CLAUDE.md /path/to/your-project/
cp template/.claudeignore /path/to/your-project/

# Make hooks executable
chmod +x /path/to/your-project/.claude/hooks/*.sh

# Optional: copy global config
cp global/statusline.sh ~/.claude/
cp global/keybindings.json ~/.claude/
chmod +x ~/.claude/statusline.sh
```

## After Setup

1. **Edit `CLAUDE.md`** — fill in your project description, stack, structure, and conventions
2. **Customize hooks** — edit `.claude/hooks/context-reinject.sh` with your project's critical reminders
3. **Add rules** — create stack-specific rules in `.claude/rules/`
4. **Install plugins** — see [Plugins](../features/plugins.md) for recommendations
5. **Start Claude Code** — `cd your-project && claude`

## File Locations

| File | Scope | Purpose |
|------|-------|---------|
| `~/.claude/settings.json` | Global (all projects) | Permissions, status line, notifications |
| `~/.claude/statusline.sh` | Global | Status bar script |
| `~/.claude/keybindings.json` | Global | CLI keyboard shortcuts |
| `.claude/settings.json` | Project (shared via git) | Team permissions, hooks |
| `.claude/settings.local.json` | Project (gitignored) | Personal overrides |
| `CLAUDE.md` | Project | Instructions Claude reads every session |
| `.claudeignore` | Project | Files excluded from Claude's context |
| `.claude/rules/` | Project | Auto-loaded rules (by glob match) |
| `.claude/skills/` | Project | Reusable capabilities |
| `.claude/agents/` | Project | Custom subagents |
| `.claude/hooks/` | Project | Lifecycle scripts |
