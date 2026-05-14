---
description: Compatibility alias for the Dev Agent /dev agent entrypoint
---

Use this as `/dev-agent <action> ...`.

This is the compatibility alias for `/dev agent <action> ...`.

Stable ID: `dev-agent`.

Forward to the same actions as `/dev agent`:

- `flow <flow-name> [project-name]`
- `role <role-name> [task]`
- `next <project-name>`
- `check <gate-name> <project-name> [phase-or-options]`

Resolve actions, flows, roles, and gates from `dev-agent/dev-agent.manifest.json`. Prefer project-local `bin/dev-flow`; otherwise use the installed `dev-agent-runtime/bin/dev-flow`. Installed runtime commands read/write `<project-name>/` under the active workspace/current shell directory, or `DEV_FLOW_WORKSPACE_ROOT` when set.
