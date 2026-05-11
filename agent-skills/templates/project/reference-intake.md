# Reference Intake: {{PROJECT}}

Use this before customer-facing UI design or visual polish.

## Reference Assets
- Put screenshots, reference images, Figma exports, mood boards, or product captures in `design/references/` or `design/screenshots/`.

## Draft Assets
- Put sketches, wireframes, SVG drafts, low-fidelity prototypes, local HTML/CSS mock screenshots, and files named draft/sketch/prototype under `design/drafts/` or `design/mocks/`.

## Approved Design Assets
- Put implementation-ready design boards and exports only under `design/approved/`.
- Recommended approved subfolders: `design/approved/screens/` and `design/approved/components/`.
- Follow the formal source contract in `agent-skills/references/design-artifacts.md`.
- Keep browser/simulator/runtime screenshots, HTML/CSS mock captures, and SVG layout sketches out of `design/approved/`.

## Figma Handoff
- After approved imagegen/GPT Image assets exist, record file/node and export mappings in `design/FIGMA_HANDOFF.md` when Figma formalizes them.
- Export approved Figma frames or component boards to `design/approved/` and record them in `DESIGN_ARTIFACTS.md` with Source type `figma` or `figma-mcp`.

## Reference Software
- Put product names, app store links, websites, Figma links, or competitor notes in `design/reference-links.md`.

## Decision
- If reference assets or software are provided, extract visual patterns before designing: layout density, navigation model, component style, spacing, typography, color, motion, and tone.
- If this is customer-facing UI and no reference is provided, ask the user for examples unless the user has explicitly delegated visual direction.
- If the user delegates visual direction, create `design/REFERENCE_BOARD.md` before implementation planning.
