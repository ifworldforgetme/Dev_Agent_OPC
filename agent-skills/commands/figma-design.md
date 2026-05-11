---
description: Formalize approved visual direction into Figma screen frames and exported design assets
---

Use this after `design-flow` has identified screens and approved high-fidelity
visual direction, and before implementation planning when Figma is useful for
fidelity, reusable layout structure, or visual QA.

Precondition: for Codex-generated customer-facing UI, approved imagegen/GPT
Image raster/PDF assets must already exist. Figma formalizes that selected
image direction into frames/components/exports. Do not use local HTML/CSS mock
captures or Figma frames created from those captures as the approved visual
source. Existing user-supplied Figma files may be source design input only when
the user explicitly provides them.

1. Read `work/<project-name>/design/DESIGN.md`, `VISUAL_SYSTEM.md`,
   `SCREEN_ACCEPTANCE.md`, `DESIGN_ARTIFACTS.md`,
   `DESIGN_IMAGE_DESCRIPTIONS.md` when AI-generated images are used,
   `FIGMA_HANDOFF.md`, approved imagegen/GPT Image assets,
   references, and existing UI if present.
2. If Figma tools are available, invoke the Figma plugin skills
   `figma-use` and `figma-generate-design`. If no Figma file is connected or
   supplied, record the blocker in `design/FIGMA_HANDOFF.md` and continue with
   non-Figma approved assets instead of inventing a Figma source.
3. For each required screen/state, create or update a Figma frame using design
   system tokens/components when available. Use Figma as the formalized design
   source, not as a runtime screenshot sink.
4. Export final Figma frames as PNG or PDF under `design/approved/screens/`.
5. Update `DESIGN_ARTIFACTS.md` with `Source type` set to `figma` or
   `figma-mcp`, the Figma file/node source, approved export path, export detail,
   approved/final status, and implementation notes.
6. Update `FIGMA_HANDOFF.md` with the Figma source, approved export, role
   (`screen-frame` or `state-frame`), status, and notes.
7. Run `bin/dev-flow design-check <project-name>`. Use
   `bin/dev-flow figma-check <project-name>` or `asset-check` separately only
   when you need focused handoff diagnostics or evidence.

Do not move to planning or build while the required check fails.
