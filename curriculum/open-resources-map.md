# Open Curriculum Resource Map

This book is designed to support **a complete first undergraduate software‑engineering
course** on its own (see the [chapter → ACM/IEEE SEEK mapping](#coverage-vs-the-acmieee-seek-body-of-knowledge)
below). This map is a companion: for each chapter it lists the best **free or openly
accessible** courses, textbooks, primary sources, and videos, so learners who want more
depth — or instructors assembling a reading list — can reinforce every topic without
buying anything. **Licenses vary and are noted where known** — "free to read" is not the
same as "openly licensed"; check each before adapting.

Resources are grouped as:

- 📘 **Open textbook / notes** — full readable text, usually CC‑licensed.
- 🎓 **Course / MOOC** — university courseware or a free online course.
- 📄 **Primary source** — the canonical spec, standard, or paper.
- 🎥 **Video** — recorded lectures or talks.

> **Coverage summary.** The book's ten core chapters cover a first course; Chapter 11
> (AI) is an optional capstone. The four
> "anchor" open courses below reinforce most of that ground; the per‑chapter tables add
> focused resources for the rest (estimation, use‑case mechanics, architectural pattern
> catalogs, and the statistics in Chapter 10).

## The four anchor courses

| Anchor | Covers chapters | What it is | License |
|--------|-----------------|------------|---------|
| **MIT 6.031 Software Construction** — [web.mit.edu/6.031](http://web.mit.edu/6.031), [OCW 6.005 (2016)](https://ocw.mit.edu/courses/6-005-software-construction-spring-2016/) | 6, 8, 9 | Complete, polished reading notes on specs, ADTs, testing, code review, and design. | CC BY‑SA (OCW) |
| **UC Berkeley — Engineering Software as a Service (ESaaS)** — [saasbook.info](https://saasbook.info/) | 1, 2, 3, 9 | Free book + MOOC on agile, BDD/user stories, and testing. | Free book; CC‑BY media |
| **CMU 17‑214 / 17‑313 Software Engineering** — [17-313 course site](https://cmu-313.github.io/) | 2, 6, 8, 10 | Open slides/readings on process, design, reviews, and measurement. | Course‑open |
| **"Software Engineering at Google"** — [free online](https://abseil.io/resources/swe-book) | 1, 8, 9, 10 | Industry practices for reviews, testing, and metrics at scale. | CC BY‑NC‑ND |

---

## Chapter 1 — Introduction

| Type | Resource | Notes |
|------|----------|-------|
| 📘 | [ESaaS ch. 1 "Introduction to SaaS & Agile"](https://saasbook.info/) | What SE is; why process matters. |
| 📄 | [ACM Code of Ethics and Professional Conduct](https://www.acm.org/code-of-ethics) | §1.6 social responsibility. |
| 📄 | [IEEE‑CS/ACM Software Engineering Code of Ethics](https://www.computer.org/education/code-of-ethics) | Professional conduct. |
| 📄 | N. Leveson & C. Turner, ["An Investigation of the Therac‑25 Accidents"](https://web.stanford.edu/class/cs240/old/sp2014/readings/therac-25.pdf) (IEEE Computer, 1993) | The canonical safety case study. |
| 📄 | [SWEBOK Guide v4 (IEEE)](https://www.computer.org/education/bodies-of-knowledge/software-engineering) | The discipline's body of knowledge. |
| 🎥 | [MIT 6.031 Lecture 1 "Static Checking"](http://web.mit.edu/6.031/www/sp21/classes/01-static-checking/) | Sets up "safe from bugs, easy to understand, ready for change." |

Covers: what is SE, requirements challenge, complexity, defects/testing intro, the
iron triangle (scope/cost/time), the VW & Therac‑25 case studies, ethics.

## Chapter 2 — Software Development Processes

| Type | Resource | Notes |
|------|----------|-------|
| 📄 | [Manifesto for Agile Software Development](https://agilemanifesto.org/) | The four values, twelve principles. |
| 📄 | [The Scrum Guide (2020)](https://scrumguides.org/scrum-guide.html) · [PDF](https://scrumguides.org/docs/scrumguide/v2020/2020-Scrum-Guide-US.pdf) | Roles, events, artifacts — primary source. |
| 📘 | [Extreme Programming (c2 wiki / Beck summaries)](http://wiki.c2.com/?ExtremeProgramming) | XP practices and user stories. |
| 📄 | W. Royce, ["Managing the Development of Large Software Systems"](https://www.praxisframework.org/files/royce1970.pdf) (1970) | The origin of "waterfall" (and its critique). |
| 📄 | B. Boehm, ["A Spiral Model of Software Development and Enhancement"](https://www.cs.unc.edu/techreports/86-020.pdf) (1988) | Risk‑driven process. |
| 🎓 | [ESaaS ch. 7 (Project Management, Agile)](https://saasbook.info/) | Plan‑and‑document vs. agile lifecycles. |

Covers: process vs. values, plan‑vs‑grow cultures, Scrum, XP, waterfall & V‑model,
risk, the spiral framework.

## Chapter 3 — User Requirements

| Type | Resource | Notes |
|------|----------|-------|
| 🎓 | [ESaaS ch. 7 "Requirements: BDD & User Stories"](https://saasbook.info/) | User stories, Connextra template, SMART. |
| 📄 | [Volere Requirements Specification Template](https://www.volere.org/templates/volere-requirements-specification-template/) | Industry requirements template. |
| 📄 | [ISO/IEC/IEEE 29148 (requirements engineering)](https://www.iso.org/standard/72089.html) | Standard (abstract free). |
| 📘 | K. Wiegers, ["Software Requirements" articles](https://www.processimpact.com/goodies.shtml) | Free companion articles & templates. |
| 📄 | B. Schneier, ["Attack Trees"](https://www.schneier.com/academic/archives/1999/12/attack_trees.html) | §3.7 security requirements. |
| 📄 | [INVEST checklist for user stories](https://www.agilealliance.org/glossary/invest/) | Story quality. |

Covers: requirements cycle, eliciting needs, user stories/features/scenarios, goal
hierarchies, security attack trees.

## Chapter 4 — Requirements Analysis

| Type | Resource | Notes |
|------|----------|-------|
| 📄 | [Planning Poker (Mountain Goat Software)](https://www.mountaingoatsoftware.com/agile/planning-poker) | Story‑point estimation. |
| 📘 | M. Cohn, ["Agile Estimating and Planning" free chapters/articles](https://www.mountaingoatsoftware.com/blog) | Velocity, story points. |
| 📄 | [MoSCoW prioritization (DSDM/Agile Business)](https://www.agilebusiness.org/dsdm-project-framework/moscow-prioritisation.html) | Must/Should/Could/Won't. |
| 📄 | N. Kano et al., [Kano model overview](https://foldingburritos.com/blog/kano-model/) | Satisfiers vs. dissatisfiers. |
| 📄 | B. Boehm, [COCOMO II model definition](http://csse.usc.edu/TECHRPTS/1995/usccse95-500/usccse95-500.pdf) | Parametric effort estimation. |
| 📄 | [Wideband Delphi](https://en.wikipedia.org/wiki/Wideband_delphi) | Structured group consensus. |

Covers: iteration planning, anchoring bias, story points & velocity, Planning Poker,
MoSCoW, Kano, value/cost/risk, COCOMO.

## Chapter 5 — Use Cases

| Type | Resource | Notes |
|------|----------|-------|
| 📘 | A. Cockburn, ["Use cases, ten years later" & templates](https://alistair.cockburn.us/coffee-cup-example/) | The definitive use‑case method. |
| 📄 | [UML Use Case Diagrams (OMG UML spec)](https://www.omg.org/spec/UML/) | Actors, relationships, notation. |
| 📘 | [ESaaS §7 (user stories vs. use cases)](https://saasbook.info/) | When to use each. |
| 🎥 | [Use case modeling tutorials (free)](https://www.uml-diagrams.org/use-case-diagrams.html) | Notation reference. |

Covers: actors & goals, basic/alternative flows, extension points, use‑case diagrams,
include/extend relationships.

## Chapter 6 — Design and Architecture

| Type | Resource | Notes |
|------|----------|-------|
| 📘 | [MIT 6.031 — Specifications, ADTs, Abstraction](http://web.mit.edu/6.031/www/sp21/) | Modularity, coupling/cohesion, spec design. |
| 📄 | P. Kruchten, ["Architectural Blueprints — the 4+1 View Model"](https://www.cs.ubc.ca/~gregor/teaching/papers/4+1view-architecture.pdf) (1995) | The 4+1 views. |
| 📘 | [refactoring.guru — Design Principles & SOLID](https://refactoring.guru/design-patterns) | Coupling, cohesion, OO relationships. |
| 📄 | [UML Class Diagrams reference](https://www.uml-diagrams.org/class-diagrams-overview.html) | Association/aggregation/composition/inheritance. |
| 📘 | ["Software Engineering at Google" ch. on design](https://abseil.io/resources/swe-book) | Real‑world modular design. |

Covers: role of architecture, modularity principle, coupling & cohesion, UML class
diagrams, 4+1 views, describing an architecture.

## Chapter 7 — Architectural Patterns

| Type | Resource | Notes |
|------|----------|-------|
| 📘 | M. Fowler, [Patterns of Enterprise Application Architecture (catalog)](https://martinfowler.com/eaaCatalog/) | Layering, MVC, and more. |
| 📄 | M. Fowler, [GUI Architectures (MVC/MVP)](https://martinfowler.com/eaaDev/uiArchs.html) | Model‑View‑Controller in depth. |
| 📘 | [Microsoft — Cloud Design Patterns](https://learn.microsoft.com/azure/architecture/patterns/) | Pub/sub, broker, client‑server, pipes‑and‑filters. |
| 📘 | M. Richards, [Software Architecture Patterns (free O'Reilly report)](https://www.oreilly.com/content/software-architecture-patterns/) | Layered, event‑driven, microkernel. |
| 📄 | [Reactive/Dataflow: The Reactive Manifesto](https://www.reactivemanifesto.org/) | Streams and back‑pressure. |
| 📘 | [Software Product Lines (SEI)](https://resources.sei.cmu.edu/library/asset-view.cfm?assetid=513819) | Families & product lines. |

Covers: layering, shared‑data, observer, publish‑subscribe, MVC, dataflow/pipelines,
client‑server, broker, product lines.

## Chapter 8 — Static Checking

| Type | Resource | Notes |
|------|----------|-------|
| 📘 | [Google Engineering Practices — Code Review](https://google.github.io/eng-practices/review/) | How industry does code review. |
| 📘 | [MIT 6.031 — Code Review reading](http://web.mit.edu/6.031/www/sp21/classes/04-code-review/) | Static checking & review practice. |
| 📄 | M. Fagan, ["Design and Code Inspections"](https://www.cs.umd.edu/class/spring2019/cmsc435/reading/Fagan-inspections.pdf) (IBM Sys. J., 1976) | The origin of formal inspection. |
| 📘 | ["Software Engineering at Google" — code review ch.](https://abseil.io/resources/swe-book) | Review at scale. |
| 📄 | [SonarQube / linters docs](https://docs.sonarsource.com/) | Automated static analysis in practice. |

Covers: architecture reviews, software inspections, code reviews, automated static
analysis, false positives/negatives.

## Chapter 9 — Testing

| Type | Resource | Notes |
|------|----------|-------|
| 📘 | [MIT 6.031 — Testing reading](http://web.mit.edu/6.031/www/sp21/classes/03-testing/) | Partitioning, coverage, glass‑box vs. black‑box. |
| 📘 | P. Ammann & J. Offutt, [Introduction to Software Testing (free samples & slides)](https://cs.gmu.edu/~offutt/softwaretest/) | Graph/control‑flow coverage, MC/DC. |
| 🎓 | [ESaaS ch. 8 "Testing"](https://saasbook.info/) | TDD, unit/integration, test doubles. |
| 📘 | ["Software Engineering at Google" — testing chapters](https://abseil.io/resources/swe-book) | Test sizes, flakiness, coverage culture. |
| 📄 | [NIST — Combinatorial (pairwise) testing](https://csrc.nist.gov/projects/automated-combinatorial-testing-for-software) | Input coverage & ACTS tool. |

Covers: levels of testing, control‑flow graphs & coverage, MC/DC, equivalence/
boundary, combinatorial testing.

## Chapter 10 — Quality Metrics

| Type | Resource | Notes |
|------|----------|-------|
| 📘 | [OpenIntro Statistics (CC BY‑SA)](https://www.openintro.org/book/os/) | Boxplots, histograms, variance, normal & t‑distributions, confidence intervals, regression. |
| 📘 | [Introduction to Modern Statistics (CC, OpenIntro)](https://openintro-ims.netlify.app/) | Modern companion to the above. |
| 📄 | [DORA / "Accelerate" State of DevOps metrics](https://dora.dev/) | Modern software delivery metrics. |
| 📘 | N. Fenton & J. Bieman, [Software Metrics (concepts overview)](https://www.cs.toronto.edu/~sme/CSC444F/handouts/) | Measurement theory, scales. |
| 📄 | [ISO/IEC 25010 product quality model](https://iso25000.com/index.php/en/iso-25000-standards/iso-25010) | Forms of software quality. |

Covers: meaningful metrics & scales, forms of quality, boxplots/histograms, variance/
SD, normal & t‑distributions, confidence intervals, linear regression.

## Appendix A — A Team Project

| Type | Resource | Notes |
|------|----------|-------|
| 🎓 | [ESaaS project guidance & rubric](https://saasbook.info/resources) | Running a semester team project. |
| 📄 | [Volere templates](https://www.volere.org/templates/) | Proposal & requirements docs. |
| 📘 | [Google Project Aristotle (team effectiveness)](https://rework.withgoogle.com/print/guides/5721312655835136/) | What makes teams work. |
| 📄 | [ACM/IEEE CS Curricula — SE course guidance](https://www.acm.org/education/curricula-recommendations) | Why a project is required. |

Covers: project goals, team experience, proposal, status reports, final report.

---

## Coverage vs. the ACM/IEEE SEEK body of knowledge

The book is designed to support a complete *first* undergraduate SE course. The table
below maps each chapter to the knowledge areas of the ACM/IEEE **SE2014 / SEEK** guideline
so instructors can see coverage — and its limits — directly, rather than taking a "full
scope" claim on faith. SEEK is a curriculum *guideline*; no single one‑semester course
covers the whole discipline, and the "Depth" column is honest about that.

| SEEK knowledge area | Where in this book | Depth |
|---------------------|--------------------|-------|
| Professional Practice (PRF) | Ch. 1 (ethics, cases), Appendix A (teamwork) | Introductory |
| Software Process (PRO) | Ch. 2 (Scrum, XP, waterfall, V, spiral, Shape Up) | Solid |
| Requirements / Modeling & Analysis (REQ, MAA) | Ch. 3–5 (elicitation, analysis, use cases) | Solid |
| Software Design (DES) | Ch. 6–7 (modularity, UML, 4+1, patterns) | Solid |
| Software V&V (VAV) | Ch. 8–9 (reviews, static analysis, testing, coverage) | Solid |
| Software Quality (QUA) | Ch. 10 (metrics, statistics, defects) | Solid |
| Security (SEC) | Ch. 3 §3.7 (attack trees, STRIDE), Ch. 8 §8.4 (SAST) | Introductory |
| Software Construction (CST) | assumed as a prerequisite; touched in Ch. 8–9 | Light |
| Software Evolution / Maintenance | cost‑of‑change theme throughout; no dedicated chapter | Light |
| Emerging practice: AI‑assisted SE | Ch. 11 (optional capstone) | Introductory |
| Computing Essentials, Math & Eng. Fundamentals (CMP, FND) | assumed prerequisites | Out of scope |

## Notes on coverage & gaps

Within the areas it *does* teach, the book is self‑contained — no purchase is required to
follow the course. This map records how much of each topic *also* has strong external open
coverage, so you know where the free supplements are richest:

- **Abundant open supplements:** process/agile, requirements & user stories,
  design/modularity, code review & static analysis, testing & coverage, and all of the
  statistics in Chapter 10.
- **Thinner external coverage:** some *estimation* details (e.g. COCOMO calibration), a
  few *architectural‑pattern* treatments, and worked *case studies*. Our own chapters
  supply original explanations and examples for these.
- **Deliberately light or out of scope** (per the SEEK table above): deep software
  *construction*, *maintenance/evolution*, and the CS/math prerequisites — appropriate
  omissions for a one‑semester first course, but worth naming so no one mistakes this for
  the whole discipline.
