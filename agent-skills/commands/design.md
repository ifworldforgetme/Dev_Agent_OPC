---
description: Create reference-driven UX, interaction, visual system, and screen acceptance requirements
---

Invoke the `design-flow` skill.

Read the approved spec, inspect references under `work/<project-name>/design/`, and inspect existing screens or components if present. For customer-facing UI, run `bin/dev-flow reference-check <project-name> --required` when available. Then:

1. Define the UX problem and success criteria.
2. Extract concrete patterns from provided references, or ask for references if visual direction is not delegated.
3. Compare interaction approaches and choose a recommendation.
4. Define information architecture, navigation, screen hierarchy, states, and interaction model.
5. Define visual direction: icon style, palette, typography, spacing, cards, buttons, motion, and gestures.
6. Define screen acceptance criteria for key states and breakpoints.

Save `DESIGN.md`, `VISUAL_SYSTEM.md`, and `SCREEN_ACCEPTANCE.md` under `work/<project-name>/design/`. Run `bin/dev-flow design-check <project-name>` when available.
