# Design Artifacts: {{PROJECT}}

Use formal design assets before implementation planning for every customer-facing UI screen.

## Asset Classes
- Drafts: sketches, SVG/Mermaid/Markdown wireframes, low-fidelity prototypes, local HTML/CSS mock screenshots, files named draft/sketch/prototype. Save under `design/drafts/` or `design/mocks/`. Drafts are forbidden as implementation targets.
- Approved assets: high-fidelity raster/PDF design boards, Figma exports, GPT Image/Imagegen outputs, designer uploads, or other explicitly approved design sources. Save under `design/approved/`.
- Verification assets: browser screenshots, simulator captures, Playwright/Chrome captures, and runtime app output. Save under `reviews/visual-screenshots/` only when an exception or blocked flow needs evidence.

## Required Coverage
- Derive the canonical screen list from the PRD/spec/design/interaction model and record every required screen as a `##` section in `SCREEN_ACCEPTANCE.md`.
- Produce or collect 1-N approved layout/state assets for each `SCREEN_ACCEPTANCE.md` screen.
- Add at least one Screen Coverage row for each exact `SCREEN_ACCEPTANCE.md` screen heading.
- `design-check` requires a raster/PDF approved asset for every `SCREEN_ACCEPTANCE.md` screen; SVG drafts alone do not satisfy the gate.
- Browser, Playwright, Chrome, simulator, local HTML/CSS, and runtime screenshots are QA/draft artifacts only. They must not be recorded as approved design assets.
- If bitmap icons, illustrations, UI cutouts, spritesheets, or animation frames are needed, save them under `design/cut-assets/` and list them in `design/cut-assets/ASSET_MANIFEST.md`.

## Screen Coverage
| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |
|---|---|---|---|---|---|---|---|
