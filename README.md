# Dev Agent OPC

Dev Agent OPC is a lifecycle-driven workflow pack for AI coding agents. It turns a coding assistant from a general-purpose helper into a structured product and engineering partner that can move from idea to PRD, agent design, specification, UX design, task planning, implementation, testing, review, and launch.

The project is designed to work across agent hosts through portable `SKILL.md` workflows, command snippets, specialist personas, and a helper CLI.

## Based On

Dev Agent OPC is based on and extends [Addy Osmani's `agent-skills`](https://github.com/addyosmani/agent-skills), adding project-state management, product-management flow, AI-agent product flow, UI quality gates, adapter packaging, and OpenClaw-oriented installation support.

Related platforms and surfaces:

- [OpenClaw](https://github.com/openclaw/openclaw) / [OpenClaw Docs](https://docs.openclaw.ai)
- [Codex CLI](https://www.npmjs.com/package/@openai/codex)
- Claude Code, Gemini CLI, OpenCode, and other `SKILL.md`-compatible agent environments

## What It Provides

### Lifecycle Workflows

| Stage | Alias / Command | Main skill | Output |
|---|---|---|---|
| Idea | `idea` / `/idea` | `idea-refine` | Focused idea brief |
| Product | `pm` / `/pm` | `pm-flow` | PRD, user stories, metrics, acceptance criteria |
| Agent | `agent` / `/agent` | `agent-flow` | Agent workflow, tools, prompts, memory, recovery, evals |
| Spec | `spec` / `/spec` | `spec-driven-development` | Buildable technical/product spec |
| Design | `design` / `/design` | `design-flow` | UX, visual system, screen acceptance |
| Plan | `plan` / `/plan` | `planning-and-task-breakdown` | Small verifiable tasks |
| Build | `build` / `/build` | `incremental-implementation` + `test-driven-development` | Implemented slices with proof |
| Test | `test` / `/test` | `test-driven-development` | Tests, regression proof, verification evidence |
| Review | `review` / `/review` | `code-review-and-quality` | Structured quality review |
| Ship | `ship` / `/ship` | `shipping-and-launch` | Launch notes, go/no-go, rollback plan |

### Specialist Personas

- `product-designer` — customer-facing UX, visual systems, references, and screen acceptance criteria
- `ui-quality-reviewer` — screenshot-based visual QA and polish review
- `code-reviewer` — correctness, readability, architecture, security, and performance review
- `test-engineer` — test strategy, coverage, and prove-it regression tests
- `security-auditor` — threat modeling, vulnerability review, and hardening recommendations

### Quality Gates

The helper CLI can create and check project state under `work/<project-name>/`:

- `reference-check` — ensures customer-facing UI has reference images, software, links, or explicit visual-direction delegation
- `design-check` — requires `DESIGN.md`, `VISUAL_SYSTEM.md`, and `SCREEN_ACCEPTANCE.md`
- `visual-check` — requires screenshot evidence and `VISUAL_QA.md`
- `check` — runs the project-local `bin/check` gate

### Adapter Packaging

The repository can generate or install adapters for:

- Codex App/CLI
- Claude Code
- Gemini CLI
- OpenClaw
- OpenCode

Generated adapter output is disposable and should be regenerated from `agent-skills/` rather than edited by hand.

## Repository Structure

```text
agent-skills/
  skills/          Canonical SKILL.md workflows
  agents/          Specialist personas
  commands/        Platform-neutral command prompts
  references/      Shared quality and orchestration references
  .claude/         Claude Code command files
  .gemini/         Gemini command files
bin/dev-flow       Helper CLI for project state, gates, packaging, and installs
work/              Local project artifacts created by bin/dev-flow init
```

## Quick Start

```bash
# Inspect available workflows
bin/dev-flow list
bin/dev-flow command pm
bin/dev-flow command agent

# Start a project
bin/dev-flow init my-project
bin/dev-flow status my-project
bin/dev-flow next my-project

# Move through phases. Each transition verifies the previous phase by default.
bin/dev-flow phase my-project pm "Write product requirements"
bin/dev-flow phase my-project agent "Design agent workflow"
bin/dev-flow phase my-project spec "Write buildable spec"

# Verify a single phase or the whole delivery package
bin/dev-flow verify-phase my-project design
bin/dev-flow ship-check my-project

# Use --force only when intentionally recording state before artifacts exist
bin/dev-flow phase my-project design "Explore UX direction" --force
```

For customer-facing UI:

```bash
bin/dev-flow reference-check my-project --required
bin/dev-flow design-check my-project
bin/dev-flow visual-check my-project
```

## Package Or Install

Generate adapter output:

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

## Design Principles

- **Spec before code** — reduce guessing by making requirements explicit.
- **Product before implementation** — PRDs, stories, and metrics clarify what matters.
- **Agent workflows before prompts** — reliable AI products need tools, permissions, memory, recovery, and evals, not just instructions.
- **Reference-driven UI** — customer-facing design should be grounded in concrete references or explicit visual direction.
- **Small verifiable slices** — every task should have acceptance criteria and evidence.
- **Evidence-gated phases** — phase changes are state updates, not work execution; `verify-phase` and `ship-check` make artifacts explicit before claiming progress.
- **Portable adapters** — keep canonical workflows in `agent-skills/`, then generate host-specific installs.

## Author

Created and maintained by:

- **Kevin KE**
- **laoke.ai**
- Built to work with **OpenClaw** and **Model GPT-5.5**

## License

MIT. See [`LICENSE`](LICENSE).
