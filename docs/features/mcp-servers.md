# MCP Servers

MCP (Model Context Protocol) servers connect Claude Code to external tools, APIs, and databases.

## Adding MCP Servers

```bash
# HTTP transport (remote servers)
claude mcp add --transport http github https://api.githubcopilot.com/mcp/

# Stdio transport (local processes)
claude mcp add --transport stdio filesystem \
  -- npx -y @modelcontextprotocol/server-filesystem /path/to/workspace

# With environment variables
claude mcp add --transport stdio airtable \
  --env AIRTABLE_API_KEY=YOUR_KEY \
  -- npx -y airtable-mcp-server
```

## Project-Scoped Configuration

Share MCP servers with your team via `.mcp.json`:

```json
{
  "mcpServers": {
    "context7": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@context7/mcp-server"]
    }
  }
}
```

Environment variable expansion is supported:

```json
{
  "mcpServers": {
    "api-server": {
      "type": "http",
      "url": "${API_BASE_URL}/mcp",
      "headers": {
        "Authorization": "Bearer ${API_KEY}"
      }
    }
  }
}
```

## Recommended MCP Servers

| Server | Purpose | Install |
|--------|---------|---------|
| **Context7** | Library documentation lookup | Plugin or stdio |
| **GitHub** | Repository, PRs, issues | Plugin or HTTP |
| **Filesystem** | Advanced file operations | stdio |

## Managing Servers

```bash
claude mcp list              # List all servers
claude mcp get github        # Get details
claude mcp remove github     # Remove
/mcp                         # Check status in Claude Code
```

## When to Use MCP vs CLI

!!! tip "Prefer CLI tools over MCP when possible"
    Tools like `gh`, `aws`, `gcloud` have no persistent context overhead. MCP servers consume context for tool definitions. Use MCP only when CLI doesn't cover your needs.
