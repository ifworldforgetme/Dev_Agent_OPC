---
description: Run a Dev Agent lifecycle flow by name
---

Use this as `/dev-flow <flow-name> [project-name]`.

Shortcut for `/dev agent flow <flow-name> [project-name]`.

Resolve the requested flow from `agent-skills/dev-agent.manifest.json`. Read the matching command with `bin/dev-flow command <flow-name>`, invoke its required skill, write outputs under `work/<project-name>/`, run the command's gate, and record the next phase after the gate passes.

Supported flows: `idea`, `pm`, `agent`, `spec`, `design`, `figma-design`, `figma-library`, `plan`, `build`, `test`, `review`, `ship`, `debug`, `ui`, `api`, `security`, `code-simplify`.

Prefer project-local `bin/dev-flow`; otherwise use the installed `dev-agent-runtime/bin/dev-flow`.
