---
description: Implement the next task incrementally with tests and verification
---

Invoke the agent-skills:incremental-implementation skill alongside agent-skills:test-driven-development.

Pick the next pending task under `work/<project-name>/tasks/`:

1. Read acceptance criteria, nearby code, tests, and project conventions; state assumptions, tradeoffs, and blockers before editing.
2. For customer-facing UI, require `bin/dev-flow design-check <project-name>` and `tasks/IMPLEMENTATION_TRACE.md`; return to design/plan if the design contract is missing.
3. Write or update the smallest proof for the expected behavior before implementation.
4. Implement the smallest slice that satisfies the task, without unrelated cleanup or speculative flexibility.
5. Run relevant lint, test, typecheck, and build commands from the project-local source directory.
6. For customer-facing UI, finish the planned UI batch before visual scoring, then invoke agent-skills:frontend-ui-engineering and run `bin/dev-flow qa-check <project-name>`.
7. Update `tasks/PDCA.md` Do, task status, and verification evidence.

If the implementation stalls or fails, invoke agent-skills:debugging-and-error-recovery.
