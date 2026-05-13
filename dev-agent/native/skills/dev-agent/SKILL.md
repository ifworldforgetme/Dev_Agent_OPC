---
name: dev-agent
description: 全流程帮你梳理想法、拆解方案、调用专业角色，并通过质量门禁推进到可落地交付。
---

# Dev Agent

Use this as the single native entry skill for Dev Agent. The detailed
workflow skills, personas, commands, references, templates, and gates live in
the installed `dev-agent-runtime/` folder.

Prefer the visible entry:

- `/dev agent flow <flow-name> [project-name]`
- `/dev agent next <project-name>`
- `/dev agent check <gate-name> <project-name> [phase-or-options]`
- `/dev agent role <role-name> [task]`

Compatibility alias:

- `/dev-agent <action> ...`

Supported flows include `idea`, `pm`, `agent`, `spec`, `design`,
`figma-design`, `figma-library`, `plan`, `build`, `test`, `review`, `ship`,
`debug`, `ui`, `api`, `security`, and `code-simplify`.

Supported roles are `code-reviewer`, `product-designer`, `security-auditor`,
`test-engineer`, and `ui-quality-reviewer`.

When command snippets are unavailable, locate the installed runtime in one of:

- `.codex/dev-agent-runtime/`
- `${CODEX_HOME:-$HOME/.codex}/dev-agent-runtime/`
- `.claude/dev-agent-runtime/`
- `$HOME/.claude/dev-agent-runtime/`

Then use `bin/dev-flow manifest`, `bin/dev-flow command <flow-name>`,
`bin/dev-flow agent <role-name>`, `bin/dev-flow status <project-name>`, and
`bin/dev-flow next <project-name>` to load the current flow instructions.

Do not copy project-specific work into the install directory. Project artifacts
belong under `work/<project-name>/` in the active workspace.
