# Agent SDK

The Claude Agent SDK provides programmatic access to Claude Code for building custom applications and integrations.

## Installation

=== "TypeScript"
    ```bash
    npm install @anthropic-ai/claude-agent-sdk
    ```

=== "Python"
    ```bash
    pip install claude-agent-sdk
    ```

## Basic Usage

=== "TypeScript"
    ```typescript
    import { query } from "@anthropic-ai/claude-agent-sdk";

    for await (const message of query({
      prompt: "Find and fix the bug in auth.py",
      options: { allowedTools: ["Read", "Edit", "Bash"] }
    })) {
      console.log(message);
    }
    ```

=== "Python"
    ```python
    from claude_agent_sdk import query, ClaudeAgentOptions

    async for message in query(
        prompt="Find and fix the bug in auth.py",
        options=ClaudeAgentOptions(allowed_tools=["Read", "Edit", "Bash"]),
    ):
        print(message)
    ```

## Structured Output

=== "TypeScript"
    ```typescript
    import { z } from "zod";

    const schema = z.object({
      functions: z.array(z.string()),
      total: z.number()
    });

    for await (const message of query({
      prompt: "Extract function names from auth.py",
      options: {
        outputFormat: { type: "json", schema: schema.parse }
      }
    })) {
      if ("structured_output" in message) {
        const result = message.structured_output;
      }
    }
    ```

## When to Use

| Use Case | Best Approach |
|----------|--------------|
| Interactive development | CLI (`claude`) |
| CI/CD pipelines | CLI headless (`claude -p`) or SDK |
| Custom applications | Agent SDK |
| One-off tasks | CLI |
| Production automation | Agent SDK |
