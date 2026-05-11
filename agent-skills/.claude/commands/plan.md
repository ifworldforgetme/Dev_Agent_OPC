---
description: Break work into small verifiable tasks with acceptance criteria and dependency ordering
---

Invoke the agent-skills:planning-and-task-breakdown skill.

Read the existing spec under `work/<project-name>/specs/` or equivalent and the relevant codebase sections. Then:

1. Enter plan mode — read only, no code changes
2. Identify the dependency graph between components
3. Slice work vertically (one complete path per task, not horizontal layers)
4. Write tasks with acceptance criteria and verification steps
5. For UI work, write `work/<project-name>/tasks/IMPLEMENTATION_TRACE.md` mapping every accepted screen to implementation target, approved asset, cut asset decision, test evidence, and status
6. Add checkpoints between phases
7. Update `work/<project-name>/tasks/PDCA.md` Current Cycle and Plan with scope, checkpoint, objective, source artifacts, acceptance criteria, and quality gates
8. Present the plan for human review

Save the plan and task list under `work/<project-name>/tasks/`. Reference source files with project-local paths such as `work/<project-name>/apps/mobile/...`; do not create root-level `tasks/` or `apps/` for project-specific work.
