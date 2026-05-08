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
- `reference-links.md` when reference software, sites, Figma links, or competitor notes exist
- `imagegen-prompts.md` when raster design boards are useful
- Generated design boards, mockups, or visual references when requested

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
   - If the user delegates visual direction, create a short reference board under `work/<project-name>/design/` first.

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
   - For each key screen, list required states, breakpoints, primary actions, and visual acceptance criteria.
   - Include at least empty, loading, error, success, disabled, selected, long-content, and narrow-screen states when applicable.
   - Name what later needs screenshot evidence under `work/<project-name>/reviews/visual-screenshots/`.

9. **Generate visual artifacts when useful**
   - Use the installed `imagegen` skill for raster UI boards, visual spec boards, icon explorations, and high-fidelity layout concepts.
   - Prefer deterministic Mermaid/SVG/Markdown for exact diagrams with important text.
   - Load `references/imagegen-design-artifacts.md` before writing imagegen prompts.
   - Save project-bound outputs under `work/<project-name>/design/`.

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
- [Artifact path or prompt file]

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
- Visual acceptance:
- Accessibility acceptance:
```

## Verification

- [ ] `DESIGN.md`, `VISUAL_SYSTEM.md`, and `SCREEN_ACCEPTANCE.md` are saved under `work/<project-name>/design/`
- [ ] Customer-facing UI has reference intake or an explicit user delegation for visual direction
- [ ] Interaction alternatives and recommendation are explicit
- [ ] Platform and accessibility requirements are listed
- [ ] Key screens and states are defined
- [ ] Visual direction is concrete enough for implementation
- [ ] Imagegen prompts or outputs are saved when visual artifacts were requested
- [ ] `bin/dev-flow design-check <project-name>` passes when available
- [ ] Spec or task plan references the design package before build starts
