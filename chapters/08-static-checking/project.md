# Chapter 8 → Your Project: Make Review a Gate, Not a Favor

> **Sprint alignment.** Code review as a required gate starts in **Sprint 1** and never
> stops; the automated-analysis layer — linting with reports, findings triaged — lands in
> **Sprint 3** of the hardening arc and stays on for the rest of the term. See
> [Running the Project on Two‑Week Sprints](../appendix-a-team-project/two-week-sprints.md).

## Developer hat

On a student team, review tends to be a favor: "looks good" typed without reading. This
chapter's job is to make it a gate instead.

1. **Protect main and require a review on every merge**
   ([§8.3](./#83-code-reviews-check-intent-and-trust)). Branch protection turns review
   from a courtesy into a mechanism: nothing lands without another person's eyes. Keep
   the discipline that makes it work — small PRs, reviewed within hours, not days
   (§8.3.2), and reviews that check *intent* ("does this do what the story says, and
   should it?") rather than only style.
2. **Wire automated review into CI on every pull request**
   ([§8.4](./#84-automated-static-analysis)). This includes AI-assisted review
   ([§11.2.6](../11-ai-across-the-lifecycle/#1126-static-checking-and-code-review-chapter-8)):
   treat the model as a tireless first-pass reviewer that reads every diff and never gets
   bored — and whose findings a human still judges. It filters; you decide.
3. **In the linting sprint, add a linter with reports to the pipeline**
   ([§8.4.1](./#841-a-variety-of-static-checkers)) — and then do the part most teams
   skip: **triage the findings**. Classify false positives honestly
   ([§8.4.2](./#842-false-positives-and-false-negatives)) — a real false positive gets
   suppressed *with a reason*, not waved away — and turn the true positives into backlog
   items on the board. A linter whose report nobody reads is a checkbox, not a checker;
   Sprint 4's debt paydown will collect whatever you file now.

## Customer hat

Nothing directly this chapter — but sloppy review shows up two weeks later as the broken
demo your customer watches, so your customer hat has a stake in your developer hat's
discipline.

## Done means

- [ ] Main is protected: no direct pushes, and every merge requires an approving review.
- [ ] Median review turnaround is under a day (spot-check your merged PRs).
- [ ] Automated review — static analysis and/or AI-assisted — comments on every pull
      request via CI.
- [ ] By the linting sprint: a linter runs in the pipeline with reports, and its findings
      are triaged on the board — false positives dispositioned, real ones filed as
      backlog items.

## Project exercises

_Do these as part of the sprint work above; they produce artifacts your sprint reports and
reviews can point to._

1. Design a lightweight code‑review policy for your team project. Specify: the
   maximum change size you will target and *why*; your review‑latency goal (in hours) and how
   you will hit it; who reviews changes to your most sensitive module and why they are the
   *invested expert*; and one rule for keeping reviews focused on codebase health rather than
   personal style. Keep it to one page a new teammate could actually follow.

2. Set up automated static analysis for your project's language(s). Turn on a
   type checker (or your compiler's strict mode), a linter, and one bug‑pattern or security
   scanner, and wire them into CI so they run on every change (Chapter 2). Report: what each
   tool is, how many findings each produced on your current code, and — picking three findings
   — classify each as a *true positive worth fixing*, a *false positive to suppress*, or a
   *style preference*. Note the change you made to reduce false‑positive noise.

3. Run one real architecture review of your team's design before you build the
   riskiest part. Pick the review type from §8.1.2 that fits your stage, invite at least one
   person who is *not* an author of the design, and drive it with two or three concrete
   scenarios (a load spike, a dependency failure, a security threat). Record every concern as
   an item with an owner and a disposition (fix now / accept the risk and why / investigate by
   a date). Submit the scenario list and the resulting decision log.

---

- Back to [Chapter 8](./) · [Exercises](exercises.md) · [Open Resources](resources.md)
- Sprint guide: [Running the Project on Two‑Week Sprints](../appendix-a-team-project/two-week-sprints.md)
