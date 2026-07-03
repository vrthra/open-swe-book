#!/usr/bin/env bash
# Build per-language EPUB + PDF editions: identical prose, one language of code.
#   tools/build-epubs.sh                 -> the five single-language editions
#   tools/build-epubs.sh go              -> just the Go edition
#   tools/build-epubs.sh all             -> one edition with every language stacked
# Output: $EPUB_OUT (default ./epubs) as swebook-<lang>.epub.
# Requires: mdbook+mdbook-mermaid (PATH or se-book-mdbook docker image),
#           Chrome/Chromium headless, pandoc (PATH or pandoc/core docker image).
set -euo pipefail
cd "$(dirname "$0")/.."
BOOK_DIR="$PWD"
OUT="${EPUB_OUT:-$PWD/epubs}"
BUILD=".epub-build"
mkdir -p "$OUT"
VERSION="${SWEBOOK_VERSION:-$(git describe --tags --always 2>/dev/null || echo dev)}"
export SWEBOOK_VERSION="$VERSION"

CHROME="${CHROME_BIN:-$(command -v google-chrome-stable || command -v google-chrome \
  || command -v chromium-browser || command -v chromium)}"

run_pandoc() {  # run_pandoc <in-html> <out-epub> <edition-description> <title> <cover>
  local args=(-f html+tex_math_dollars --mathml
    --metadata title="$4" --metadata identifier="org.swebook.$2.$VERSION"
    --metadata author="Thomas Hastings" --metadata lang=en
    --metadata rights="CC BY-SA 4.0 (prose); MIT (code)"
    --metadata description="$3" --toc --toc-depth=2 --split-level=1)
  if command -v pandoc >/dev/null; then
    pandoc "$OUT/$1" -o "$OUT/$2" "${args[@]}" \
      --css tools/epub.css --highlight-style tools/onelight.theme \
      --epub-cover-image "$5" \
      --epub-embed-font fonts/Inconsolata-latin.woff2
  else
    docker run --rm --user "$(id -u):$(id -g)" -v "$OUT:/data" -v "$BOOK_DIR:/book" pandoc/core \
      "/data/$1" -o "/data/$2" "${args[@]}" \
      --css /book/tools/epub.css --highlight-style /book/tools/onelight.theme \
      --epub-cover-image "/book/$5" \
      --epub-embed-font /book/fonts/Inconsolata-latin.woff2
  fi
}

# 1. Build the site and render print.html with JS (mermaid -> SVG).
if command -v mdbook >/dev/null; then
  mdbook build -d "$BOOK_DIR/$BUILD"
else
  docker run --rm -v "$BOOK_DIR:/book" se-book-mdbook mdbook build -d "/book/$BUILD"
fi
"$CHROME" --headless --disable-gpu ${CHROME_FLAGS:-} --dump-dom \
  --virtual-time-budget=30000 \
  "file://$BOOK_DIR/$BUILD/print.html" > "$OUT/rendered.html"

# 2. Covers (regenerated every run: they carry the version).
LANGS="${1:-python java javascript go ruby}"
for lang in $LANGS; do
  [ "$lang" = all ] || bash tools/make-covers.sh covers "$lang"
done

# 3. Per-language filter + pandoc.
TITLE="Software Engineering: An Open Body of Knowledge"
declare -A PRETTY=([python]=Python [java]=Java [javascript]=JavaScript [go]=Go [ruby]=Ruby)
for lang in $LANGS; do
  python3 tools/epub-lang-filter.py "$OUT/rendered.html" "$lang" "$VERSION" > "$OUT/filtered-$lang.html"
  if [ "$lang" = all ]; then
    name="swebook.epub"; edition="First Edition, all languages"
    title="$TITLE"; cover="tools/covers/cover-python.png"
  else
    name="swebook-$lang.epub"; edition="First Edition, ${PRETTY[$lang]} code examples ($VERSION)"
    title="$TITLE (${PRETTY[$lang]} Edition)"; cover="tools/covers/cover-$lang.png"
  fi
  run_pandoc "filtered-$lang.html" "$name" "$edition" "$title" "$cover"
  echo "built: $name"

  # PDF twin: same filtered HTML through pandoc standalone HTML (same One
  # Light highlighting + MathML), cover page injected, printed by Chrome.
  html="$OUT/pdf-$lang.html"
  if command -v pandoc >/dev/null; then
    pandoc "$OUT/filtered-$lang.html" -o "$html" -s -f html+tex_math_dollars --mathml \
      --metadata title="$title" --toc --toc-depth=2 \
      --highlight-style tools/onelight.theme \
      --css "file://$BOOK_DIR/tools/epub.css" --css "file://$BOOK_DIR/tools/pdf.css"
  else
    docker run --rm --user "$(id -u):$(id -g)" -v "$OUT:/data" -v "$BOOK_DIR:/book" pandoc/core \
      "/data/filtered-$lang.html" -o "/data/pdf-$lang.html" -s \
      -f html+tex_math_dollars --mathml \
      --metadata title="$title" --toc --toc-depth=2 \
      --highlight-style /book/tools/onelight.theme \
      --css "file://$BOOK_DIR/tools/epub.css" --css "file://$BOOK_DIR/tools/pdf.css"
  fi
  python3 - "$html" "$BOOK_DIR/$cover" "$BOOK_DIR" <<'PY'
import sys, re
p, cover, book = sys.argv[1], sys.argv[2], sys.argv[3]
t = open(p, encoding="utf-8").read()
t = re.sub(r"(<body[^>]*>)",
           r'\1<div class="pdf-cover"><img src="file://' + cover + '"/></div>',
           t, count=1)
font = ('<style>@font-face{font-family:"Inconsolata";font-weight:200 900;'
        'src:url("file://' + book + '/fonts/Inconsolata-latin.woff2")'
        ' format("woff2")}</style>')
t = t.replace("</head>", font + "</head>", 1)
open(p, "w", encoding="utf-8").write(t)
PY
  "$CHROME" --headless --disable-gpu ${CHROME_FLAGS:-} \
    --print-to-pdf="$OUT/${name%.epub}.pdf" --no-pdf-header-footer \
    --virtual-time-budget=20000 "file://$html" 2>/dev/null
  rm -f "$html"
  echo "built: ${name%.epub}.pdf"
done
rm -f "$OUT"/rendered.html "$OUT"/filtered-*.html
