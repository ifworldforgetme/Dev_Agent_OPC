---
description: Build or polish user-facing UI with visual quality gates
---

Invoke the `frontend-ui-engineering` skill.

Use this when implementing screens, components, interactions, responsive layouts, or visual polish:

1. Run or confirm `bin/dev-flow asset-check <project-name>` and `bin/dev-flow design-check <project-name>` before writing UI code. If the formal source, approved asset path, resolution/export detail, approved/final status, implementation trace, or cut-asset decision is missing, or the assets are browser/Playwright/simulator/runtime screenshots, prototypes, or drafts, stop and return to design/plan.
2. Read `work/<project-name>/design/DESIGN.md`, `VISUAL_SYSTEM.md`, `SCREEN_ACCEPTANCE.md`, `DESIGN_ARTIFACTS.md`, approved assets under `design/approved/`, cut assets under `design/cut-assets/`, and `tasks/IMPLEMENTATION_TRACE.md`.
3. Inspect existing component and styling conventions.
4. Implement the UI with stable responsive layout constraints.
5. Verify core states, empty states, loading states, and error states.
6. Run functional-flow checks and record them in `work/<project-name>/reviews/FUNCTIONAL_TEST.md`.
7. Run monkey or exploratory stress checks and record them in `work/<project-name>/reviews/MONKEY_TEST.md`.
8. Compare the implemented UI against approved design assets and any cut assets in `work/<project-name>/reviews/VISUAL_COMPARISON.md` with a per-screen fidelity matrix that includes approved asset path, runtime surface, score, decision, and `Overall score: N/100`; high-fidelity delivery requires at least 90/100.
9. Capture screenshots under `work/<project-name>/reviews/visual-screenshots/` only when an exception occurs or a flow cannot be completed.
10. Run `bin/dev-flow qa-check <project-name>` when available.

If no design contract, approved screen assets, or formal design artifact contract exists for customer-facing UI, return to the design phase first.
