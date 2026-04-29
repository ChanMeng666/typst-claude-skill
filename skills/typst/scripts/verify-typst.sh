#!/usr/bin/env bash
# Verify Typst installation and environment for document generation.

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

pass() { printf "${GREEN}[PASS]${NC} %s\n" "$1"; }
fail() { printf "${RED}[FAIL]${NC} %s\n" "$1"; }
warn() { printf "${YELLOW}[WARN]${NC} %s\n" "$1"; }

echo "=== Typst Environment Check ==="
echo

# Check typst on PATH
if command -v typst &>/dev/null; then
  VERSION=$(typst --version 2>&1 | head -1)
  pass "Typst found: $VERSION"

  # Check version >= 0.14
  VER_NUM=$(echo "$VERSION" | grep -oE '[0-9]+\.[0-9]+' | head -1)
  MAJOR=$(echo "$VER_NUM" | cut -d. -f1)
  MINOR=$(echo "$VER_NUM" | cut -d. -f2)
  if [ "$MAJOR" -eq 0 ] && [ "$MINOR" -lt 14 ]; then
    warn "Typst version $VER_NUM is below 0.14. Some features may not work."
  fi
else
  fail "Typst not found on PATH"
  echo "  Install: winget install --id Typst.Typst  (Windows)"
  echo "           brew install typst                (macOS)"
  echo "           cargo install typst-cli           (Any platform)"
  exit 1
fi

# Check writable directory
if [ -w "." ]; then
  pass "Current directory is writable"
else
  fail "Current directory is not writable"
fi

# List CJK fonts
echo
echo "--- Available CJK Fonts ---"
CJK_FONTS=$(typst fonts 2>/dev/null | grep -iE "source han|simsun|simhei|microsoft yahei|noto sans cjk|noto serif cjk|pingfang|hiragino|yu gothic|malgun" || true)
if [ -n "$CJK_FONTS" ]; then
  pass "CJK fonts found:"
  echo "$CJK_FONTS" | sed 's/^/  /'
else
  warn "No common CJK fonts detected. CJK documents may show missing glyphs."
  echo "  Run 'typst fonts' to see all available fonts."
fi

echo
echo "=== Done ==="
