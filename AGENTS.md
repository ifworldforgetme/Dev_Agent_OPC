# Local Development Flow

This workspace packages `agent-skills/` as the canonical skill and agent source.
Root-level files provide local helper commands and publishing glue only. Load only
the relevant Markdown files from `agent-skills/skills/`,
`agent-skills/agents/`, and `agent-skills/references/` when the current task
calls for them.

## Primary Workflow

Use this lifecycle for non-trivial product or engineering work:

1. Idea: `agent-skills/skills/idea-refine/SKILL.md`
2. Product: `agent-skills/skills/pm-flow/SKILL.md` when PRDs, user stories, scope, or metrics are needed
3. Agent workflow: `agent-skills/skills/agent-flow/SKILL.md` when AI agents or automations are involved
4. Spec: `agent-skills/skills/spec-driven-development/SKILL.md`
5. Design: `agent-skills/skills/design-flow/SKILL.md`
6. Plan: `agent-skills/skills/planning-and-task-breakdown/SKILL.md`
7. Build: `agent-skills/skills/incremental-implementation/SKILL.md`
8. Test: `agent-skills/skills/test-driven-development/SKILL.md`
9. Review: `agent-skills/skills/code-review-and-quality/SKILL.md`
10. Ship: `agent-skills/skills/shipping-and-launch/SKILL.md`

For debugging, load `agent-skills/skills/debugging-and-error-recovery/SKILL.md`.
For UI work, also load `agent-skills/skills/frontend-ui-engineering/SKILL.md`.
For customer-facing UI, `design-flow` owns reference intake and design gates, and
`frontend-ui-engineering` owns implementation plus screenshot-based visual QA.
For APIs or public module boundaries, also load
`agent-skills/skills/api-and-interface-design/SKILL.md`.
For security-sensitive work, also load
`agent-skills/skills/security-and-hardening/SKILL.md`.

## Local Commands

Use `bin/dev-flow` to inspect the local workflow pack:

```bash
bin/dev-flow list
bin/dev-flow show spec
bin/dev-flow show design
bin/dev-flow command pm
bin/dev-flow command agent
bin/dev-flow command build
bin/dev-flow agent product-designer
bin/dev-flow agent ui-quality-reviewer
bin/dev-flow refs
```

Use `bin/dev-flow` to manage project state:

```bash
bin/dev-flow init <project-name>
bin/dev-flow status <project-name>
bin/dev-flow next <project-name>
bin/dev-flow phase <project-name> <phase> [task] [--force]
bin/dev-flow verify-phase <project-name> <phase>
bin/dev-flow ship-check <project-name>
bin/dev-flow reference-check <project-name> [--required]
bin/dev-flow design-check <project-name> [--allow-no-reference]
bin/dev-flow visual-check <project-name>
bin/dev-flow check <project-name>
bin/dev-flow package-adapters [output-dir]
bin/dev-flow install <codex|claude-code|gemini|openclaw|opencode> [--scope project|user] [--dest path]
```

Start real work with `bin/dev-flow init <project-name>`. At the beginning of a
session, run `bin/dev-flow status <project-name>` and `bin/dev-flow next
<project-name>` to recover the current phase and next artifact target. After a
phase is approved, update `.dev-flow/state.env` through `bin/dev-flow phase`.
Before claiming a slice is done, run the relevant `bin/dev-flow verify-phase
<project-name> <phase>`, `bin/dev-flow check <project-name>`, and any
project-specific checks listed in `work/<project-name>/tasks/quality-gates.md`.
Before delivery, run `bin/dev-flow ship-check <project-name>`.

Important: `bin/dev-flow phase` records state only; it does not execute the
skill work. By default it verifies all prior applicable phases before moving
forward. `pm`, `agent`, `design`, and design mockups are applicability-gated by
`work/<project-name>/.dev-flow/applicability.env`; set `PM_FLOW`,
`AGENT_FLOW`, `UI_FLOW`, `UI_IMAGEGEN`, or `UI_MOCKUPS` to `required`,
`disabled`, or `auto`.
Use `--force` only when intentionally recording an early state and then complete
the missing artifacts before delivery.

For customer-facing apps, run `bin/dev-flow reference-check <project-name>
--required` before design or visual implementation. Use user-provided reference
images, screenshots, Figma exports, app names, websites, or competitor products
as concrete design inputs. If no reference is present and the user has not
explicitly delegated visual direction, ask for examples before implementation
planning. If the user delegates visual direction, create a short reference board
under `work/<project-name>/design/` first.

For customer-facing UI, use the canonical skills and personas inside
`agent-skills/`:

- `agent-skills/skills/design-flow/SKILL.md` before implementation planning
- `agent-skills/skills/frontend-ui-engineering/SKILL.md` during implementation and visual QA
- `agent-skills/agents/product-designer.md` for UX and visual-system design
- `agent-skills/agents/ui-quality-reviewer.md` for screenshot-based visual review

For every customer-facing screen, the design phase must use the installed
`imagegen` skill to produce 1-N layout and state images before implementation
planning. Save prompts and screen/state coverage in
`work/<project-name>/design/imagegen-prompts.md`, selected boards under
`work/<project-name>/design/imagegen/`, and any bitmap cut assets under
`work/<project-name>/design/cut-assets/` with an asset manifest.

Run `bin/dev-flow design-check <project-name>` before planning implementation.
Run `bin/dev-flow visual-check <project-name>` before delivery. Treat failures
as blockers unless the user explicitly narrows scope away from customer-facing UI.

## Artifacts

`work/` is runtime state. It does not need to exist in a clean checkout, and
generated project folders are ignored by git by default so personal experiments
are not published with the reusable workflow pack.

Keep every project self-contained under `work/<project-name>/`.
Project-specific source code and runtime apps belong inside that project folder, not
at the workspace root.

- Project state: `work/<project-name>/.dev-flow/state.env`
- Context loading rules: `work/<project-name>/.dev-flow/context.md`
- Apps and source roots: `work/<project-name>/apps/`, `work/<project-name>/packages/`, or another project-local directory.
- Ideas: `work/<project-name>/ideas/`
- Product artifacts: `work/<project-name>/product/`
- Agent workflow artifacts: `work/<project-name>/agent/`
- Specs: `work/<project-name>/specs/`
- Design requirements and visual artifacts: `work/<project-name>/design/`
- Reference images and screenshots: `work/<project-name>/design/references/`, `work/<project-name>/design/mocks/`, `work/<project-name>/design/screenshots/`
- Imagegen UI boards and prompt ledger: `work/<project-name>/design/imagegen/`, `work/<project-name>/design/imagegen-prompts.md`
- Cut assets, when needed: `work/<project-name>/design/cut-assets/`
- Reference software and links: `work/<project-name>/design/reference-links.md`
- Plans and task lists: `work/<project-name>/tasks/`
- Reviews: `work/<project-name>/reviews/`
- Visual QA screenshots: `work/<project-name>/reviews/visual-screenshots/`
- Launch notes and release artifacts: `work/<project-name>/ship/`

Expected phase outputs:

- Idea: `work/<project-name>/ideas/idea-brief.md`
- Product, when applicable: `work/<project-name>/product/PRD.md`, `USER_STORIES.md`, `ACCEPTANCE.md`, `METRICS.md`
- Agent, when applicable: `work/<project-name>/agent/AGENT_SPEC.md`, `WORKFLOW.md`, `TOOLS_AND_PERMISSIONS.md`, `PROMPTS_AND_SKILLS.md`, `EVALS.md`, `FAILURE_RECOVERY.md`, `OPERATIONS.md`
- Spec: `work/<project-name>/specs/SPEC.md`
- Design, when UI is applicable: `work/<project-name>/design/DESIGN.md`, `work/<project-name>/design/VISUAL_SYSTEM.md`, `work/<project-name>/design/SCREEN_ACCEPTANCE.md`, `work/<project-name>/design/imagegen-prompts.md`, `work/<project-name>/design/imagegen/*`
- Plan: `work/<project-name>/tasks/PLAN.md`
- Visual QA: `work/<project-name>/reviews/VISUAL_QA.md`
- Review: `work/<project-name>/reviews/REVIEW.md`
- Ship: `work/<project-name>/ship/LAUNCH.md`

Only require human review for requirement confirmation, customer-facing visual
direction when no reference is available, high-risk architecture decisions,
security/payment/permission/data-deletion behavior, and production launch
approval. Routine implementation, tests, and local documentation should continue
automatically when the current plan and quality gates are clear.

Do not create project-specific `./apps`, `./packages`, `./server`, `./src`, or
similar root-level directories unless the user explicitly says the code is shared
across multiple projects. When running commands, use the project-local path, for
example `cd work/<project-name>/apps/mobile`.

Do not create root-level `skills/`, `agents/`, or checked-in `dist/` directories.
Skills and personas belong under `agent-skills/`; generated adapter packages
belong in `dist/` only as temporary output from `bin/dev-flow package-adapters`
and should be regenerated rather than hand-edited.

Root-level project-scope adapter installs such as `.codex/`, `.claude/`,
`.gemini/`, `.openclaw/`, and `.opencode/` are generated output. They are
ignored by git and should be regenerated with `bin/dev-flow install` rather than
hand-edited in this repository.
