# Chapter 10 → Your Project: Run the Project on Evidence

> **Sprint alignment.** The numbers start flowing in **Sprint 1** (velocity, coverage, defect
> counts), become decisions in **Sprints 2–4** (what to fix, what to cut, what the trend says),
> and end up as the spine of the **final report**. Collect a little every sprint and the report
> writes itself; collect nothing and you will be reconstructing history from git logs at 2 a.m.
> See [Running the Project on Two-Week Sprints](../appendix-a-team-project/two-week-sprints.md).

## Developer hat

Your project generates data whether you look at it or not. This chapter's job is to make you
look — honestly.

1. **Track velocity honestly.** Every sprint report records planned points vs. done points.
   Resist the urge to make the numbers match: the gap between them *is* the information, and
   it is what makes your next sprint's plan an estimate instead of a wish.
2. **Watch the coverage trend, not just the floor.** The CI pipeline reports coverage on every
   commit; holding ~80% is table stakes. What matters is the direction — a floor you clear by
   less each sprint is a warning ([§10.1.2](./#1012-selecting-useful-metrics)).
3. **Count defects by severity** ([§10.4.1](./#1041-severity-of-defects)). "Seven bugs" says
   nothing; "one showstopper, two majors, four cosmetic" is a plan. Triage every finding —
   from testing, from your customer, from the scanners — onto that scale.
4. **Keep a hill chart per scope in each sprint report**
   ([§10.3.5](./#1035-hill-charts-displaying-uncertainty-not-just-quantity)). It reports the
   thing velocity can't: how much *uncertainty* remains, not just how much work.
5. **Once CD is live, measure your own DORA four keys**
   ([§12.5](../12-delivery/#125-dora-metrics)). Deployment frequency and lead time fall
   straight out of your pipeline history — you built the instrument in Sprint 2; now read it.
6. **Mind Goodhart.** Any number you optimize directly will lie to you
   ([§10.1.2](./#1012-selecting-useful-metrics)). Coverage padded with assertion-free tests,
   velocity inflated by point creep — the metric goes up, the quality doesn't. Use the numbers
   to ask questions, not to score points.
7. **In the final report, present the data you accumulated** — a run of velocity across four
   sprints, a coverage trend, maybe a boxplot of story cycle times — rather than
   reconstructing it. Evidence gathered sprint by sprint is credible; evidence assembled the
   night before is archaeology.

## Customer hat

One habit: ask your developers for the **trend**, not the snapshot. "Is coverage rising or
falling?" tells you more than any single number.

## Done means

- [ ] Every sprint report carries real numbers: planned vs. done velocity, the coverage
      trend, and defect counts by severity.
- [ ] A hill chart per scope appears in each sprint report and moves between reports.
- [ ] DORA deployment frequency and lead time are measured from pipeline history once CD is
      live.
- [ ] The final report's charts come from data accumulated across sprints, not reconstructed
      at the end.

## Project exercises

_Do these as part of the sprint work above; they produce artifacts your sprint reports and
reviews can point to._

1. Choose one *goal* for your team project's quality and write a full GQM
   tree for it (goal, at least two questions, and a metric per question). For each metric,
   note its scale of measurement and whether it needs normalization by exposure.
2. Set up a lightweight defect log for your project and, at the end of an
   iteration, compute DRE for the work you completed (defects your team caught in review
   and testing versus defects found afterward by teammates or "users"). Report the number
   and one concrete process change you would make to raise it next iteration.
3. Pick one numeric metric you will track across your project's iterations
   (velocity, build time, defects per story, review turnaround). After three iterations,
   plot the values as a boxplot *or* compute a confidence interval for the mean, and write
   two sentences on whether any apparent trend is real or within normal variation.

---

- Back to [Chapter 10](./) · [Exercises](exercises.md) · [Open Resources](resources.md)
- Sprint guide: [Running the Project on Two-Week Sprints](../appendix-a-team-project/two-week-sprints.md)
