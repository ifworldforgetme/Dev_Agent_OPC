---
description: Debug failures through reproduction, localization, fix, and regression proof
---

Invoke the `debugging-and-error-recovery` skill.

Use the prove-it loop:

1. Capture the exact failure, command, logs, inputs, and environment.
2. Reproduce the issue with the smallest reliable command or test.
3. Localize the responsible boundary before changing code.
4. Apply the smallest fix that addresses the root cause.
5. Add or update regression proof.
6. Re-run the failing proof and relevant broader checks.

Do not patch symptoms without a reproduced failure.
