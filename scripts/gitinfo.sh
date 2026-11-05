#!/bin/sh
set -eu
cd "$(dirname "$0")/.."

mkdir -p build

sha=${GITHUB_SHA:-$(git rev-parse HEAD 2>/dev/null || echo unknown)}
sha=$(printf '%s' "$sha" | cut -c1-7)
day=$(date -u +%Y-%m-%d)

printf '\\newcommand{\\GitSHA}{%s}\n\\newcommand{\\BuildDate}{%s}\n' "$sha" "$day" > build/gitinfo.tex
