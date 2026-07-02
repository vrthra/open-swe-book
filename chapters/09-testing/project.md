# Chapter 9 → Your Project: Tests Are the Feature

> **Sprint alignment.** This chapter is the core of **Sprint 1** — tests, coverage, and
> CI are that sprint's new engineering layer — and it stays load-bearing in **every
> sprint after**: no story is done without tests, and the Gherkin scenarios are the
> acceptance layer of every Demo Day. See
> [Running the Project on Two‑Week Sprints](../appendix-a-team-project/two-week-sprints.md).

## Developer hat

A feature without tests is a rumor. From Sprint 1 on, the tests *are* the feature.

1. **Every story lands with unit and integration tests**
   ([§9.2](./#92-levels-of-testing)) — written test-first, red before green
   ([§2.3.2](../02-software-development-processes/#232-testing-make-it-central-to-development)).
   The unit tests pin the pieces; the integration tests catch what the pieces do to each
   other, which is where full-stack projects actually break.
2. **Make the Gherkin scenarios on your cards executable** with a BDD runner such as
   Behave ([§9.2.3](./#923-functional-system-and-acceptance-testing)). The
   `Given / When / Then` text your customer approved at planning becomes an acceptance
   test that runs in CI — the same words, now enforced.
3. **Hold the coverage floor (~80%) — but read the pitfall first**
   ([§9.1.3](./#913-test-adequacy-deciding-when-to-stop)). Assertion-free tests that
   execute code without checking it will hit any number you name and teach you nothing.
   Coverage is a diagnostic, not a goal; pair it with real oracles.
4. **Derive input tests from equivalence classes and boundaries**
   ([§9.4](./#94-input-coverage-i-black-box-testing)). For each input your stories
   accept, name the valid and invalid classes, then test the edges — empty, maximum,
   one-past. This is where the "what if the user types nothing?" bugs die before the
   demo instead of during it.
5. **At Demo Day, show the tests behind each demoed story.** The Gherkin runs are the
   acceptance evidence — demo the behavior, then show the green scenarios that prove it
   was not a lucky click.

## Customer hat

Your acceptance happens *through* those scenarios. When your developers walk you through
the Gherkin at sprint planning, read every `Then` clause like it will be enforced —
because it will be. Correcting a `Then` clause at planning is the cheapest bug fix you
will ever make.

## Done means

- [ ] No story merges without unit and integration tests; CI enforces it.
- [ ] Coverage meets the agreed floor (~80%) and is reported by CI on every commit.
- [ ] The cards' Gherkin scenarios are executable and run in CI.
- [ ] Input tests cover the equivalence classes and boundaries of user-facing inputs.
- [ ] Demo Day includes the tests behind each demoed story.
- [ ] Wearing your customer hat: you reviewed the Gherkin scenarios at planning and
      flagged any `Then` clause that does not match what you meant.

## Project exercises

_Do these as part of the sprint work above; they produce artifacts your sprint reports and
reviews can point to._

1. For one non-trivial function in your team project, write a unit-test
   suite that reaches 100% branch coverage. Include the coverage tool's report (or a hand
   analysis) and, for at least one test, name the equivalence class or boundary it targets.

2. Identify one place in your project configured by two or more parameters
   (e.g., user role × subscription tier × platform). Model the parameters and values, then
   produce a pairwise test plan — by hand for a small case, or with a tool (PICT/ACTS) for
   a larger one. Report how many configurations pairwise required versus exhaustive.

3. Audit your project's test strategy against the testing pyramid (§9.2.4).
   Count your unit, integration, and end-to-end tests; plot the shape; and write a
   one-paragraph plan to move it toward a healthy pyramid, naming one slow test you would
   replace with faster lower-level tests.

---

- Back to [Chapter 9](./) · [Exercises](exercises.md) · [Open Resources](resources.md)
- Sprint guide: [Running the Project on Two‑Week Sprints](../appendix-a-team-project/two-week-sprints.md)
