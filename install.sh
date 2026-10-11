#!/usr/bin/env bash
# Install ALL skills into the CURRENT project (only this project, nothing global).
#   Claude Code reads  <project>/.claude/skills
#   Codex reads        <project>/.agents/skills
# Works on Linux, macOS and Windows (Git Bash / WSL). Windows without bash: use install.ps1.
#
# One-liner, run from your project root:
#   git clone --depth 1 https://github.com/0xcipherdaemon/skillz.git .skillz && bash .skillz/install.sh && rm -rf .skillz
#
# Options:
#   --target claude|codex|both   where to install (default: both)
#   --only a,b                   only these groups (e.g. --only ui-design,animation)
#   --skip a,b                   everything except these groups
set -eu
HERE="$(cd "$(dirname "$0")" && pwd)"
TARGET="both"; ONLY=""; SKIP=""
while [ $# -gt 0 ]; do
  case "$1" in
    --target) TARGET="${2:-}"; shift 2 ;;
    --only) ONLY="${2:-}"; shift 2 ;;
    --skip) SKIP="${2:-}"; shift 2 ;;
    -h|--help) sed -n '2,15p' "$0"; exit 0 ;;
    *) echo "Unknown option: $1 (try --help)" >&2; exit 1 ;;
  esac
done
case "$TARGET" in claude) DESTS=".claude/skills" ;; codex) DESTS=".agents/skills" ;; both) DESTS=".claude/skills .agents/skills" ;;
  *) echo "--target must be claude, codex or both" >&2; exit 1 ;; esac
in_list() { case ",$2," in *",$1,"*) return 0 ;; *) return 1 ;; esac; }
count=0
for gdir in "$HERE"/plugins/*/; do
  g="$(basename "$gdir")"
  [ -d "$gdir/skills" ] || continue
  if [ -n "$ONLY" ] && ! in_list "$g" "$ONLY"; then continue; fi
  if [ -n "$SKIP" ] && in_list "$g" "$SKIP"; then continue; fi
  for s in "$gdir"skills/*/; do
    s="${s%/}"; n="$(basename "$s")"
    for d in $DESTS; do mkdir -p "$d"; rm -rf "$d/$n"; cp -R "$s" "$d/$n"; done
    count=$((count+1))
  done
done
echo "Installed $count skills into: $DESTS  (in $(pwd))"
