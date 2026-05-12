---
description: Run a Dev Agent OPC executable gate
---

Use this as `/opc-check <gate-name> <project-name> [phase-or-options]`.

Resolve gates from `agent-skills/dev-agent-opc.manifest.json`. Common gates: `verify-phase`, `reference-check`, `asset-check`, `figma-check`, `design-check`, `qa-check`, `env-check`, `pdca-check`, `ship-check`, `doctor`, `check`.

Prefer project-local `bin/dev-flow`; otherwise use the installed `dev-agent-opc-runtime/bin/dev-flow`. Treat gate failures as blockers.
