---
description: Run a Dev Agent OPC executable gate for the current project
---

Use this as `/opc-check <gate-name> <project-name> [phase-or-options]`.

Resolve gates from `agent-skills/dev-agent-opc.manifest.json`. Prefer project-local `bin/dev-flow`; otherwise use the installed `dev-agent-opc-runtime/bin/dev-flow`.

Common gates: `verify-phase`, `reference-check`, `asset-check`, `figma-check`, `design-check`, `qa-check`, `env-check`, `pdca-check`, `ship-check`, `doctor`, `check`.

Treat gate failures as blockers. Fix the missing artifact or contract first, unless the user explicitly narrows scope or accepts the risk.
