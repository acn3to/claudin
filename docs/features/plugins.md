# Plugins

Plugins are packages that bundle skills, agents, hooks, and MCP servers together for easy distribution.

## Installing Plugins

```bash
# From the official marketplace
claude plugin install plugin-name@claude-plugins-official

# With scope
claude plugin install plugin-name@claude-plugins-official --scope project  # project-only
claude plugin install plugin-name@claude-plugins-official --scope user     # all projects

# List installed
claude plugin list

# Remove
claude plugin uninstall plugin-name
```

## Recommended Plugins by Stack

### Universal (any project)
| Plugin | What it does |
|--------|-------------|
| `security-guidance` | Security audit patterns and vulnerability detection |
| `context7` | Up-to-date library documentation lookup |

### TypeScript / Node.js
| Plugin | What it does |
|--------|-------------|
| `typescript-lsp` | TypeScript language server for type-aware analysis |
| `pr-review-toolkit` | Structured PR review automation |

### Frontend
| Plugin | What it does |
|--------|-------------|
| `frontend-design` | UI/UX patterns and component design |

### GitHub Integration
| Plugin | What it does |
|--------|-------------|
| `github` | GitHub MCP server — PRs, issues, API from Claude |

## Plugin vs Skill vs Agent

| Component | Purpose | Distribution |
|-----------|---------|-------------|
| **Plugin** | Package that bundles multiple components | Marketplace |
| **Skill** | Single capability Claude can invoke | `.claude/skills/` or via plugin |
| **Agent** | Isolated subagent with restricted tools | `.claude/agents/` or via plugin |

## Plugin Structure (for creating your own)

```
my-plugin/
├── .claude-plugin/
│   └── plugin.json          # Metadata (required)
├── commands/                # Slash commands
├── agents/                  # Custom agents
├── skills/                  # Skills
├── hooks/hooks.json         # Event handlers
├── .mcp.json                # MCP servers
└── settings.json            # Default settings
```

Plugin skills are namespaced: `/plugin-name:skill-name` to prevent conflicts.
