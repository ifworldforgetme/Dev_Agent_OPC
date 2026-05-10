---
description: Create reference-driven UX, interaction, visual system, and screen acceptance requirements
---

Invoke the `design-flow` skill.

Read the approved spec, inspect references under `work/<project-name>/design/`, and inspect existing screens or components if present. For customer-facing UI, run `bin/dev-flow reference-check <project-name> --required` when available. If the user explicitly delegates visual direction, run `bin/dev-flow reference-check <project-name> --delegated` instead. Then:

1. Define the UX problem and success criteria.
2. Extract concrete patterns from provided references, or ask for references if visual direction is not delegated.
3. Compare interaction approaches and choose a recommendation.
4. Define information architecture, navigation, screen hierarchy, states, and interaction model.
5. Define visual direction: icon style, palette, typography, spacing, cards, buttons, motion, and gestures.
6. Define screen acceptance criteria for key states and breakpoints.
7. Use the installed `imagegen` skill to generate 1-N high-fidelity layout and state images for every customer-facing screen before implementation planning.
8. Save imagegen prompts and screen/state coverage in `imagegen-prompts.md`, selected boards in `design/imagegen/`, and any bitmap cut assets in `design/cut-assets/`.

Save `DESIGN.md`, `VISUAL_SYSTEM.md`, `SCREEN_ACCEPTANCE.md`, and `imagegen-prompts.md` under `work/<project-name>/design/`. Run `bin/dev-flow design-check <project-name>` when available; do not move to planning or build while it fails.
