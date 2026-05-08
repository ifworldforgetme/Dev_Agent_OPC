---
description: Build or polish user-facing UI with visual quality gates
---

Invoke the `frontend-ui-engineering` skill.

Use this when implementing screens, components, interactions, responsive layouts, or visual polish:

1. Read `work/<project-name>/design/DESIGN.md`, `VISUAL_SYSTEM.md`, and `SCREEN_ACCEPTANCE.md`.
2. Inspect existing component and styling conventions.
3. Implement the UI with stable responsive layout constraints.
4. Verify core states, empty states, loading states, and error states.
5. Capture screenshot evidence under `work/<project-name>/reviews/visual-screenshots/`.
6. Write or update `work/<project-name>/reviews/VISUAL_QA.md`.
7. Run `bin/dev-flow visual-check <project-name>` when available.

If no design contract exists for customer-facing UI, return to the design phase first.
