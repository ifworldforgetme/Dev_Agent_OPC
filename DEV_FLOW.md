# Dev Flow Native Adapter Workflow

This workspace packages `dev-agent` as the canonical workflow source and adds a
thin helper layer for project state, quality gates, adapter packaging, and direct
adapter installation.

## What Is Here

- `dev-agent/`: canonical workflow pack with skills, agents, commands, references, and platform docs.
- `dev-agent/commands/`: platform-neutral prompts for lifecycle and focused auxiliary flows.
- `dev-agent/dev-agent.manifest.json`: native flow, role, and gate index used by `/dev agent` and `/dev-agent`.
- `AGENTS.md`: local instruction layer telling agents how to use the pack here.
- `bin/dev-flow`: helper script for listing workflows, managing project state, checking host requirements, enforcing gates, packaging adapters, and installing adapters.
- `work/`: runtime project-local specs, source roots, reviews, and launch artifacts created on demand by `bin/dev-flow init`; ignored by git by default.

## Lifecycle Commands

The primary lifecycle is deliberately small:

```text
idea -> spec -> design -> build -> qa -> ship
```

`qa` and `ship` are optional unless the user or project applicability requires
them. Product, agent-contract, planning, testing, and review checks are folded
into `spec`, `build`, `qa`, and `ship`.

| Intent | Prompt alias | Native action | Loads |
|---|---|---|---|
| Refine a rough idea | `Use local flow: idea` | `/dev agent flow idea` | `idea-refine` |
| Write PRD + buildable spec | `Use local flow: spec` | `/dev agent flow spec` | `spec-driven-development` with agent contract when needed |
| Design the experience | `Use local flow: design` | `/dev agent flow design` | `design-flow` |
| Implement a slice | `Use local flow: build` | `/dev agent flow build` | `incremental-implementation` with micro-plan and proof-first checks |
| Optional QA | `Use local flow: qa` | `/dev agent flow qa` | functional, monkey, visual, and quality review when required |
| Optional launch | `Use local flow: ship` | `/dev agent flow ship` | `shipping-and-launch` |

Stable native entrypoints:

```text
/dev agent flow <flow-name> [project-name]
/dev agent role <role-name> [task]
/dev agent next <project-name>
/dev agent check <gate-name> <project-name> [phase-or-options]
/dev-agent <action> ...
```

## Execution Navigator

`bin/dev-flow` is the runtime navigator. For existing project work, agents
should start with:

```bash
bin/dev-flow status <project-name>
bin/dev-flow next <project-name>
```

`next` returns the current phase, command, skill files, minimal context, required
outputs, blockers, gate, and phase-record command. Load only that named context
instead of reading the workflow pack broadly.

## Project Lifecycle

Create one self-contained project folder before starting real work:

```bash
bin/dev-flow init <project-name> [--type ui|agent|api|library|docs]
bin/dev-flow status <project-name>
bin/dev-flow next <project-name>
bin/dev-flow phase <project-name> spec "Write PRD and SPEC"
bin/dev-flow verify-phase <project-name> spec
bin/dev-flow design-check <project-name>
bin/dev-flow phase <project-name> build "Build the first slice"
bin/dev-flow verify-phase <project-name> build
bin/dev-flow qa-check <project-name>      # only when QA is required
bin/dev-flow ship-check <project-name>    # only when shipping
```

`init` creates the control layer under `work/<project-name>/`:

- `.dev-flow/state.env`: current phase, active task, blockers, last verification
- `.dev-flow/schema.env`: project schema version and project type
- `.dev-flow/applicability.env`: optional gates such as `UI_FLOW`, `UI_REFERENCES`, `UI_DESIGN_ASSETS`, `AUTOMATED_QA`, `VISUAL_QA`, and `SHIP_FLOW`
- `.dev-flow/context.md`: minimal context loading guidance
- `.dev-flow/HOST_REQUIREMENTS.md`: host SDKs, CLIs, services, credentials, and permissions
- `product/PRD.md` and `specs/SPEC.md`: product + build source of truth
- `design/`: UI design, references, formal assets, and handoff records when UI applies
- `tasks/status.md`, `tasks/quality-gates.md`, `tasks/IMPLEMENTATION_TRACE.md`: status and build handoff
- `reviews/`: verification, optional QA evidence, blocked build records, and exception screenshots
- `ship/`: optional launch notes and rollback/go-no-go evidence

`bin/dev-flow phase` only records state. By default it verifies all prior
applicable lifecycle phases before moving forward. Use `--force` only when you
intentionally record early state and will complete missing artifacts later.

## Host Environment Contract

Host SDKs and services are machine capabilities, not project runtime files. Do
not install shared SDKs such as Xcode, Android SDK, Java/JDK, Docker,
Playwright browsers, Figma MCP, simulators, or package-manager caches inside
`work/<project-name>/`.

Record those requirements in `.dev-flow/HOST_REQUIREMENTS.md`. Run
`bin/dev-flow env-check <project-name>` only before a build slice or ship scope
actually uses the host capability. Slow or permission-heavy setup should be a
separate environment-prep pass that audits the host and asks before installing or
starting shared services.

## UI Design And Build Gates

For customer-facing apps, ask whether the user has references: screenshots,
reference images, Figma exports, apps, websites, or competitors. If no reference
exists and the user has not delegated visual direction, ask for examples before
UI build. If the user delegates visual direction, create `design/REFERENCE_BOARD.md`
and use `bin/dev-flow design-check <project-name> --allow-no-reference`.

Do not require sketches or prototypes. The design flow produces only what the
current build needs. Satisfy `dev-agent/references/design-artifacts.md` and run
`bin/dev-flow design-check <project-name>`. When Figma is used, satisfy
`dev-agent/references/figma-handoff.md` and run
`bin/dev-flow figma-check <project-name>`.

Before UI build, run `bin/dev-flow design-check <project-name>`. During build,
think before coding: confirm the spec is clear, choose the simplest source
architecture, check design readiness, record host needs, and route blockers back
to spec/design/debug/security instead of coding around missing decisions.

## QA And Ship

QA is optional by default. Enable it with:

```bash
AUTOMATED_QA="required"
VISUAL_QA="required"
```

in `work/<project-name>/.dev-flow/applicability.env`, or run it when the user
asks. Automated QA records `reviews/FUNCTIONAL_TEST.md` and
`reviews/MONKEY_TEST.md`; visual QA records `reviews/VISUAL_COMPARISON.md` with
`Overall score: N/100`. Runtime screenshots are required only for exceptions,
blocked flows, or explicit user requests.

Ship is optional and centered on launch evidence, rollback, and go/no-go.

## Artifact Summary

| Phase | Required output |
|---|---|
| Idea | `ideas/idea-brief.md` |
| Spec | `product/PRD.md`, `specs/SPEC.md` |
| Design, when UI applies | `design/DESIGN.md`, `VISUAL_SYSTEM.md`, `SCREEN_ACCEPTANCE.md`, `DESIGN_ARTIFACTS.md`, design contract inputs when required |
| Build | source under `apps/` or `packages/`, `reviews/VERIFICATION.md` or `reviews/BLOCKED_BUILD.md`, UI implementation trace when UI applies |
| QA, when required | `reviews/FUNCTIONAL_TEST.md`, `MONKEY_TEST.md`, `VISUAL_COMPARISON.md` as applicable |
| Ship, when requested | `ship/LAUNCH.md` with risk, rollback, and GO/NO-GO |

Only stop for human review at requirement confirmation, customer-facing visual
direction when no reference is available, high-risk architecture choices,
security/payment/permission/data-deletion behavior, and production launch
approval.

## Adapter Packaging

Generate a disposable adapter package:

```bash
bin/dev-flow package-adapters dist/dev-flow-native
```

Direct installs default to native mode: one `dev-agent` top-level skill,
`/dev agent` plus `/dev-agent` commands, and a `dev-agent-runtime/` folder under
the destination. Use `--mode full` only when you intentionally want every
internal workflow skill installed as a top-level skill.

```bash
bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope project
bin/dev-flow install gemini --scope project
bin/dev-flow uninstall codex --scope user
```

After changing this workflow pack, run:

```bash
tests/dev-flow-smoke.sh
```
