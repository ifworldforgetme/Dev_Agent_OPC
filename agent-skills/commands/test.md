---
description: Run the test-driven development or prove-it debugging workflow
---

Invoke the `test-driven-development` skill.

For new behavior:

1. Write a failing test or equivalent executable proof.
2. Implement until the proof passes.
3. Refactor while keeping the proof green.
4. Run the broader regression suite that matches the risk.

For bugs:

1. Reproduce the bug with a failing test or script.
2. Confirm the failure.
3. Fix the bug.
4. Confirm the proof passes.
5. Run regression checks.

For browser-visible behavior, also invoke `browser-testing-with-devtools` or an available browser automation workflow.

After tests run, update the Check section of `work/<project-name>/tasks/PDCA.md`
with verification, functional, monkey, visual comparison, and blocker evidence
as applicable.
