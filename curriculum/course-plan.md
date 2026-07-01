# 15‑Week Course Plan

A ready‑to‑use schedule for a junior/senior software‑engineering course built on this
book, run as **two parallel tracks** (as the ACM/IEEE guidelines recommend):

- **Concepts track** — the ten core chapters (one theme per week), plus the optional
  Chapter 11 on AI as an advanced capstone.
- **Project track** — a real team project (Appendix A), started early and iterated.

The two tracks are **tightly coupled at the start** (weeks 1–4, while teams form and
scope their projects) and **loosely coupled afterward**, so each can move at its own
pace.

## Weekly schedule

| Week | Concepts (chapter) | Project milestone | Key open resources |
|------|--------------------|-------------------|--------------------|
| 1 | Ch. 1 — Introduction | Form teams; brainstorm ideas | ACM Code of Ethics; Therac‑25 |
| 2 | Ch. 2 — Processes (Scrum/XP) | Pick a process; set up repo & board | Scrum Guide; Agile Manifesto |
| 3 | Ch. 3 — User Requirements | **Project Proposal** (App. A.2) | ESaaS ch.7; Volere; INVEST |
| 4 | Ch. 4 — Requirements Analysis | Backlog + estimates (Planning Poker) | Planning Poker; MoSCoW; Kano |
| 5 | Ch. 5 — Use Cases | Use cases / stories for iteration 1 | Cockburn use cases |
| 6 | Ch. 6 — Design & Architecture | Architecture sketch; class diagram | MIT 6.031; 4+1 views |
| 7 | Ch. 7 — Architectural Patterns | **Status Report 1** (skeletal system) | Fowler PoEAA; MS patterns |
| 8 | *Midterm / catch‑up* | Sprint review + retrospective | — |
| 9 | Ch. 8 — Static Checking | Set up CI, linters, code review | Google eng‑practices; Fagan |
| 10 | Ch. 9 — Testing (coverage) | Test plan; coverage targets | MIT 6.031 testing; Ammann/Offutt |
| 11 | Ch. 9 — Testing (MC/DC, combinatorial) | **Status Report 2** (viable system) | NIST combinatorial |
| 12 | Ch. 10 — Metrics (quality & defects) | Defect tracking; quality dashboard | OpenIntro Stats; DORA |
| 13 | Ch. 10 — Metrics (statistics) | Measure & analyze project data | OpenIntro Stats |
| 14 | Ch. 11 — SE in the Age of AI *(optional capstone)* + review | **Comprehensive Final Report** (A.5) | METR study; o16g manifesto |
| 15 | Final presentations / demos | Ship & retrospective | — |

## Assessment (suggested weights)

| Component | Weight |
|-----------|-------:|
| Team project (proposal, 2 status reports, final report, demo) | 45% |
| Individual exercises / problem sets (chapter `exercises.md`) | 20% |
| Midterm (concepts, weeks 1–7) | 15% |
| Final exam (concepts, whole book) | 20% |

## Learning outcomes

By the end, a student can:

1. Choose and run an appropriate **process** (Scrum/XP/hybrid) for a team project.
2. **Elicit, write, prioritize, and estimate** requirements as user stories/use cases.
3. **Design a modular architecture** and describe it with UML and 4+1 views.
4. Apply the right **architectural patterns** to a problem.
5. **Review and statically check** code and architecture for defects.
6. Design a **test suite** that meets defined coverage criteria.
7. Define and interpret **quality metrics** using sound statistics.
8. Work effectively on a **software team** and communicate progress.

## Adapting the plan

- **10‑week quarter:** merge weeks 4↔5 and 12↔13; move MC/DC to optional reading.
- **Bootcamp / self‑study:** follow the four anchor courses in
  [`open-resources-map.md`](open-resources-map.md) alongside the chapters; do the
  project solo or in a pair.
- **No team project:** keep the concepts track; replace project milestones with the
  larger exercises marked *"project"* in each chapter's `exercises.md`.
