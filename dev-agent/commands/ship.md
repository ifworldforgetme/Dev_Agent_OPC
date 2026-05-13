---
description: Prepare launch evidence, go/no-go decision, and rollback plan
---

Invoke the `shipping-and-launch` skill.

Prepare release evidence under `work/<project-name>/ship/`:

1. Run `bin/dev-flow env-check <project-name>`, then final lint, test, build, smoke, and packaging checks from project-local source paths.
2. Review code quality, security, test coverage, accessibility, infrastructure, and docs.
3. For non-trivial releases, use the `code-reviewer`, `security-auditor`, and `test-engineer` personas as independent review passes, then merge their reports in the main context.
4. Write launch notes, known risks, monitoring notes, and rollback steps.
5. Update the Act section of `work/<project-name>/tasks/PDCA.md` with the decision, standardization, follow-up iteration, rollback, or recovery notes.
6. Run `bin/dev-flow pdca-check <project-name>` and `bin/dev-flow ship-check <project-name>`.
7. Produce a `GO` or `NO-GO` decision.

Do not give a `GO` decision without a rollback plan.
