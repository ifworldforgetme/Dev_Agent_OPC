---
description: Simplify code without changing behavior
---

Invoke the `code-simplification` skill.

Simplify the requested scope or recent changes:

1. Understand behavior, callers, edge cases, and existing tests before editing.
2. Look for deep nesting, long functions, unclear names, duplicated logic, and dead code.
3. Change one small area at a time.
4. Run relevant tests after each meaningful simplification.
5. Stop if behavior changes or evidence becomes unclear.

Use the QA quality checklist or `code-reviewer` persona to review the final diff when risk warrants it.
