---
description: Implement the next task incrementally with tests and verification
---

Invoke the agent-skills:incremental-implementation skill alongside agent-skills:test-driven-development.

Pick the next pending task under `work/<project-name>/tasks/`:

1. Read acceptance criteria, nearby code, tests, and project conventions; state assumptions, tradeoffs, and blockers before editing.
2. Check `.dev-flow/HOST_REQUIREMENTS.md` before using host SDKs/CLIs; do not install shared SDKs under `work/<project-name>/`.
3. For customer-facing UI, require `bin/dev-flow design-check <project-name>` and `tasks/IMPLEMENTATION_TRACE.md`; return to design/plan if the design contract is missing.
4. Write or update the smallest proof for the expected behavior before implementation.
5. Implement the smallest slice that satisfies the task, without unrelated cleanup or speculative flexibility.
6. Run relevant lint, test, typecheck, and build commands from the project-local source directory.
7. For customer-facing UI, finish the planned UI batch before visual scoring, then invoke agent-skills:frontend-ui-engineering and run `bin/dev-flow qa-check <project-name>`.
8. Update `tasks/PDCA.md` Do, task status, and verification evidence.

If the implementation stalls or fails, invoke agent-skills:debugging-and-error-recovery.
