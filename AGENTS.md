# Local Development Flow

This workspace packages `dev-agent/` as the canonical skill and agent source.
Root-level files provide local helper commands and publishing glue only.

bin/dev-flow is the only execution navigator for project work. For any
existing project, run these before opening workflow Markdown:

```bash
bin/dev-flow status <project-name>
bin/dev-flow next <project-name>
```

Do not start by bulk-reading Markdown. Load only the command, skill, references,
and project files named by `bin/dev-flow next`. Use broader Markdown reads only
when maintaining this workflow pack itself, creating/migrating a project, or
debugging a broken navigator.

## Primary Workflow

Use this lean lifecycle for non-trivial product or engineering work:

1. Idea: `dev-agent/skills/idea-refine/SKILL.md`
2. Spec: `dev-agent/skills/spec-driven-development/SKILL.md`; write PRD, scope, stories, metrics, technical spec, and agent runtime contract when needed
3. Design: `dev-agent/skills/design-flow/SKILL.md` when customer-facing UX or visual direction matters
4. Build: `dev-agent/skills/incremental-implementation/SKILL.md`; include lightweight task slicing and proof-first verification inside build
5. QA: optional; use functional/monkey/visual QA only when the project or user requires it
6. Ship: optional; use `dev-agent/skills/shipping-and-launch/SKILL.md` only for release/go-no-go work

For debugging, load `dev-agent/skills/debugging-and-error-recovery/SKILL.md`.
For UI work, also load `dev-agent/skills/frontend-ui-engineering/SKILL.md`.
For APIs or public module boundaries, also load
`dev-agent/skills/api-and-interface-design/SKILL.md`. For security-sensitive
work, also load `dev-agent/skills/security-and-hardening/SKILL.md`.

Do not bury problems in code. If requirements, design assets, host permissions,
SDKs, or risk boundaries are insufficient, return the issue to the owning flow
(spec, design, debug, security, or host requirements). If the flow cannot decide,
record a blocker and ask the user.

## Local Commands

Use `bin/dev-flow` to inspect and operate the workflow pack:

```bash
bin/dev-flow list
bin/dev-flow show spec
bin/dev-flow show design
bin/dev-flow command build
bin/dev-flow command qa
bin/dev-flow agent product-designer
bin/dev-flow agent ui-quality-reviewer
bin/dev-flow refs

bin/dev-flow init <project-name> [--type ui|agent|api|library|docs]
bin/dev-flow status <project-name>
bin/dev-flow next <project-name>
bin/dev-flow autonomy <project-name>
bin/dev-flow delegate <project-name>
bin/dev-flow ui-polish <project-name>
bin/dev-flow phase <project-name> <idea|spec|design|build|qa|ship> [task] [--force]
bin/dev-flow verify-phase <project-name> <idea|spec|design|build|qa|ship>
bin/dev-flow env-check <project-name>
bin/dev-flow design-check <project-name> [--allow-no-reference]
bin/dev-flow qa-check <project-name>
bin/dev-flow ship-check <project-name>
bin/dev-flow doctor <project-name>
bin/dev-flow migrate <project-name> [--type ui|agent|api|library|docs]
bin/dev-flow check <project-name>
bin/dev-flow package-adapters [output-dir]
bin/dev-flow install <codex|claude-code|gemini|openclaw|opencode> [--scope project|user] [--dest path]
```

Start real work with `bin/dev-flow init <project-name> --type <type>`. Use
`--type ui` for customer-facing interface work, `--type agent` for agentic
workflows, `--type api` for backend/API work, `--type library` for packages, and
`--type docs` for documentation-only work. The default type is `ui`, which keeps
strict design gates on. QA and ship stay optional unless `AUTOMATED_QA`,
`VISUAL_QA`, or the user requires them.

At the beginning of every project session, run `bin/dev-flow status <project-name>`
and `bin/dev-flow next <project-name>` to recover the current phase, minimal
context, required outputs, blockers, and next gate. Treat `next` as the source of
truth for what to read and what to run. `bin/dev-flow phase` records state only;
it does not execute skill work. Use `--force` only to intentionally record early
state, then complete missing artifacts before delivery.

`bin/dev-flow autonomy <project-name>` reports whether the host should continue
autonomously or schedule a heartbeat; `bin/dev-flow delegate <project-name>`
reports optional subagent task packets. These modules are independent, but the
Autonomy section in `next` may surface parallelizable work when host subagents
are available.

For UI build work, runtime visual inspection has a default one-pass budget.
Record that pass with `bin/dev-flow ui-polish <project-name>`. After the budget
is used, only P0/P1 defects block the current task; P2/P3 polish belongs in
`reviews/UI_DEBT.md`, and Autonomy should advance instead of looping on details.

Host SDKs, CLIs, simulators, MCP servers, credentials, and system services are
host-machine capabilities, not project runtime files. Record them in
`<project-name>/.dev-flow/HOST_REQUIREMENTS.md`. Run `env-check` only before
the current build slice or ship scope uses that host capability.

## UI Design And Build

For customer-facing apps, ask whether the user has reference images, screenshots,
Figma exports, apps, websites, or competitor products. If references exist, use
them. If no reference is present and the user has not delegated visual direction,
ask for examples before UI build. If visual direction is delegated, create
`<project-name>/design/REFERENCE_BOARD.md` and run
`bin/dev-flow design-check <project-name> --allow-no-reference`.

Do not require sketches or prototypes. The design phase should produce the
minimum build-ready handoff: `DESIGN.md`, `VISUAL_SYSTEM.md`,
`SCREEN_ACCEPTANCE.md`, and `DESIGN_ARTIFACTS.md` when formal visual assets are
needed. Satisfy `dev-agent/references/design-artifacts.md` as the current
HTML/CSS design-package contract, and run `bin/dev-flow design-check
<project-name>`. When Figma is used, satisfy
`dev-agent/references/figma-handoff.md` and run
`bin/dev-flow figma-check <project-name>`.

Before UI build, run `bin/dev-flow design-check <project-name>`. During build,
think first: confirm the current requirement and spec are clear, choose the
simplest source architecture, check whether design resources are sufficient for
the requested fidelity, and only then code. If a needed asset or decision is
missing, return to design/spec instead of guessing.

## QA And Ship

QA is optional by default. Enable it by setting `AUTOMATED_QA="required"` or
`VISUAL_QA="required"` in `<project-name>/.dev-flow/applicability.env`, or
run it when the user asks. Automated QA records `reviews/FUNCTIONAL_TEST.md` and
`reviews/MONKEY_TEST.md`; visual QA records `reviews/VISUAL_COMPARISON.md` with
`Overall score: N/100`. Runtime screenshots are required only for exceptions,
blocked flows, or explicit user requests.

Do not enter QA automatically after each build slice. Use QA only after the
overall requested implementation is complete, the project flags require QA, or
the user explicitly asks for it.

Ship is optional. Use `ship-check` only when preparing release evidence,
rollback, and go/no-go decisions.

## Artifacts

Keep every project self-contained under `<project-name>/`. Project-specific
source code and runtime apps belong inside that project folder, not at the
workspace root.
`init` creates only the control layer; lifecycle folders below are created when
`next`, `phase`, or a gate needs that phase.

- State: `.dev-flow/state.env`, `.dev-flow/schema.env`, `.dev-flow/context.md`, `.dev-flow/HOST_REQUIREMENTS.md`, `.dev-flow/autonomy.env`
- Ideas: `ideas/idea-brief.md`
- Product/spec: `product/PRD.md`, `specs/SPEC.md`
- Optional agent notes: `agent/` for legacy/imported material; canonical agent runtime contract belongs in `specs/SPEC.md`
- Design: `design/DESIGN.md`, `VISUAL_SYSTEM.md`, `SCREEN_ACCEPTANCE.md`, `DESIGN_ARTIFACTS.md`, `DESIGN_IMAGE_DESCRIPTIONS.md`, `FIGMA_HANDOFF.md`, `design/approved/`, `design/cut-assets/`
- Build planning/evidence: `tasks/status.md`, `tasks/quality-gates.md`, `tasks/IMPLEMENTATION_TRACE.md`, `tasks/AUTONOMY.md`, `tasks/DELEGATION.md`, `tasks/subagents/TEMPLATE.md`, `reviews/VERIFICATION.md`, `reviews/BLOCKED_BUILD.md`, `reviews/UI_DEBT.md`
- Optional QA: `reviews/FUNCTIONAL_TEST.md`, `reviews/MONKEY_TEST.md`, `reviews/VISUAL_COMPARISON.md`, `reviews/visual-screenshots/`
- Optional ship: `ship/LAUNCH.md`
- Source roots: `apps/`, `packages/`, or another project-local source directory

Only require human review for requirement confirmation, customer-facing visual
direction when no reference is available, high-risk architecture decisions,
security/payment/permission/data-deletion behavior, and production launch
approval. Routine implementation, tests, and local documentation should continue
automatically when the current spec, design, and build gate are clear.

Do not create project-specific `./apps`, `./packages`, `./server`, `./src`, or
similar root-level directories unless the user explicitly says the code is shared
across multiple projects. When running commands, use the project-local path, for
example `cd <project-name>/apps/mobile`.

Do not create root-level `skills/`, `agents/`, or checked-in `dist/` directories.
Skills and personas belong under `dev-agent/`; generated adapter packages belong
in `dist/` only as temporary output from `bin/dev-flow package-adapters` and
should be regenerated rather than hand-edited.

Root-level project-scope adapter installs such as `.codex/`, `.claude/`,
`.gemini/`, `.openclaw/`, and `.opencode/` are generated output. They are
ignored by git and should be regenerated with `bin/dev-flow install` rather than
hand-edited in this repository.
