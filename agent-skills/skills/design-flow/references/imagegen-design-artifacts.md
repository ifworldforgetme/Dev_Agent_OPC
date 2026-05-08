# Imagegen Design Artifacts

Use this reference when a design package needs visual boards generated with the installed `imagegen` skill.

## When To Use Imagegen

- App framework boards for visualizing screen hierarchy.
- Interaction flow boards mixing UI surfaces and user actions.
- Visual specification boards for icon direction, palette, typography, and component states.
- High-fidelity layout concepts for screens before implementation.

Use deterministic Markdown, Mermaid, SVG, or code-native diagrams instead when exact text, exact geometry, or version-controlled precision matters more than visual exploration.

## Prompt Pattern

```text
Use case: ui-mockup
Asset type: <framework board | interaction flow | visual spec | screen layouts>
Primary request: <what to visualize>
Style/medium: professional mobile product design board, Figma-like, practical app UI
Composition/framing: <landscape board | four phone screens | left-to-right flow>
Color palette: <project palette>
Text constraints: labels short, large, and legible; avoid dense paragraphs
Constraints: project-bound output, no irrelevant marketing or mascots
Avoid: no generic AI gradients, no unreadable tiny text, no decorative blobs, no pure stock imagery
```

## Recommended Artifact Set

1. App framework board
   - Top-level navigation, core screens, and hierarchy.

2. Interaction flow board
   - Inputs, decisions, user actions, confirmations, undo, and feedback.

3. Visual specification board
   - Icon direction, color palette, typography, cards, buttons, chips, tab bar, and state treatments.

4. Screen layout board
   - Main screens with detailed element placement.

## Validation

- The image shows the correct app domain and surfaces.
- Text is short enough to be useful even if imperfect.
- The layout can inform implementation tasks.
- The artifact is saved under `work/<project-name>/design/` when project-bound.
