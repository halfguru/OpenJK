#!/bin/sh
#
# Install git hooks for OpenJK
#
# Usage: sh scripts/install-hooks.sh
#

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
HOOKS_DIR="$(cd "$SCRIPT_DIR/.." && pwd)/.git/hooks"

if [ ! -d "$HOOKS_DIR" ]; then
    echo "error: .git/hooks not found. Are you in the OpenJK repository?"
    exit 1
fi

cp "$SCRIPT_DIR/pre-commit-hook.sh" "$HOOKS_DIR/pre-commit"
chmod +x "$HOOKS_DIR/pre-commit"

echo "Installed pre-commit hook."
