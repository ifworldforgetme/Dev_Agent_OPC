# Imagegen Design Artifacts

Use image generation only when bitmap artifacts help the design process. Prefer Markdown, Mermaid, SVG, or code-native artifacts for exact text, diagrams, schemas, and implementation-critical layouts.

## Good Uses

- Mood boards for visual direction when the user delegates aesthetics.
- UI style boards showing density, component feel, color, texture, and icon tone.
- Product or app hero imagery when a landing page genuinely needs real visual assets.
- Icon or illustration exploration before final vector implementation.
- Reference composites that summarize visual direction from provided screenshots or products.

## Prompt Requirements

- Name the product type, target user, platform, and screen or artifact purpose.
- Include concrete reference influence: layout density, navigation style, component treatment, palette, typography, and mood.
- Specify what must not appear: generic gradients, decorative blobs, unreadable text, fake brands, or unrelated devices.
- Ask for realistic content density and visible states when the image represents a UI.

## Output Rules

- Save prompts in `work/<project-name>/design/imagegen-prompts.md`.
- Save generated images under `work/<project-name>/design/mocks/` or `work/<project-name>/design/references/`.
- Do not treat generated UI text as final copy; transcribe only design direction and rebuild exact UI in code.
