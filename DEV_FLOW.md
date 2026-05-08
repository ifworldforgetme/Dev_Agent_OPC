# Development Flow Trial

This workspace vendors Addy Osmani's `agent-skills` repository locally and uses it
as a workflow reference. It is not installed as native Codex skills yet.

## What Is Here

- `agent-skills/`: upstream workflow pack cloned from GitHub.
- `AGENTS.md`: local instruction layer telling agents how to use the pack here.
- `bin/dev-flow`: helper script for listing and opening workflow files.
- `work/`: suggested location for specs, plans, reviews, and launch artifacts.

## Daily Use

Use these prompt aliases with Codex or another coding agent:

| Intent | Say this | Loads |
|---|---|---|
| Refine a rough product idea | `Use local flow: idea` | `idea-refine` |
| Turn an idea into a buildable spec | `Use local flow: spec` | `spec-driven-development` |
| Break a spec into tasks | `Use local flow: plan` | `planning-and-task-breakdown` |
| Implement a slice | `Use local flow: build` | `incremental-implementation` + `test-driven-development` |
| Prove behavior works | `Use local flow: test` | `test-driven-development` |
| Review before merge | `Use local flow: review` | `code-review-and-quality` |
| Prepare to launch | `Use local flow: ship` | `shipping-and-launch` |

Example:

```text
Use local flow: idea
我想做一个面向酒店售后团队的 Agent 工作台，帮我把创意收敛成可开发方案。
```

Then:

```text
Use local flow: spec
基于上面的方案生成 SPEC.md，目标是后续可以直接拆任务和实现。
```

## Inspect The Pack

```bash
bin/dev-flow list
bin/dev-flow show idea
bin/dev-flow show spec
bin/dev-flow command plan
bin/dev-flow agent security-auditor
bin/dev-flow refs
```

## Artifact Locations

Use these folders while trialing the workflow:

```text
work/ideas/
work/specs/
work/tasks/
work/reviews/
work/ship/
```

The upstream repo's Claude slash commands expect names like `SPEC.md` and
`tasks/plan.md`; locally, prefer the `work/` folders above so the workflow trial
does not mix upstream files with your project files.

## When To Convert To Native Skills

Convert only after the flow proves useful in real work. Good signals:

- You repeatedly ask for the same alias, such as `idea`, `spec`, or `review`.
- The local artifact paths feel stable.
- You want Codex to auto-discover the workflows instead of manually saying
  `Use local flow: ...`.
- You want to customize trigger descriptions and shorten the upstream content.

At that point, copy or adapt selected `agent-skills/skills/*/SKILL.md` directories
into `~/.codex/skills/` or package them as a Codex plugin.
