# Chapter 8 — Open Resources

Free, open‑licensed, or freely accessible materials that reinforce this chapter. Types: 📘 open
text · 🎓 course · 📄 primary source · 🎥 video. Licenses vary and are noted where known.

## Code review (used in §8.3)

- 📘 **Google Engineering Practices — "How to do a code review"** —
  [google.github.io/eng-practices/review](https://google.github.io/eng-practices/review/).
  Google's public guide for both reviewers and authors: what to look for, how fast to review,
  how to handle disagreement, and why "will this improve the codebase's health over time?" is
  the central question. *Licensed CC BY 3.0 — freely reusable with attribution.*
- 📘 **MIT 6.031 *Software Construction* — "Code Review" reading** —
  [web.mit.edu/6.031](https://web.mit.edu/6.031/www/sp22/classes/04-code-review/). A concrete,
  example‑driven reading on reviewing for correctness and clarity, with a catalog of common
  smells. *Course materials offered openly by MIT OpenCourseWare (CC BY‑NC‑SA).*
- 📘 **"Software Engineering at Google," Ch. 9 "Code Review"** —
  [abseil.io/resources/swe-book](https://abseil.io/resources/swe-book/html/ch09.html). Why
  Google reviews nearly every change, the roles of reviewers, the value of small changes, and
  review latency. *Free to read online; book text CC BY‑NC‑ND.*

## Inspection (used in §8.2)

- 📄 **M. E. Fagan, "Design and Code Inspections to Reduce Errors in Program Development,"
  *IBM Systems Journal* 15(3), 1976** — the founding paper on formal inspection, defining the
  phases, roles, and the discipline of measuring the process. Widely available as a PDF from
  IBM and university course pages; search "Fagan Design and Code Inspections 1976 PDF."
- 📄 **NASA Software Formal Inspections Standard (NASA‑STD‑8739.9)** —
  [standards.nasa.gov](https://standards.nasa.gov/). A public, practical standard for running
  inspections, including entry/exit criteria and data collection. *U.S. government work —
  public domain.*

## Automated static analysis (used in §8.4)

- 📘 **SonarQube / SonarSource documentation** —
  [docs.sonarsource.com](https://docs.sonarsource.com/). Docs for a widely used static‑analysis
  platform: rule categories (bugs, vulnerabilities, code smells), quality gates, and how
  findings are surfaced in CI. *Docs free to read; the tool has open‑source and commercial
  editions.*
- 📄 **"Lessons from Building Static Analysis Tools at Google," *CACM* 61(4), 2018** —
  [cacm.acm.org](https://cacm.acm.org/research/lessons-from-building-static-analysis-tools-at-google/).
  The primary source behind §8.4.2's argument that *false‑positive rate*, not raw recall,
  decides whether developers act on a tool. Explains their target of keeping false positives
  low enough that warnings get fixed.
- 📘 **Clang Static Analyzer — user documentation** —
  [clang-analyzer.llvm.org](https://clang-analyzer.llvm.org/). Openly documented data‑flow /
  bug‑pattern analyzer for C/C++/Objective‑C, useful for seeing what path‑sensitive analysis
  actually reports. *Open source (Apache‑2.0 with LLVM exceptions).*

## License note

Linked resources remain under their own licenses (noted above where known); this page is
CC BY‑SA 4.0.
