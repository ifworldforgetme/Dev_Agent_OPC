---
description: Build or update a Figma component library for a project before UI implementation
---

Use local flow: figma-library.

Use this only when reusable tokens, component variants, or a durable design
system are needed. When Figma tools are available, invoke `figma-use` and
`figma-generate-library`, run discovery before writes, create tokens before
components, validate each component, and export implementation-target boards as
PNG/PDF under `design/approved/components/`.

Record Figma source and approved export mappings in `FIGMA_HANDOFF.md` and
`DESIGN_ARTIFACTS.md`, then run `bin/dev-flow design-check <project-name>`.
Use `figma-check` or `asset-check` separately only for focused library/handoff
diagnostics or evidence.
