# Visual QA Rubric

Use this after implementing customer-facing UI and before delivery.

## Evidence

- Capture screenshots for required breakpoints and states from `SCREEN_ACCEPTANCE.md`.
- Include mobile/narrow, tablet or medium, desktop, loading, empty, error, and long-content states when applicable.
- Save screenshots under `work/<project-name>/reviews/visual-screenshots/`.
- Save findings in `work/<project-name>/reviews/VISUAL_QA.md`.

## Review Axes

- Fidelity: implementation follows reference direction and `VISUAL_SYSTEM.md`.
- Layout: no overlap, clipping, unintended scroll traps, unstable sizing, or broken responsive behavior.
- Content: realistic copy and data fit without hiding important actions.
- Interaction: primary actions, disabled states, focus states, and error recovery are visible and usable.
- Accessibility: contrast, labels, keyboard/focus, touch targets, reduced motion, and screen reader structure are acceptable.
- Runtime: no console errors, missing assets, blank canvases, or broken network-dependent UI.

## Severity

- Blocker: prevents task completion, hides primary action, breaks mobile/desktop, overlaps text, or violates critical accessibility.
- Important: visible mismatch from design contract, missing required state, weak hierarchy, or poor density.
- Suggestion: polish that improves quality without blocking delivery.
