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
- `imagegen-prompts.md`
- `reference-links.md` when reference software, sites, Figma links, or competitor notes exist
- Generated imagegen layout and state boards under `design/imagegen/`
- Bitmap cut assets under `design/cut-assets/` when implementation needs them

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
   - Name what later must be exercised by functional tests, monkey/exploratory testing, and visual comparison against imagegen boards. Do not require runtime screenshots unless a flow is blocked or an exception occurs.

9. **Generate imagegen UI boards before planning implementation**
   - Use the installed `imagegen` skill for every customer-facing UI screen before implementation planning.
   - If you create a deterministic SVG, Mermaid, Markdown, wireframe, or code-native layout draft first, treat it only as a structure reference. Render or screenshot that draft, use it as an explicit imagegen reference, then generate a high-fidelity raster/PDF board from it.
   - Produce 1-N high-fidelity layout and state images for each `##` screen listed in `SCREEN_ACCEPTANCE.md`.
   - Add at least one `imagegen-prompts.md` coverage row for each exact `SCREEN_ACCEPTANCE.md` screen heading, pointing to a project-local final raster/PDF board path under `design/imagegen/`.
   - Cover important states such as default, empty, loading, error, success, selected, disabled, long-content, and narrow-screen where applicable.
   - Save prompts and a screen/state coverage table in `work/<project-name>/design/imagegen-prompts.md`.
   - Save final selected imagegen outputs under `work/<project-name>/design/imagegen/`.
   - Save structure drafts under `design/imagegen/` or `design/mocks/` only as drafts; they do not satisfy the imagegen gate by themselves.
   - Imagegen outputs must be real non-empty image or PDF files; do not use placeholder text files with image extensions.
   - Final imagegen boards must include at least one raster image or PDF output such as `.png`, `.jpg`, `.webp`, `.heic`, `.gif`, or `.pdf`; SVG alone is not an acceptable final imagegen board.
   - If bitmap icons, illustrations, background images, or UI elements are needed in implementation, cut or derive them and save them under `work/<project-name>/design/cut-assets/` with `ASSET_MANIFEST.md`.
   - Prefer deterministic Mermaid/SVG/Markdown for exact diagrams with important text.
   - Load `references/imagegen-design-artifacts.md` before writing imagegen prompts.

10. **Gate before planning**
   - Update the spec if design changes product scope.
   - Load `references/design-rubric.md` before self-reviewing customer-facing UI.
   - Run `bin/dev-flow design-check <project-name>` when this workspace helper is available.
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
- Imagegen boards: [paths under design/imagegen/]
- Cut assets: [paths under design/cut-assets/, if any]
- Prompt ledger: imagegen-prompts.md

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
- Required imagegen boards: [final raster/PDF paths under design/imagegen/]
- Visual acceptance:
- Accessibility acceptance:
```

```markdown
# imagegen-prompts.md

## Required Coverage
- One row in Screen Coverage for each exact `##` screen heading in `SCREEN_ACCEPTANCE.md`.
- Each screen must point to at least one final raster/PDF imagegen board under `design/imagegen/`.

## Screen Coverage
| Screen | State | Prompt summary | Saved image path | Build notes |
|---|---|---|---|---|

## Prompts
[Record the final prompts used with the imagegen skill.]
```

## Verification

- [ ] `DESIGN.md`, `VISUAL_SYSTEM.md`, and `SCREEN_ACCEPTANCE.md` are saved under `work/<project-name>/design/`
- [ ] Customer-facing UI has reference intake or an explicit user delegation for visual direction
- [ ] `imagegen-prompts.md` maps every `SCREEN_ACCEPTANCE.md` `##` screen to 1-N generated imagegen boards
- [ ] Final selected imagegen boards are saved under `work/<project-name>/design/imagegen/` as raster images or PDFs, not only SVG drafts
- [ ] Any required bitmap cut assets are saved under `work/<project-name>/design/cut-assets/` and listed in `ASSET_MANIFEST.md`
- [ ] Interaction alternatives and recommendation are explicit
- [ ] Platform and accessibility requirements are listed
- [ ] Key screens and states are defined
- [ ] Visual direction is concrete enough for implementation
- [ ] `bin/dev-flow design-check <project-name>` passes when available
- [ ] Spec or task plan references the design package before build starts
