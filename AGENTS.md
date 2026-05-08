# Local Development Flow

This workspace uses `agent-skills/` as a local, non-native development workflow pack.
Do not treat it as installed Codex skills yet. Load only the relevant Markdown files
from `agent-skills/skills/`, `agent-skills/agents/`, and `agent-skills/references/`
when the current task calls for them.

## Primary Workflow

Use this lifecycle for non-trivial product or engineering work:

1. Idea: `agent-skills/skills/idea-refine/SKILL.md`
2. Spec: `agent-skills/skills/spec-driven-development/SKILL.md`
3. Design: `agent-skills/skills/design-flow/SKILL.md`
4. Plan: `agent-skills/skills/planning-and-task-breakdown/SKILL.md`
5. Build: `agent-skills/skills/incremental-implementation/SKILL.md`
6. Test: `agent-skills/skills/test-driven-development/SKILL.md`
7. Review: `agent-skills/skills/code-review-and-quality/SKILL.md`
8. Ship: `agent-skills/skills/shipping-and-launch/SKILL.md`

For debugging, load `agent-skills/skills/debugging-and-error-recovery/SKILL.md`.
For UI work, also load `agent-skills/skills/frontend-ui-engineering/SKILL.md`.
For APIs or public module boundaries, also load
`agent-skills/skills/api-and-interface-design/SKILL.md`.
For security-sensitive work, also load
`agent-skills/skills/security-and-hardening/SKILL.md`.

## Local Commands

Use `bin/dev-flow` to inspect the local workflow pack:

```bash
bin/dev-flow list
bin/dev-flow show spec
bin/dev-flow show design
bin/dev-flow command build
bin/dev-flow agent code-reviewer
bin/dev-flow refs
```

## Artifacts

Keep every project self-contained under `work/<project-name>/`.
Project-specific source code and runtime apps belong inside that project folder, not
at the workspace root.

- Apps and source roots: `work/<project-name>/apps/`, `work/<project-name>/packages/`, or another project-local directory.
- Ideas: `work/<project-name>/ideas/`
- Specs: `work/<project-name>/specs/`
- Design requirements and visual artifacts: `work/<project-name>/design/`
- Plans and task lists: `work/<project-name>/tasks/`
- Reviews: `work/<project-name>/reviews/`
- Launch notes and release artifacts: `work/<project-name>/ship/`

Do not create project-specific `./apps`, `./packages`, `./server`, `./src`, or
similar root-level directories unless the user explicitly says the code is shared
across multiple projects. When running commands, use the project-local path, for
example `cd work/<project-name>/apps/mobile`.

Do not edit files under `agent-skills/` unless the user explicitly asks to customize
the imported workflow pack. Prefer adding local adaptations in this workspace.
