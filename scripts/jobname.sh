#!/bin/sh
set -eu
cd "$(dirname "$0")/.."

team=$(sed -n 's/^\\newcommand{\\TeamNumber}{\(.*\)}.*/\1/p' config/metadata.tex)
name=$(sed -n 's/^\\newcommand{\\ProjectName}{\(.*\)}.*/\1/p' config/metadata.tex | tr -d ' ')

printf 'T%s%s_Midterm' "$team" "$name"
