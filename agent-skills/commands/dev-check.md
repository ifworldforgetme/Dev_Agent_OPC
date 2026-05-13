---
description: Run a Dev Agent executable gate for the current project
---

Use this as `/dev-check <gate-name> <project-name> [phase-or-options]`.

This is the autocomplete-friendly shortcut for `/dev agent check <gate-name> <project-name> [phase-or-options]`.

Resolve gates from `agent-skills/dev-agent.manifest.json`. Prefer project-local `bin/dev-flow`; otherwise use the installed `dev-agent-runtime/bin/dev-flow`.

Common gates: `verify-phase`, `reference-check`, `asset-check`, `figma-check`, `design-check`, `qa-check`, `env-check`, `pdca-check`, `ship-check`, `doctor`, `check`.

Treat gate failures as blockers. Fix the missing artifact or contract first, unless the user explicitly narrows scope or accepts the risk.
