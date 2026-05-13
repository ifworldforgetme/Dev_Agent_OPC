# Design Artifacts

Customer-facing UI must have approved design assets before implementation planning. The gate is provider-neutral but provenance is strict: only formal producers can qualify.

## Asset Classes

- References: external screenshots, apps, websites, Figma links, and competitor notes. Save under `design/references/`, `design/screenshots/`, or `design/reference-links.md`.
- Drafts: sketches, SVG/Mermaid/Markdown wireframes, low-fidelity prototypes, local HTML/CSS mock screenshots, and files named draft/sketch/prototype. Save under `design/drafts/` or `design/mocks/`.
- Approved assets: implementation-ready raster/PDF boards and state images from formal producers. Save under `design/approved/`.
- AI image HTML companions: when imagegen, GPT Image, or another AI image model generates an approved asset, save a semantic HTML description under `design/approved/html/` and record the mapping in `design/DESIGN_IMAGE_DESCRIPTIONS.md`.
- Figma handoff: when Figma is used to formalize imagegen/GPT Image or reference-driven direction, record file/node and export mappings in `design/FIGMA_HANDOFF.md`.
- Verification assets: browser screenshots, simulator captures, Playwright/Chrome captures, and runtime output. Save under `reviews/visual-screenshots/` only when an exception or blocked flow needs evidence.
- Delegated reference board: when the user delegates visual direction and no external reference is provided, save the generated reference direction in `design/REFERENCE_BOARD.md`.

Drafts and verification assets are forbidden as implementation targets. Use them only as inputs to create a formal approved asset.

## Coverage Contract

Derive required screens from the PRD, spec, design, and interaction model. Record each as a `##` heading in `SCREEN_ACCEPTANCE.md`, then add at least one `DESIGN_ARTIFACTS.md` Screen Coverage row for each exact heading:

| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |
|---|---|---|---|---|---|---|---|

Allowed `Source type` values and producers:

| Source type | Producer | Required Source reference |
|---|---|---|
| `imagegen` | AI image generation model raster output | `imagegen://...` |
| `gpt-image` / `gpt-image-2` | GPT Image raster output | `gpt-image://...` or `gpt-image-2://...` |
| `figma` / `figma-mcp` | Figma file/frame/component export | `figma://...` or Figma URL |
| `designer-upload` / `uploaded-approved` | Human/designer uploaded PNG/JPG/WebP/HEIC/PDF export | `upload://...`, `designer-upload://...`, or `design/sources/uploads/...` |
| `design-system` | Established design-system board export | `design-system://...`, `component-library://...`, `token://...`, or `design/sources/design-system/...` |
| `external-design` | External design tool export with source evidence | `external-design://...`, `approved://...`, or `design/sources/approved/...` |

Do not use `manual-design`, `local-approved`, SVG/HTML renders, browser captures, screenshots, canvas captures, runtime app output, or prototype exports as formal source provenance.

When `Source type` is `imagegen`, `gpt-image`, or `gpt-image-2`, `Implementation notes` must include a semantic HTML companion path such as `HTML: design/approved/html/dashboard.html`. The companion must be a real non-empty `.html` file under `design/approved/html/`, and `design/DESIGN_IMAGE_DESCRIPTIONS.md` must map the approved image to the HTML description.

## Figma Handoff Contract

Use Figma after visual exploration when it improves fidelity, component reuse,
or visual QA. Do not require a Figma library for every UI; simple one-screen
work can use imagegen/GPT Image, uploaded designer assets, or design-system exports directly.

When `Source type` is `figma` or `figma-mcp`:

- `Source reference` must be a Figma URL or `figma://...` reference with file/node context.
- `Approved asset path` must point to a real exported PNG/PDF under `design/approved/`.
- `design/FIGMA_HANDOFF.md` must map the same Figma source to the same approved export.
- Run `bin/dev-flow figma-check <project-name>` before planning or build.

## Output Rules

- Approved assets must live under `work/<project-name>/design/approved/`.
- Approved assets must be real non-empty raster image or PDF files.
- AI-generated approved images must have semantic HTML companions that describe layout hierarchy, content, components, states, colors, spacing, typography, interactions, and implementation notes.
- SVG, Mermaid, Markdown, and code-native files can be drafts or precise diagrams, but they do not satisfy the approved asset gate by themselves.
- SVG/XML sketches must not be stored under `design/approved/`. SVG files may be stored under `design/cut-assets/` only as manifested element/runtime assets, not as screen layout references.
- Browser, Playwright, Chrome, simulator, local HTML/CSS, and running-app screenshots must not be used as approved assets.
- If SVG icons, bitmap icons, illustrations, backgrounds, UI cutouts, icon matrices, spritesheets, or animation frames are needed, save them under `design/cut-assets/` and list each item in `design/cut-assets/ASSET_MANIFEST.md`.
- If no cut assets are required, record `CUT_ASSETS_REQUIRED: no` with rationale.
- `tasks/IMPLEMENTATION_TRACE.md` must map each accepted screen to implementation target, approved asset, design source reference, HTML companion when applicable, cut asset decision, test evidence, and status before UI build starts.

## Cut Asset Rules

`ASSET_MANIFEST.md` must identify the approved source asset, region or frame, output path, format, alpha behavior, runtime path, usage, and notes. Transparent PNG assets must preserve alpha. Icon matrices and spritesheets must record grid, frame size, frame order, anchor point, scale, and intended FPS or state mapping.

## Implementation Use

Use approved assets to extract layout hierarchy, responsive density, spacing, typography, colors, component states, icon style, and motion direction. Do not implement from a draft or screenshot and then treat the runtime screenshot as the design source.
