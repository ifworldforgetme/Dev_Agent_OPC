# Dev Flow Native Adapter Workflow

This workspace packages `agent-skills` as the canonical workflow source and adds
a thin helper layer for project state, quality gates, adapter packaging, and
direct adapter installation.

## What Is Here

- `agent-skills/`: canonical workflow pack with skills, agents, commands, references, and platform docs.
- `agent-skills/commands/`: platform-neutral stage prompts used by Codex, OpenClaw, OpenCode, and other hosts when native slash commands are unavailable.
- `agent-skills/.claude/commands/`: Claude Code slash command files.
- `agent-skills/.gemini/commands/`: Gemini CLI command files.
- `AGENTS.md`: local instruction layer telling agents how to use the pack here.
- `bin/dev-flow`: helper script for listing workflows, managing project state, enforcing gates, packaging adapters, and installing adapters.
- `work/`: runtime project-local specs, plans, source roots, reviews, and launch artifacts created on demand by `bin/dev-flow init`; ignored by git by default.

## Lifecycle Commands

Use natural-language aliases in any agent, or install native command files where
the host supports them:

| Intent | Prompt alias | Native command where supported | Loads |
|---|---|---|---|
| Refine a rough product idea | `Use local flow: idea` | `/idea` | `idea-refine` |
| Product requirements | `Use local flow: pm` | `/pm` | `pm-flow` |
| AI agent workflow design | `Use local flow: agent` | `/agent` | `agent-flow` |
| Turn an idea into a buildable spec | `Use local flow: spec` | `/spec` | `spec-driven-development` |
| Design the experience | `Use local flow: design` | `/design` | `design-flow` |
| Break a spec into tasks | `Use local flow: plan` | `/plan` | `planning-and-task-breakdown` |
| Implement a slice | `Use local flow: build` | `/build` | `incremental-implementation` + `test-driven-development` |
| Prove behavior works | `Use local flow: test` | `/test` | `test-driven-development` |
| Review before merge | `Use local flow: review` | `/review` | `code-review-and-quality` |
| Prepare to launch | `Use local flow: ship` | `/ship` | `shipping-and-launch` |

Slash command support is host-specific. If a host does not support custom slash
commands, use the prompt alias or the installed command snippet content.

## Inspect The Pack

```bash
bin/dev-flow list
bin/dev-flow show idea
bin/dev-flow show spec
bin/dev-flow command plan
bin/dev-flow agent security-auditor
bin/dev-flow refs
```

## Project Lifecycle

Create one self-contained project folder before starting real work:

```bash
bin/dev-flow init <project-name> [--type ui|agent|api|library|docs]
bin/dev-flow status <project-name>
bin/dev-flow next <project-name>
bin/dev-flow phase <project-name> pm "Write PRD and product acceptance criteria"
bin/dev-flow phase <project-name> agent "Design agent workflow and evals"
bin/dev-flow phase <project-name> spec "Write SPEC.md from the approved idea"
bin/dev-flow verify-phase <project-name> spec
bin/dev-flow reference-check <project-name> --required
bin/dev-flow asset-check <project-name>
bin/dev-flow design-check <project-name>
bin/dev-flow qa-check <project-name>
bin/dev-flow pdca-check <project-name>
bin/dev-flow ship-check <project-name>
bin/dev-flow doctor <project-name>
bin/dev-flow migrate <project-name> [--type ui|agent|api|library|docs]
bin/dev-flow check <project-name>
```

`work/` does not need to exist in a clean checkout. `init` creates the directory
and a control layer under `work/<project-name>/` when a project actually starts:

- `.dev-flow/state.env`: current phase, active task, blockers, last verification
- `.dev-flow/schema.env`: project schema version and project type (`ui`, `agent`, `api`, `library`, or `docs`)
- `.dev-flow/applicability.env`: phase gates for `PM_FLOW`, `AGENT_FLOW`, `UI_FLOW`, `UI_REFERENCES`, `UI_DESIGN_ASSETS`, `UI_MOCKUPS`, and `GIT_CHECKPOINTS`
- `.dev-flow/context.md`: what context to load at each lifecycle phase
- `design/reference-intake.md`: rules for using reference images and software
- `design/reference-links.md`: user-provided reference apps, sites, Figma links, or competitor notes
- `design/REFERENCE_BOARD.md`: required when visual direction is delegated without external references
- `design/DESIGN_ARTIFACTS.md`: screen/state ledger for approved design assets
- `design/drafts/` and `design/mocks/`: sketches, wireframes, SVG/Markdown drafts, low-fidelity prototypes, and local mock screenshots
- `design/approved/`: implementation-ready raster/PDF design boards from approved sources such as imagegen, GPT Image, Figma MCP, Figma exports, or designer uploads; recommended subfolders are `screens/` and `components/`
- `design/cut-assets/`: bitmap UI assets, transparent PNGs, icon matrices, spritesheets, or animation frames derived from approved design assets when needed; recommended subfolders are `icons/`, `sprites/`, `illustrations/`, and `backgrounds/`
- `tasks/IMPLEMENTATION_TRACE.md`: screen/state to implementation/test handoff for UI work
- `tasks/status.md`: human-readable project ledger and review gates
- `tasks/quality-gates.md`: project-specific verification checklist
- `tasks/PDCA.md`: Current Cycle/Plan/Do/Check/Act handoff ledger
- `reviews/FUNCTIONAL_TEST.md`: normal critical-flow test evidence after implementation
- `reviews/MONKEY_TEST.md`: exploratory, random, repeated, or stress test evidence
- `reviews/VISUAL_COMPARISON.md`: comparison against approved design assets with `Overall score: N/100`
- `bin/check`: executable quality gate for this project

Use `phase` whenever the project moves from idea to pm, agent, spec, design,
plan, build, test, review, or ship. A phase transition verifies all prior
applicable phases by default. `pm` and `agent` are optional unless their
artifacts exist or their flow is marked `required` in
`.dev-flow/applicability.env`. `init --type ui` is the strict default and keeps
`UI_FLOW="required"` plus `UI_DESIGN_ASSETS="required"`. `init --type api`,
`library`, or `docs` disables UI gates by default; `init --type agent` requires
agent workflow artifacts and disables UI gates unless explicitly changed. Use
`--force` only when deliberately recording state before artifacts are ready. Use
`verify-phase` to check one stage, `doctor` to audit generated structure,
`migrate` to add missing v0.2 templates, and `ship-check` before delivery. Use
`next` at the start of a session to get the next prompt and artifact target.

## PDCA Handoff

Use `tasks/PDCA.md` as the persistent operating loop for every delivery cycle:

- Current Cycle records cycle ID, scope, owner or agent, and checkpoint.
- Plan records objective, source artifacts, acceptance criteria, risk, and gates.
- Do records implementation slices, changed areas, and build artifacts.
- Check records verification, functional tests, monkey tests, visual comparison, and blockers.
- Act records the decision, what becomes standard, what iterates next, and rollback or recovery notes.

Update this file as work moves across phases. Run `bin/dev-flow pdca-check
<project-name>` before delivery; `ship-check` invokes the same gate so a project
cannot ship with only an empty PDCA template. The reusable handoff contract is
documented in `agent-skills/references/pdca-delivery-loop.md`.

## UI Quality Gates

For customer-facing apps, run `bin/dev-flow reference-check <project-name>
--required` before writing design requirements. If the user provided screenshots,
reference images, Figma exports, app names, or websites, place them under
`work/<project-name>/design/` and extract concrete UI patterns from them. If no
reference exists and the visual direction is not already delegated, ask the user
for examples before implementation planning.

If the user explicitly delegates visual direction, run
`bin/dev-flow reference-check <project-name> --delegated` or
`bin/dev-flow design-check <project-name> --allow-no-reference`. This records
`UI_REFERENCES="delegated"` in `.dev-flow/applicability.env` so later phase and
ship checks use the same decision. Delegated visual direction also requires
`design/REFERENCE_BOARD.md`; do not treat the delegated env value as a substitute
for a concrete design reference board.

Derive the canonical screen list from the PRD, spec, design, and interaction
model, then record each required screen as a `##` section in
`SCREEN_ACCEPTANCE.md`. Every customer-facing screen must have 1-N approved
layout/state assets saved under `work/<project-name>/design/approved/`, with
screen/state coverage recorded in `design/DESIGN_ARTIFACTS.md`. The coverage
table must include a row for each exact `SCREEN_ACCEPTANCE.md` screen heading
and record source type, source reference, approved asset path, resolution/export
detail, approved/final status, and implementation notes.

Approved design assets may come from imagegen, GPT Image, Figma MCP, exported
Figma frames, designer uploads, manual design-system comps, or another explicit
approved source. Drafts are useful for structure but are not implementation
targets. Save deterministic SVG, Mermaid, Markdown, wireframes, local HTML/CSS
mock screenshots, and files named draft/sketch/prototype under `design/drafts/`
or `design/mocks/`. Chrome, Playwright, local browser, simulator, and runtime
screenshots are verification artifacts, not approved design assets; keep them
under `design/screenshots/` for references or `reviews/visual-screenshots/` for
exception evidence. `design-check` rejects draft, screenshot, prototype, and
runtime paths as approved assets.

If bitmap icons, illustrations, backgrounds, UI cutouts, spritesheets, or
animation frames are needed, save cut assets under `design/cut-assets/` and list
them in `ASSET_MANIFEST.md`. If none are needed, record
`CUT_ASSETS_REQUIRED: no` with rationale so the design gate can verify the
decision.

Use `asset-check` after writing `DESIGN_ARTIFACTS.md`, approved assets, and
cut-asset decisions. Use `design-check` after writing `DESIGN.md`, `VISUAL_SYSTEM.md`,
`SCREEN_ACCEPTANCE.md`, `DESIGN_ARTIFACTS.md`, approved assets, and cut-asset
decisions. Before entering build for UI work, `tasks/IMPLEMENTATION_TRACE.md`
must map every accepted screen to an implementation target, approved asset,
cut-asset decision, and test evidence. Use `qa-check` after implementation. Normal QA requires
functional-flow evidence, monkey/exploratory testing evidence, and a visual
comparison score against the approved design assets. The visual comparison must
include every `SCREEN_ACCEPTANCE.md` screen with approved asset path, runtime
surface, per-screen score, and decision, and score at least 90/100 for
high-fidelity UI delivery. Runtime screenshots are required only when
`reviews/EXCEPTION.md` or `reviews/BLOCKED_FLOW.md` records an exception or a
flow that cannot be completed.

Approved design assets, cut assets, and exception screenshots must be real
non-empty image or PDF files, not placeholder text files with image extensions.
If formal source, approved path, resolution/export detail, or final status
cannot be confirmed, stop before planning or build.

## Artifact Locations

Use these folders while running the workflow:

```text
work/<project-name>/ideas/
work/<project-name>/product/
work/<project-name>/agent/
work/<project-name>/specs/
work/<project-name>/design/
work/<project-name>/design/references/
work/<project-name>/design/drafts/
work/<project-name>/design/mocks/
work/<project-name>/design/screenshots/
work/<project-name>/design/sources/
work/<project-name>/design/sources/imagegen/
work/<project-name>/design/sources/gpt-image/
work/<project-name>/design/sources/figma/
work/<project-name>/design/sources/uploads/
work/<project-name>/design/approved/
work/<project-name>/design/approved/screens/
work/<project-name>/design/approved/components/
work/<project-name>/design/cut-assets/
work/<project-name>/design/cut-assets/icons/
work/<project-name>/design/cut-assets/sprites/
work/<project-name>/design/cut-assets/illustrations/
work/<project-name>/design/cut-assets/backgrounds/
work/<project-name>/tasks/
work/<project-name>/reviews/
work/<project-name>/reviews/visual-screenshots/
work/<project-name>/ship/
work/<project-name>/apps/
work/<project-name>/packages/
```

Every phase should produce a named artifact:

| Phase | Required output |
|---|---|
| Idea | `work/<project-name>/ideas/idea-brief.md` |
| Product, when applicable | `work/<project-name>/product/PRD.md`, `USER_STORIES.md`, `METRICS.md`, `ACCEPTANCE.md` |
| Agent, when applicable | `work/<project-name>/agent/AGENT_SPEC.md`, `WORKFLOW.md`, `TOOLS_AND_PERMISSIONS.md`, `PROMPTS_AND_SKILLS.md`, `EVALS.md`, `FAILURE_RECOVERY.md`, `OPERATIONS.md` |
| Spec | `work/<project-name>/specs/SPEC.md` |
| Design | `work/<project-name>/design/DESIGN.md`, `VISUAL_SYSTEM.md`, `SCREEN_ACCEPTANCE.md`, `DESIGN_ARTIFACTS.md`, `design/approved/*` |
| Plan | `work/<project-name>/tasks/PLAN.md`, and `tasks/IMPLEMENTATION_TRACE.md` when UI applies |
| PDCA | `work/<project-name>/tasks/PDCA.md` |
| Build | Working source under `apps/` or `packages/` |
| Test | Verification evidence in `tasks/status.md` or `reviews/` |
| QA | `work/<project-name>/reviews/FUNCTIONAL_TEST.md`, `MONKEY_TEST.md`, `VISUAL_COMPARISON.md` |
| Review | `work/<project-name>/reviews/REVIEW.md` |
| Ship | `work/<project-name>/ship/LAUNCH.md` |

Only stop for human review at requirement confirmation, customer-facing visual
direction when no reference is available, high-risk architecture choices,
security/payment/permission/data-deletion behavior, and production launch
approval.

## Native Adapter Packaging

Generate a disposable adapter package:

```bash
bin/dev-flow package-adapters dist/dev-flow-native
```

The package contains installable folders for Codex, Claude Code, Gemini CLI,
OpenClaw, and OpenCode plus a `runtime/` folder. The adapter folders are the
rules prompt layer. The `runtime/` folder carries executable gates:
`bin/dev-flow`, project templates, `AGENTS.md`, `DEV_FLOW.md`, and smoke tests.
It is generated from `agent-skills/skills`,
`agent-skills/agents`, `agent-skills/commands`, and
`agent-skills/references`; do not hand-edit checked-in adapter output.

## Direct Installation

Install to the default project scope:

```bash
bin/dev-flow install codex
bin/dev-flow install claude-code
bin/dev-flow install gemini
bin/dev-flow install openclaw
bin/dev-flow install opencode
```

Install to user scope:

```bash
bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope user
bin/dev-flow install gemini --scope user
bin/dev-flow install openclaw --scope user
bin/dev-flow install opencode --scope user
```

Use `--dest <path>` for staging, CI checks, or custom agent homes:

```bash
bin/dev-flow install codex --dest /tmp/dev-flow-codex
```

Default destinations:

| Target | Project scope | User scope |
|---|---|---|
| Codex | `.codex/` | `${CODEX_HOME:-~/.codex}` |
| Claude Code | `.claude/` | `~/.claude` |
| Gemini CLI | `.gemini/extensions/dev-flow-quality/` | `~/.gemini/extensions/dev-flow-quality/` |
| OpenClaw | `.openclaw/` | `~/.openclaw` |
| OpenCode | `.opencode/` | `~/.config/opencode` |

Installer behavior is additive: it creates or updates matching files, but it
does not delete old custom files in the destination.

## Evidence Gates

`bin/dev-flow phase` only records state; it does not perform the skill work for
the agent. To prevent false progress, phase transitions verify the previous
phase by default. The intended pattern is:

```bash
bin/dev-flow next <project-name>
# create the requested artifacts
bin/dev-flow verify-phase <project-name> <phase>
bin/dev-flow phase <project-name> <next-phase> "next task"
```

Use `bin/dev-flow pdca-check <project-name>` and `bin/dev-flow ship-check
<project-name>` before delivery. `ship-check` verifies all required phases plus
optional phases that have artifacts or are marked `required` in
`.dev-flow/applicability.env`, runs the project default gate, runs UI QA when
applicable, and then runs the PDCA gate. If a runtime gate cannot run, such as
Android APK build in an environment without Java/Gradle/Android SDK, record the
blocker in `reviews/BLOCKED_BUILD.md` rather than silently passing the phase.

After changing this workflow pack, run:

```bash
tests/dev-flow-smoke.sh
```

The smoke test creates ignored temporary `work/` projects and verifies that UI
planning cannot bypass design, delegated visual direction persists, invalid fake
image files fail, empty PDCA templates fail, a complete fixture reaches
`ship-check`, and adapters package.
