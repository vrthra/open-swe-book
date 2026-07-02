# Chapter 11 → Your Project: Use AI Like an Engineer

> **Sprint alignment.** This chapter is live in **every sprint**: documenting your AI use —
> with transcripts — is part of the common cycle, and the AI review gate you wire into CI in
> Sprint 1 runs on every pull request thereafter. The question is never *whether* your team
> uses AI; it is whether you can show your work. See
> [Running the Project on Two-Week Sprints](../appendix-a-team-project/two-week-sprints.md).

## Developer hat

Your team will use AI assistance all term. Engineering discipline is what separates using it
from being used by it.

1. **Write the team AI-use policy in week one of building.** Decide, in writing, what agents
   may do in your repo and what evidence is required before AI-assisted code merges — this is
   exercise 1 in the [Project exercises](#project-exercises) below. A policy argued about
   after a bad merge is a post-mortem; a policy written first is engineering.
2. **Document every AI assist in the README, with a link to the transcript.** Provenance is
   part of honest engineering ([§11.2.9](./#1129-the-team-project-appendix-a)): a grader, a
   customer, or a teammate should be able to see where the AI's contribution ends and your
   judgment begins.
3. **Treat AI code review in CI as a tireless first-pass reviewer, not an oracle**
   ([§11.2.6](./#1126-static-checking-and-code-review-chapter-8)). It reads every diff and
   never gets bored — but a human judges every finding. Accepting or dismissing each one is
   the reviewer's job you cannot delegate.
4. **Remember the productivity paradox** ([§11.1.4](./#1114-the-productivity-paradox)).
   Developers who *felt* faster with AI were measurably slower. Perceived speed is not
   measured speed — so verify AI output against your tests and your review, and let your
   sprint's velocity data, not your gut, say whether the assist helped.
5. **Never merge AI-generated code without the same tests and review a human's code would
   need.** The evidence says AI-assisted code ships with more defects and vulnerabilities
   unless it passes through exactly the disciplines this book teaches
   ([§11.3](./#113-the-evidence-productivity-quality-security)) — your test suite, your
   coverage floor, and your protected main *are* the verification layer.

## Customer hat

One line: AI can draft your feedback to your developers, but the priorities in it must be
yours — nobody's agent knows what you actually meant by your pitch.

## Done means

- [ ] The team AI-use policy is in the repo, written before the first build sprint's work
      merged.
- [ ] The README's AI-use log is current, with a transcript link for every assist.
- [ ] Zero AI-assisted merges skipped tests or human review — the log and the PR history
      agree.
- [ ] Anyone on the team can explain any AI-assisted code the team shipped.

## Project exercises

_Do these as part of the sprint work above; they produce artifacts your sprint reports and
reviews can point to._

1. Write an *AI‑use policy* for your team (½ page): where agents may be used,
   what evidence (tests, review, metric) is required before merging AI‑generated code, and
   how you will record provenance in your final report.
2. Take one backlog item. Have an AI draft its user story, acceptance
   criteria, and unit tests; then *review* them as an engineer. Document every change you
   made and why — this is your verification layer in action.
3. Choose one **outcome** metric (not an activity metric) for your project in
   the spirit of Outcome Engineering, define it precisely (Chapter 10), and measure it
   before and after adopting an AI tool. Report whether the outcome actually improved.

---

- Back to [Chapter 11](./) · [Exercises](exercises.md) · [Open Resources](resources.md)
- Sprint guide: [Running the Project on Two-Week Sprints](../appendix-a-team-project/two-week-sprints.md)
