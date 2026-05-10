---
description: Build or polish user-facing UI with visual quality gates
---

Invoke the `frontend-ui-engineering` skill.

Use this when implementing screens, components, interactions, responsive layouts, or visual polish:

1. Run or confirm `bin/dev-flow design-check <project-name>` before writing UI code.
2. Read `work/<project-name>/design/DESIGN.md`, `VISUAL_SYSTEM.md`, `SCREEN_ACCEPTANCE.md`, `imagegen-prompts.md`, and approved boards under `design/imagegen/`.
3. Inspect existing component and styling conventions.
4. Implement the UI with stable responsive layout constraints.
5. Verify core states, empty states, loading states, and error states.
6. Run functional-flow checks and record them in `work/<project-name>/reviews/FUNCTIONAL_TEST.md`.
7. Run monkey or exploratory stress checks and record them in `work/<project-name>/reviews/MONKEY_TEST.md`.
8. Compare the implemented UI against the approved imagegen boards and any cut assets in `work/<project-name>/reviews/VISUAL_COMPARISON.md` with `Overall score: N/100`.
9. Capture screenshots under `work/<project-name>/reviews/visual-screenshots/` only when an exception occurs or a flow cannot be completed.
10. Run `bin/dev-flow qa-check <project-name>` when available.

If no design contract or imagegen screen boards exist for customer-facing UI, return to the design phase first.
