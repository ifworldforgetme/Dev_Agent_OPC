---
name: frontend-ui-engineering
description: Use when building, modifying, or reviewing user-facing UI, responsive states, accessibility, visual fidelity, functional QA, monkey testing, or product-grade frontend polish.
---

# Frontend UI Engineering

Build production-quality interfaces that match the approved design contract,
respect platform conventions, and survive functional, exploratory, and visual
QA. The output should feel intentionally designed, not template-generated.

## Before Editing

- Inspect the existing stack, component conventions, design tokens, routing,
  state management, tests, and build commands.
- State assumptions, trade-offs, conflicts with platform conventions, and any
  missing design inputs before changing UI code.
- Choose the smallest implementation that satisfies the current planned batch.
- Keep source changes inside the project-local app/package unless shared code is
  explicitly required.

## Customer-Facing UI Gate

Do not start implementation until these exist and pass for the current scope:

- `work/<project-name>/design/DESIGN.md`
- `work/<project-name>/design/VISUAL_SYSTEM.md`
- `work/<project-name>/design/SCREEN_ACCEPTANCE.md`
- `work/<project-name>/design/DESIGN_ARTIFACTS.md`
- `work/<project-name>/tasks/IMPLEMENTATION_TRACE.md`
- `bin/dev-flow design-check <project-name>`

Also read these when applicable:

- `DESIGN_IMAGE_DESCRIPTIONS.md` and `design/approved/html/` for AI-generated
  approved design images
- `FIGMA_HANDOFF.md` for Figma-backed screens, states, components, or libraries
- `design/cut-assets/ASSET_MANIFEST.md` for runtime icons, sprites, imagery,
  matrices, and animation frames

If the formal source, approved asset, resolution/export detail, status, HTML
companion, Figma handoff, or cut-asset decision cannot be confirmed, stop and
return to design instead of implementing around a guess.

## Design Source Rules

- Implement from approved raster/PDF design assets, approved Figma exports, and
  manifested runtime assets.
- Do not treat browser, Playwright, Chrome, simulator, local HTML/CSS,
  prototype, draft, SVG/XML sketch, or running-app screenshots as approved
  design sources.
- SVG is allowed under `design/cut-assets/` only as a manifested element/runtime
  asset, never as the reference for a whole screen layout.
- If a needed icon, illustration, sprite, or image is missing, return to design
  to create an approved asset or cut-asset entry.

## Implementation Workflow

1. **Create a screen checklist**
   - Map each current `SCREEN_ACCEPTANCE.md` screen/state to implementation
     files, approved asset, source reference, HTML companion when applicable,
     Figma handoff when applicable, cut assets, and test evidence.
   - Keep `tasks/IMPLEMENTATION_TRACE.md` current as work progresses.

2. **Translate design into primitives**
   - Extract layout grid, breakpoints, spacing, typography, colors, component
     variants, icon/illustration usage, motion, and state rules.
   - Preserve hierarchy first: navigation, primary action, grouping, density,
     responsive behavior, and required empty/loading/error/success states.
   - Adapt intentionally when platform conventions require it, and record the
     deviation in the trace or review artifact.

3. **Use local patterns**
   - Reuse existing components, tokens, icons, forms, data-fetching patterns,
     test helpers, and accessibility utilities.
   - Add abstraction only when it removes current duplication or matches an
     established local pattern.
   - Prefer composition and focused components over large configurable objects.

4. **Manage state simply**
   - Local state: component-only UI state.
   - Lifted state: a few sibling components.
   - URL state: filters, tabs, pagination, and shareable view state.
   - Server state: cached remote data.
   - Global store: genuinely app-wide client state.

5. **Build required states**
   - Implement default, empty, loading, error, success, disabled, selected,
     long-content, narrow-screen, and permission states when applicable.
   - Use realistic content so wrapping, truncation, overflow, and localization
     risks are visible during development.

6. **Finish the planned batch**
   - Complete the current screen set, task slice, or release-candidate scope
     recorded in `tasks/PLAN.md` or `tasks/IMPLEMENTATION_TRACE.md`.
   - Cheap local checks are fine per screen, but final visual scoring and broad
     runtime screenshot capture wait until the batch is implemented.
   - Mid-batch screenshots are only for blocked flows, exception evidence,
     regressions that need proof, or explicit user request.

## UI Standards

- Use semantic design tokens before raw colors or one-off values.
- Keep spacing, radius, shadows, and type hierarchy consistent with the project.
- Avoid generic AI aesthetics: purple-heavy gradients, decorative blobs, stock
  card grids, nested cards, excessive shadows, and oversized hero layouts in
  utility products.
- Use stable responsive constraints for boards, grids, controls, counters,
  toolbars, and repeated tiles so labels, icons, hover states, and dynamic
  content do not shift layout.
- Do not let text overlap, clip, or overflow its control at mobile or desktop
  widths.
- Prefer native controls and semantic elements; icon-only buttons need labels.
- Use project icon libraries where available; do not substitute text glyphs when
  the approved design uses illustrated icons or product imagery.

## Accessibility

Use `references/accessibility-checklist.md` for detail. Minimum bar:

- Keyboard reaches every interactive element in a logical order.
- Focus states are visible and managed through dialogs, menus, and route changes.
- Inputs have labels; icon-only controls have accessible names.
- Normal text contrast is at least 4.5:1; large text and UI indicators meet 3:1.
- State is not communicated by color alone.
- Screen reader structure follows headings, landmarks, lists, form labels, and
  status regions.
- Motion, loading, and optimistic updates have fallbacks and recovery paths.

## Runtime Asset Handling

- Use `design/cut-assets/ASSET_MANIFEST.md` as source of truth for SVG icons,
  bitmap icons, transparent PNGs, illustrations, spritesheets, matrices, and
  animation frames.
- Preserve alpha for transparent assets.
- Record grid, frame size, frame order, anchor, scale, FPS/state mapping,
  output path, runtime path, and usage for sprites or matrices.
- Do not cut assets from drafts, browser screenshots, simulator captures, or
  runtime screenshots.
- For mobile apps, replace default app icon, adaptive icon, and splash icon
  before release packaging when product assets are in scope.

## QA Gate

After implementing the current customer-facing UI batch:

1. Confirm every screen/state in the batch is implemented or marked blocked in
   `tasks/IMPLEMENTATION_TRACE.md`.
2. Run functional happy-path and recovery-path checks; save
   `reviews/FUNCTIONAL_TEST.md`.
3. Run monkey or exploratory checks across navigation, repeated actions,
   invalid inputs, resizing, and state changes; save `reviews/MONKEY_TEST.md`.
4. Compare the UI against approved design assets, HTML companions, Figma
   exports, and cut assets; save `reviews/VISUAL_COMPARISON.md`.
5. `VISUAL_COMPARISON.md` must include `Overall score: N/100`, per-screen rows
   for every `SCREEN_ACCEPTANCE.md` screen, approved asset path, runtime
   surface, score, decision, differences, and final decision.
6. High-fidelity delivery requires at least 90/100 unless the user explicitly
   narrows scope or lowers the bar.
7. Capture runtime screenshots under `reviews/visual-screenshots/` only when
   `reviews/EXCEPTION.md` or `reviews/BLOCKED_FLOW.md` records an exception or
   blocked flow, or when the user explicitly asks for screenshots.
8. Run `bin/dev-flow qa-check <project-name>` when available.

Use `references/visual-qa-rubric.md` for detailed scoring.

## Red Flags

- Implementation starts before `design-check` and `IMPLEMENTATION_TRACE.md`.
- Approved design assets are missing, invalid, or replaced by screenshots.
- AI-generated approved images lack semantic HTML companions.
- Figma-backed assets lack `FIGMA_HANDOFF.md`.
- SVG is used as a screen/layout reference instead of a manifested runtime asset.
- Required states are missing.
- Text overlaps, clips, or becomes unreadable at required breakpoints.
- Keyboard or screen-reader access is broken.
- UI ignores approved asset hierarchy, imagery, or icon direction.
- Visual comparison misses screens or scores below 90/100 for high-fidelity work.

## Verification

- `bin/dev-flow design-check <project-name>` passed before UI implementation.
- `tasks/IMPLEMENTATION_TRACE.md` maps screens to implementation targets,
  approved assets, source references, HTML companions, Figma handoff, cut-asset
  decisions, and test evidence.
- The implementation uses approved raster/PDF/Figma exports and manifested cut
  assets as visual targets.
- Required responsive states and accessibility states are implemented.
- Runtime has no known console/build errors.
- Functional, monkey, and visual comparison review files exist for
  customer-facing UI.
- Visual comparison covers every accepted screen and meets the required score.
- Screenshots exist only for recorded exceptions, blocked flows, or explicit
  user requests.
- `bin/dev-flow qa-check <project-name>` passes before delivery.
