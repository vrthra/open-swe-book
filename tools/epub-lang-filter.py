#!/usr/bin/env python3
"""EPUB preprocessing for the rendered print.html DOM.

- Extracts <main>, strips scripts/buttons.
- Unwraps pre.mermaid blocks into data-URI <img> (pandoc drops inline <svg>
  and anything inside <pre>), fixing HTML-serialized void tags first.
- For a single-language edition, keeps only the target language's block in
  every run of adjacent code blocks drawn from the five tab languages
  (python, java, javascript, go, ruby); falls back to the run's first block
  (Python) with a caption when the target is missing.

Usage: epub-lang-filter.py rendered.html [all|python|java|javascript|go|ruby]
"""
import base64
import re
import sys

LANGS = ["python", "java", "javascript", "go", "ruby"]
NAME = {"python": "Python", "java": "Java", "javascript": "JavaScript",
        "go": "Go", "ruby": "Ruby"}


def fix_svg_xml(svg: str) -> str:
    svg = re.sub(r"<br\s*>", "<br/>", svg)
    svg = re.sub(r"<hr\s*>", "<hr/>", svg)
    svg = re.sub(r"<(img|input)(\s[^>]*[^/>])?>", r"<\1\2/>", svg)
    if "xmlns" not in svg.split(">")[0]:
        svg = svg.replace("<svg", '<svg xmlns="http://www.w3.org/2000/svg"', 1)
    return svg


def mermaid_to_img(m: re.Match) -> str:
    s = re.search(r"<svg\b.*</svg>", m.group(1), re.S)
    if not s:
        return m.group(0)
    svg = fix_svg_xml(s.group(0))
    b = base64.b64encode(svg.encode()).decode()
    return f'<p><img src="data:image/svg+xml;base64,{b}" alt="diagram"/></p>'


def lang_of(block: str):
    m = re.search(r'<code[^>]*class="[^"]*language-(\w+)', block)
    return m.group(1) if m else None


def filter_language(body: str, target: str) -> str:
    # Tokenize <pre> elements without crossing </pre>, then group exactly the
    # way tabs.js does: a group starts at a tab-language block and extends
    # over ADJACENT (whitespace-separated) blocks whose language is a tab
    # language not already in the group.
    pres = list(re.finditer(r"<pre\b(?:(?!</pre>).)*</pre>", body, re.S))
    keep_spans = []  # (start, end, replacement)
    i = 0
    while i < len(pres):
        lang = lang_of(pres[i].group(0))
        if lang not in LANGS:
            i += 1
            continue
        group = [(lang, pres[i])]
        j = i + 1
        while j < len(pres) \
                and body[pres[j - 1].end():pres[j].start()].strip() == "" \
                and (l := lang_of(pres[j].group(0))) in LANGS \
                and l not in [g[0] for g in group]:
            group.append((l, pres[j]))
            j += 1
        if len(group) >= 2:
            chosen = next((m for l, m in group if l == target), None)
            if chosen is not None:
                repl = chosen.group(0)
            else:
                repl = f"<p><em>({NAME[group[0][0]]})</em></p>" + group[0][1].group(0)
            keep_spans.append((group[0][1].start(), group[-1][1].end(), repl))
        i = j
    for start, end, repl in reversed(keep_spans):
        body = body[:start] + repl + body[end:]
    return body


def main() -> None:
    path, target = sys.argv[1], (sys.argv[2] if len(sys.argv) > 2 else "all")
    t = open(path, encoding="utf-8").read()
    body = re.search(r"<main>(.*)</main>", t, re.S).group(1)
    body = re.sub(r"<script\b.*?</script>", "", body, flags=re.S)
    body = re.sub(r"<button[^>]*>.*?</button>", "", body, flags=re.S)
    body = re.sub(r'<pre class="mermaid"[^>]*>(.*?)</pre>', mermaid_to_img,
                  body, flags=re.S)
    if target != "all":
        body = filter_language(body, target)
    print('<!DOCTYPE html><html><head><meta charset="utf-8">'
          "<title>Software Engineering: An Open Body of Knowledge</title>"
          "<style>svg,img{max-width:100%;height:auto} pre{white-space:pre-wrap}"
          " table,th,td{border:1px solid #888;border-collapse:collapse;"
          "padding:4px}</style></head><body>" + body + "</body></html>")


if __name__ == "__main__":
    main()
