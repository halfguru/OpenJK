#!/bin/sh
#
# Pre-commit hook: auto-format staged C/C++ files with clang-format
#
# Install: copy to .git/hooks/pre-commit (no .sample extension)
# Skip:    git commit --no-verify

# Get list of staged C/C++ files
FILES=$(git diff --cached --name-only --diff-filter=ACM | grep -E '\.(cpp|c|h|hpp|cxx|ixx)$' | grep -v '^lib/' | grep -v '^build/' | grep -v '^tests/')

if [ -z "$FILES" ]; then
    exit 0
fi

# Check if clang-format is available
if ! command -v clang-format >/dev/null 2>&1; then
    echo "warning: clang-format not found, skipping format check"
    exit 0
fi

# Format each file and re-stage if changed
FORMAT_FAILED=0
for f in $FILES; do
    if [ -f "$f" ]; then
        clang-format -i "$f"
        git add "$f"
    fi
done

exit 0
