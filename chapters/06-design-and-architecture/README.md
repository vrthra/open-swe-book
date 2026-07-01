# Chapter 6 — Design and Architecture

> **Where we are.** Chapters 3 through 5 answered *what* to build: you elicited user
> requirements, analyzed them, and captured behavior as use cases. This chapter is the
> hinge where the project turns from problem to solution. Before anyone writes a line of
> production code, someone decides how the system will be carved into parts, how those
> parts will talk to one another, and which qualities the whole must exhibit. That set of
> decisions is the system's **architecture**, and living with it — well or badly — is
> most of what "maintaining software" means. Chapter 7 will catalog reusable
> architectural *patterns*; here you learn the underlying vocabulary and judgment.

A house can be built without blueprints. People do it — a room added here, a porch
bolted on there — and for a while it works. Then someone wants to move a load-bearing
wall, and it turns out no one knows which walls are load-bearing. Software accretes the
same way, except that its "walls" are invisible, so the discovery that you cannot safely
change something usually arrives as a production incident rather than a sagging roof.
**Architecture is the discipline of deciding, on purpose and in advance, where the walls
go** — and of writing that decision down so the next person can respect it.

## 6.1 The Role of Architecture

### 6.1.1 What Is Architecture?

Ask five engineers to define software architecture and you will get five answers, but
they cluster around a single idea. The architecture of a system is the set of
**structures** needed to reason about it: the parts it is made of, the externally visible
properties of those parts, and the relationships among them. Two phrases in that
sentence carry the weight.

First, **externally visible properties.** Architecture is deliberately about the *outside*
of each part — what it offers, what it requires, what guarantees it makes — and not about
the private machinery inside. When you say "the payments module talks to the ledger only
through a documented interface," you have made an architectural statement. When you say
"the ledger sorts its entries with quicksort," you have made an implementation statement.
The line between them is exactly the line between what other parts can depend on and what
they must not.

Second, **structures.** A system has more than one architecture depending on which
structure you look at. The way code is grouped into files and packages is one structure.
The way running processes communicate at runtime is another. The way software is deployed
onto machines is a third. All three are "the architecture," and confusing them is a
common source of muddled design discussions (§6.4 gives you a way to keep them straight).

> **Definition.** A system's **architecture** is the set of significant design decisions
> about how it is structured — its components, their responsibilities and interfaces, and
> the relationships and constraints among them — chosen to satisfy the system's most
> important quality requirements.

The word *significant* is doing real work. Not every decision is architectural. Whether a
helper function takes two arguments or three is a local matter you can change on a Tuesday
afternoon and no one else will notice. Whether the system stores state in a single shared
database or gives each service its own store is a decision that, once made and built upon,
may take a year and a rewrite to reverse. **Architectural decisions are the ones that are
expensive to change** — which is precisely why they deserve thought before, not after.

### 6.1.2 Design Includes Architecture

People sometimes talk as though "design" and "architecture" name two different
activities, or two different phases separated by a fence. They do not. **Design is a
continuum of decisions at different scales**, and architecture is simply its coarsest,
most consequential end.

```mermaid
flowchart LR
    A["Architecture<br/>(system-wide, expensive to change)"] --> B["High-level design<br/>(subsystems, module boundaries)"]
    B --> C["Detailed design<br/>(class responsibilities, interfaces)"]
    C --> D["Implementation<br/>(algorithms, data structures)"]
    classDef s fill:#eef,stroke:#66a;
    class A,B,C,D s;
```

At the top, you decide that the system is a web client, an API server, and a background
worker sharing a database — a handful of decisions that shape everything else. In the
middle, you decide how the API server divides into modules: authentication, messaging,
user profiles. Lower still, you decide that the messaging module exposes a `Conversation`
class with certain operations. At the bottom, you choose the data structure that stores
messages in memory. Each level *constrains* the levels below it and is *realized by* them.
A brilliant sorting algorithm cannot rescue an architecture that put the sort in the wrong
process; a clean architecture cannot survive detailed code that ignores its boundaries.

The practical consequence is that you cannot fully separate "the architects" from "the
programmers." The people writing code make micro-architectural decisions constantly, and
if those decisions ignore the intended structure, the real architecture drifts away from
the drawn one. Good teams keep the two aligned by writing the architecture down (§6.5) and
by reviewing changes against it.

### 6.1.3 What Is a Good Software Architecture?

There is no single "correct" architecture for a problem, only architectures that serve
some goals better than others. So we judge an architecture the way we judge a plan: by how
well it delivers the qualities that matter for *this* system, at an acceptable cost.
Concretely, a good architecture tends to have these properties.

- **It fits the important quality requirements.** If the system must handle ten thousand
  concurrent users, the architecture must have an answer for load and failure. If it must
  keep working while individual parts are redeployed, the architecture must isolate those
  parts. Architecture exists mainly to satisfy the *non-functional* requirements —
  performance, availability, security, modifiability — because functional requirements can
  usually be met by many structures, but quality requirements rule most of them out.
- **It makes likely changes cheap.** No architecture makes *every* change cheap; that is
  impossible, because reducing the cost of one kind of change usually raises the cost of
  another. The art is to predict which changes are likely and arrange the walls so those
  changes stay local. An architecture that isolates the parts most likely to change — the
  user interface, the tax rules, the payment provider — earns its keep for years.
- **It can be understood.** An architecture that no one on the team can hold in their head
  is, for practical purposes, no architecture at all: people will violate boundaries they
  cannot see. Conceptual integrity — a small number of consistent ideas applied
  throughout — is worth more than local cleverness.
- **It is buildable and testable.** A structure that looks elegant on a diagram but forces
  every test to spin up the entire system is a bad architecture, because it makes the
  feedback loop that catches defects slow and expensive (Chapter 9).

> **Principle.** You cannot maximize all qualities at once. Good architecture is the art
> of *trading off* consciously — buying the qualities this system needs and knowingly
> paying for them in the qualities it does not — rather than stumbling into whichever
> trade-offs the code happens to make for you.

## 6.2 Designing Modular Systems

The single most powerful idea in software design is **modularity**: build the system out
of parts that can each be understood, built, tested, and changed largely on their own. The
whole of §6.2 unpacks what makes a decomposition into modules good rather than merely
present. (Every non-trivial program *has* modules; the question is whether they are the
*right* ones.)

### 6.2.1 The Modularity Principle

A **module** is a unit of software with a boundary: a set of things it provides to the
rest of the system and a set of things it keeps to itself. The value of a module comes
almost entirely from what it *hides*.

**Information hiding** is the discipline of designing each module around a decision — often
a design decision likely to change — and hiding that decision behind an interface, so that
the rest of the system depends on the *interface* and not on the decision. The classic
example: a module that stores user records should expose operations like `find(id)` and
`save(record)` while hiding whether the records live in a SQL database, a file, or a
remote service. Because callers never learned how records are stored, you can switch from
files to a database without touching a single caller. The hidden decision was free to
change because it was, in fact, hidden.

**Encapsulation** is the mechanism that enforces information hiding: the language keeps
the private parts of a module unreachable from outside, so that clients *cannot* accidentally
depend on internals even if they wanted to. A field marked `private`, a function not
exported from its file, a class whose only public surface is a small set of methods — these
are encapsulation. Information hiding is the *intent* ("callers should not know how records
are stored"); encapsulation is the *enforcement* ("and the compiler will stop them").

The reason this matters is not tidiness. It is that **a module's interface is a promise,
and its implementation is a secret.** As long as you keep the promise, you may change the
secret freely, and no one who relied only on the promise can break. The size of the promise
you make — the "surface area" of the interface — is therefore the size of the commitment
you can never quietly walk back. Small, deliberate interfaces are small, deliberate
commitments. This is why experienced designers fight to keep interfaces narrow: every
public method is a hostage to fortune.

> **Principle.** Design each module around a secret. Ask "what decision does this module
> hide, such that if that decision changed, only this module would change?" A module that
> hides nothing is not a module; it is just a place where code happens to sit.

### 6.2.2 Coupling and Cohesion

Two measures, introduced together decades ago and never improved upon, tell you whether a
decomposition is good: **coupling** between modules and **cohesion** within each.

**Coupling** is the strength of the dependency between two modules — how much one must know
about the other, and how badly a change to one ripples into the other. You want it **low**.
Coupling is not binary; it comes in kinds, and the kinds form a ladder from worst to best.
Knowing the ladder lets you diagnose *why* a dependency hurts, not just that it does.

- **Content coupling (worst).** One module reaches inside another and manipulates its
  internals directly — modifying its private data, or jumping into the middle of its code.
  Any change to the target's internals can break the intruder without warning. This is the
  coupling encapsulation exists to prevent.
- **Common coupling.** Modules share global mutable state — a global variable, a shared
  singleton. Now any module can change data any other module reads, so behavior depends on
  execution order and no module can be understood alone. Bugs here are notoriously
  non-local.
- **Control coupling.** One module passes a flag that tells another *what to do* — a
  control signal — so the caller must understand the callee's internal logic and branches.
  A function called `process(data, mode)` where `mode` selects between unrelated behaviors
  couples caller to callee's internal structure.
- **Stamp coupling.** A module passes a whole compound record when the callee needs only a
  field or two. The callee is now needlessly coupled to the shape of the whole record, and
  changing that record's structure can ripple into modules that never used the changed part.
- **Data coupling (best).** Modules communicate only through simple parameters — the exact
  data the callee needs, and nothing more. This is the loosest, most honest form of
  connection, and the one to aim for.

**Cohesion** is how well the elements *inside* a single module belong together — how
focused the module is on one job. You want it **high**. It, too, comes in kinds, from worst
to best:

- **Coincidental (worst):** the parts are grouped for no real reason — a "utils" grab-bag.
- **Logical:** parts are grouped because they are the same *category* of thing (all the
  input routines) though they do unrelated jobs.
- **Temporal:** parts are grouped because they run at the same *time* (everything done "at
  startup"), not because they relate.
- **Procedural / communicational:** parts share a flow of control, or operate on the same
  data.
- **Functional (best):** every part contributes to one well-defined task, and the module
  does that task completely and does nothing else.

Coupling and cohesion pull in the same direction, which is why they are always taught
together: **when you raise cohesion, coupling tends to fall, and vice versa.** If each
module does exactly one thing (high cohesion), related logic sits together and does not need
to reach across boundaries (low coupling). If a module does five unrelated things (low
cohesion), pieces of those five jobs inevitably entangle with five other modules (high
coupling). Chasing one gets you the other.

> **Pitfall.** A "utility" or "helpers" module is usually a cohesion failure wearing a
> friendly name. Because it has no single responsibility, everything ends up depending on
> it, and it ends up depending on everything — the worst of both measures. When you notice
> a module you cannot describe in one sentence without saying "and," split it.

### 6.2.3 Design Guidelines for Modules

The two measures above become actionable through a handful of guidelines. None is a law;
each is a heuristic that pays off far more often than not.

1. **Give each module one responsibility.** You should be able to state a module's job in a
   single sentence with no "and." This is the *single responsibility* idea, and it is
   really "high cohesion" restated as a design rule.
2. **Make interfaces small and explicit.** Expose the fewest operations that let clients do
   their job. Every additional public operation is another promise you must keep forever
   (§6.2.1).
3. **Depend on interfaces, not implementations.** When module A needs a service, let it
   depend on an abstract description of that service, so that any conforming implementation
   can be substituted. This keeps coupling at the data/interface level and makes testing
   (with fakes) and change (with new providers) cheap.
4. **Push details down and out.** Keep policy — the important, stable decisions — in the
   core, and push volatile details (the specific database, the specific UI toolkit) to the
   edges where they can be swapped. Stable things should not depend on volatile things.
5. **Avoid cyclic dependencies.** If A depends on B and B depends on A, they are not two
   modules; they are one module with a line drawn through it, and you can no longer build,
   test, or reason about either alone. Break the cycle by introducing an interface one side
   owns.
6. **Design for the changes you expect.** You cannot isolate everything, so spend your
   modularity budget on the decisions most likely to change: external providers, business
   rules, presentation. Do not pay for flexibility you have no reason to expect (that is
   over-engineering, its own kind of accidental complexity).

## 6.3 Class Diagrams

To design and discuss modular structure, you need a notation. The **class diagram** from
the Unified Modeling Language (UML) is the lingua franca for describing the static
structure of object-oriented systems: the classes, what each holds and does, and how they
relate. You will not draw every class; you draw the ones whose relationships someone needs
to understand.

### 6.3.1 Representing a Class

A class is drawn as a box with up to three compartments: the **name** on top, the
**attributes** (data each object holds) in the middle, and the **operations** (what each
object can do) at the bottom. A **visibility** marker precedes each member:

- `+` **public** — visible to everyone (part of the interface, the promise),
- `-` **private** — visible only inside the class (the secret),
- `#` **protected** — visible to the class and its subclasses,
- `~` **package** — visible within the same package.

The convention is `visibility name : type` for attributes and
`visibility name(parameters) : returnType` for operations. Here is a small messaging model
you can read at a glance.

```mermaid
classDiagram
    class User {
        -id: UserId
        -displayName: String
        -status: Presence
        +send(to: Conversation, body: String) Message
        +setStatus(s: Presence) void
    }
    class Message {
        -id: MessageId
        -body: String
        -sentAt: Instant
        +markRead() void
    }
    class Conversation {
        -id: ConversationId
        -title: String
        +post(m: Message) void
        +participants() List~User~
    }
    class GroupConversation {
        -adminIds: Set~UserId~
        +promote(u: User) void
    }
    class Attachment {
        -filename: String
        -sizeBytes: long
    }
    Conversation <|-- GroupConversation : generalization
    User "1" --> "0..*" Message : sends
    Conversation "1" *-- "0..*" Message : composition
    Message "1" o-- "0..*" Attachment : aggregation
    Message ..> Presence : dependency
```

Read the boxes first: a `User` hides its `id` and `status` (private, the `-`) but promises
a public `send` operation (the `+`). The relationships — the lines between boxes — are the
real content of the diagram, and they are the subject of the next section.

### 6.3.2 Relationships between Classes

The lines in a class diagram are not decoration; each *shape* means something precise about
how two classes are connected and how tightly. Getting them right is how a diagram
communicates coupling.

- **Association** (a plain solid line) says two classes are connected: objects of one
  refer to objects of the other. "A `User` *sends* `Message`s" is an association. It is the
  most general relationship; the others are associations with extra meaning.
- **Aggregation** (a solid line with a *hollow* diamond at the "whole" end) is a
  "has-a / part-of" relationship where the part can outlive the whole and can be shared. A
  `Message` aggregates `Attachment`s: the same attachment could be referenced elsewhere, and
  deleting the message need not destroy the file. Aggregation is a weak, informal grouping.
- **Composition** (a solid line with a *filled* diamond at the "whole" end) is a stronger
  "part-of" where the part's lifetime is bound to the whole and the part is not shared. A
  `Conversation` is *composed of* its `Message`s: destroy the conversation and its messages
  go with it; a message belongs to exactly one conversation. Composition encodes ownership.
- **Generalization** (a solid line with a *hollow triangle* pointing at the parent) is
  inheritance: "a `GroupConversation` *is a* `Conversation`." The subclass inherits the
  parent's interface and can be used wherever the parent is expected.
- **Dependency** (a *dashed* arrow) is the weakest link: one class *uses* another
  transiently — as a parameter type, a return type, or a local — without holding a
  long-lived reference. `Message` depends on `Presence` if one of its methods takes a
  `Presence` argument. Dependencies are the couplings you most want to keep few and
  one-directional.

**Multiplicity** annotates the ends of a line with how many objects participate: `1`
(exactly one), `0..*` or `*` (zero or more), `1..*` (one or more), `0..1` (optional). In
the diagram above, `Conversation "1" *-- "0..*" Message` reads "one conversation is composed
of zero or more messages, and each message belongs to exactly one conversation."
Multiplicities are not pedantry: `1` versus `0..1` versus `0..*` is often the difference
between a null-pointer bug, a missing foreign key, and a correct schema.

> **Pitfall.** Do not agonize over aggregation versus composition in every diagram — even
> UML experts argue about the boundary. What matters is the *lifetime and ownership*
> question the distinction forces you to ask: "if I delete the whole, does the part die,
> and can two wholes share one part?" Answer that; the diamond follows.

## 6.4 Architectural Views

A single diagram cannot capture a whole system any more than a single photograph captures
a building. Stakeholders ask different questions — "what are the responsibilities?", "how
does it perform under load?", "how do I check out and build the code?", "which server runs
what?" — and each question is best answered by a different picture. A **view** is a
representation of the system from one such perspective.

### 6.4.1 The 4+1 Grouping of Views

A widely used way to organize views, introduced by Philippe Kruchten, groups them into four
plus one. The four cover distinct concerns; the "+1" ties them together.

```mermaid
flowchart TB
    subgraph plus1[" "]
        SC["+1 · Scenarios<br/>(use cases that<br/>exercise the others)"]
    end
    LOG["Logical View<br/>functionality; classes,<br/>responsibilities<br/>(end user)"]
    DEV["Development View<br/>code organization;<br/>modules, packages, layers<br/>(programmer)"]
    PROC["Process View<br/>runtime; processes,<br/>threads, concurrency<br/>(integrator)"]
    PHYS["Physical View<br/>deployment; nodes,<br/>networks, hardware<br/>(operations)"]
    SC --- LOG
    SC --- DEV
    SC --- PROC
    SC --- PHYS
    LOG -.-> PROC
    DEV -.-> PHYS
    classDef v fill:#eef,stroke:#66a;
    classDef s fill:#efe,stroke:#6a6;
    class LOG,DEV,PROC,PHYS v;
    class SC s;
```

- **Logical view** — the *functionality* the system offers to end users, expressed as the
  key abstractions: classes, their responsibilities, their relationships. Class diagrams
  (§6.3) live here. It answers "what are the concepts and what can they do?"
- **Process view** — the system *at runtime*: the processes and threads, how they
  communicate, and how concurrency, performance, and availability are handled. It answers
  "what is executing, and how do the running pieces coordinate?" This is where you reason
  about deadlocks, throughput, and failover.
- **Development view** — the *code as organized for building*: the modules, packages,
  libraries, and layers, and their dependency structure. It is the programmer's map (§6.5.3)
  and answers "where does this code live and what may depend on what?"
- **Physical view** (also called the *deployment* view) — the *software mapped onto
  hardware*: which components run on which nodes, and how those nodes are networked. It
  answers "what do we actually deploy, and where?"
- **+1: Scenarios** — a handful of important **use cases** (Chapter 5) that thread through
  all four views. Scenarios are the glue: walking a use case through the logical, process,
  development, and physical views is how you check that the four are *consistent* with one
  another and that, together, they actually deliver the behavior. They also make the views
  discoverable — a reader follows a familiar story and sees each view play its part.

The power of the 4+1 grouping is that it *separates concerns among readers*. An operations
engineer reads the physical view and ignores the logical one; a new programmer reads the
development view. Nobody has to understand everything at once, which is the same complexity
argument that motivated modularity — applied now to the documentation.

### 6.4.2 Structures and Views

It helps to distinguish a **structure** from a **view**. A structure is something real in
the system — the actual set of modules and their dependencies, the actual set of runtime
processes. A view is a *representation* of a structure, drawn for an audience. The three
big families of structure are worth naming because almost every architectural confusion is
a failure to keep them apart:

- **Module structures** — how the system is divided into units of *code*: modules,
  packages, classes, layers, and the "is-part-of," "depends-on," and "is-a" relations
  among them. (Development and logical views show these.)
- **Component-and-connector structures** — how the system is divided into units that have
  *runtime* presence: processes, services, clients, servers, and the connectors —
  channels, calls, message queues — through which they interact. (The process view shows
  these.)
- **Allocation structures** — how software elements *map onto* their environment: onto
  hardware nodes, onto teams that own them, onto files in a repository. (The physical view
  shows these.)

The reason to keep these straight is that a single box on one diagram can be several things
on another. A "messaging" module in the development view might, at runtime, be split across
three processes in the process view and deployed on two machines in the physical view. If
you try to force all of that into one diagram, you get a picture that is wrong from every
angle. **Draw one structure per view, name the view, and say who it is for.**

## 6.5 Describing System Architecture

Deciding an architecture is worthless if the decision lives only in the head of the person
who made it. Architecture must be *described* — written down in a form the team can read,
question, and hold changes accountable to. This section gives you a practical outline and a
worked example.

### 6.5.1 Outline for an Architecture Description

An architecture description need not be a book. For most systems, a living document of a few
pages, kept next to the code, does the job. A serviceable outline:

1. **Context and goals.** What the system is, who its stakeholders are, and — crucially —
   the *quality requirements* that drive the architecture (the target load, the availability
   goal, the security posture, the changes you expect). Everything after this section exists
   to satisfy this section.
2. **Constraints and decisions.** The fixed constraints (must run on the customer's cloud;
   must integrate with an existing identity provider) and the *significant decisions* you
   made, each with a one-line rationale. Recording *why* is what lets a future engineer
   safely revisit the *what*.
3. **The views.** One section per view you chose to document (§6.4): typically a logical
   view (a class or component diagram), a development view (the module hierarchy), a process
   view if concurrency matters, and a physical view if deployment is non-trivial.
4. **Key scenarios.** Two or three use cases walked through the views, showing how the
   parts cooperate to deliver behavior — the "+1" made concrete.
5. **Risks and open questions.** Honesty about what you are unsure of. An architecture
   document that admits its risks is far more useful than one that pretends to certainty.

### 6.5.2 System Overview of a Communications App

Make it concrete. Suppose you are building **a communications app** — one-to-one and group
messaging, with presence ("online / away") and file attachments. Its important quality
requirements are: messages should be delivered within a second under normal load; the
system should stay usable if the attachment storage is temporarily unavailable; and the
team expects to change the *transport* (today WebSockets, perhaps something else later) and
to add new *message types* often.

Those quality requirements dictate the shape. The need to swap transports says: hide the
transport behind an interface. The need to survive attachment-storage outages says: make
attachments a separate component the messaging core does not synchronously depend on. Here
is a component-and-connector (process) view for that overview.

```mermaid
flowchart TB
    subgraph client["Client (browser / mobile)"]
        UI[Chat UI]
    end
    subgraph edge["API / Gateway"]
        GW[Connection Gateway]
    end
    subgraph core["Messaging Service"]
        MSG[Message Router]
        PRES[Presence Tracker]
    end
    subgraph stores["Backing Stores"]
        MDB[(Message Store)]
        ADB[(Attachment Store)]
    end
    UI -- "WebSocket" --> GW
    GW -- "authenticated calls" --> MSG
    MSG -- "read/write" --> MDB
    MSG -- "notify" --> PRES
    MSG -. "async upload/fetch<br/>(may be degraded)" .-> ADB
    classDef c fill:#eef,stroke:#66a;
    class UI,GW,MSG,PRES c;
```

Notice how the diagram *encodes the quality requirements*. The transport (WebSocket) is
confined to the edge between the UI and the Connection Gateway, so changing it touches two
boxes, not the whole system. The Attachment Store is reached by a *dashed, asynchronous*
connector, signaling that the Message Router does not block on it — if attachments are down,
text messages still flow, satisfying the "stay usable" requirement. The architecture is
readable *because* it makes the important decisions visible and hides the rest.

### 6.5.3 A Development View: Module Hierarchies

The process view above shows runtime pieces. The **development view** shows how the *code*
is organized and — most importantly — which modules are *allowed* to depend on which. The
usual discipline is a **layered** module hierarchy: higher layers may depend on lower ones,
never the reverse, and volatile details sit at the edges.

```mermaid
flowchart TB
    subgraph L1["Presentation layer"]
        WEB[web-ui]
    end
    subgraph L2["Application layer"]
        CONV[conversations]
        USERS[users]
    end
    subgraph L3["Domain layer"]
        MODEL[domain-model<br/>User · Message · Conversation]
    end
    subgraph L4["Infrastructure layer"]
        TRANSPORT[transport<br/>«interface» + WebSocket impl]
        PERSIST[persistence<br/>«interface» + DB impl]
    end
    WEB --> CONV
    WEB --> USERS
    CONV --> MODEL
    USERS --> MODEL
    CONV --> TRANSPORT
    CONV --> PERSIST
    MODEL -.->|no dependency| TRANSPORT
    classDef m fill:#eef,stroke:#66a;
    class WEB,CONV,USERS,MODEL,TRANSPORT,PERSIST m;
```

Two things about this hierarchy are worth internalizing. First, **the domain model depends
on nothing below it.** The `domain-model` module — the classes from §6.3 — knows nothing
about databases or WebSockets. That is deliberate: the domain is the most stable, most
valuable part of the system, so it must not be dragged along when a volatile detail changes.
The dashed "no dependency" line is a design *rule*, not an observation, and a good build
setup enforces it (Chapter 8's static checks can fail the build if `domain-model` ever
imports `transport`).

Second, **the infrastructure layer is where interfaces meet implementations.** The
`persistence` and `transport` modules each expose an interface that the application layer
depends on, while hiding a concrete implementation behind it. This is dependency inversion
in the concrete: the important, stable code (application and domain) depends on abstractions,
and the volatile code (the actual database driver, the actual socket library) depends on
those same abstractions from below. Swapping the database becomes a change confined to one
module — exactly the "make likely changes cheap" property from §6.1.3, realized in the code
structure rather than merely wished for on a slide.

## 6.6 Conclusion

Architecture is what you get when you make the expensive decisions on purpose. Its core is a
single, endlessly applied idea — **decompose the system into modules with high cohesion and
low coupling, each hiding a decision behind a small, explicit interface** — and everything
else in this chapter is that idea seen from a different angle. Coupling and cohesion give
you a vocabulary to *diagnose* a decomposition; information hiding tells you *how to choose*
the boundaries; class diagrams and multiplicities let you *record* the static structure;
the 4+1 views let you *describe* the system to different audiences without drowning any of
them; and an architecture document makes the whole thing *durable* — a decision the team can
respect instead of a story only one person remembers.

Two ideas are worth carrying into the rest of the book. First, architecture serves *quality
requirements*: you choose a structure to buy performance, availability, security, or —
above all — cheap change, and you pay for it consciously in the qualities you did not
choose. Second, architecture is only real to the extent that the code obeys it; a drawn
boundary that the build does not enforce and the reviews do not defend will erode. Chapter 7
takes the next step, showing that you rarely invent these structures from nothing: recurring
problems have well-understood **architectural patterns** — layered, client-server,
pipe-and-filter, publish-subscribe, and more — that package hard-won decisions so you can
reuse the judgment, not just the diagram.

---

- **Key takeaways** are summarized above in §6.6.
- Continue to the [Exercises](exercises.md).
- Go deeper with the [Open Resources](resources.md) for this chapter.
