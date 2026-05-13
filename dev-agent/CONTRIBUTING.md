# Contributing To The Dev Agent Runtime

This directory is the source for Dev Agent OPC workflows, roles, commands, and
native install metadata. Keep changes focused on making the runtime easier for
agents to invoke, verify, and ship with.

## Add Or Update A Workflow Skill

1. Create or edit `skills/<skill-name>/SKILL.md`.
2. Keep the YAML frontmatter fields `name` and `description`.
3. Make the description explicit about when the skill should be used.
4. Put long checklists, examples, or tables in `references/` and link to them.
5. Add scripts only when deterministic execution is better than instructions.

## Quality Bar

- Skills must describe actionable process, not generic advice.
- Each phase should name required outputs and exit criteria.
- UI-facing work must preserve the design, asset, and QA gates.
- Commands should route work without duplicating entire skill bodies.
- Personas should stay single-role and produce one clear report shape.

## Command And Adapter Changes

- Update `commands/` first.
- Keep `commands/dev.md` and `commands/dev-agent.md` in sync.
- Mirror behavior into `.claude/commands/` and `.gemini/commands/` when those hosts need native command files.
- Regenerate or reinstall adapters rather than editing installed output by hand.

## Before Committing

Run the smallest useful verification for the change. For command, installer, or
runtime changes, use:

```bash
tests/dev-flow-smoke.sh
bin/dev-flow list
bin/dev-flow command dev
```

For install-surface changes, also run the relevant host install command from the
repository root, for example:

```bash
bin/dev-flow install codex --scope user
```
