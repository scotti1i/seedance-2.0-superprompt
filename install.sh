#!/usr/bin/env bash
#
# install.sh — Install seedance-2.0-superprompt skill to ~/.claude/skills/
#
# Usage:
#   bash install.sh                  # install via cp
#   bash install.sh --symlink        # install via symlink (for contributors)
#   bash install.sh --uninstall      # remove the installed skill
#
# Manual install (alternative):
#   git clone https://github.com/scotti1i/seedance-2.0-superprompt.git
#   cp -r seedance-2.0-superprompt/seedance ~/.claude/skills/seedance

set -euo pipefail

SKILL_NAME=seedance
SKILL_DEST="${HOME}/.claude/skills/${SKILL_NAME}"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_SRC="${REPO_ROOT}/seedance"

color() { printf '\033[%sm%s\033[0m' "$1" "$2"; }
say()   { echo "$(color "$1" "$2")"; }
ok()    { say "1;32" "✓ $*"; }
info()  { say "1;36" "→ $*"; }
warn()  { say "1;33" "! $*"; }
die()   { say "1;31" "✗ $*"; exit 1; }

# ============================================================
# Parse args
# ============================================================
MODE=cp
if [ "${1:-}" = "--symlink" ]; then
  MODE=symlink
elif [ "${1:-}" = "--uninstall" ]; then
  MODE=uninstall
fi

# ============================================================
# Pre-flight
# ============================================================
[ -d "${SKILL_SRC}" ] || die "Cannot find ${SKILL_SRC} — are you running this from the repo root?"

[ -f "${SKILL_SRC}/SKILL.md" ] || die "Missing SKILL.md in ${SKILL_SRC} — repo may be incomplete"

mkdir -p "$(dirname "${SKILL_DEST}")"

# ============================================================
# Uninstall
# ============================================================
if [ "${MODE}" = "uninstall" ]; then
  if [ -L "${SKILL_DEST}" ] || [ -d "${SKILL_DEST}" ]; then
    rm -rf "${SKILL_DEST}"
    ok "Removed ${SKILL_DEST}"
  else
    info "Skill not installed (nothing to remove)"
  fi
  exit 0
fi

# ============================================================
# Backup existing install
# ============================================================
if [ -L "${SKILL_DEST}" ] || [ -d "${SKILL_DEST}" ]; then
  BACKUP="${SKILL_DEST}.bak.$(date +%s)"
  mv "${SKILL_DEST}" "${BACKUP}"
  warn "Existing skill backed up to ${BACKUP}"
fi

# ============================================================
# Install
# ============================================================
if [ "${MODE}" = "symlink" ]; then
  ln -s "${SKILL_SRC}" "${SKILL_DEST}"
  ok "Symlinked ${SKILL_SRC} → ${SKILL_DEST}"
else
  cp -r "${SKILL_SRC}" "${SKILL_DEST}"
  ok "Copied ${SKILL_SRC} → ${SKILL_DEST}"
fi

# ============================================================
# Verify
# ============================================================
[ -f "${SKILL_DEST}/SKILL.md" ] || die "Install verification failed: missing SKILL.md"

ok "Installed seedance-prompt skill"
echo
info "Restart Claude Code, then try:"
echo "   /seedance 10s vertical cat playing with a ball in soft afternoon light"
echo
info "Or browse templates:"
echo "   cat ${SKILL_DEST}/templates/INDEX.md"
echo
info "Methodology speed-run:"
echo "   cat ${SKILL_DEST}/methodology.md | head -100"
