---
description: Implement the next task incrementally with tests and verification
---

Invoke the `incremental-implementation` skill alongside `test-driven-development`.

Pick the next pending task under `work/<project-name>/tasks/`:

1. Read the task, acceptance criteria, nearby source files, and tests.
2. For customer-facing UI, confirm `bin/dev-flow asset-check <project-name>` and `bin/dev-flow design-check <project-name>` pass. Read `tasks/IMPLEMENTATION_TRACE.md`, `design/approved/`, `DESIGN_ARTIFACTS.md`, and `design/cut-assets/` before writing UI code. If the formal source, approved asset path, resolution/export detail, approved/final status, implementation trace, or cut-asset decision is missing, or the assets are browser/Playwright/simulator/runtime screenshots, prototypes, or drafts, stop and return to design/plan.
3. Write or update proof for the expected behavior.
4. Implement the smallest slice that satisfies the task.
5. Run the relevant lint, test, typecheck, and build commands from the project-local source directory.
6. For customer-facing UI, also invoke `frontend-ui-engineering`, record functional and monkey test evidence, compare against approved design assets with per-screen runtime surface, score, and decision rows, and run `bin/dev-flow qa-check <project-name>` when available. Capture screenshots only for exceptions or blocked flows.
7. Update the Do section of `work/<project-name>/tasks/PDCA.md` with implementation slices, changed areas, and build artifacts.
8. Update task status and verification evidence.

If the implementation stalls or fails, invoke `debugging-and-error-recovery`.
