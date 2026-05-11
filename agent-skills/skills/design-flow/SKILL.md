---
name: design-flow
description: Use when a spec needs customer-facing UX, visual direction, screen acceptance, formal design assets, Figma handoff, or design gates before implementation planning.
---

# Design Flow

Turn an approved spec into a build-ready design package. Use after
`spec-driven-development` and before `planning-and-task-breakdown` for screens,
apps, websites, dashboards, games, and any user-facing workflow where visual or
interaction quality affects delivery.

## Operating Rules

- Think before committing: state assumptions, unclear points, alternatives, and
  trade-offs before choosing a direction.
- Keep it simple: produce only the artifacts needed for the current product
  scope, but do not skip required design gates.
- Modify precisely: keep artifacts project-local under `work/<project-name>/`.
- Work toward a verifiable target: every key screen must have acceptance
  criteria and an approved visual source before implementation planning.

## Outputs

Save design artifacts under `work/<project-name>/design/`:

- `DESIGN.md`
- `VISUAL_SYSTEM.md`
- `SCREEN_ACCEPTANCE.md`
- `DESIGN_ARTIFACTS.md`
- `DESIGN_IMAGE_DESCRIPTIONS.md` when AI-generated design images are used
- `FIGMA_HANDOFF.md` when Figma formalization or exports are used
- `REFERENCE_BOARD.md` when visual direction is delegated
- approved raster/PDF boards under `design/approved/`
- semantic HTML companions under `design/approved/html/`
- runtime element assets under `design/cut-assets/`
- references, drafts, and mocks under their matching non-approved folders

Use `agent-skills/templates/project/` for file templates. Use
`agent-skills/references/design-artifacts.md` and
`agent-skills/references/figma-handoff.md` for the detailed source contract.

## Workflow

1. **Read context**
   - Load the spec, project type, applicability flags, prior design artifacts,
     reference intake, and existing app screens when code already exists.
   - Keep commands and paths inside `work/<project-name>/`.

2. **Run reference intake**
   - For customer-facing UI, run
     `bin/dev-flow reference-check <project-name> --required`.
   - If references exist, extract concrete layout, navigation, component,
     typography, spacing, color, motion, density, and state patterns.
   - If no reference exists and the user has not delegated visual direction,
     ask for examples before planning implementation.
   - If the user delegates visual direction, create `REFERENCE_BOARD.md` and
     run `bin/dev-flow reference-check <project-name> --delegated`.

3. **Define the UX problem**
   - Name the target user, primary job, success criteria, constraints, and what
     currently feels unclear, slow, risky, or unfinished.

4. **Compare interaction approaches**
   - Present 2-4 plausible directions with trade-offs.
   - Recommend one direction and explain why it reduces cognitive load,
     improves trust, or speeds up a real workflow.

5. **Specify product structure**
   - Define information architecture, screen hierarchy, navigation, primary and
     secondary actions, permissions, confirmations, undo, and state model.
   - For assistant products, separate deterministic decision logic from
     conversational expression unless the user approves the LLM as decision
     owner.

6. **Specify platform and visual system**
   - Load `references/platform-ux-principles.md` when platform behavior matters.
   - Define palette, typography, spacing, icon direction, component rules,
     density, motion, accessibility, and forbidden visual patterns.
   - Avoid generic AI aesthetics: purple-heavy gradients, decorative blobs,
     nested card stacks, and oversized hero layouts in utility products.

7. **Define screen acceptance**
   - Derive canonical `SCREEN_ACCEPTANCE.md` headings from the PRD/spec and
     interaction model.
   - For each key screen, list content, states, breakpoints, actions, visual
     acceptance, accessibility acceptance, and required approved assets.
   - Include empty, loading, error, success, disabled, selected, long-content,
     and narrow-screen states when applicable.

8. **Create or collect formal design assets**
   - Every `SCREEN_ACCEPTANCE.md` screen needs 1-N high-fidelity layout/state
     assets before implementation planning.
   - Valid Source type values are `imagegen`, `gpt-image`, `gpt-image-2`,
     `figma`, `figma-mcp`, `designer-upload`, `uploaded-approved`,
     `design-system`, and `external-design`.
   - Formal producers are AI image model raster/PDF output, Figma exports,
     designer uploads, established design-system board exports, or external
     design-tool exports with source evidence.
   - `manual`, `local`, SVG/HTML renders, browser captures, canvas captures,
     simulator screenshots, Playwright screenshots, and running-app screenshots
     are not formal producers, even if saved as PNG.

9. **Use the Codex-generated UI order**
   - Canonical order: reference/spec direction -> imagegen/GPT Image
     high-fidelity raster/PDF design -> semantic HTML companion -> optional
     Figma formalization/export -> implementation.
   - Figma is downstream structure, component, and export handoff after an
     approved high-fidelity image exists. Existing user-supplied Figma files may
     be formal sources only when explicitly provided as design input.
   - Do not approve HTML/CSS mock captures or Figma frames created from those
     captures as the visual source.

10. **Record artifact coverage**
    - Load `references/design-artifacts.md` before writing
      `DESIGN_ARTIFACTS.md`.
    - Add one row for each exact `SCREEN_ACCEPTANCE.md` screen heading.
    - Record source type, source reference, approved asset path,
      resolution/export detail, approved/final status, and implementation notes.
    - Approved screen/layout assets must be real non-empty raster images or PDF
      files under `design/approved/`. SVG/XML sketches must not live there.

11. **Record AI image descriptions and Figma handoff**
    - When imagegen/GPT Image creates an approved design image, generate a
      semantic HTML companion at the same time under `design/approved/html/`.
    - Map image to HTML in `DESIGN_IMAGE_DESCRIPTIONS.md` and include
      `HTML: design/approved/html/<name>.html` in `DESIGN_ARTIFACTS.md`.
    - When Figma is used, load `references/figma-handoff.md`, update
      `FIGMA_HANDOFF.md`, use Source type `figma` or `figma-mcp`, and run
      `bin/dev-flow figma-check <project-name>` or `design-check`.

12. **Handle runtime assets**
    - SVG icons are allowed as element/runtime assets under `design/cut-assets/`
      when listed in `ASSET_MANIFEST.md`; SVG must not be used as a screen
      layout reference.
    - Cut assets must derive from approved design assets or matching approved
      asset generation, not drafts or runtime screenshots.
    - If no cut assets are needed, record `CUT_ASSETS_REQUIRED: no` with a
      rationale in `design/cut-assets/ASSET_MANIFEST.md`.
    - For mobile apps, specify and later replace framework-default app icons,
      adaptive icons, and splash icons before release packaging.

13. **Gate before planning**
    - Update the spec if design changes product scope.
    - Load `references/design-rubric.md` for design self-review when useful.
    - Run `bin/dev-flow design-check <project-name>` before implementation
      planning. Use focused `asset-check` or `figma-check` only for diagnostics.

## Verification

- Customer-facing UI has references or explicit delegated visual direction.
- `DESIGN.md`, `VISUAL_SYSTEM.md`, and `SCREEN_ACCEPTANCE.md` exist.
- `DESIGN_ARTIFACTS.md` covers every `SCREEN_ACCEPTANCE.md` screen heading.
- Approved screen/layout assets are raster/PDF files under `design/approved/`.
- Browser, local HTML/CSS, simulator, Playwright, and running-app screenshots
  are reference, draft, or QA evidence only.
- AI-generated approved images have semantic HTML companions and ledger rows.
- Figma-backed assets have `FIGMA_HANDOFF.md` coverage.
- SVG appears only as a manifested element/runtime cut asset, not as an approved
  screen/layout design.
- `ASSET_MANIFEST.md` records required cut assets or `CUT_ASSETS_REQUIRED: no`.
- Interaction alternatives, recommendation, platform rules, accessibility, key
  screens, and states are explicit.
- `bin/dev-flow design-check <project-name>` passes before planning or build.
