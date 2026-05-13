---
description: Run a Dev Agent lifecycle flow by name
---

Use this as `/dev-flow <flow-name> [project-name]`.

This is the autocomplete-friendly shortcut for `/dev agent flow <flow-name> [project-name]`.

Resolve the flow from `agent-skills/dev-agent.manifest.json`, then read `agent-skills/commands/<flow-name>.md` with `bin/dev-flow command <flow-name>` when available.

Supported flows: `idea`, `pm`, `agent`, `spec`, `design`, `figma-design`, `figma-library`, `plan`, `build`, `test`, `review`, `ship`, `debug`, `ui`, `api`, `security`, `code-simplify`.

Prefer project-local `bin/dev-flow`; otherwise use the installed `dev-agent-runtime/bin/dev-flow`.
