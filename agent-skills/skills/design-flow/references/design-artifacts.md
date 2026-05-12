# Design Artifacts

Use this reference when a design package needs implementation-ready visual assets.

The screen coverage contract is explicit: derive required screens from the PRD, spec, design, and interaction model; record each as a `##` heading in `SCREEN_ACCEPTANCE.md`; then add at least one `DESIGN_ARTIFACTS.md` Screen Coverage row for each exact heading. Each row records source type, source reference, approved asset path, resolution/export detail, approved/final status, and implementation notes.

## Directory Classes

- `design/references/` and `design/screenshots/`: external reference input.
- `design/drafts/` and `design/mocks/`: sketches, wireframes, SVG/Mermaid/Markdown drafts, low-fidelity prototypes, local HTML/CSS mock screenshots.
- `design/approved/`: formal raster/PDF assets that implementation may use; SVG/XML sketches are forbidden here.
- `design/approved/html/`: semantic HTML companions for imagegen/GPT Image approved assets.
- `design/DESIGN_IMAGE_DESCRIPTIONS.md`: image-to-HTML mapping ledger for AI-generated approved assets.
- `design/REFERENCE_BOARD.md`: delegated visual direction, required when no external reference exists and the user delegates visual choices.
- `design/FIGMA_HANDOFF.md`: Figma file/node to approved export mapping when Figma formalizes a screen, component board, or design-system library.
- `reviews/visual-screenshots/`: runtime screenshot evidence only when a flow is blocked or exceptional.

Approved assets can come only from formal producers: imagegen/GPT Image raster output, Figma MCP or exported Figma frames, designer uploads, uploaded-approved files, established design-system board exports, or external design-tool exports recorded under `design/sources/approved/`. For Codex-generated customer-facing UI, produce or obtain the approved high-fidelity imagegen/GPT Image raster/PDF design before Figma formalization. Figma-backed assets are valid after they formalize an approved high-fidelity image, or when the user supplies Figma as the source design input. Drafts, SVG/XML sketches, HTML/CSS mock captures, browser screenshots, simulator screenshots, canvas captures, and runtime captures are not approved design assets. SVG may be a cut asset only when manifested as an element/runtime asset derived from an approved design, not as a screen layout reference.

When `Source type` is `imagegen`, `gpt-image`, or `gpt-image-2`, the `Implementation notes` cell must include `HTML: design/approved/html/<name>.html`, the HTML file must exist under `design/approved/html/`, and `DESIGN_IMAGE_DESCRIPTIONS.md` must map the approved image to the HTML companion.

When `Source type` is `figma` or `figma-mcp`, the source reference must be a Figma URL or `figma://...` reference, the exported PNG/PDF must live under `design/approved/`, and `design/FIGMA_HANDOFF.md` must map the same source to the same approved export. Run `bin/dev-flow figma-check <project-name>` before planning or build for Figma-backed assets.

## Validation

- Every `SCREEN_ACCEPTANCE.md` screen has at least one approved asset row.
- The approved asset path points under `design/approved/`.
- The asset is a real raster image or PDF, not a text placeholder or SVG/XML draft.
- AI-generated approved assets have HTML companions under `design/approved/html/` and coverage in `DESIGN_IMAGE_DESCRIPTIONS.md`.
- `Status` says approved or final.
- Cut assets are either listed in `design/cut-assets/ASSET_MANIFEST.md` with real files, or the manifest records `CUT_ASSETS_REQUIRED: no` with rationale.
- `tasks/IMPLEMENTATION_TRACE.md` maps every accepted screen to implementation target, approved asset, design source reference, HTML companion when applicable, cut-asset decision, test evidence, and status before build starts.
- Transparent PNGs preserve alpha; icon matrices and spritesheets record grid, frame size, frame order, anchor point, scale, and intended FPS or state mapping.
