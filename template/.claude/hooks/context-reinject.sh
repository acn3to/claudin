#!/bin/bash
# Context Re-injection Hook
# Reminds Claude of critical project context after context compaction.
# Registered as SessionStart hook with matcher "compact"
#
# Customize the echo below with your project's critical reminders.

cat <<'EOF'
[Post-compaction] Check CLAUDE.md for project conventions.
Never edit .env or credential files. Review the task list before continuing.
EOF

exit 0
