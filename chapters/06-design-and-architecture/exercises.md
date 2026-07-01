# Chapter 6 — Exercises

Exercises are graded by depth: **[warm‑up]** checks understanding, **[analysis]** asks you
to reason about a design, and **[project]** connects to your team project (Appendix A).
Where an exercise asks for a diagram, a hand sketch or a Mermaid block is fine — the
thinking is what is graded.

## Concepts

1. **[warm‑up]** In your own words, explain the difference between *information hiding* and
   *encapsulation*, and give one concrete example where a language provides encapsulation
   but a design still fails at information hiding (that is, the interface leaks a secret).

2. **[warm‑up]** For each pair, say which relationship it is — association, aggregation,
   composition, generalization, or dependency — and justify the choice in one sentence:
   (a) an `Order` and the `LineItem`s that make it up and die with it; (b) a `Playlist` and
   the `Song`s it references, where songs exist independently; (c) a `SavingsAccount` and an
   `Account`; (d) a `ReportGenerator` whose `render()` method takes a `Theme` argument.

3. **[warm‑up]** Name the four "4+1" views plus the "+1," and for each write the one
   question it answers and the one stakeholder who cares most about it.

4. **[warm‑up]** Rank these couplings from worst to best and give a one-line reason for the
   worst and the best: *stamp*, *content*, *data*, *common*, *control*.

## Analysis

5. **[analysis]** You are handed a module named `Utilities` containing: `formatCurrency`,
   `parseCsvFile`, `sendEmail`, `retryWithBackoff`, and `MAX_UPLOAD_SIZE`. Diagnose its
   cohesion (name the type), explain the specific maintenance problems this module will
   cause, and propose a re-decomposition into cohesive modules. State the responsibility of
   each new module in a single "and"-free sentence.

6. **[analysis]** Read the following description and critique its coupling and cohesion.
   *"The `PriceEngine` reads its input by directly modifying the `cart` object's private
   `items` list, computes a total, stores it in a global variable `LAST_TOTAL` that the
   `Checkout` and `Receipt` modules both read, and takes a boolean flag `isB2B` that selects
   between two completely different pricing algorithms."* Identify each coupling type present
   (there are at least three), explain the concrete risk of each, and rewrite the design in a
   paragraph so that the modules communicate through data coupling and depend on interfaces.

7. **[analysis]** Draw a UML **class diagram** for a small library-loan system with these
   facts: a `Member` may have zero or more `Loan`s; each `Loan` is for exactly one `BookCopy`
   and belongs to exactly one `Member`; a `BookCopy` is one physical copy of a `Book`, and a
   `Book` may have one or more `BookCopy`s that are destroyed if the `Book` record is removed;
   a `ReferenceBook` is a kind of `Book` that cannot be loaned. Show attributes with
   visibility, at least one operation per class, correct multiplicities, and use composition,
   association, and generalization at least once each. Then write two sentences explaining
   which relationships you chose composition versus aggregation for and why.

8. **[analysis]** Take the communications-app *development view* from §6.5.3. Suppose a new
   requirement arrives: messages must now be end-to-end encrypted. In which layer(s) and
   module(s) does this change belong, and why? Identify one *wrong* place to put it that
   would violate the "domain depends on nothing below it" rule, and explain the harm.

9. **[analysis]** A teammate argues that because their service "has a clean class diagram,"
   the architecture is documented. Using the structure-versus-view distinction from §6.4.2,
   explain what the class diagram does *not* tell an operations engineer or a new programmer,
   and name the two additional views you would ask them to add before you would call the
   architecture "described."

10. **[analysis]** Cyclic dependencies are called out in §6.2.3 as something to avoid. Given
    modules `Auth`, `User`, and `Notification` where `Auth` needs to notify on login,
    `Notification` needs the user's preferences from `User`, and `User` needs `Auth` to check
    permissions — draw the dependency cycle, then show how to break it by introducing one
    interface owned by the right module. Explain why your choice of interface owner matters.

## Project

11. **[project]** For your team project, list the three design decisions you believe are the
    most *expensive to change later* (i.e., genuinely architectural). For each, state which
    quality requirement drives it and one alternative you considered but rejected, with the
    reason.

12. **[project]** Produce a one-page **architecture description** for your project following
    the outline in §6.5.1: context and quality goals, constraints and significant decisions,
    at least a logical view (class or component diagram) and a development view (module
    hierarchy), one key scenario walked through the views, and an honest list of risks.

13. **[project]** Identify the single decision in your system most likely to change during
    the term (a provider, a business rule, a UI framework, a transport). Name the module that
    will hide that decision, write the small interface it will expose, and explain in two or
    three sentences how this arrangement keeps the change local when it arrives.

14. **[project]** Pick two modules in your planned design and classify the coupling between
    them using the ladder from §6.2.2. If it is worse than *data* coupling, propose a concrete
    change that would loosen it, and note what you would trade away (if anything) to get there.
