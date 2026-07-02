# Chapter 9 — Open Resources

Free, open‑licensed, or freely accessible materials that reinforce this chapter. Types: 📘 open
text · 🎓 course · 📄 primary source / standard · 🎥 video. Licenses vary and are noted where
known. Each entry notes its license or access terms; when in doubt, check the linked page.

## Foundations: what to test and how

- 🎓 **MIT 6.031 — Software Construction, "Testing" reading** —
  [web.mit.edu/6.031](https://web.mit.edu/6.031/www/sp22/classes/03-testing/). Excellent
  treatment of partitioning the input space, choosing test cases, and coverage. *License:
  the 6.031 materials are offered for reuse under Creative Commons (BY‑SA); check the page
  footer.*
- 🎓 **UC Berkeley — Engineering Software as a Service (ESaaS), ch. 8 "Testing"** —
  [saasbook.info](https://www.saasbook.info/). Test-driven development, mocks/stubs, and
  the testing pyramid in a full-stack context. *License: book is free to read online;
  see the site for terms.*
- 📘 **Software Engineering at Google — testing chapters** (Ch. 11 "Testing Overview",
  Ch. 12 "Unit Testing", Ch. 13 "Test Doubles", Ch. 14 "Larger Testing") —
  [abseil.io/resources/swe-book](https://abseil.io/resources/swe-book). Industrial
  perspective on test size, flakiness, hermeticity, and scaling a suite. *License: CC
  BY‑NC‑ND 4.0 (free to read; no derivatives).*

## Coverage criteria, white-box, and MC/DC

- 📘 **Ammann & Offutt — "Introduction to Software Testing" companion site** —
  [cs.gmu.edu/~offutt/softwaretest](https://cs.gmu.edu/~offutt/softwaretest/). Slides,
  examples, and tools for graph coverage, logic coverage (including MC/DC), and
  input-space partitioning — the academic backbone of §9.3–9.6. *Access: teaching
  materials free on the author's site.*
- 📄 **NASA/DOT‑FAA — "A Practical Tutorial on Modified Condition/Decision Coverage"**
  (Hayhurst, Veerhusen, Chilenski, Rierson), NASA/TM‑2001‑210876 —
  [search NTRS](https://ntrs.nasa.gov/). The definitive, worked explanation of MC/DC and
  independence pairs. *License: U.S. government work, public domain.*
- 📄 **RTCA DO‑178C** (software considerations in airborne systems) — the standard that
  *mandates* MC/DC for the most critical software levels. The standard itself is sold by
  RTCA, but many university course pages summarize its coverage objectives for free.

## Black-box and combinatorial testing

- 📄 **NIST — Automated Combinatorial Testing for Software (ACTS) project** —
  [csrc.nist.gov/projects/automated-combinatorial-testing-for-software](https://csrc.nist.gov/projects/automated-combinatorial-testing-for-software).
  The empirical fault-strength data behind §9.6, plus the free **ACTS** covering-array
  generator and NIST Special Publication 800‑142. *License: U.S. government work, public
  domain; ACTS tool free for download.*
- 📄 **Microsoft PICT — Pairwise Independent Combinatorial Testing tool** —
  [github.com/microsoft/pict](https://github.com/microsoft/pict). A small, scriptable
  covering-array generator for building pairwise test suites. *License: MIT.*

## Tools and practice

- 📘 **pytest documentation** — [docs.pytest.org](https://docs.pytest.org/). Fixtures,
  parametrization, and the `raises` idiom used in this chapter's examples. *License:
  docs under MIT.*
- 📄 **Hypothesis — property-based testing for Python** —
  [hypothesis.readthedocs.io](https://hypothesis.readthedocs.io/). Puts the property/
  invariant oracles of §9.1.4 into practice by generating inputs for you. *License:
  MPL‑2.0.*
- 📘 **Python `unittest.mock` — official documentation** —
  [docs.python.org/3/library/unittest.mock.html](https://docs.python.org/3/library/unittest.mock.html).
  `Mock`, `patch`, and `side_effect` — the standard-library way to build the stubs and
  mocks of §9.2.1. *License: Python docs, PSF license (free to read and reuse).*
- 📘 **behave — BDD for Python, documentation** —
  [behave.readthedocs.io](https://behave.readthedocs.io/). Executable Gherkin as in the
  §9.2.3 callout: a `features/` directory of `.feature` scenarios plus a `steps/`
  directory whose `@given`/`@when`/`@then` functions bind each step to code. *License:
  BSD‑2‑Clause.*
- 📄 **mutmut — mutation testing for Python** —
  [mutmut.readthedocs.io](https://mutmut.readthedocs.io/). Generates and runs the mutants
  of §9.1.5 against a pytest suite and reports the survivors. *License: open source; see
  the project page.*
- 📄 **Google OSS‑Fuzz — continuous fuzzing documentation** —
  [google.github.io/oss-fuzz](https://google.github.io/oss-fuzz/). How industrial-scale
  fuzz testing (§9.4) is run continuously against hundreds of open-source projects, with
  guides for adding your own. *License: Apache‑2.0.*
- 🎥 **"TDD, Where Did It All Go Wrong" — Ian Cooper** (conference talk, freely on
  YouTube). A widely-cited critique of testing implementation details instead of behavior;
  a good companion to the pyramid and oracle discussions. *Access: free to view.*

## License note

Linked resources remain under their own licenses (noted above where known); this page is
licensed **CC BY‑SA 4.0**.
