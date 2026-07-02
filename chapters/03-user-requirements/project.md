# Chapter 3 → Your Project: Requirements from a Real Customer

> **Sprint alignment.** This chapter lands hardest in **Sprint 0‑2** (user stories +
> lo‑fi UI, elicited from your customer team) and stays live in **every sprint's**
> customer meeting. It is the chapter the dual‑hat swap was built for: the idea lives in
> *another team's* heads, so everything in §3.1–3.3 stops being theory the moment you
> schedule your first elicitation interview. See
> [Running the Project on Two‑Week Sprints](../appendix-a-team-project/two-week-sprints.md).

## Developer hat

You were assigned another team's pitch. Your job now is to find out what they actually
want — which is not the same as what the pitch says.

1. **Run a real elicitation session** with your customer team before writing any stories
   ([§3.3.2](./#332-accessing-user-needs)). Interview first, then ask them to *walk
   through* how the target user copes today (the baseline). Watch for the §3.1.2 traps
   live: tacit knowledge, the unstated obvious, solutions masquerading as needs. When the
   pitch says "add a dashboard," ask what's really going wrong ([§3.3.2](./#332-accessing-user-needs)).
2. **Write the backlog as INVEST stories with Gherkin acceptance criteria**
   ([§3.4.1](./#341-guidelines-for-effective-user-stories)). Every card on your board
   carries `Given / When / Then` scenarios — they are demoed as passing behavior at Demo
   Day and become your acceptance tests ([§9.2.3](../09-testing/#923-functional-system-and-acceptance-testing)). This is a standing requirement of every
   sprint, not a one-time deliverable.
3. **Storyboard the main flows** ([§3.5.3](./#353-storyboards-drawing-the-scenario)):
   four to eight lo‑fi frames per key scenario, walked past your customer *before* the
   backlog counts as done. Draw the unhappy paths too — each frame you can't draw is a
   requirement you haven't discovered.
4. **Confirm priorities with the customer, in writing.** End Sprint 0‑2 (and every sprint
   planning after) with the customer's answer to one question: "If we only finish three
   stories, which three?"

## Customer hat

Another team is doing all of the above *to you*, about your pitch. Being a good customer
is graded work too:

- **Answer elicitation questions concretely.** Tell stories about specific users doing
  specific things; resist handing them your imagined UI ([§3.1](./#31-what-is-a-requirement) —
  give needs, not designs, unless asked).
- **Prioritize when asked, honestly.** "Everything is a must-have" is the customer
  anti-pattern that §4.4 exists to fix. Pick.
- **React to their storyboards and stories** within the sprint — silence from the
  customer hat stalls another team's grade and their learning.

## Done means

- [ ] An elicitation session with the customer team happened and is documented (notes or
      recording link in the repo).
- [ ] Backlog stories are INVEST-shaped, MVP-marked ([§4.4.1](../04-requirements-analysis/#441-must-should-could-wont-moscow-prioritization)), and each card has Gherkin
      acceptance criteria.
- [ ] Storyboards for the core flows are in the repo, and the customer has seen them.
- [ ] The customer's priority ranking is recorded (channel post or meeting notes).
- [ ] Wearing your customer hat: you have answered your developers' questions and
      prioritized their candidate stories this sprint.

## Project exercises

_Do these as part of the sprint work above; they produce artifacts your sprint reports and
reviews can point to._

1. For your team project, run one lightweight elicitation activity with a real or
   stand‑in user (interview, observation, or a paper prototype reaction). Write up what
   you *expected* to learn, what you *actually* learned, and at least one *implied or
   latent* need that surprised you.
2. Write five user stories for your project in Connextra format, each with at least two
   *Given/When/Then* acceptance criteria. Group them under one or two named *features*,
   and for each feature, name the stakeholder *goal* it serves.
3. Identify the single most valuable asset your project protects (data, money, safety,
   availability). Build an attack tree for one attacker goal against it, and add the
   resulting security requirements to your backlog — noting for each which attack‑tree
   leaf justifies it.

---

- Back to [Chapter 3](./) · [Exercises](exercises.md) · [Open Resources](resources.md)
- Sprint guide: [Running the Project on Two‑Week Sprints](../appendix-a-team-project/two-week-sprints.md)
