# PDCA Delivery Loop

Use PDCA as the cross-phase control loop for every non-trivial project. The
workflow phases still own their specialist artifacts; `tasks/PDCA.md` is the
handoff ledger that proves the cycle has closed.

## Simulated Handoff

```text
User: Build a polished habit tracker app.
Agent: init project, clarify requirements, and record the idea.

Plan:
- Spec, design, approved design assets, task plan, acceptance criteria, and quality gates are written.
- Host SDKs, CLIs, permissions, and credentials are recorded in `.dev-flow/HOST_REQUIREMENTS.md` instead of installed under `work/<project>`.
- UI work records `tasks/IMPLEMENTATION_TRACE.md` so each accepted screen maps to implementation and test evidence.
- `tasks/PDCA.md` Current Cycle records scope and checkpoint.
- `tasks/PDCA.md` Plan records objective, source artifacts, and expected evidence.

Do:
- Implementation proceeds in project-local slices under `work/<project>/apps/`.
- `tasks/PDCA.md` Do records changed areas and build artifacts after each slice.

Check:
- Verification, functional tests, monkey tests, and visual comparison run.
- `bin/dev-flow env-check <project>` confirms required host capabilities are satisfied or records blockers.
- UI delivery compares runtime UI against approved design assets and requires at least 90/100.
- `tasks/PDCA.md` Check records the evidence and blockers.

Act:
- Shipping records GO or NO-GO, what becomes standard, what iterates next, and rollback or recovery notes.
- `bin/dev-flow pdca-check <project>` and `bin/dev-flow ship-check <project>` must pass.
```

## Boundary Rules

- Phase state is not evidence. `bin/dev-flow phase` records progress only.
- Empty templates are not evidence. `pdca-check` requires concrete content in Current Cycle, Plan, Do, Check, and Act.
- Act is mandatory before delivery. A project that has built and tested still has not closed the loop until the decision and next-cycle handling are recorded.
- UI Check must link visual comparison and approved design evidence when design is applicable.
- Shared SDKs and machine-level tools belong to the host environment contract, not project runtime output.
- Blocked runtime checks must be recorded as blocker evidence, not silently skipped.
- Follow-up work belongs in Act, then becomes the Plan input for the next cycle.
