# Chapter 2 → Your Project: Pitch, Then Set Up the Machine

> **Sprint alignment.** This chapter powers **Sprint 0‑0** (your pitches) and **Sprint
> 0‑1** (the swap, and standing up your team's process), and it defines the **cadence of
> every sprint after that** — the events you schedule this week are the ones you will run
> all term. See
> [Running the Project on Two‑Week Sprints](../appendix-a-team-project/two-week-sprints.md).

## Developer hat

1. **Write your idea pitches in Shape Up form** ([§2.8](./#28-shape-up-fixed-time-variable-scope)),
   using the [idea pitch template](../../templates/idea-pitch.md): problem, appetite,
   rough solution, rabbit holes, no‑gos. Pick your strongest candidates from the Chapter 1
   collection — the ones with a named, reachable user survive contact with strangers.
2. **Stand up the machine.** Create the team repository and project board, and turn on
   **branch protection for main** now, while it costs nothing: work lands on branches and
   merges through review, from the very first commit. A rule adopted in week two is a
   habit; the same rule adopted in Sprint 3 is an argument.
3. **Write your working agreements and a Definition of Done** and commit both. The DoD is
   your team's exit criteria for *every* story — tested, reviewed, merged, deployed — the
   "what is a process" question of [§2.1.1](./#211-what-is-a-process) answered concretely,
   before the first sprint pressures you to answer it conveniently.
4. **Map the Scrum events onto the course cadence** ([§2.2.3](./#223-scrum-events)) and
   put them on a shared calendar: **sprint planning** happens at each sprint boundary and
   *includes the customer meeting*; **Demo Day is the sprint review**; the **team and
   customer review is the retrospective**. Add a short standup rhythm that fits your
   schedules. Named events with agreed times are what make a process real
   ([§2.2.1](./#221-overview-of-scrum)); "we'll sync when needed" is what makes it
   fiction.

## Customer hat

Your pitch is your product this week. Another team will build it, and you will live with
what they build — so write the pitch the way Shape Up demands ([§2.8](./#28-shape-up-fixed-time-variable-scope)):

- **Rough**, so the developers have room to design — a pitch that dictates the UI is a
  solution masquerading as a need.
- **Solved**, so the core approach is credible — name the main elements and the rabbit
  holes you already see.
- **Bounded**, so the appetite is honest — declare the no‑gos, and keep the whole thing
  readable in one sitting by strangers who cannot ask you questions until the swap.

## Done means

- [ ] Each member's pitch(es) are submitted in Shape Up form, on the template.
- [ ] The repository and project board are live, and main is protected — a direct push to
      main is impossible.
- [ ] Working agreements and the Definition of Done are committed to the repository.
- [ ] The event calendar — planning + customer meeting, standups, Demo Day, team/customer
      review — is agreed and visible to the whole team.

## Project exercises

_Do these as part of the sprint work above; they produce artifacts your sprint reports and
reviews can point to._

1. Choose a process for your team project and defend it in one page. State your project's
   dominant risks using the §2.6.1 categories, rank them by rough exposure (probability ×
   impact), and show how your chosen process — likely a Scrum+XP hybrid — confronts the
   top two risks *early*. Include your team's initial Definition of Done and the length
   you have chosen for your sprints, with justification.

2. Set up the engineering scaffolding for one XP practice before your first sprint: stand
   up a continuous-integration pipeline that builds your project and runs its tests on
   every push, and write one failing test plus the minimal code to make it pass. Submit
   the pipeline configuration and a screenshot of a green build.

---

- Back to [Chapter 2](./) · [Exercises](exercises.md) · [Open Resources](resources.md)
- Sprint guide: [Running the Project on Two‑Week Sprints](../appendix-a-team-project/two-week-sprints.md)
