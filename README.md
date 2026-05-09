# Dev Agent OPC

[![Version](https://img.shields.io/badge/version-v0.1-blue.svg)](#release-status)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Agent Skills](https://img.shields.io/badge/agent--skills-compatible-111827.svg)](agent-skills/)

Dev Agent OPC is a portable workflow pack for AI coding agents. It gives an
agent a structured operating model for product and engineering work: idea
refinement, product requirements, agent workflow design, specification, UX
design, planning, implementation, testing, review, and launch.

The repository keeps the canonical source in `agent-skills/` and uses
`bin/dev-flow` as a local control plane for project state, quality gates,
adapter packaging, and host-specific installation.

## Why This Exists

General-purpose coding agents are useful, but real product work needs more than
one prompt. Dev Agent OPC turns repeatable delivery practices into reusable
agent workflows:

- lifecycle stages with explicit artifacts
- specialist personas for product design, UI QA, code review, testing, and security
- evidence gates before phase transitions and shipping
- reference-driven UI workflows for customer-facing products
- portable adapters for Codex, Claude Code, Gemini CLI, OpenClaw, and OpenCode

## Based On

Dev Agent OPC builds on [Addy Osmani's `agent-skills`](https://github.com/addyosmani/agent-skills)
and adds a project-local workflow layer, product-management flow, AI-agent
product flow, visual quality gates, adapter packaging, and OpenClaw-oriented
installation support.

## Release Status

`v0.1` is the first maintained release line for this repository.

Highlights in this release:

- evidence-gated phase transitions in `bin/dev-flow`
- optional `pm`, `agent`, `design`, and UI mockup gates through `.dev-flow/applicability.env`
- reference intake, design checks, and screenshot-based visual QA for UI work
- shared design, platform UX, visual QA, and image-generation reference material
- ignored runtime `work/` state so personal project experiments are not published accidentally
- adapter generation and installation paths for multiple agent hosts

## Repository Layout

```text
agent-skills/
  skills/          Canonical SKILL.md workflows
  agents/          Specialist agent personas
  commands/        Platform-neutral command prompts
  references/      Shared checklists, rubrics, and orchestration guidance
  .claude/         Claude Code command files
  .gemini/         Gemini CLI command files
bin/dev-flow       Helper CLI for state, gates, packaging, and installs
DEV_FLOW.md        Detailed local workflow documentation
AGENTS.md          Agent instructions for this repository
work/              Runtime project state created on demand; ignored by git
```

`work/` is intentionally absent from a clean checkout. It is created only when
you run `bin/dev-flow init <project-name>`.

## Lifecycle

| Stage | Alias / Command | Main workflow | Primary output |
|---|---|---|---|
| Idea | `idea` / `/idea` | `idea-refine` | Focused idea brief |
| Product | `pm` / `/pm` | `pm-flow` | PRD, user stories, metrics, acceptance criteria |
| Agent | `agent` / `/agent` | `agent-flow` | Agent workflow, tools, prompts, operations, recovery, evals |
| Spec | `spec` / `/spec` | `spec-driven-development` | Buildable product and technical spec |
| Design | `design` / `/design` | `design-flow` | UX, visual system, screen acceptance criteria |
| Plan | `plan` / `/plan` | `planning-and-task-breakdown` | Small, verifiable implementation tasks |
| Build | `build` / `/build` | `incremental-implementation` | Implemented slices with proof |
| Test | `test` / `/test` | `test-driven-development` | Tests and regression evidence |
| Review | `review` / `/review` | `code-review-and-quality` | Structured quality review |
| Ship | `ship` / `/ship` | `shipping-and-launch` | Launch notes, go/no-go, rollback plan |

## Quick Start

Inspect the available workflows:

```bash
bin/dev-flow list
bin/dev-flow command pm
bin/dev-flow command agent
bin/dev-flow refs
```

Start a project:

```bash
bin/dev-flow init my-project
bin/dev-flow status my-project
bin/dev-flow next my-project
```

Move through phases:

```bash
bin/dev-flow phase my-project pm "Write product requirements"
bin/dev-flow phase my-project agent "Design agent workflow"
bin/dev-flow phase my-project spec "Write buildable spec"
```

Verify work before claiming progress:

```bash
bin/dev-flow verify-phase my-project spec
bin/dev-flow check my-project
bin/dev-flow ship-check my-project
```

Phase transitions verify all prior applicable phases by default. Use `--force`
only when intentionally recording state before artifacts exist.

## Applicability Gates

Each project gets `work/<project-name>/.dev-flow/applicability.env`.

Use it to control optional workflow phases:

```bash
PM_FLOW="auto"
AGENT_FLOW="auto"
UI_FLOW="auto"
UI_MOCKUPS="auto"
GIT_CHECKPOINTS="auto"
```

Supported values:

- `auto` validates the phase only after matching artifacts exist.
- `required` treats the phase as part of phase transitions and `ship-check`.
- `disabled` skips the phase in phase transitions and `ship-check`.

## UI Quality Gates

Customer-facing UI work should be grounded in concrete references and verified
with screenshots.

```bash
bin/dev-flow reference-check my-project --required
bin/dev-flow design-check my-project
bin/dev-flow visual-check my-project
```

Reference material can include screenshots, Figma exports, app names, websites,
competitor products, platform UI examples, or explicit user-delegated visual
direction.

## Adapter Packaging

Generate disposable adapter output:

```bash
bin/dev-flow package-adapters
```

Install into an agent host:

```bash
bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope project
bin/dev-flow install gemini --scope project
bin/dev-flow install openclaw --scope user
bin/dev-flow install opencode --scope project
```

Use `--dest <path>` to install into a staging directory or custom agent home.
Generated adapter folders are build output and should be regenerated from
`agent-skills/`, not edited by hand.

## Specialist Personas

- `product-designer` for UX, visual systems, reference synthesis, and screen acceptance.
- `ui-quality-reviewer` for screenshot-based visual QA and polish review.
- `code-reviewer` for correctness, readability, architecture, security, and performance review.
- `test-engineer` for test strategy, coverage, and regression proof.
- `security-auditor` for threat modeling, vulnerability review, and hardening.

## Development Model

- `main` is the release branch.
- `dev` is the active iteration branch after `v0.1`.
- Release tags use the `vX.Y` format.
- Commit messages should follow Conventional Commits, for example `docs: polish README for v0.1 release`.

Runtime project folders under `work/` and generated adapter installs such as
`.codex/`, `.claude/`, `.gemini/`, `.openclaw/`, `.opencode/`, and `dist/` are
ignored by git.

## Design Principles

- Make requirements explicit before implementation.
- Keep source workflows canonical in `agent-skills/`.
- Treat phase changes as state updates, not proof of completed work.
- Use executable quality gates instead of prose-only reminders.
- Keep customer-facing UI reference-driven and screenshot-reviewed.
- Keep local project experiments separate from the publishable workflow pack.

## Maintainer

Created and maintained by Kevin KE / laoke.ai.

## License

MIT. See [`LICENSE`](LICENSE).
