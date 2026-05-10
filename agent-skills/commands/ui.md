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
6. Compare runtime screenshots against the approved imagegen boards and any cut assets.
7. Capture screenshot evidence under `work/<project-name>/reviews/visual-screenshots/`.
8. Write or update `work/<project-name>/reviews/VISUAL_QA.md`.
9. Run `bin/dev-flow visual-check <project-name>` when available.

If no design contract or imagegen screen boards exist for customer-facing UI, return to the design phase first.
