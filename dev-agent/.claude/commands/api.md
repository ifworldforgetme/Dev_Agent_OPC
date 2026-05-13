---
description: Design or review public APIs and module boundaries
---

Invoke the `api-and-interface-design` skill.

Use this before adding public routes, SDK surfaces, exported modules, or cross-service contracts:

1. Identify callers, lifecycle, compatibility expectations, and failure modes.
2. Define request, response, error, pagination, auth, and versioning behavior.
3. Keep contracts narrow, typed, and easy to test.
4. Add examples and verification commands.
5. Update specs, docs, and tests for the public boundary.

Do not expose a broad interface just to speed up internal implementation.
