# Chapter 12 — Open Resources

Free, open‑licensed, or freely accessible materials that reinforce this chapter. Types: 📘 open
text · 🎓 course · 📄 primary source / standard · 🎥 video · 🛠 tool. Licenses vary and are noted
where known. Each entry notes its license or access terms; when in doubt, check the linked page.

## Primary sources for the case studies

- 📄 **SEC Release No. 34-70694 — In the Matter of Knight Capital Americas LLC** (October
  2013) — [sec.gov](https://www.sec.gov/litigation/admin/2013/34-70694.pdf). The
  enforcement order behind §12.3.4's first case study: the reused flag, the eighth server,
  the 97 unheeded alerts, and the rollback that made things worse are all findings in this
  document. Read it — it is short, plainly written, and the definitive corrective to the
  folklore versions. *License: U.S. government work, public domain.*
- 📄 **CrowdStrike — External Technical Root Cause Analysis, Channel File 291** (August
  2024) — [crowdstrike.com](https://www.crowdstrike.com/wp-content/uploads/2024/08/Channel-File-291-Incident-Root-Cause-Analysis-08.06.2024.pdf).
  The vendor's own account of the 21-versus-20 field mismatch, the validator bug, and the
  committed remediations (staged rings, customer-controlled cadence, bounds checking).
  A model of what a public post-incident analysis should contain. *Access: free on the
  vendor's site.*

## The cloud and distributed systems

- 📄 **Kubernetes documentation** — [kubernetes.io/docs](https://kubernetes.io/docs/).
  The official concepts, tutorials, and reference for §12.1.5: containers, pods, services,
  ingress, and cluster architecture, with a browser-based interactive tutorial that needs
  no installation. *License: docs are CC BY 4.0.*
- 📘 **37signals — "We have left the cloud"** —
  [world.hey.com/dhh](https://world.hey.com/dhh/we-have-left-the-cloud-251760fb). The
  first-person record of §12.1.4's repatriation case study, with the linked earlier posts
  laying out the reasoning and the cost arithmetic for leaving the cloud on steady,
  predictable workloads. *Access: free to read.*
- 📘 **InfoQ — "Prime Video Switched from Serverless to EC2 and ECS to Save Costs"** (May
  2023) —
  [infoq.com](https://www.infoq.com/news/2023/05/prime-ec2-ecs-saves-costs/). A concise
  writeup of the Prime Video team's account of cutting one monitoring service's cost by
  roughly 90 percent by consolidating a distributed serverless design into a
  monolith-style process (§12.1.4). *Access: free to read.*
- 📄 **Gilbert & Lynch — "Brewer's Conjecture and the Feasibility of Consistent,
  Available, Partition-Tolerant Web Services"** (ACM SIGACT News, 2002) —
  [doi.org/10.1145/564585.564601](https://doi.org/10.1145/564585.564601). The paper that
  turned Brewer's conjecture into §12.1.6's CAP theorem by proving it; author copies
  circulate freely. Pair it with Brewer's own retrospective, **"CAP Twelve Years Later:
  How the 'Rules' Have Changed"** (IEEE Computer, 2012), free to read at
  [infoq.com/articles/cap-twelve-years-later](https://www.infoq.com/articles/cap-twelve-years-later-how-the-rules-have-changed/),
  which corrects the folklore "pick two of three" reading. *Access: both freely readable.*

## CI/CD and deployment practice

- 📘 **Martin Fowler — "Continuous Integration"** —
  [martinfowler.com/articles/continuousIntegration.html](https://martinfowler.com/articles/continuousIntegration.html).
  The canonical long-form article behind §12.2: mainline commits, self-testing builds,
  broken-build discipline, and the ten-minute build. *Access: free to read; ©
  martinfowler.com.*
- 📘 **Martin Fowler — "DeploymentPipeline", "BlueGreenDeployment", "CanaryRelease", and
  "FeatureToggle"** — [martinfowler.com/bliki](https://martinfowler.com/bliki/). Short,
  precise entries (the feature-toggle article, by Pete Hodgson, covers the flag-hygiene
  discipline of §12.3.2). *Access: free to read.*
- 📄 **Minimum CD** — [minimumcd.org](https://minimumcd.org/). A community-maintained,
  vendor-neutral statement of the *minimum* practices that constitute continuous delivery
  — a useful checklist for auditing your own pipeline against §12.2–12.3. *License: CC
  BY-SA 4.0.*
- 📘 **Bryan Finster — "5-Minute DevOps" series** — free to read on
  [dev.to/bdfinst](https://dev.to/bdfinst) and Medium. Short, blunt essays from a
  practitioner on trunk-based development, small batches, pipeline discipline, and why
  "we're too regulated for CD" is usually wrong. Several installments pair directly with
  this chapter's sections. *Access: free to read.*
- 📘 **Google — Site Reliability Engineering (the SRE book and workbook)** —
  [sre.google/books](https://sre.google/books/). Free online editions covering release
  engineering, canarying, error budgets, and postmortem culture — the operations side of
  §12.3 and §12.5 at planetary scale. *License: CC BY-NC-ND 4.0 (free to read).*

## DORA and delivery research

- 📄 **DORA — research program, four-keys definitions, and annual State of DevOps
  reports** — [dora.dev](https://dora.dev/). The research base for §12.5: metric
  definitions, performance-band data, capability catalog, and a quick check for assessing
  your own team. *Access: site content free; reports free to download.*
- 📘 **Forsgren, Humble, Kim — *Accelerate*** (IT Revolution Press, 2018). The book-length
  treatment of the research methodology and the speed-and-stability finding. *Not* openly
  licensed — listed here as the standard citation; the dora.dev material above covers the
  findings freely.

## Continuous security and the supply chain

- 📄 **GitHub Docs — Dependabot** —
  [docs.github.com/en/code-security/dependabot](https://docs.github.com/en/code-security/dependabot).
  Reference for the update-bot workflow of §12.4.2. *License: GitHub docs are CC BY 4.0.*
- 🛠 **OWASP Dependency-Check and Dependency-Track** —
  [owasp.org/www-project-dependency-check](https://owasp.org/www-project-dependency-check/)
  and [dependencytrack.org](https://dependencytrack.org/). Open-source SCA: the first
  scans a build for known-vulnerable components; the second tracks SBOMs across an
  organization. *License: Apache-2.0.*
- 📄 **SLSA — Supply-chain Levels for Software Artifacts** — [slsa.dev](https://slsa.dev/).
  A leveled framework for build-pipeline integrity and artifact provenance — the
  structured answer to the SolarWinds-style attacks of §12.4.2. *License: spec on GitHub
  under Community Specification License; site content CC BY 4.0.*

## Legacy code, refactoring, and technical debt

- 📘 **Martin Fowler — "StranglerFigApplication"** —
  [martinfowler.com/bliki/StranglerFigApplication.html](https://martinfowler.com/bliki/StranglerFigApplication.html).
  The original naming of §12.6.5's incremental-replacement pattern, with the fig-tree
  metaphor from its source. *Access: free to read.*
- 📘 **Refactoring catalog** — [refactoring.com/catalog](https://refactoring.com/catalog/)
  (Fowler's official catalog of named moves and mechanics) and
  [refactoring.guru](https://refactoring.guru/refactoring) (a free-to-read tutorial
  treatment with examples). The named, small, behavior-preserving steps of §12.6.3.
  *Access: both free to read online; the full *Refactoring* book is commercial.*
- 📄 **Ward Cunningham — "The WyCash Portfolio Management System"** (OOPSLA 1992
  experience report) — widely mirrored, e.g. via
  [c2.com](http://c2.com/doc/oopsla92.html). The four-paragraph origin of the
  technical-debt metaphor (§12.6.4), worth reading to see how much the original meaning —
  debt as *deliberate*, to be repaid with refactoring — matches this chapter's framing.
  *Access: free on the author's site.*

## License note

Linked resources remain under their own licenses (noted above where known); this page is
licensed **CC BY‑SA 4.0**.
