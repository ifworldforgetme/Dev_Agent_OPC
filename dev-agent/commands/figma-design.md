---
description: Formalize approved visual direction into Figma screen frames and exported design assets
---

Use this after `design-flow` has identified screens and when Figma is useful for
fidelity, reusable layout structure, or visual QA. Satisfy
`dev-agent/references/design-artifacts.md` and
`dev-agent/references/figma-handoff.md`.

1. Read `DESIGN.md`, `VISUAL_SYSTEM.md`, `SCREEN_ACCEPTANCE.md`,
   `DESIGN_ARTIFACTS.md`, `FIGMA_HANDOFF.md`, references, and existing UI.
2. If Figma tools are available, invoke the Figma plugin skills
   `figma-use` and `figma-generate-design`. If no Figma file is connected or
   supplied, record the blocker in `design/FIGMA_HANDOFF.md` and continue with
   non-Figma approved assets instead of inventing a Figma source.
3. For each required screen/state, create or update a Figma frame using design
   system tokens/components when available.
4. Export final Figma frames and update `DESIGN_ARTIFACTS.md` plus
   `FIGMA_HANDOFF.md` according to the Figma handoff reference.
5. Run `bin/dev-flow figma-check <project-name>` and
   `bin/dev-flow design-check <project-name>`.

Do not move to build while the required check fails.
