# Design Artifacts

Customer-facing UI must have approved design assets before implementation planning. The gate is provider-neutral: imagegen, GPT Image, Figma MCP, exported Figma frames, designer uploads, manual design-system comps, or another explicitly approved source can all qualify.

## Asset Classes

- References: external screenshots, apps, websites, Figma links, and competitor notes. Save under `design/references/`, `design/screenshots/`, or `design/reference-links.md`.
- Drafts: sketches, SVG/Mermaid/Markdown wireframes, low-fidelity prototypes, local HTML/CSS mock screenshots, and files named draft/sketch/prototype. Save under `design/drafts/` or `design/mocks/`.
- Approved assets: implementation-ready raster/PDF boards and state images. Save under `design/approved/`.
- Verification assets: browser screenshots, simulator captures, Playwright/Chrome captures, and runtime output. Save under `reviews/visual-screenshots/` only when an exception or blocked flow needs evidence.
- Delegated reference board: when the user delegates visual direction and no external reference is provided, save the generated reference direction in `design/REFERENCE_BOARD.md`.

Drafts and verification assets are forbidden as implementation targets. Use them only as inputs to create a formal approved asset.

## Coverage Contract

Derive required screens from the PRD, spec, design, and interaction model. Record each as a `##` heading in `SCREEN_ACCEPTANCE.md`, then add at least one `DESIGN_ARTIFACTS.md` Screen Coverage row for each exact heading:

| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |
|---|---|---|---|---|---|---|---|

Allowed `Source type` values include `imagegen`, `gpt-image-2`, `figma`, `figma-mcp`, `designer-upload`, `manual-design`, `design-system`, `uploaded-approved`, `other-approved`, and `local-approved`.

## Output Rules

- Approved assets must live under `work/<project-name>/design/approved/`.
- Approved assets must be real non-empty raster image or PDF files.
- SVG, Mermaid, Markdown, and code-native files can be drafts or precise diagrams, but they do not satisfy the approved asset gate by themselves.
- Browser, Playwright, Chrome, simulator, local HTML/CSS, and running-app screenshots must not be used as approved assets.
- If bitmap icons, illustrations, backgrounds, UI cutouts, icon matrices, spritesheets, or animation frames are needed, save them under `design/cut-assets/` and list each item in `design/cut-assets/ASSET_MANIFEST.md`.
- If no bitmap cut assets are required, record `CUT_ASSETS_REQUIRED: no` with rationale.
- `tasks/IMPLEMENTATION_TRACE.md` must map each accepted screen to implementation target, approved asset, cut asset decision, test evidence, and status before UI build starts.

## Cut Asset Rules

`ASSET_MANIFEST.md` must identify the approved source asset, region or frame, output path, format, alpha behavior, runtime path, usage, and notes. Transparent PNG assets must preserve alpha. Icon matrices and spritesheets must record grid, frame size, frame order, anchor point, scale, and intended FPS or state mapping.

## Implementation Use

Use approved assets to extract layout hierarchy, responsive density, spacing, typography, colors, component states, icon style, and motion direction. Do not implement from a draft or screenshot and then treat the runtime screenshot as the design source.
