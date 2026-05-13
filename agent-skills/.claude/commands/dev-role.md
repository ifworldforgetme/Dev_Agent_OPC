---
description: Invoke a Dev Agent specialist role/persona
---

Use this as `/dev-role <role-name> [task]`.

Shortcut for `/dev agent role <role-name> [task]`.

Resolve the role from `agent-skills/dev-agent.manifest.json`, then read the persona with `bin/dev-flow agent <role-name>` when available.

Supported roles: `code-reviewer`, `product-designer`, `security-auditor`, `test-engineer`, `ui-quality-reviewer`.

Use one role for one perspective and one output. Personas do not call other personas; use `/dev-flow ship` for release fan-out and merge.
