---
description: Prepare launch evidence, go/no-go decision, and rollback plan
---

Invoke the `shipping-and-launch` skill.

Prepare release evidence under `work/<project-name>/ship/`:

1. Run final lint, test, build, smoke, and packaging checks from project-local source paths.
2. Review code quality, security, test coverage, accessibility, infrastructure, and docs.
3. For non-trivial releases, use the `code-reviewer`, `security-auditor`, and `test-engineer` personas as independent review passes, then merge their reports in the main context.
4. Write launch notes, known risks, monitoring notes, and rollback steps.
5. Produce a `GO` or `NO-GO` decision.

Do not give a `GO` decision without a rollback plan.
