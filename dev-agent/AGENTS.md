# Dev Agent Runtime Instructions

This directory is the canonical source for Dev Agent OPC skills, commands,
personas, references, templates, and native install metadata.

## Source Boundaries

- Canonical commands live in `commands/`.
- Host-specific command adapters live in `.claude/commands/` and `.gemini/commands/`.
- Workflow skills live in `skills/<name>/SKILL.md`.
- Specialist personas live in `agents/<role>.md`.
- Shared gates, checklists, and orchestration notes live in `references/`.
- Project scaffolding lives in `templates/project/`.
- Native user-facing entry metadata lives in `dev-agent.manifest.json` and `native/skills/dev-agent/SKILL.md`.

Treat generated installs and package output as disposable. Do not make source
changes in `.codex/`, generated `.claude/`, generated `.gemini/`, `.openclaw/`,
`.opencode/`, or `dist/`.

## Runtime Model

Dev Agent exposes one primary visible entrypoint:

```text
/dev agent
```

The stable ID is `dev-agent`; `/dev-agent` remains a compatibility alias. Keep
the public command surface centered on `/dev agent` and let users describe goals
in natural language.

## Intent Mapping

Map user intent to the smallest useful flow:

- Idea clarification: `idea-refine`
- Product scope, PRD, user stories, acceptance, or metrics: `pm-flow`
- Agent behavior, tools, approvals, memory, operations, or evals: `agent-flow`
- Requirements and technical specification: `spec-driven-development`
- Customer-facing UI, visual direction, references, or screen acceptance: `design-flow`
- Implementation planning: `planning-and-task-breakdown`
- Build slices: `incremental-implementation`
- Test strategy or verification: `test-driven-development`
- Debugging or unexpected behavior: `debugging-and-error-recovery`
- UI implementation and QA: `frontend-ui-engineering`
- Code quality review: `code-review-and-quality`
- Security-sensitive work: `security-and-hardening`
- Release readiness: `shipping-and-launch`

For APIs or public module boundaries, include `api-and-interface-design`.

## Personas, Skills, And Commands

- Skills are the workflow: they define steps and exit criteria.
- Personas are the role: they provide perspective and output shape.
- Commands are the entrypoint: they route user intent into the right skill or persona.

Personas do not invoke other personas. Use parallel fan-out only when independent
reviews can run separately and then be merged by the main agent, such as release
review across code, security, and test perspectives.

## Maintenance Rules

- Keep command wording short and install-friendly.
- Keep workflow details inside skills and references, not command files.
- Keep native entry descriptions user-facing and plain language.
- Preserve design and QA gates for customer-facing UI.
- Preserve `work/` as runtime output rather than reusable source.

After command, installer, or runtime changes, run `tests/dev-flow-smoke.sh` from
the repository root.
