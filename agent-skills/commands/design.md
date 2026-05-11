---
description: Create reference-driven UX, interaction, visual system, and screen acceptance requirements
---

Invoke the `design-flow` skill.

Read the approved spec, inspect references under `work/<project-name>/design/`, and inspect existing screens or components if present. For customer-facing UI, run `bin/dev-flow reference-check <project-name> --required` when available. If the user explicitly delegates visual direction, run `bin/dev-flow reference-check <project-name> --delegated` instead. Then:

1. Define the UX problem and success criteria.
2. Extract concrete patterns from provided references, or ask for references if visual direction is not delegated. If visual direction is delegated, create `design/REFERENCE_BOARD.md` before approving the design.
3. Compare interaction approaches and choose a recommendation.
4. Define information architecture, navigation, screen hierarchy, states, and interaction model.
5. Define visual direction: icon style, palette, typography, spacing, cards, buttons, motion, and gestures.
6. Derive the required screen list from the PRD, spec, design, and interaction model, then define each as a `##` section in `SCREEN_ACCEPTANCE.md` with key states and breakpoints.
7. If helpful, create deterministic SVG/Mermaid/Markdown layout drafts for structure, then save them under `design/drafts/` or `design/mocks/`; drafts are not implementation targets.
8. Produce or collect 1-N high-fidelity approved raster/PDF layout and state assets for every `SCREEN_ACCEPTANCE.md` screen before implementation planning. Valid sources include imagegen/GPT Image, Figma MCP or Figma exports, designer uploads, manual design-system comps, or another explicitly approved source.
9. Save screen/state coverage in `DESIGN_ARTIFACTS.md`, with at least one row for each exact `SCREEN_ACCEPTANCE.md` screen heading. Each row must record source type, source reference, approved asset path under `design/approved/`, resolution/export detail, approved/final status, and implementation notes.
10. Save approved assets in `design/approved/`, and any bitmap cut assets, transparent PNGs, icon matrices, spritesheets, or animation frames in `design/cut-assets/`. If no bitmap cut assets are needed, record `CUT_ASSETS_REQUIRED: no` in `design/cut-assets/ASSET_MANIFEST.md`. Do not treat SVG drafts, Chrome/Playwright screenshots, simulator screenshots, local browser screenshots, HTML/CSS mock screenshots, or runtime captures as approved design assets.

Save `DESIGN.md`, `VISUAL_SYSTEM.md`, `SCREEN_ACCEPTANCE.md`, and `DESIGN_ARTIFACTS.md` under `work/<project-name>/design/`. Run `bin/dev-flow asset-check <project-name>` and `bin/dev-flow design-check <project-name>` when available; do not move to planning or build while either fails.
