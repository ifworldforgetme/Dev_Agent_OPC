---
description: Implement the next task incrementally — build, test, verify, commit or checkpoint
---

Invoke the agent-skills:incremental-implementation skill alongside agent-skills:test-driven-development.
For customer-facing UI tasks, also invoke agent-skills:frontend-ui-engineering and verify the design contract exists under `work/<project-name>/design/`, including `imagegen-prompts.md`, saved boards under `design/imagegen/`, and cut assets under `design/cut-assets/` when needed.

Pick the next pending task from `work/<project-name>/tasks/`. Run implementation commands from the relevant project-local app/source directory, for example `work/<project-name>/apps/mobile`. For each task:

1. Read the task's acceptance criteria
2. Load relevant context (existing code, patterns, types)
3. Write a failing test for the expected behavior (RED)
4. Implement the minimum code to pass the test (GREEN)
5. Run the full test suite to check for regressions
6. Run the build to verify compilation
7. For customer-facing UI, compare implementation against approved imagegen boards, capture/update screenshot evidence, and run `bin/dev-flow visual-check <project-name>` when available
8. Commit with a descriptive message when inside a git repo and commits are authorized; otherwise record a checkpoint in `work/<project-name>/tasks/status.md`
9. Mark the task complete and move to the next one

If any step fails, follow the agent-skills:debugging-and-error-recovery skill.
