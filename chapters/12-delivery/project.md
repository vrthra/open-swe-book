# Chapter 12 → Your Project: The Hardening Arc, Sprint by Sprint

> **Sprint alignment.** This chapter *is* the project's engineering arc. Each build sprint
> adds one permanent layer of the delivery pipeline — CI in **Sprint 1**, CD in **Sprint 2**,
> security scanning in **Sprint 3**, debt paydown in **Sprint 4** — and once a layer is added,
> it stays on for the rest of the term. See
> [Running the Project on Two-Week Sprints](../appendix-a-team-project/two-week-sprints.md).

## Developer hat

One layer per sprint, in Chapter 12's order: make the checks automatic, make release boring,
widen the net, then pay down what the net caught.

1. **Sprint 1 — CI and production.** A CI pipeline runs your tests and reports coverage on
   every commit ([§12.2](./#122-continuous-integration-pipelines)), automated review runs on
   every pull request, and the application is deployed to production
   ([§12.1](./#121-saas-and-the-cloud), [§12.3](./#123-continuous-deployment)) — a real URL
   your customer can open.
2. **Sprint 2 — CD.** Merging to main deploys automatically
   ([§12.3](./#123-continuous-deployment)). Before wiring it up, read the Knight Capital and
   CrowdStrike case studies and answer as a team, in writing: *what is our rollback story,
   and how would we know within five minutes that a deploy is bad?* Both firms had pipelines;
   neither had answers.
3. **Sprint 3 — widen the net.** The pipeline gains dependency-vulnerability scanning with
   reports ([§12.4](./#124-continuous-security-pipelines)), and the deployment gets
   production polish — a real domain, not a platform subdomain. Findings are triaged into the
   backlog, not ignored.
4. **Sprint 4 — pay the debt.** Every open vulnerability and linter finding gets fixed
   ([§12.6](./#126-legacy-code-refactoring-and-technical-debt)). Because the scanners have
   been running since Sprint 3, this is a bounded, graded exercise in technical-debt paydown
   — not an open-ended cleanup.
5. **Every sprint — release discipline.** Tag the repository at each sprint boundary and push
   the tags: the tag is the auditable "what shipped." And keep the pipeline green — a red
   main is a stop-the-line event ([§12.2](./#122-continuous-integration-pipelines)), not
   background noise you merge past.

## Customer hat

One line: the URL you check each sprint *is* the pipeline working — if what you see is stale
or broken, saying so is your job.

## Done means

- [ ] Sprint 1: CI runs tests and coverage on every commit, PRs get automated review, and the
      app is live in production.
- [ ] Sprint 2: merging to main deploys automatically, and the team's rollback story is
      written down.
- [ ] Sprint 3: dependency scans report on every build, and the app serves from a real
      domain.
- [ ] Sprint 4: zero open vulnerability or linter findings.
- [ ] A sprint tag is pushed at every sprint boundary, and main is green.

## Project exercises

_Do these as part of the sprint work above; they produce artifacts your sprint reports and
reviews can point to._

1. The CI-pipeline exercise in Chapter 2's
   [project guide](../02-software-development-processes/project.md) had you stand up a CI
   pipeline that builds and tests on every push; this exercise extends it — do not rebuild
   it. Add a dependency scanning gate (§12.4.2) to that pipeline: enable an SCA tool or
   update bot (Dependabot, OWASP Dependency-Check, or equivalent), and configure it to open
   pull requests for vulnerable dependencies. Submit the configuration, one bot-opened PR (or
   a simulated one against a deliberately pinned old dependency) showing CI running on
   it, and a paragraph on how you decided whether the bump was safe to merge.

2. Measure your team's own four keys (§12.5.4) over the most recent two
   weeks of your project. Define "production" for your context in one sentence, extract
   deployment frequency and median lead time from your pipeline and `git log`, and start
   the deploy log needed for change failure rate and recovery time if you do not have
   one. Present the four numbers, compare them to the DORA performance bands, and — in
   GQM style — write one *question* per weak number and the data you would need to answer
   it. Targets are explicitly not required; explain why (§12.5.2).

3. Audit your project for delivery risk. Identify: every feature flag and
   its owner/removal date (§12.3.2), your rollback procedure and the date it was last
   actually exercised (§12.3.3), and the one module your team most fears changing
   (§12.6.1). For the feared module, write characterization tests covering its two most
   important behaviors, then perform and commit one small catalogued refactoring under
   green tests (§12.6.3), linking the commits in your report.

---

- Back to [Chapter 12](./) · [Exercises](exercises.md) · [Open Resources](resources.md)
- Sprint guide: [Running the Project on Two-Week Sprints](../appendix-a-team-project/two-week-sprints.md)
