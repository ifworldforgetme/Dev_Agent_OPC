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
- `work/`: project-local specs, plans, source roots, reviews, and launch artifacts.

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
bin/dev-flow init <project-name>
bin/dev-flow status <project-name>
bin/dev-flow next <project-name>
bin/dev-flow phase <project-name> pm "Write PRD and product acceptance criteria"
bin/dev-flow phase <project-name> agent "Design agent workflow and evals"
bin/dev-flow phase <project-name> spec "Write SPEC.md from the approved idea"
bin/dev-flow verify-phase <project-name> spec
bin/dev-flow reference-check <project-name> --required
bin/dev-flow design-check <project-name>
bin/dev-flow visual-check <project-name>
bin/dev-flow ship-check <project-name>
bin/dev-flow check <project-name>
```

`init` creates a control layer under `work/<project-name>/`:

- `.dev-flow/state.env`: current phase, active task, blockers, last verification
- `.dev-flow/context.md`: what context to load at each lifecycle phase
- `design/reference-intake.md`: rules for using reference images and software
- `design/reference-links.md`: user-provided reference apps, sites, Figma links, or competitor notes
- `tasks/status.md`: human-readable project ledger and review gates
- `tasks/quality-gates.md`: project-specific verification checklist
- `bin/check`: executable quality gate for this project

Use `phase` whenever the project moves from idea to pm, agent, spec, design,
plan, build, test, review, or ship. A phase transition verifies the previous
phase by default; use `--force` only when deliberately recording state before
artifacts are ready. Use `verify-phase` to check one stage and `ship-check`
before delivery. Use `next` at the start of a session to get the next prompt
and artifact target.

## UI Quality Gates

For customer-facing apps, run `bin/dev-flow reference-check <project-name>
--required` before writing design requirements. If the user provided screenshots,
reference images, Figma exports, app names, or websites, place them under
`work/<project-name>/design/` and extract concrete UI patterns from them. If no
reference exists and the visual direction is not already delegated, ask the user
for examples before implementation planning.

Use `design-check` after writing `DESIGN.md`, `VISUAL_SYSTEM.md`, and
`SCREEN_ACCEPTANCE.md`. Use `visual-check` after implementation screenshots and
`reviews/VISUAL_QA.md` exist.

## Artifact Locations

Use these folders while running the workflow:

```text
work/<project-name>/ideas/
work/<project-name>/product/
work/<project-name>/agent/
work/<project-name>/specs/
work/<project-name>/design/
work/<project-name>/design/references/
work/<project-name>/design/mocks/
work/<project-name>/design/screenshots/
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
| Product | `work/<project-name>/product/PRD.md`, `USER_STORIES.md`, `METRICS.md`, `ACCEPTANCE.md` |
| Agent | `work/<project-name>/agent/AGENT_SPEC.md`, `WORKFLOW.md`, `TOOLS_AND_PERMISSIONS.md`, `PROMPTS_AND_SKILLS.md`, `EVALS.md`, `FAILURE_RECOVERY.md` |
| Spec | `work/<project-name>/specs/SPEC.md` |
| Design | `work/<project-name>/design/DESIGN.md`, `VISUAL_SYSTEM.md`, `SCREEN_ACCEPTANCE.md` |
| Plan | `work/<project-name>/tasks/PLAN.md` |
| Build | Working source under `apps/` or `packages/` |
| Test | Verification evidence in `tasks/status.md` or `reviews/` |
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
OpenClaw, and OpenCode. It is generated from `agent-skills/skills`,
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

Use `bin/dev-flow ship-check <project-name>` before delivery. It verifies idea,
pm, agent, spec, design, plan, build, test, review, and ship artifacts. If a
runtime gate cannot run, such as Android APK build in an environment without
Java/Gradle/Android SDK, record the blocker in `reviews/BLOCKED_BUILD.md` rather
than silently passing the phase.
