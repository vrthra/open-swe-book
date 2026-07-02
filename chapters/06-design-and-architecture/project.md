# Chapter 6 → Your Project: Design Before the Skeleton

> **Sprint alignment.** This chapter lands **before Sprint 0‑3**: the architecture you
> sketch now is the one your walking skeleton walks. A thin end‑to‑end path only proves
> something if the parts it threads through are the parts you actually intend to build,
> so spend a working session on design *before* you deploy. See
> [Running the Project on Two‑Week Sprints](../appendix-a-team-project/two-week-sprints.md).

## Developer hat

You have a backlog of stories and a customer's priorities. Before you write skeleton
code, decide what the system's big pieces are — at marker-on-whiteboard resolution, not
UML-tool resolution.

1. **Sketch the architecture at the component level**
   ([§6.1.2](./#612-design-includes-architecture)). Fat-marker fidelity is the point:
   boxes for the major components, arrows for who talks to whom. If the team cannot draw
   it together in twenty minutes, you do not yet agree on what you are building.
2. **Derive a domain-model class diagram from your stories**
   ([§6.3](./#63-class-diagrams)). Walk the use cases and Gherkin scenarios: the nouns
   that keep recurring are your candidate classes; the verbs between them are your
   associations. Keep it to the domain — a dozen classes that everyone recognizes beats
   fifty that nobody reads.
3. **Name your module boundaries** ([§6.2](./#62-designing-modular-systems)). For a
   full-stack app the first cut is nearly always front end / API / domain logic /
   persistence. Aim the boundaries at low coupling and high cohesion (§6.2.2): each
   module should be changeable — and testable — without opening the others. Make the
   boundaries visible as top-level directories in the repo, so the layout *is* the
   development view.
4. **Write a one-page architecture description** and commit it
   ([§6.5.1](./#651-outline-for-an-architecture-description)): system overview, the main
   components and their responsibilities, and the two or three decisions you have
   actually made. Which brings us to —
5. **Keep it rough, honestly.** A decision you cannot defend yet is not a decision; write
   it down as an open question instead of guessing. The description is a living document
   you will revise when Chapter 7's patterns and the first sprints teach you more.

## Customer hat

Nothing this chapter — architecture is the developers' call. The customer owns *what*
the system does; *how* it is built is not their decision to make (or to second-guess).

## Done means

- [ ] A component-level architecture sketch is committed to the repo (a photo of the
      whiteboard counts).
- [ ] A domain-model class diagram derived from the backlog stories is committed.
- [ ] A one-page architecture description (§6.5.1 outline) is committed, with genuinely
      open decisions marked as open.
- [ ] The repo's top-level layout names the module boundaries (front end, API, domain,
      persistence — or your defended alternative).

## Project exercises

_Do these as part of the sprint work above; they produce artifacts your sprint reports and
reviews can point to._

1. For your team project, list the three design decisions you believe are the most
   *expensive to change later* (i.e., genuinely architectural). For each, state which
   quality requirement drives it and one alternative you considered but rejected, with
   the reason.

2. Produce a one-page **architecture description** for your project following the outline
   in §6.5.1: context and quality goals, constraints and significant decisions, at least
   a logical view (class or component diagram) and a development view (module hierarchy),
   one key scenario walked through the views, and an honest list of risks.

3. Identify the single decision in your system most likely to change during the term (a
   provider, a business rule, a UI framework, a transport). Name the module that will
   hide that decision, write the small interface it will expose, and explain in two or
   three sentences how this arrangement keeps the change local when it arrives.

4. Pick two modules in your planned design and classify the coupling between them using
   the ladder from §6.2.2. If it is worse than *data* coupling, propose a concrete change
   that would loosen it, and note what you would trade away (if anything) to get there.

---

- Back to [Chapter 6](./) · [Exercises](exercises.md) · [Open Resources](resources.md)
- Sprint guide: [Running the Project on Two‑Week Sprints](../appendix-a-team-project/two-week-sprints.md)
