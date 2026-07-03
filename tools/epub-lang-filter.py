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


def strip_tagged(body: str, is_target) -> str:
    """Remove whole elements whose OPENING tag satisfies is_target(tag_html).
    Depth-tracked scan over span/div tags only (MathJax markup is spans/divs)."""
    out = []
    i = 0
    tag = re.compile(r"<(/?)(span|div)\b[^>]*>", re.I)
    while True:
        m = tag.search(body, i)
        if not m:
            out.append(body[i:])
            break
        if m.group(1) or not is_target(m.group(0)):
            out.append(body[i:m.end()])
            i = m.end()
            continue
        # opening tag of a target element: skip to its matching close
        out.append(body[i:m.start()])
        depth = 1
        j = m.end()
        while depth:
            n = tag.search(body, j)
            if not n:
                j = len(body)
                break
            j = n.end()
            if n.group(2).lower() == m.group(2).lower():
                depth += -1 if n.group(1) else 1
        i = j
    return "".join(out)


def mathjax_to_tex(body: str) -> str:
    """Replace MathJax v2 rendering with the original TeX so pandoc can emit
    MathML: drop rendered/preview nodes, then unwrap the math/tex scripts."""
    body = strip_tagged(body, lambda t: 'class="MathJax' in t or "MathJax_Preview" in t
                        or "MathJax_Display" in t)
    body = re.sub(
        r'<script type="math/tex; mode=display"[^>]*>(.*?)</script>',
        lambda m: "<p>$$" + m.group(1) + "$$</p>", body, flags=re.S)
    body = re.sub(
        r'<script type="math/tex"[^>]*>(.*?)</script>',
        lambda m: "$" + m.group(1) + "$", body, flags=re.S)
    return body


def drop_web_sections(body: str) -> str:
    """Remove site-only front-page sections from the EPUB (build instructions,
    HTML table of contents, repo how-to, and the EPUB download links)."""
    for sec in ("building-the-book", "table-of-contents", "how-to-use-this-repository"):
        body = re.sub(
            r'<h2[^>]*id="' + sec + r'"[^>]*>.*?(?=<h2\b|\Z)', "", body, flags=re.S)
    body = re.sub(r"<p>(?:(?!</p>).)*epub/swebook-(?:(?!</p>).)*</p>", "", body,
                  flags=re.S)
    return body


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
    body = mathjax_to_tex(body)
    body = re.sub(r"<script\b.*?</script>", "", body, flags=re.S)
    body = re.sub(r'<div class="buttons">.*?</div>', "", body, flags=re.S)
    body = re.sub(r"<button[^>]*>.*?</button>", "", body, flags=re.S)
    body = drop_web_sections(body)
    body = re.sub(r'<pre class="mermaid"[^>]*>(.*?)</pre>', mermaid_to_img,
                  body, flags=re.S)
    if target != "all":
        body = filter_language(body, target)
    # pandoc's highlighter keys on a bare language class ("python"), not
    # highlight.js's "language-python hljs" form
    body = re.sub(r'<code class="language-(\w+)[^"]*"', r'<code class="\1"', body)
    print('<!DOCTYPE html><html><head><meta charset="utf-8">'
          "<title>Software Engineering: An Open Body of Knowledge</title>"
          "</head><body>" + body + "</body></html>")


if __name__ == "__main__":
    main()
