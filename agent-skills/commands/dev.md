---
description: Run Dev Agent through the visible /dev agent entrypoint
---

Use this as `/dev agent <action> ...`.

Compatibility alias: `/dev-agent <action> ...`.

Stable ID: `dev-agent`.

Supported actions:

- `flow <flow-name> [project-name]`: resolve the flow from `agent-skills/dev-agent.manifest.json`, then read `agent-skills/commands/<flow-name>.md` with `bin/dev-flow command <flow-name>` when available.
- `role <role-name> [task]`: resolve the role from `agent-skills/dev-agent.manifest.json`, then read the persona with `bin/dev-flow agent <role-name>` when available.
- `next <project-name>`: run `bin/dev-flow status <project-name>` and `bin/dev-flow next <project-name>`.
- `check <gate-name> <project-name> [phase-or-options]`: resolve the gate from `agent-skills/dev-agent.manifest.json`, then run the matching `bin/dev-flow` gate.

Supported flows: `idea`, `pm`, `agent`, `spec`, `design`, `figma-design`, `figma-library`, `plan`, `build`, `test`, `review`, `ship`, `debug`, `ui`, `api`, `security`, `code-simplify`.

Supported roles: `code-reviewer`, `product-designer`, `security-auditor`, `test-engineer`, `ui-quality-reviewer`.

Runtime resolution:
1. Prefer project-local `bin/dev-flow`.
2. If unavailable, use an installed runtime at `.codex/dev-agent-runtime/bin/dev-flow`, `${CODEX_HOME:-$HOME/.codex}/dev-agent-runtime/bin/dev-flow`, `.claude/dev-agent-runtime/bin/dev-flow`, or the host adapter's `dev-agent-runtime/bin/dev-flow`.

Do not create a new workflow. Load only the required context, write outputs under `work/<project-name>/`, run the listed gate, then record the next phase with `phase` after the gate passes.
