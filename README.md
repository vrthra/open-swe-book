# Software Engineering — Principles & Practices

**An open, chapter-based curriculum for a junior/senior software‑engineering course.**

This is a free, openly‑licensed course book that teaches the *principles and best
practices* of modern software engineering: how software is built in industry using
agile methods, how to discover and analyze requirements, how to design and architect
modular systems, how to check and test code, and how to measure quality with metrics.

It is organized as **twelve chapters and a team‑project appendix**, following the topic
progression of the ACM/IEEE software‑engineering
curriculum guidelines (SE2014/SEEK). Every chapter is written from scratch and is paired
with a curated map of **free or openly accessible resources** — MOOCs, university
courseware, primary specifications, and papers; licenses vary and are noted where known —
so the material is **designed to support a complete first undergraduate
software‑engineering course** without buying anything.

> **An independent open educational resource.** This is a complete, standalone book.
> Except for clearly attributed quotations and linked external resources, its explanatory
> prose, examples, diagrams, and exercises are original, and the book is released under
> Creative Commons. See [`curriculum/open-resources-map.md`](curriculum/open-resources-map.md)
> for the mapping from each chapter to complementary open materials.

---

## Why this book exists

Most software that matters is built by **teams**, under changing requirements, with
inevitable defects, at a scale no one person can hold in their head. A university
"programming" course teaches you to write a function; a **software engineering**
course teaches you to build and evolve a *system* with other people. The discipline
is less about any single language and more about a set of enduring principles:

1. **Software is complex** → we manage complexity with design and architecture.
2. **Requirements change** → we use iterative, agile methods to adapt.
3. **Defects are inevitable** → we use reviews, static checking, and testing to catch them.
4. **Teams need coordination** → we use processes, and a healthy balance of structure and flexibility.

These four ideas thread through every chapter.

## How the book is organized

The chapters group into arcs:

| Arc | Chapters | Question it answers |
|-----|----------|---------------------|
| **Getting started** | 1–2 | What is software engineering, and what process do we use? |
| **What to build** | 3–5 | How do we discover, analyze, and specify requirements? |
| **Design & architecture** | 6–7 | How do we structure a system to tame complexity? |
| **Software quality** | 8–9 | How do we check and test that the system works? |
| **Metrics** | 10 | How do we measure quality and track progress? |
| **The AI shift** | 11 | How is AI reshaping every stage — and what stays the same? |
| **Delivery** | 12 | How does code get from a merged branch to running safely in production? |
| **Practice** | Appendix A | How do we run a real team project alongside the concepts? |

## Table of contents

Use the sidebar for the full linked table of contents (chapters and sections), or jump in:

1. [Introduction](chapters/01-introduction/) — what SE is, the requirements challenge, complexity, defects, the iron triangle, professional ethics.
2. [Software Development Processes](chapters/02-software-development-processes/) — plan vs. grow, Scrum, XP, waterfall/V, spiral & risk.
3. [User Requirements](chapters/03-user-requirements/) — eliciting needs, user stories, features, scenarios, goals, security attack trees.
4. [Requirements Analysis](chapters/04-requirements-analysis/) — estimation, planning poker, MoSCoW, Kano, value/cost/risk, COCOMO.
5. [Use Cases](chapters/05-use-cases/) — actors & goals, basic and alternative flows, use‑case diagrams and relationships.
6. [Design and Architecture](chapters/06-design-and-architecture/) — modularity, coupling & cohesion, UML class diagrams, 4+1 views.
7. [Architectural Patterns](chapters/07-architectural-patterns/) — layering, shared‑data, observer, pub‑sub, MVC, dataflow, client‑server, broker, REST, product lines.
8. [Static Checking](chapters/08-static-checking/) — architecture reviews, inspections, code reviews, automated static analysis.
9. [Testing](chapters/09-testing/) — levels of testing, control‑flow & MC/DC coverage, black‑box coverage, combinatorial testing.
10. [Quality Metrics](chapters/10-quality-metrics/) — meaningful metrics, defect measures, boxplots/histograms, statistics, confidence intervals, regression.
11. [Software Engineering in the Age of AI](chapters/11-ai-across-the-lifecycle/) — how AI reshapes every lifecycle stage, the productivity/quality/security evidence, and the o16g Outcome Engineering manifesto.
12. [Delivery: CI/CD, DevOps, and Evolution](chapters/12-delivery/) — SaaS and the cloud, CI pipelines, continuous deployment (the Knight Capital and CrowdStrike case studies), security pipelines, DORA metrics, legacy code and technical debt.

- [Appendix A: A Team Project](chapters/appendix-a-team-project/) — proposal, sprint and status reports, team reviews, and final-report templates.

## How to use this repository

- **Learners:** read the chapters in order. Each ends with *Key takeaways*, *Exercises*,
  and *Open resources* pointing to free courses and readings for deeper study.
- **Instructors:** the chapters map onto a 14–16 week semester — two ready-made plans
  (a milestone track and a two-week-sprint track) live in
  [`curriculum/course-plan.md`](curriculum/course-plan.md). Run the team project from
  Appendix A on a parallel track. Reusable document templates (idea pitch, proposal,
  sprint and status reports, team review, final report, individual write-up) are linked
  from [Appendix A](chapters/appendix-a-team-project/).
- **Contributors:** see [`CONTRIBUTING.md`](CONTRIBUTING.md). This is meant to be a
  living, community‑improved resource.

## Building the book

The chapters are plain Markdown and render on GitHub as‑is. To build a browsable
website or PDF with [`mdBook`](https://rust-lang.github.io/mdBook/):

```bash
cargo install mdbook          # one-time
mdbook serve                  # live preview at http://localhost:3000
mdbook build                  # outputs static site to ./book-output
```

`SUMMARY.md` is the mdBook table of contents; `book.toml` holds configuration.

## License

Text and figures are licensed **[CC BY‑SA 4.0](LICENSE)**; any code snippets are
**MIT**. You are free to share and adapt with attribution. See [`LICENSE`](LICENSE).
