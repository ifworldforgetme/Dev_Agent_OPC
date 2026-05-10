---
description: Implement the next task incrementally with tests and verification
---

Invoke the `incremental-implementation` skill alongside `test-driven-development`.

Pick the next pending task under `work/<project-name>/tasks/`:

1. Read the task, acceptance criteria, nearby source files, and tests.
2. For customer-facing UI, confirm `bin/dev-flow design-check <project-name>` passes and read `design/imagegen/`, `design/imagegen-prompts.md`, and `design/cut-assets/` before writing UI code.
3. Write or update proof for the expected behavior.
4. Implement the smallest slice that satisfies the task.
5. Run the relevant lint, test, typecheck, and build commands from the project-local source directory.
6. For customer-facing UI, also invoke `frontend-ui-engineering`, record functional and monkey test evidence, compare against imagegen boards, and run `bin/dev-flow qa-check <project-name>` when available. Capture screenshots only for exceptions or blocked flows.
7. Update task status and verification evidence.

If the implementation stalls or fails, invoke `debugging-and-error-recovery`.
