---
description: Invoke a Dev Agent OPC specialist role/persona by name without changing the lifecycle state
---

Use this as `/opc-role <role-name> [task]`.

Resolve the role from `agent-skills/dev-agent-opc.manifest.json`, then read the persona with `bin/dev-flow agent <role-name>` when available.

Supported roles: `opc-code-reviewer`, `opc-product-designer`, `opc-security-auditor`, `opc-test-engineer`, `opc-ui-quality-reviewer`.

Use one role for one perspective and one output. Personas do not call other personas. For release fan-out, use the `ship` flow so the main agent can merge independent role reports into a go/no-go decision.
