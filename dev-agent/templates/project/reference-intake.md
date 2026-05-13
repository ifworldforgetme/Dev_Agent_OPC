# Reference Intake: {{PROJECT}}

Use this before customer-facing UI design or visual polish.

## Reference Assets
- Put screenshots, reference images, Figma exports, mood boards, or product captures in `design/references/` or `design/screenshots/`.

## Draft Assets
- Put exploratory or low-fidelity design inputs under `design/drafts/` or `design/mocks/`.

## Approved Design Assets
- Satisfy `dev-agent/references/design-artifacts.md` and run
  `bin/dev-flow design-check {{PROJECT}}` before build.

## Figma Handoff
- When Figma is used, satisfy `dev-agent/references/figma-handoff.md` and run
  `bin/dev-flow figma-check {{PROJECT}}`.

## Reference Software
- Put product names, app store links, websites, Figma links, or competitor notes in `design/reference-links.md`.

## Decision
- If reference assets or software are provided, extract visual patterns before designing: layout density, navigation model, component style, spacing, typography, color, motion, and tone.
- If this is customer-facing UI and no reference is provided, ask the user for examples unless the user has explicitly delegated visual direction.
- If the user delegates visual direction, create `design/REFERENCE_BOARD.md` before UI build.
