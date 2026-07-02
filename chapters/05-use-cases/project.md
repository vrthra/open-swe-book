# Chapter 5 → Your Project: Use Cases for the Flows That Bite

> **Sprint alignment.** This chapter deepens the backlog you built in **Sprint 0‑2** and
> pays off hardest in **Sprints 1–2**, when the complex flows come up for implementation.
> User stories carried you this far; use cases are the heavier tool you pull out for the
> handful of flows where a missed alternative path becomes a production bug. See
> [Running the Project on Two‑Week Sprints](../appendix-a-team-project/two-week-sprints.md).

## Developer hat

You do not need a use case for every story — most of your backlog is fine as INVEST cards.
You need use cases for the flows that bite: the ones with branching logic, failure modes,
and more than one actor.

1. **Pick the 2–3 most complex or critical flows** in your assigned project — checkout,
   scheduling, submission, whatever carries the risk — and write full use cases for them
   with the template ([§5.3](./#53-writing-use-cases), template in
   [§5.3.1](./#531-a-template-for-use-cases)). Name the actor's goal, walk the basic flow
   as actor‑intention/system‑interaction pairs, then hunt the alternative flows: at each
   step, ask *what else could happen here?*
   ([§5.2](./#52-alternative-flows-conditional-behaviors)). The alternative flows are the
   payoff — the basic flow you already knew.
2. **Turn every alternative flow into a Gherkin scenario and a test case.** Each
   alternative flow is, almost mechanically, one `Scenario`: the branch condition is the
   `Given`/`When`, the flow's outcome is the `Then`
   ([§3.4.1](../03-user-requirements/#341-guidelines-for-effective-user-stories)). Put the
   scenarios on the matching cards; they become the acceptance tests you demo as passing
   behavior ([§9.2.3](../09-testing/#923-functional-system-and-acceptance-testing)). An
   alternative flow with no scenario is a documented bug you have chosen to ship.
3. **Draw the actor–goal diagram and check completeness with your customer**
   ([§5.4](./#54-use-case-diagrams)). One page: every actor, every goal, lines between.
   The diagram's job is the completeness check — walk it with the customer and ask what's
   missing.

## Customer hat

When your developers bring you their actor–goal diagram, your highest‑value question is
**"who else touches this?"** The forgotten actors — the administrator, the auditor, the
support person cleaning up bad data, the external service that calls in — are the classic
gap ([§5.1.1](./#511-actors-and-goals-outline-a-system)), and each one found now is a
missing subsystem caught for the price of a conversation. Also read the alternative flows
for the critical use cases and confirm the outcomes: does a failed payment really leave the
order in *that* state?

## Done means

- [ ] Full use cases for the 2–3 complex/critical flows are in the repo, on the template,
      with basic *and* alternative flows.
- [ ] Every alternative flow has a matching Gherkin scenario on a card on the board.
- [ ] The actor–goal diagram exists, and the customer has confirmed the actor and goal
      list in writing (channel post or meeting notes).
- [ ] Wearing your customer hat: you asked "who else touches this?" about your
      developers' diagram and reviewed their critical alternative flows.

## Project exercises

_Do these as part of the sprint work above; they produce artifacts your sprint reports and
reviews can point to._

1. For your team project, produce a one-page actor–goal list: every actor (primary and
   supporting) and every user-goal-level goal. Mark which goals you will write full use
   cases for this term and which are out of scope, and give a one-sentence reason for
   each cut.
2. Choose the single most important goal from the actor–goal list you made in the
   previous exercise and write its complete use case using the §5.3.1 template, built in
   the three passes of §5.3.3. Then extract the two or three alternative flows whose
   postconditions you consider most critical, and hand them to whoever writes tests as
   named scenarios for Chapter 9.

---

- Back to [Chapter 5](./) · [Exercises](exercises.md) · [Open Resources](resources.md)
- Sprint guide: [Running the Project on Two‑Week Sprints](../appendix-a-team-project/two-week-sprints.md)
