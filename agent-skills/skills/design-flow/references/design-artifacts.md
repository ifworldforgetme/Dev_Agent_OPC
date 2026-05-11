# Design Artifacts

Use this reference when a design package needs implementation-ready visual assets.

The screen coverage contract is explicit: derive required screens from the PRD, spec, design, and interaction model; record each as a `##` heading in `SCREEN_ACCEPTANCE.md`; then add at least one `DESIGN_ARTIFACTS.md` Screen Coverage row for each exact heading. Each row records source type, source reference, approved asset path, resolution/export detail, approved/final status, and implementation notes.

## Directory Classes

- `design/references/` and `design/screenshots/`: external reference input.
- `design/drafts/` and `design/mocks/`: sketches, wireframes, SVG/Mermaid/Markdown drafts, low-fidelity prototypes, local HTML/CSS mock screenshots.
- `design/approved/`: formal raster/PDF assets that implementation may use.
- `design/REFERENCE_BOARD.md`: delegated visual direction, required when no external reference exists and the user delegates visual choices.
- `reviews/visual-screenshots/`: runtime screenshot evidence only when a flow is blocked or exceptional.

Approved assets can come from imagegen, GPT Image, Figma MCP, exported Figma frames, designer uploads, manual design-system comps, or another explicitly approved source. Drafts, browser screenshots, simulator screenshots, and runtime captures are not approved assets.

## Validation

- Every `SCREEN_ACCEPTANCE.md` screen has at least one approved asset row.
- The approved asset path points under `design/approved/`.
- The asset is a real raster image or PDF, not a text placeholder or SVG-only draft.
- `Status` says approved or final.
- Cut assets are either listed in `design/cut-assets/ASSET_MANIFEST.md` with real files, or the manifest records `CUT_ASSETS_REQUIRED: no` with rationale.
- `tasks/IMPLEMENTATION_TRACE.md` maps every accepted screen to the implementation target and test evidence before build starts.
- Transparent PNGs preserve alpha; icon matrices and spritesheets record grid, frame size, frame order, anchor point, scale, and intended FPS or state mapping.
