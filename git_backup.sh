#!/bin/bash

# ── 1) Require root ─────────────────────────────────────────────────────────────────
if (( EUID != 0 )); then
  echo "⚠️  This script must be run as root: sudo $0"
  exit 1
fi

# ── 2) Setup ───────────────────────────────────────────────────────────────────────
base="github"
shopt -s nullglob dotglob

# ── 3) Main loop ──────────────────────────────────────────────────────────────────
for parent in "$base"/*; do
  [ -d "$parent" ] || continue

  for dir in "$parent"/*; do
    [ -d "$dir" ] || continue

    # Skip non‑Git folders
    if [ ! -d "$dir/.git" ]; then
      continue
    fi

    # Check cleanliness
    cd "$dir" || continue
    git fetch origin >/dev/null 2>&1

    LOCAL=$(git rev-parse @ 2>/dev/null)
    REMOTE=$(git rev-parse @{u} 2>/dev/null)
    BASE=$(git merge-base @ @{u} 2>/dev/null)

    uncommitted=false; unpushed=false; diverged=false

    if ! git diff --quiet || ! git diff --cached --quiet; then uncommitted=true; fi
    if [ "$REMOTE" = "$BASE" ] && [ -n "$(git log --oneline "$REMOTE..$LOCAL")" ]; then unpushed=true; fi
    if [ "$LOCAL" != "$REMOTE" ] && [ "$LOCAL" != "$BASE" ] && [ "$REMOTE" != "$BASE" ]; then diverged=true; fi

    # Delete if totally clean
    if ! $uncommitted && ! $unpushed && ! $diverged; then
      echo "🗑️  Deleting clean repo (verbose): $dir"
      sudo rm -rfv "$dir"
      if [ -d "$dir" ]; then
        echo "❌  Failed to delete $dir"
      else
        echo "✅  Deleted $dir"
      fi
    fi

    cd - >/dev/null || exit
  done

  # ── 4) Parent cleanup: ignore ALL dotfiles ──────────────────────────────────────
  files=( "$parent"/* "$parent"/.* )
  files=( "${files[@]##*/}" )

  filtered=()
  for f in "${files[@]}"; do
    if [[ "$f" != "." && "$f" != ".." && "$f" != .* ]]; then
      filtered+=("$f")
    fi
  done

  if [ ${#filtered[@]} -eq 0 ]; then
    echo "🧹 Removing empty parent (ignoring dotfiles): $parent"
    sudo rm -rfv "$parent"
  else
    echo "🚫 Keeping parent (has content): $parent"
  fi
done
