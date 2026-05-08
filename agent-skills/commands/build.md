---
description: Implement the next task incrementally with tests and verification
---

Invoke the `incremental-implementation` skill alongside `test-driven-development`.

Pick the next pending task under `work/<project-name>/tasks/`:

1. Read the task, acceptance criteria, nearby source files, and tests.
2. Write or update proof for the expected behavior.
3. Implement the smallest slice that satisfies the task.
4. Run the relevant lint, test, typecheck, and build commands from the project-local source directory.
5. For customer-facing UI, also invoke `frontend-ui-engineering`, capture screenshot evidence, and run `bin/dev-flow visual-check <project-name>` when available.
6. Update task status and verification evidence.

If the implementation stalls or fails, invoke `debugging-and-error-recovery`.
