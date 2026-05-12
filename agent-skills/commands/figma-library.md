---
description: Build or update a Figma component library for a project before UI implementation
---

Use this only when the project needs reusable tokens, component variants, or a
durable design system. For one-off screens, prefer `figma-design`.

1. Read `work/<project-name>/design/VISUAL_SYSTEM.md`, `SCREEN_ACCEPTANCE.md`,
   `DESIGN_ARTIFACTS.md`, `DESIGN_IMAGE_DESCRIPTIONS.md` when AI-generated
   images are used, `FIGMA_HANDOFF.md`, existing code components, styling tokens,
   and any approved visual assets.
2. If Figma tools are available, invoke the Figma plugin skills
   `figma-use` and `figma-generate-library`. Follow the plugin workflow:
   discovery first, tokens before components, small sequential Figma operations,
   and validation after each component.
3. Define the library scope before creating components: token collections,
   text/effect styles, component list, variants, and what code component or
   runtime asset each Figma component maps to.
4. Export component boards or component-set snapshots as PNG/PDF under
   `design/approved/components/` when they are used as implementation targets.
5. Update `DESIGN_ARTIFACTS.md` for any component-backed screen/state assets and
   update `FIGMA_HANDOFF.md` with file/node IDs, component roles, approved
   exports, and status.
6. If component boards require SVG or bitmap runtime assets, save them under
   `design/cut-assets/` and record them in `ASSET_MANIFEST.md`.
7. Run `bin/dev-flow design-check <project-name>`. Use
   `bin/dev-flow figma-check <project-name>` or `asset-check` separately only
   when you need focused library/handoff diagnostics or evidence.

Do not create a component library solely to satisfy the design gate; the gate is
already satisfied by valid approved screen assets.
