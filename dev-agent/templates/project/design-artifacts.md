# Design Artifacts: {{PROJECT}}

Use formal design assets before implementation planning for every customer-facing UI screen.

## Asset Classes
- Drafts: sketches, SVG/Mermaid/Markdown wireframes, low-fidelity prototypes, local HTML/CSS mock screenshots, files named draft/sketch/prototype. Save under `design/drafts/` or `design/mocks/`. Drafts are forbidden as implementation targets.
- Approved assets: high-fidelity raster/PDF/Figma exports from formal producers only. Save under `design/approved/`.
- AI image HTML descriptions: save semantic companions under `design/approved/html/` and record them in `design/DESIGN_IMAGE_DESCRIPTIONS.md`.
- Verification assets: browser screenshots, simulator captures, Playwright/Chrome captures, and runtime app output. Save under `reviews/visual-screenshots/` only when an exception or blocked flow needs evidence.
- Figma handoff: record file/node and export mappings in `design/FIGMA_HANDOFF.md` when used.

## Required Coverage
- Derive the canonical screen list from the PRD/spec/design/interaction model and record every required screen as a `##` section in `SCREEN_ACCEPTANCE.md`.
- Produce or collect 1-N approved layout/state assets for each `SCREEN_ACCEPTANCE.md` screen.
- Add at least one Screen Coverage row for each exact `SCREEN_ACCEPTANCE.md` screen heading.
- Follow `dev-agent/references/design-artifacts.md` for allowed source types, SVG/cut-asset rules, AI-image HTML companions, and Figma handoff.
- Run `bin/dev-flow design-check {{PROJECT}}` before planning or build.

## Screen Coverage
| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |
|---|---|---|---|---|---|---|---|
