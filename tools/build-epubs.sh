#!/usr/bin/env bash
# Build per-language EPUB editions: identical prose, one language of code.
#   tools/build-epubs.sh            -> all six editions (all-languages + 5 single)
#   tools/build-epubs.sh go         -> just the Go edition
# Requires: docker (se-book-mdbook or mdbook+mdbook-mermaid on PATH),
#           google-chrome-stable, and docker (pandoc/core).
set -euo pipefail
cd "$(dirname "$0")/.."
BOOK_DIR="$PWD"
OUT="${EPUB_OUT:-$PWD/epubs}"
BUILD=".epub-build"
mkdir -p "$OUT"

# 1. Build the site and render print.html with JS (mermaid -> SVG).
if command -v mdbook >/dev/null; then
  mdbook build -d "$BOOK_DIR/$BUILD"
else
  docker run --rm -v "$BOOK_DIR:/book" se-book-mdbook mdbook build -d "/book/$BUILD"
fi
google-chrome-stable --headless --disable-gpu --dump-dom --virtual-time-budget=30000 \
  "file://$BOOK_DIR/$BUILD/print.html" > "$OUT/rendered.html"

# 2. Per-language filter + pandoc.
LANGS="${1:-all python java javascript go ruby}"
for lang in $LANGS; do
  python3 tools/epub-lang-filter.py "$OUT/rendered.html" "$lang" > "$OUT/filtered-$lang.html"
  suffix=$([ "$lang" = all ] && echo "" || echo "-$lang")
  edition=$([ "$lang" = all ] && echo "First public edition" || echo "First public edition, $lang code")
  docker run --rm -v "$OUT:/data" pandoc/core \
    "/data/filtered-$lang.html" -o "/data/software-engineering-an-open-body-of-knowledge$suffix.epub" \
    --metadata title="Software Engineering: An Open Body of Knowledge" \
    --metadata author="Thomas Hastings" --metadata lang=en \
    --metadata rights="CC BY-SA 4.0 (prose); MIT (code)" \
    --metadata description="$edition" \
    --toc --toc-depth=2 --split-level=1
  echo "built: software-engineering-an-open-body-of-knowledge$suffix.epub"
done
rm -f "$OUT"/rendered.html "$OUT"/filtered-*.html
