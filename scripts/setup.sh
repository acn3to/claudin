#!/bin/bash
# Claudin Setup Script
# Interactive installer for Claude Code environment
#
# Usage: bash scripts/setup.sh [target-directory]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR/template"
PROFILES_DIR="$SCRIPT_DIR/profiles"
GLOBAL_DIR="$SCRIPT_DIR/global"

# Colors
CYAN='\033[36m'
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

echo -e "${CYAN}${BOLD}"
echo "  ╔═══════════════════════════════════╗"
echo "  ║         Claudin Setup             ║"
echo "  ║  Claude Code Environment Builder  ║"
echo "  ╚═══════════════════════════════════╝"
echo -e "${RESET}"

# --- Target directory ---
TARGET="${1:-}"
if [ -z "$TARGET" ]; then
    echo -e "${YELLOW}Where should we set up the Claude Code environment?${RESET}"
    echo -e "${DIM}Enter the path to your project directory:${RESET}"
    read -r -p "> " TARGET
fi

TARGET=$(realpath "$TARGET" 2>/dev/null || echo "$TARGET")

if [ ! -d "$TARGET" ]; then
    echo -e "${RED}Error: Directory '$TARGET' does not exist.${RESET}"
    exit 1
fi

echo -e "\n${GREEN}Target: $TARGET${RESET}\n"

# --- Check for existing config ---
if [ -d "$TARGET/.claude" ]; then
    echo -e "${YELLOW}Warning: .claude/ directory already exists in $TARGET${RESET}"
    read -r -p "Overwrite existing configuration? (y/N) " OVERWRITE
    if [[ ! "$OVERWRITE" =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 0
    fi
fi

# --- Profile selection ---
echo -e "${BOLD}Select a project profile:${RESET}\n"
echo "  1) node-api        — Express/Fastify + MongoDB/PostgreSQL"
echo "  2) python           — Flask/FastAPI + SQLAlchemy"
echo "  3) monorepo         — Multi-service TypeScript"
echo "  4) frontend-react   — React + TypeScript"
echo "  5) serverless       — AWS Lambda + DynamoDB"
echo "  6) generic          — Minimal setup (template only)"
echo ""
read -r -p "Choice [1-6]: " PROFILE_CHOICE

case "$PROFILE_CHOICE" in
    1) PROFILE="node-api" ;;
    2) PROFILE="python" ;;
    3) PROFILE="monorepo" ;;
    4) PROFILE="frontend-react" ;;
    5) PROFILE="serverless" ;;
    *) PROFILE="generic" ;;
esac

echo -e "\n${GREEN}Profile: $PROFILE${RESET}\n"

# --- Copy template files ---
echo -e "${CYAN}Setting up base template...${RESET}"

# Copy base template
cp -r "$TEMPLATE_DIR/.claude" "$TARGET/"
cp "$TEMPLATE_DIR/.claudeignore" "$TARGET/"

# Copy CLAUDE.md only if it doesn't exist
if [ ! -f "$TARGET/CLAUDE.md" ]; then
    cp "$TEMPLATE_DIR/CLAUDE.md" "$TARGET/"
    echo -e "  ${GREEN}+${RESET} CLAUDE.md"
else
    echo -e "  ${YELLOW}~${RESET} CLAUDE.md (kept existing)"
fi

# Copy GitHub Actions
if [ ! -d "$TARGET/.github/workflows" ]; then
    mkdir -p "$TARGET/.github/workflows"
fi
cp "$TEMPLATE_DIR/.github/workflows/claude-review.yml" "$TARGET/.github/workflows/"

echo -e "  ${GREEN}+${RESET} .claude/ (settings, hooks, agents, rules, skills)"
echo -e "  ${GREEN}+${RESET} .claudeignore"
echo -e "  ${GREEN}+${RESET} .github/workflows/claude-review.yml"

# --- Apply profile overrides ---
if [ "$PROFILE" != "generic" ] && [ -d "$PROFILES_DIR/$PROFILE" ]; then
    echo -e "\n${CYAN}Applying $PROFILE profile...${RESET}"
    cp -r "$PROFILES_DIR/$PROFILE/.claude/"* "$TARGET/.claude/" 2>/dev/null || true

    # Count what was added
    PROFILE_FILES=$(find "$PROFILES_DIR/$PROFILE" -type f | wc -l | tr -d ' ')
    echo -e "  ${GREEN}+${RESET} $PROFILE_FILES profile-specific files"
fi

# --- Make hooks executable ---
chmod +x "$TARGET/.claude/hooks/"*.sh 2>/dev/null || true

# --- Global setup ---
echo ""
read -r -p "Also set up global config (status line, keybindings)? (Y/n) " SETUP_GLOBAL
if [[ ! "$SETUP_GLOBAL" =~ ^[Nn]$ ]]; then
    echo -e "\n${CYAN}Setting up global config...${RESET}"

    CLAUDE_DIR="$HOME/.claude"
    mkdir -p "$CLAUDE_DIR"

    # Status line
    if [ ! -f "$CLAUDE_DIR/statusline.sh" ]; then
        cp "$GLOBAL_DIR/statusline.sh" "$CLAUDE_DIR/"
        chmod +x "$CLAUDE_DIR/statusline.sh"
        echo -e "  ${GREEN}+${RESET} ~/.claude/statusline.sh"
    else
        echo -e "  ${YELLOW}~${RESET} ~/.claude/statusline.sh (kept existing)"
    fi

    # Keybindings
    if [ ! -f "$CLAUDE_DIR/keybindings.json" ]; then
        cp "$GLOBAL_DIR/keybindings.json" "$CLAUDE_DIR/"
        echo -e "  ${GREEN}+${RESET} ~/.claude/keybindings.json"
    else
        echo -e "  ${YELLOW}~${RESET} ~/.claude/keybindings.json (kept existing)"
    fi

    # Settings (merge statusLine into existing settings if present)
    if [ -f "$CLAUDE_DIR/settings.json" ]; then
        # Check if statusLine is already configured
        if ! jq -e '.statusLine' "$CLAUDE_DIR/settings.json" > /dev/null 2>&1; then
            # Add statusLine to existing settings
            TMP=$(mktemp)
            jq '. + {"statusLine": {"type": "command", "command": "~/.claude/statusline.sh"}}' \
                "$CLAUDE_DIR/settings.json" > "$TMP" && mv "$TMP" "$CLAUDE_DIR/settings.json"
            echo -e "  ${GREEN}+${RESET} Added statusLine to ~/.claude/settings.json"
        else
            echo -e "  ${YELLOW}~${RESET} ~/.claude/settings.json (statusLine already set)"
        fi
    else
        cp "$GLOBAL_DIR/settings.json" "$CLAUDE_DIR/"
        echo -e "  ${GREEN}+${RESET} ~/.claude/settings.json"
    fi
fi

# --- Add .claude to .gitignore ---
if [ -f "$TARGET/.gitignore" ]; then
    if ! grep -q "^\.claude/$" "$TARGET/.gitignore" 2>/dev/null; then
        echo "" >> "$TARGET/.gitignore"
        echo "# Claude Code config (local, not committed)" >> "$TARGET/.gitignore"
        echo ".claude/" >> "$TARGET/.gitignore"
        echo -e "\n${GREEN}+${RESET} Added .claude/ to .gitignore"
    fi
fi

# --- Summary ---
echo -e "\n${GREEN}${BOLD}Setup complete!${RESET}\n"
echo -e "  Project:  $TARGET"
echo -e "  Profile:  $PROFILE"
echo -e ""
echo -e "${BOLD}Next steps:${RESET}"
echo -e "  1. Edit ${CYAN}$TARGET/CLAUDE.md${RESET} with your project details"
echo -e "  2. Customize ${CYAN}$TARGET/.claude/hooks/context-reinject.sh${RESET} with project reminders"
echo -e "  3. Add project-specific rules to ${CYAN}$TARGET/.claude/rules/${RESET}"
echo -e "  4. Start Claude Code: ${CYAN}cd $TARGET && claude${RESET}"
echo -e ""
echo -e "${DIM}Full docs: https://acn3to.github.io/claudin${RESET}"
