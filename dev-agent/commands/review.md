---
description: Conduct a structured code and delivery quality review
---

Invoke the `code-review-and-quality` skill.

Review the current diff, staged changes, or recent commits across five axes:

1. Correctness: behavior matches spec, edge cases handled, tests adequate.
2. Readability: names, structure, and control flow are easy to maintain.
3. Architecture: boundaries, patterns, and abstraction levels fit the codebase.
4. Security: input, auth, secrets, permissions, and data handling are safe.
5. Performance: no obvious unbounded work, N+1 behavior, or avoidable latency.

Output findings first, ordered by severity, with file and line references when available.
