# Contributing

Thanks for helping improve this open software‑engineering book. It is meant to be a
living resource, and clear, well‑sourced contributions are very welcome.

## Ground rules

1. **Original prose only.** Do not paste text, figures, or exercises from any
   copyrighted textbook. Explain concepts in your own words and cite primary/open
   sources. This keeps the whole book CC BY‑SA‑clean.
2. **Prefer open, durable sources.** When you link a resource, prefer ones that are
   free and openly licensed (MOOCs, university courseware, standards, papers, official
   docs). Add them to the chapter's `resources.md` and, if broadly useful, to
   [`curriculum/open-resources-map.md`](curriculum/open-resources-map.md).
3. **Keep the house style** (see below) so chapters read as one book, not many.

## Repository layout

```
.
├── README.md                     # landing page
├── SUMMARY.md                    # mdBook table of contents
├── book.toml                     # mdBook config
├── LICENSE                       # CC BY-SA 4.0 (prose) + MIT (code)
├── CONTRIBUTING.md
├── curriculum/
│   ├── open-resources-map.md     # chapter → open resources mapping
│   └── course-plan.md            # 15-week schedule
├── chapters/
│   ├── 01-introduction/
│   │   ├── README.md             # the chapter body
│   │   ├── exercises.md          # exercises & project prompts
│   │   └── resources.md          # curated open resources for this chapter
│   └── ...                       # one directory per chapter
├── templates/                    # reusable project & document templates
└── assets/diagrams/              # source for diagrams (Mermaid/SVG)
```

## House style

- **Structure per chapter:** a short "Where we are / why this matters" opener, then
  numbered sections matching `SUMMARY.md`, then **Key takeaways**, a link to
  **Exercises**, and a link to **Open resources**.
- **Voice:** direct, second person ("you"), concrete. Explain the *why* behind each
  practice, not just the *how*. Use a running example or case study where it helps.
- **Diagrams:** use [Mermaid](https://mermaid.js.org/) fenced code blocks (```` ```mermaid ````)
  so they render on GitHub and in mdBook. Keep an SVG export in `assets/diagrams/`
  if the diagram is complex.
- **Callouts:** use blockquotes with a bold lead‑in, e.g. `> **Principle.** …`,
  `> **Pitfall.** …`, `> **Case study.** …`.
- **Terminology:** bold a term the first time you define it. Keep to US spelling.
- **Line length:** wrap prose around 90–100 columns to keep diffs reviewable.

## Making a change

1. Fork and branch: `git checkout -b improve-chapter-09-mcdc`.
2. Edit Markdown. Preview locally with `mdbook serve` if you have
   [mdBook](https://rust-lang.github.io/mdBook/) installed.
3. Run the link check (see `.github/workflows/ci.yml`) or at least verify new links.
4. Open a pull request describing *what* changed and *why*, and cite sources for any
   new claims.

## Reporting issues

Open an issue for anything from a typo to a conceptual gap or a broken link. If you
know the fix, a PR is even better. Suggestions for new open resources are welcome.
