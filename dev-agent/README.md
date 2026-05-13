# Dev Agent Runtime Source

This directory contains the source bundle used by `bin/dev-flow install` and
`bin/dev-flow package-adapters`. Treat it as the canonical workflow runtime for
Dev Agent OPC.

## Canonical Source

- `dev-agent.manifest.json` defines the native install surface.
- `native/skills/dev-agent/SKILL.md` is the top-level native skill shown to the user.
- `commands/dev.md` and `commands/dev-agent.md` define the native Dev Agent entrypoints.
- `commands/<flow>.md` defines phase-specific command prompts.
- `skills/*/SKILL.md` defines workflow skills and phase gates.
- `agents/*.md` defines specialist personas.
- `references/*.md` contains shared checklists and decision rules.
- `templates/project/*` contains generated project-state scaffolding.
- `lib/dev-flow/*` contains installer, gate, and migration helpers used by the root CLI.

## Adapter Source

Some host adapters keep command copies in host-native formats:

- `.claude/commands/`
- `.gemini/commands/`

When command behavior changes, update the canonical `commands/` files first and
then sync the adapter copies. Do not edit generated project installs such as
`.codex/`, `.claude/`, `.gemini/`, `.openclaw/`, or `.opencode/` as source of
truth.

## Runtime Boundaries

- Keep reusable workflow source under this directory.
- Keep user project output under `work/<project-name>/`.
- Keep host SDKs, credentials, simulators, and shared services outside project runtime output.
- Keep `dist/` as generated package output; regenerate it instead of hand-editing it.
- Keep project-specific apps, packages, or servers inside the relevant `work/<project-name>/` folder unless the user explicitly asks for shared repo-level code.

## Skill Maintenance

Every workflow skill should remain:

- Specific: concrete steps and expected outputs.
- Verifiable: clear exit criteria and evidence requirements.
- Minimal: reference supporting files instead of duplicating long material.
- Installable: safe to copy into native agent runtimes without hidden local paths.

Use `references/skill-anatomy.md` as a formatting reference when adding or reshaping a
skill.

## Verification

From the repository root, run:

```bash
tests/dev-flow-smoke.sh
bin/dev-flow list
bin/dev-flow command dev
bin/dev-flow install codex --scope user
```

Use host-specific install commands only when you need to validate that adapter.
