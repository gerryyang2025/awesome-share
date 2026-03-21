#!/usr/bin/env bash
# Regenerate assets/css/post-content-bundle.css after editing any of the source files.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT/assets/css"
{
  echo '/* post-content-bundle.css — one request for post content styles; do not edit by hand */'
  for f in rouge-highlight.css code-copy-btn.css markdown-extras.css blockquote.css table.css inline-code.css; do
    echo
    echo "/* ==== $f ==== */"
    cat "$f"
  done
} > post-content-bundle.css
echo "Wrote post-content-bundle.css ($(wc -c < post-content-bundle.css) bytes)"
