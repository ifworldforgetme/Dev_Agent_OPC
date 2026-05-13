---
description: Invoke a Dev Agent specialist role/persona
---

Use this as `/dev-role <role-name> [task]`.

This is the autocomplete-friendly shortcut for `/dev agent role <role-name> [task]`.

Resolve the role from `agent-skills/dev-agent.manifest.json`, then read the persona with `bin/dev-flow agent <role-name>` when available.

Supported roles: `code-reviewer`, `product-designer`, `security-auditor`, `test-engineer`, `ui-quality-reviewer`.

Use one role for one perspective and one output. Personas do not call other personas. For release fan-out, use the `ship` flow so the main agent can merge independent role reports into a go/no-go decision.
