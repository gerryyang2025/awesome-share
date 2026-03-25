#!/usr/bin/env bash
# Regenerate _sass/_post-content-bundle.scss after editing bundled sources.
# Loaded by assets/css/jekyll-theme-chirpy.scss (official Chirpy custom-style entry).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SASS_OUT="$ROOT/_sass/_post-content-bundle.scss"
mkdir -p "$ROOT/_sass"
cd "$ROOT/assets/css"
{
  echo '/* _post-content-bundle.scss — generated; do not edit by hand */'
  echo '/* Sources: markdown-extras.css, blockquote.css, table.css, chirpy-code-blocks.css, inline-code.css */'
  for f in markdown-extras.css blockquote.css table.css chirpy-code-blocks.css inline-code.css; do
    echo
    echo "/* ==== $f ==== */"
    cat "$f"
  done
} > "$SASS_OUT"
echo "Wrote $SASS_OUT ($(wc -c < "$SASS_OUT") bytes)"
