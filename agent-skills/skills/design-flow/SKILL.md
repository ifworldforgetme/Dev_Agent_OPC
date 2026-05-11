---
name: design-flow
description: Creates UX, interaction, reference-driven visual design, and screen acceptance requirements after spec and before implementation planning. Use when building customer-facing apps, websites, dashboards, mobile experiences, or any UI where references, aesthetics, fidelity, accessibility, or design-system clarity affect delivery quality.
---

# Design Flow

Turn an approved spec into a practical product design package before planning implementation.

Use this after `spec-driven-development` and before `planning-and-task-breakdown` for user-facing products, mobile apps, dashboards, websites, games, or any feature where interaction quality matters.

## Output

Save design artifacts under `work/<project-name>/design/`:

- `DESIGN.md`
- `VISUAL_SYSTEM.md`
- `SCREEN_ACCEPTANCE.md`
- `DESIGN_ARTIFACTS.md`
- `reference-links.md` when reference software, sites, Figma links, or competitor notes exist
- Drafts under `design/drafts/` or `design/mocks/` when used
- Approved implementation-ready design assets under `design/approved/`
- Bitmap cut assets, transparent PNGs, icon matrices, spritesheets, or animation frames under `design/cut-assets/` when implementation needs them

## Workflow

1. **Read context**
   - Load the project spec from `work/<project-name>/specs/`.
   - Read `work/<project-name>/design/reference-intake.md` and `reference-links.md` when present.
   - Inspect reference assets under `design/references/`, `design/mocks/`, and `design/screenshots/`.
   - Inspect existing app screens/components when the project already has code.
   - Keep paths project-local, for example `work/<project-name>/apps/mobile`.

2. **Run reference intake for customer-facing UI**
   - Run `bin/dev-flow reference-check <project-name> --required` when the UI is customer-facing.
   - If references exist, extract concrete patterns: layout density, navigation model, component style, spacing, typography, color, motion, tone, and state handling.
   - If no reference exists and the user has not delegated visual direction, ask for examples before implementation planning.
   - If the user delegates visual direction, create a short reference board under `work/<project-name>/design/` first and run `bin/dev-flow reference-check <project-name> --delegated`.

3. **Define UX problem**
   - State what feels unclear, slow, mechanical, risky, or visually unfinished.
   - Name the target user, primary job, and success criteria.

4. **Evaluate interaction approaches**
   - Compare 2-4 approaches with trade-offs.
   - Include one recommended direction.
   - Avoid pure novelty: every interaction must reduce cognitive load, improve trust, or speed up a real workflow.

5. **Apply platform and HCI principles**
   - For iOS and Android, account for navigation, gestures, touch targets, permissions, privacy, notifications, accessibility, and undo.
   - Load `references/platform-ux-principles.md` when platform guidance matters.

6. **Specify information architecture**
   - Define screens, hierarchy, navigation, primary actions, secondary actions, and empty/loading/error states.
   - For assistant products, separate decision logic from conversational expression. LLM-like copy may explain structured decisions, but should not become the hidden decision owner without explicit approval.

7. **Specify visual system**
   - Define icon direction, palette, typography, spacing, card/panel rules, button states, and motion/gesture principles.
   - Avoid generic AI aesthetics: purple-heavy gradients, decorative blobs, oversized hero layouts inside utility apps, and nested card stacks.

8. **Define screen acceptance**
   - Derive the canonical key-screen list from the PRD, spec, interaction model, and platform scope.
   - For each key screen, create one `## [Screen Name]` section and list required states, breakpoints, primary actions, and visual acceptance criteria.
   - Include at least empty, loading, error, success, disabled, selected, long-content, and narrow-screen states when applicable.
   - Name what later must be exercised by functional tests, monkey/exploratory testing, and visual comparison against approved design assets. Do not require runtime screenshots unless a flow is blocked or an exception occurs.

9. **Approve formal design assets before planning implementation**
   - Produce or collect 1-N high-fidelity layout and state assets for each `##` screen listed in `SCREEN_ACCEPTANCE.md`.
   - Valid sources include imagegen/GPT Image, Figma MCP or exported Figma frames, designer uploads, manual design-system comps, or another source explicitly marked approved.
   - If you create a deterministic SVG, Mermaid, Markdown, wireframe, or code-native layout draft first, treat it only as a structure reference. Save it under `design/drafts/` or `design/mocks/`, then produce or obtain a formal raster/PDF design asset under `design/approved/`.
   - Add at least one `DESIGN_ARTIFACTS.md` coverage row for each exact `SCREEN_ACCEPTANCE.md` screen heading, recording source type, source reference, approved asset path, resolution/export detail, approved/final status, and implementation notes.
   - Cover important states such as default, empty, loading, error, success, selected, disabled, long-content, and narrow-screen where applicable.
   - Save approved design assets under `work/<project-name>/design/approved/`.
   - Browser, Playwright, Chrome, simulator, local HTML/CSS, or running-app screenshots are QA artifacts or drafts only. They do not satisfy the approved design asset gate and must not be placed in `design/approved/`.
   - Approved design assets must be real non-empty raster image or PDF files such as `.png`, `.jpg`, `.webp`, `.heic`, `.gif`, or `.pdf`; SVG alone is not an acceptable approved design asset.
   - If bitmap icons, illustrations, background images, UI cutouts, icon matrices, spritesheets, or animation frames are needed in implementation, cut or derive them from approved design assets and save them under `work/<project-name>/design/cut-assets/` with `ASSET_MANIFEST.md`. If none are needed, record `CUT_ASSETS_REQUIRED: no` with a short rationale so the gate is explicit.
   - If the user delegates visual direction because no external references are provided, create `work/<project-name>/design/REFERENCE_BOARD.md` before approving the design.
   - For mobile apps, include App icon, adaptive icon, and splash icon direction before build. If the app uses Expo/React Native, the implementation must replace default `apps/mobile/assets/icon.png`, `adaptive-icon.png`, and `splash-icon.png` before release packaging.
   - Treat approved design assets as implementation source-of-truth, not mood boards. When a screen relies on illustrated icons, pet characters, visual motifs, or animation frames from an approved asset, derive reusable app assets from it or generate a matching asset set, then list both `design/cut-assets/` and app runtime asset paths in `ASSET_MANIFEST.md`.
   - Prefer deterministic Mermaid/SVG/Markdown for exact diagrams with important text.
   - Load `references/design-artifacts.md` before writing design artifact coverage.

10. **Gate before planning**
   - Update the spec if design changes product scope.
   - Load `references/design-rubric.md` before self-reviewing customer-facing UI.
   - Run `bin/dev-flow asset-check <project-name>` and `bin/dev-flow design-check <project-name>` when this workspace helper is available.
   - Only then create implementation tasks from the design and spec.

## Design Package Template

```markdown
# DESIGN.md

## UX Problem
[What needs to improve and for whom.]

## Recommended Direction
[Chosen interaction model and why.]

## Alternatives Considered
- [Option]: [trade-off]

## Platform Principles
- iOS: [...]
- Android: [...]

## Information Architecture
[Screens, hierarchy, navigation, state model.]

## Interaction Model
[Gestures, visible controls, confirmations, undo, accessibility.]

## Visual System
[Icon, palette, typography, spacing, cards, buttons, motion.]

## Design Artifacts
- Approved design assets: [paths under design/approved/]
- Drafts/prototypes: [paths under design/drafts/ or design/mocks/, if any]
- Cut assets: [paths under design/cut-assets/, if any]
- Delegated reference board: [design/REFERENCE_BOARD.md, when applicable]
- Artifact ledger: DESIGN_ARTIFACTS.md

## Build Implications
[What implementation tasks should account for.]
```

```markdown
# VISUAL_SYSTEM.md

## Reference Influence
[References used and the concrete UI patterns extracted from them.]

## Palette
[Semantic colors and forbidden color patterns.]

## Typography
[Type scale, density, truncation, and real-content rules.]

## Spacing and Layout
[Spacing scale, grid/container rules, density, card/panel rules.]

## Components and Motion
[Buttons, inputs, icons, menus, tabs, states, transitions.]

## Forbidden Patterns
[Generic AI aesthetic and project-specific visual traps.]
```

```markdown
# SCREEN_ACCEPTANCE.md

## [Screen Name]
- Required content:
- Required states:
- Breakpoints:
- Required design assets: [approved raster/PDF paths under design/approved/]
- Visual acceptance:
- Accessibility acceptance:
```

```markdown
# DESIGN_ARTIFACTS.md

## Required Coverage
- One row in Screen Coverage for each exact `##` screen heading in `SCREEN_ACCEPTANCE.md`.
- Each screen must point to at least one approved raster/PDF design asset under `design/approved/`.
- Each row must include source type, source reference, approved asset path, resolution/export detail, approved/final status, and implementation notes.
- Browser/Playwright/Chrome/simulator/local screenshots, drafts, prototypes, and runtime captures are QA or draft artifacts, not approved design assets.

## Screen Coverage
| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |
|---|---|---|---|---|---|---|---|
```

```markdown
# cut-assets/ASSET_MANIFEST.md

## Decision
- CUT_ASSETS_REQUIRED: yes|no
- Rationale:

## Asset Manifest
| Asset | Source approved asset | Source region / frame | Output path | Format | Alpha | Runtime path | Usage | Notes |
|---|---|---|---|---|---|---|---|---|

## Sprite / Matrix Rules
- Transparent PNG assets must preserve alpha.
- Icon matrices and spritesheets must record grid, frame size, frame order, anchor point, scale, and intended FPS or state mapping.
- Do not cut assets from drafts, browser screenshots, simulator captures, or runtime screenshots.
```

## Verification

- [ ] `DESIGN.md`, `VISUAL_SYSTEM.md`, and `SCREEN_ACCEPTANCE.md` are saved under `work/<project-name>/design/`
- [ ] Customer-facing UI has reference intake or an explicit user delegation for visual direction
- [ ] `DESIGN_ARTIFACTS.md` maps every `SCREEN_ACCEPTANCE.md` `##` screen to 1-N approved design assets
- [ ] `DESIGN_ARTIFACTS.md` records source type, source reference, approved asset path, resolution/export detail, approved/final status, and implementation notes
- [ ] Approved design assets are saved under `work/<project-name>/design/approved/` as raster images or PDFs, not SVG-only drafts
- [ ] Browser/Playwright/Chrome/simulator/local screenshots are stored as references, drafts, or QA evidence only; they are not used as approved design assets
- [ ] Delegated visual direction has `work/<project-name>/design/REFERENCE_BOARD.md`
- [ ] Any required bitmap cut assets, transparent PNGs, icon matrices, spritesheets, or animation frames are saved under `work/<project-name>/design/cut-assets/` and listed in `ASSET_MANIFEST.md`, or `ASSET_MANIFEST.md` explicitly records `CUT_ASSETS_REQUIRED: no`
- [ ] Mobile app icon, adaptive icon, and splash icon are custom product assets rather than framework placeholders
- [ ] Implementation tasks explicitly consume approved design assets or derived cut assets; do not approve code that only loosely imitates the board with text placeholders
- [ ] Interaction alternatives and recommendation are explicit
- [ ] Platform and accessibility requirements are listed
- [ ] Key screens and states are defined
- [ ] Visual direction is concrete enough for implementation
- [ ] `bin/dev-flow asset-check <project-name>` and `bin/dev-flow design-check <project-name>` pass when available
- [ ] Spec or task plan references the design package before build starts
