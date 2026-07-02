# Chapter 7 → Your Project: Choose Patterns on Purpose

> **Sprint alignment.** This chapter shapes **Sprint 0‑3's walking skeleton** and every
> sprint after it: the patterns you pick now are the skeleton the whole term walks on.
> Chapter 6 gave you boxes and arrows; this chapter tells you which *named shapes* those
> boxes should take — and makes you say what each one costs. See
> [Running the Project on Two‑Week Sprints](../appendix-a-team-project/two-week-sprints.md).

## Developer hat

Your app will have an architecture whether you choose one or not. Choose one.

1. **Pick the app's shape deliberately.** For a full-stack SaaS project the sensible
   default is layered ([§7.1](./#71-software-layering)) + client-server
   ([§7.5.1](./#751-the-client-server-pattern)) + a RESTful API
   ([§7.5.4](./#754-restful-apis)). Defaults are fine — *unexamined* defaults are not. If
   your project genuinely wants something else (a dataflow pipeline, heavy pub-sub), say
   so and say why. The same discipline applies to the **stack** that implements the
   shape. Choose it on: team familiarity; batteries-included versus assemble-yourself
   (Django/Rails hand you auth, ORM, and admin; React + Node hands you choices); your
   schema's needs (relational versus flexible); the security defaults the framework
   gives you for free (XSS/CSRF/injection protection); and how easily it deploys.
   Record the rationale in the decision record (step 3) — in a fixed semester, the
   wrong-but-known stack usually beats the perfect-but-foreign one.
2. **Write a resource table for your domain**, in the style of §7.5.4's clinic example:
   the nouns from your class diagram become URIs, and each row pairs a
   `VERB /resource/...` request with its meaning. If a needed operation will not fit the
   noun-and-verb grammar, you have found a design problem early — cheap.
3. **Record each pattern choice as a mini decision record** using the §7.7 table's row
   format ([§7.7](./#77-conclusion)): the pattern, the problem it solves *here*, and the
   trade-off you are accepting. Three or four honest rows in the repo beat a page of
   architecture prose nobody rereads.
4. **Choose the skeleton's first thread** — the one story your Sprint 0‑3 deployment will
   carry end to end. Pick it the Shape Up way: core, small, and novel
   ([§2.8](../02-software-development-processes/#28-shape-up-fixed-time-variable-scope)) —
   the thinnest path that still touches every layer you just named.
5. **Stand up a test server** ([§7.5.2](./#752-deploying-test-servers)) so the front end
   can build against a fake while the real back end firms up. The resource table from
   step 2 is exactly the contract the fake implements — which is the point of writing it
   first.

## Customer hat

Nothing this chapter — pattern choices are the developers' call, made to serve the
priorities your customer hat already gave them.

## Done means

- [ ] Pattern decisions are recorded in the repo — one row each: pattern, problem it
      solves here, trade-off accepted.
- [ ] A REST resource table for the domain is drafted and committed.
- [ ] The skeleton's first thread is chosen and its core-small-novel justification is
      written down.
- [ ] A test server (or agreed fake) exists so front-end work is not blocked on the back
      end.

## Project exercises

_Do these as part of the sprint work above; they produce artifacts your sprint reports and
reviews can point to._

1. For your team project, identify the *one* place where you most expect the
   design to change during the term (a swappable data source, a UI that will be restyled, a
   third-party service that might be replaced, a feature that some users get and others do
   not). Choose the architectural pattern that would make that specific change cheap, place
   it in your architecture, and write a short "trade-off note" (about 150 words) stating
   what the pattern costs you and why you judge it worth paying here. If you conclude *no*
   pattern is worth it yet, justify that too — declining to add machinery is also a design
   decision.

---

- Back to [Chapter 7](./) · [Exercises](exercises.md) · [Open Resources](resources.md)
- Sprint guide: [Running the Project on Two‑Week Sprints](../appendix-a-team-project/two-week-sprints.md)
