#!/usr/bin/env bash

set -x -e -o pipefail
shopt -s nullglob

tmpdir=$(mktemp -d)
for pdf in static/resumes/*.pdf; do
  cp "$pdf" "$tmpdir"
  filename=$(basename "$pdf")
  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 -dNOPAUSE -dQUIET -dBATCH -dPrinted=false -sOutputFile="$pdf" "$tmpdir/$filename"
done
