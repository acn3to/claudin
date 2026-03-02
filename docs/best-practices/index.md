# Best Practices

Lessons learned from configuring Claude Code across multiple real-world projects.

## Top 10 Practices

1. **Keep CLAUDE.md under 200 lines** — it loads every session. Move details to skills and rules.

2. **Start with restrictive permissions** — allow more as needed. Recovering from accidents is expensive.

3. **Use Sonnet as your daily driver** — it handles 90% of tasks. Save Opus for architecture decisions.

4. **Set subagent models to Haiku** — `model: haiku` on read-only agents saves 85-92% on token costs.

5. **Protect .env files with hooks** — Claude is helpful and will try to edit them if you let it.

6. **Use `/clear` between unrelated tasks** — prevents context pollution and keeps sessions focused.

7. **Create focused skills, not giant ones** — one skill per job. Load on-demand instead of always.

8. **Audit all file changes** — the audit hook gives you traceability for free.

9. **Don't over-configure** — start with the Claudin defaults and customize as needs arise.

10. **Read the status line** — when context hits yellow (70%+), consider compacting or starting fresh.
