---
description: Route to a Dev Agent OPC lifecycle flow by name, then execute the existing command, skill, and gate contract
---

Use this as `/opc-flow <flow-name> [project-name]`.

Do not create a new workflow. Resolve the requested flow from `agent-skills/dev-agent-opc.manifest.json`, then read `agent-skills/commands/<flow-name>.md` with `bin/dev-flow command <flow-name>` when available.

Supported flows: `idea`, `pm`, `agent`, `spec`, `design`, `figma-design`, `figma-library`, `plan`, `build`, `test`, `review`, `ship`, `debug`, `ui`, `api`, `security`, `code-simplify`.

Runtime resolution:
1. Prefer project-local `bin/dev-flow`.
2. If unavailable, use an installed runtime at `.codex/dev-agent-opc-runtime/bin/dev-flow`, `${CODEX_HOME:-$HOME/.codex}/dev-agent-opc-runtime/bin/dev-flow`, `.claude/dev-agent-opc-runtime/bin/dev-flow`, or the host adapter's `dev-agent-opc-runtime/bin/dev-flow`.

If a project name is available, run `status` and `next` first, load only the brief's required context, execute the flow command, write outputs under `work/<project-name>/`, run the listed gate, then record the next phase with `phase` after the gate passes.
