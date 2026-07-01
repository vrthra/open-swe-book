# Chapter 8 — Exercises

Exercises are graded by depth: **[warm‑up]** checks understanding, **[analysis]** asks you to
reason, **[project]** connects to your team project (Appendix A).

## Concepts

1. **[warm‑up]** In one or two sentences each, explain what makes a technique *static* rather
   than *dynamic*, and give one example of each from this book. Then state the single biggest
   thing static checking *cannot* tell you that testing (Chapter 9) can.

2. **[warm‑up]** Name the six phases of a traditional inspection in order, and give a
   one‑sentence purpose for each. Which phase finds most of the defects, and why is it *not*
   the meeting?

3. **[warm‑up]** List the five inspection roles (author, reviewer, reader, moderator, scribe)
   and, for each, state the one thing the inspection breaks down without. Explain why the
   author must never also be the moderator or reader of their own code.

4. **[warm‑up]** Define *false positive* and *false negative* for a static analyzer in your
   own words, and give a concrete one‑line example of each. Which one gives you *false
   reassurance*, and why is that the more dangerous error?

5. **[warm‑up]** Distinguish a *discovery* review from a *deep‑dive* review from a
   *retrospective* review by when each happens and what question it answers.

## Analysis

6. **[analysis]** A teammate proposes replacing your team's code reviews entirely with an
   aggressive static analyzer, arguing "the tool never gets tired and never misses a null
   check." Using the ideas of *intent*, *trust*, and *false negatives*, write a ~150‑word
   response explaining what the tool would catch, what it would miss, and why review and
   analysis are complementary rather than substitutes.

7. **[analysis]** Your team's static analyzer has 95% recall but a 55% false‑positive rate;
   developers have started dismissing its warnings without reading them. Explain, using
   precision/recall, why the *high recall* is now worthless in practice, and describe two
   concrete changes you would make to restore the team's trust in the tool. Would you accept
   *lower recall* to get there? Justify it.

8. **[analysis]** Fill in and interpret this confusion matrix. A checker was run on a module
   known (from later production incidents plus a hand audit) to contain 20 real defects of the
   kind the checker targets. The checker raised 30 alarms; 12 of them corresponded to real
   defects. Compute the true positives, false positives, and false negatives, then compute the
   tool's precision and recall. In one sentence, say whether you'd trust this tool and why.

9. **[analysis]** **Perform a code review.** Read the function below (pseudocode close to
   Python). List every defect and concern you would raise as a reviewer, and for each, label
   whether it is about *correctness*, *intent/design*, or *style/clarity*. Then state which
   one or two of these an ordinary automated linter or type checker would likely have caught on
   its own, and which require a *human* reviewer who understands intent.

   ```
   # Applies a discount code to a shopping cart and returns the new total.
   def apply_discount(cart, code):
       total = 0
       for item in cart.items:
           total = total + item.price * item.quantity
       discount = discounts.lookup(code)        # returns None if code is unknown
       total = total - total * discount.percent / 100
       if total < 0:
           total == 0
       cart.total = total
       return total
   ```

10. **[analysis]** In an inspection meeting, a reviewer starts sketching, on the whiteboard, a
    better algorithm to replace the one under inspection, and a fifteen‑minute design debate
    breaks out. As the moderator, what rule is being violated, what do you say, and where does
    that redesign work properly belong? Explain *why* the meeting protects this boundary.

11. **[analysis]** The §8.2.2 case study found that raising the preparation rate above ~1,000
    lines/hour cut defect yield from ~8 to ~2 per thousand lines. A manager reads this as "great
    news — the faster reviews find fewer problems, so the code must be getting cleaner." Explain
    why this interpretation is exactly backwards, and describe the one metric you would add to
    the team's dashboard to expose the real story.

## Project

12. **[project]** Design a lightweight code‑review policy for your team project. Specify: the
    maximum change size you will target and *why*; your review‑latency goal (in hours) and how
    you will hit it; who reviews changes to your most sensitive module and why they are the
    *invested expert*; and one rule for keeping reviews focused on codebase health rather than
    personal style. Keep it to one page a new teammate could actually follow.

13. **[project]** Set up automated static analysis for your project's language(s). Turn on a
    type checker (or your compiler's strict mode), a linter, and one bug‑pattern or security
    scanner, and wire them into CI so they run on every change (Chapter 2). Report: what each
    tool is, how many findings each produced on your current code, and — picking three findings
    — classify each as a *true positive worth fixing*, a *false positive to suppress*, or a
    *style preference*. Note the change you made to reduce false‑positive noise.

14. **[project]** Run one real architecture review of your team's design before you build the
    riskiest part. Pick the review type from §8.1.2 that fits your stage, invite at least one
    person who is *not* an author of the design, and drive it with two or three concrete
    scenarios (a load spike, a dependency failure, a security threat). Record every concern as
    an item with an owner and a disposition (fix now / accept the risk and why / investigate by
    a date). Submit the scenario list and the resulting decision log.
