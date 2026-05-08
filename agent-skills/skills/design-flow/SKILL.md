---
name: design-flow
description: Creates UX, interaction, and visual design requirements after spec and before implementation planning. Use when a product needs UI structure, platform interaction principles, HCI guardrails, visual direction, app icons, wireframes, design-system notes, or imagegen-generated design artifacts before task breakdown.
---

# Design Flow

Turn an approved spec into a practical product design package before planning implementation.

Use this after `spec-driven-development` and before `planning-and-task-breakdown` for user-facing products, mobile apps, dashboards, websites, games, or any feature where interaction quality matters.

## Output

Save design artifacts under `work/<project-name>/design/`:

- `design-requirements.md` or `<feature>-design-requirements.md`
- `imagegen-prompts.md` when raster design boards are useful
- Generated design boards, mockups, or visual references when requested

## Workflow

1. **Read context**
   - Load the project spec from `work/<project-name>/specs/`.
   - Inspect existing app screens/components when the project already has code.
   - Keep paths project-local, for example `work/<project-name>/apps/mobile`.

2. **Define UX problem**
   - State what feels unclear, slow, mechanical, risky, or visually unfinished.
   - Name the target user, primary job, and success criteria.

3. **Evaluate interaction approaches**
   - Compare 2-4 approaches with trade-offs.
   - Include one recommended direction.
   - Avoid pure novelty: every interaction must reduce cognitive load, improve trust, or speed up a real workflow.

4. **Apply platform and HCI principles**
   - For iOS and Android, account for navigation, gestures, touch targets, permissions, privacy, notifications, accessibility, and undo.
   - Load `references/platform-ux-principles.md` when platform guidance matters.

5. **Specify information architecture**
   - Define screens, hierarchy, navigation, primary actions, secondary actions, and empty/loading/error states.
   - For assistant products, separate decision logic from conversational expression. LLM-like copy may explain structured decisions, but should not become the hidden decision owner without explicit approval.

6. **Specify visual system**
   - Define icon direction, palette, typography, spacing, card/panel rules, button states, and motion/gesture principles.
   - Avoid generic AI aesthetics: purple-heavy gradients, decorative blobs, oversized hero layouts inside utility apps, and nested card stacks.

7. **Generate visual artifacts when useful**
   - Use the installed `imagegen` skill for raster UI boards, visual spec boards, icon explorations, and high-fidelity layout concepts.
   - Prefer deterministic Mermaid/SVG/Markdown for exact diagrams with important text.
   - Load `references/imagegen-design-artifacts.md` before writing imagegen prompts.
   - Save project-bound outputs under `work/<project-name>/design/`.

8. **Gate before planning**
   - Update the spec if design changes product scope.
   - Only then create implementation tasks from the design and spec.

## Design Package Template

```markdown
# [Project or Feature] Design Requirements

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

## Verification

- [ ] Design requirements are saved under `work/<project-name>/design/`
- [ ] Interaction alternatives and recommendation are explicit
- [ ] Platform and accessibility requirements are listed
- [ ] Key screens and states are defined
- [ ] Visual direction is concrete enough for implementation
- [ ] Imagegen prompts or outputs are saved when visual artifacts were requested
- [ ] Spec or task plan references the design package before build starts
