# Context Loading: {{PROJECT}}

Load only the files needed for the current phase.

- Idea: read `ideas/` and relevant user notes.
- Product: read `product/` only when PM_FLOW is required or product artifacts exist.
- Agent: read `agent/` only when AGENT_FLOW is required or agent artifacts exist.
- Spec: read approved idea/product/agent artifacts that apply, and existing app files if present.
- Design: read `specs/SPEC.md`, `design/reference-intake.md`, `design/DESIGN_ARTIFACTS.md`, `design/REFERENCE_BOARD.md` when delegated, user-provided references, existing screens, and platform constraints.
- Plan: read approved spec/design, `tasks/IMPLEMENTATION_TRACE.md`, and inspect likely source boundaries.
- Build: read the assigned task, approved design docs, `design/approved/` layout/state assets, cut-asset manifest, implementation trace, nearby source files, and tests.
- PDCA: keep `tasks/PDCA.md` current across Current Cycle, Plan, Do, Check, and Act so decisions and evidence survive handoffs.
- QA: read verification evidence, functional and monkey test logs, visual comparison score, and exception screenshots only when a flow is blocked.
- Ship: read review results, QA evidence, verification evidence, PDCA evidence, and launch notes.

Do not bulk-load `agent-skills/` or unrelated project folders.
