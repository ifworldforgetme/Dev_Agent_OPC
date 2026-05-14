---
description: Write PRD and buildable SPEC before design or build
---

Invoke the `spec-driven-development` skill. Product and agent-contract thinking
belong inside this flow; do not create separate PM or agent phases.

Read the approved idea artifacts and create the lean product/technical source of
truth:

1. Define the objective, target users, and user-visible outcomes.
2. Write or update `<project-name>/product/PRD.md` with MVP scope, core stories, acceptance criteria, metrics only when useful, and explicit non-goals.
3. Write `<project-name>/specs/SPEC.md` with stack constraints, host needs, source boundaries, commands, code style, test strategy, risks, and success criteria.
4. When agent automation is in scope, add `## Agent Runtime Contract` covering job, tools/permissions, approval points, prompts/skills/context, memory/checkpoints, evals, operations, and failure recovery/escalation.
5. For customer-facing UI, identify whether design references exist, whether visual direction is delegated, and what design decisions must be resolved before build.
6. If requirements are unclear or high-risk, raise the blocker to idea/spec or the user instead of guessing.

Confirm with the user before proceeding unless the user has explicitly delegated defaults.
