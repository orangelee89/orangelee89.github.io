#!/usr/bin/env bash
set -euo pipefail

export PATH="/Library/TeX/texbin:$PATH"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
BUILD_DIR="$SCRIPT_DIR/.build"
OUTPUT_PDF="$REPO_DIR/CV.pdf"

if ! command -v latexmk >/dev/null 2>&1; then
  echo "Error: latexmk is not installed or not on PATH." >&2
  exit 1
fi

rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

(
  cd "$SCRIPT_DIR"
  latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir="$BUILD_DIR" main.tex
)

cp "$BUILD_DIR/main.pdf" "$OUTPUT_PDF"
rm -rf "$BUILD_DIR"

echo "Updated $OUTPUT_PDF"
