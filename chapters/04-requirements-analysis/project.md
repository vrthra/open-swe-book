# Chapter 4 → Your Project: Size It, Rank It, Fit the Box

> **Sprint alignment.** This chapter lands first in **Sprint 0‑1** — the scope‑decision
> record that goes into your proposal — and then never leaves: estimation, prioritization,
> and appetite are the working core of **every sprint planning** from Sprint 1 to the end
> of term. See
> [Running the Project on Two‑Week Sprints](../appendix-a-team-project/two-week-sprints.md).

## Developer hat

1. **Record the scope decision as a value/cost/risk table**
   ([§4.4.3](./#443-balancing-value-cost-and-risk)). For your assigned pitch, list the
   candidate features, score each for value, cost, and risk, and write down what the first
   version will and won't attempt — and *why*. This is the decision record Sprint 0‑1
   requires, and it is what you will point at when the customer asks in Sprint 3 why
   feature X isn't in.
2. **Play Planning Poker at every sprint planning**
   ([§4.3.1](./#431-wideband-delphi-and-planning-poker)): independent, simultaneous
   estimates, then argue about the outliers — that argument is where the hidden
   requirements surface. Record the points on the cards; unwritten estimates cannot become
   velocity.
3. **Mark the MVPs.** MVP marking is MoSCoW's *must‑have* line
   ([§4.4.1](./#441-must-should-could-wont-moscow-prioritization)): the stories without
   which there is no product. Everything else is negotiable by definition — which is the
   whole point of drawing the line before the sprint gets tight.
4. **Forecast with real velocity from Sprint 1 onward**
   ([§4.2.3](./#423-velocity-of-work)). After one sprint you have a measured
   points‑per‑sprint number; multiply it by the sprints remaining and compare against the
   backlog. That arithmetic — not optimism — is your ship/won't‑ship forecast, and it goes
   in the sprint report.
5. **Plan by appetite, then hammer scope**
   ([§4.2.4](./#424-appetite-fixed-time-variable-scope)). Each sprint is a fixed two‑week
   box: ask "what is the best version we can demo in two weeks?", and mark nice‑to‑haves
   with a `~` on the board when you write them — cutting a `~` at crunch time is a
   pre‑authorized decision, not a mid‑sprint argument.

## Customer hat

Your developers will ask you to prioritize their candidate stories. Answer honestly:

- **Pick.** "Everything is a must‑have" is the customer anti‑pattern this chapter exists
  to fix — a must‑have list that includes everything decides nothing.
- **Tell them what would delight versus what is merely expected**
  ([§4.5](./#45-customer-satisfiers-and-dissatisfiers)). Must‑be features earn no praise,
  only complaints when absent; attractors are where a small team's effort buys real
  satisfaction. Your developers cannot see that difference from outside your head.

## Done means

- [ ] The value/cost/risk table and scope decisions are in the repo, acknowledged by the
      customer.
- [ ] Planning Poker happened this sprint and every card carries its points.
- [ ] MVP stories are visibly marked on the board; the must‑have line is real.
- [ ] Velocity (from Sprint 1 on) appears in the sprint report with a ship forecast.
- [ ] `~` nice‑to‑haves are visible on the board — and any cut ones are listed, not hidden.
- [ ] Wearing your customer hat: you ranked your developers' stories and named your
      delighters this sprint.

## Project exercises

_Do these as part of the sprint work above; they produce artifacts your sprint reports and
reviews can point to._

1. **Analyze and plan your project.** Using your team project's current backlog
   (Appendix A):

   a. Run five backlog items through your own version of the §4.1 checklist. Rewrite any
      that fail it.
   b. Estimate all backlog items in story points using a real Planning Poker session with
      your teammates. Record one story where the *discussion* changed the estimate, and
      what you learned.
   c. Build a prioritization table with columns for value, cost (points), and risk, and
      compute `(value + risk) ÷ cost`. Produce a ranked build order.
   d. Classify three features with Kano's two questions and mark any **Delighter** you
      find.
   e. If you have completed at least two sprints, compute your velocity and forecast a
      completion range for the remaining backlog. If not, produce a COCOMO estimate from
      a KLOC guess and note which you would trust more, and why.

   Submit the checklist, the point estimates, the ranked table, the Kano classifications,
   and the forecast, with a short paragraph on where two of your estimation methods
   *disagreed* and what you did about it.

---

- Back to [Chapter 4](./) · [Exercises](exercises.md) · [Open Resources](resources.md)
- Sprint guide: [Running the Project on Two‑Week Sprints](../appendix-a-team-project/two-week-sprints.md)
