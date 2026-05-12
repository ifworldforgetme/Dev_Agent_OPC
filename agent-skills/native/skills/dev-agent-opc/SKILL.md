---
name: dev-agent-opc
description: Use to run the Dev Agent OPC native workflow through /opc-flow, /opc-next, /opc-check, or /opc-role without exposing each internal workflow skill as a separate top-level skill.
---

# Dev Agent OPC

Use this as the single native entry skill for Dev Agent OPC. The detailed
workflow skills, personas, commands, references, templates, and gates live in
the installed `dev-agent-opc-runtime/` folder.

Prefer the namespaced commands:

- `/opc-flow <flow-name> [project-name]`
- `/opc-next <project-name>`
- `/opc-check <gate-name> <project-name> [phase-or-options]`
- `/opc-role <role-name> [task]`

Supported flows include `idea`, `pm`, `agent`, `spec`, `design`,
`figma-design`, `figma-library`, `plan`, `build`, `test`, `review`, `ship`,
`debug`, `ui`, `api`, `security`, and `code-simplify`.

Supported roles are `opc-code-reviewer`, `opc-product-designer`,
`opc-security-auditor`, `opc-test-engineer`, and `opc-ui-quality-reviewer`.

When command snippets are unavailable, locate the installed runtime in one of:

- `.codex/dev-agent-opc-runtime/`
- `${CODEX_HOME:-$HOME/.codex}/dev-agent-opc-runtime/`
- `.claude/dev-agent-opc-runtime/`
- `$HOME/.claude/dev-agent-opc-runtime/`

Then use `bin/dev-flow manifest`, `bin/dev-flow command <flow-name>`,
`bin/dev-flow agent <role-name>`, `bin/dev-flow status <project-name>`, and
`bin/dev-flow next <project-name>` to load the current flow instructions.

Do not copy project-specific work into the install directory. Project artifacts
belong under `work/<project-name>/` in the active workspace.
