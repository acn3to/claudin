#!/bin/bash
# Claude Code Status Line
# Shows: [Model] dir | branch +staged ~modified | [===-------] 25% | $0.42 | 3m 12s

input=$(cat)

# Parse JSON
MODEL=$(echo "$input" | jq -r '.model.display_name // "Claude"')
DIR=$(echo "$input" | jq -r '.workspace.current_dir // ""')
DIR="${DIR##*/}"
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
DURATION_MS=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')

# Colors
CYAN='\033[36m'
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
DIM='\033[2m'
RESET='\033[0m'

# Context bar — color by usage
if [ "$PCT" -ge 90 ]; then BAR_COLOR="$RED"
elif [ "$PCT" -ge 70 ]; then BAR_COLOR="$YELLOW"
else BAR_COLOR="$GREEN"
fi

BAR_WIDTH=10
FILLED=$((PCT * BAR_WIDTH / 100))
EMPTY=$((BAR_WIDTH - FILLED))
BAR_FILL=$(printf "%${FILLED}s" | tr ' ' '=')
BAR_EMPTY=$(printf "%${EMPTY}s" | tr ' ' '-')
BAR="[${BAR_FILL}${BAR_EMPTY}]"

# Duration
MINS=$((DURATION_MS / 60000))
SECS=$(((DURATION_MS % 60000) / 1000))

# Cost
COST_FMT=$(printf '$%.2f' "$COST")

# Git info
BRANCH=""
GIT_INFO=""
if git rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null)
    STAGED=$(git diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
    MODIFIED=$(git diff --numstat 2>/dev/null | wc -l | tr -d ' ')

    GIT_INFO="${DIM}|${RESET} ${GREEN}${BRANCH}${RESET}"
    [ "$STAGED" -gt 0 ] && GIT_INFO="$GIT_INFO ${GREEN}+${STAGED}${RESET}"
    [ "$MODIFIED" -gt 0 ] && GIT_INFO="$GIT_INFO ${YELLOW}~${MODIFIED}${RESET}"
fi

echo -e "${CYAN}[${MODEL}]${RESET} ${DIR} ${GIT_INFO} ${DIM}|${RESET} ${BAR_COLOR}${BAR}${RESET} ${PCT}% ${DIM}|${RESET} ${YELLOW}${COST_FMT}${RESET} ${DIM}|${RESET} ${DIM}${MINS}m ${SECS}s${RESET}"
