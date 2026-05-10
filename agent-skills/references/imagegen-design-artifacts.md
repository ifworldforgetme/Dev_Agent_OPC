# Imagegen Design Artifacts

For customer-facing UI, image generation is a mandatory design gate before
implementation planning. Every screen needs 1-N generated layout/state boards so
the implementation has a concrete visual target, not only prose requirements.

Prefer Markdown, Mermaid, SVG, or code-native artifacts for exact text,
diagrams, schemas, and implementation-critical logic. Use imagegen for visual
composition, polish, icon tone, state treatment, and high-fidelity UI direction.

## Good Uses

- High-fidelity layout boards for each key app screen.
- State boards for empty, loading, error, success, selected, disabled,
  long-content, and narrow-screen variants when applicable.
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
- For each prompt, name the target screen, state, viewport, and the exact design
  question the image should answer.

## Output Rules

- Save prompts in `work/<project-name>/design/imagegen-prompts.md`.
- Save final selected imagegen UI boards under `work/<project-name>/design/imagegen/`.
- Save generated reference boards under `work/<project-name>/design/references/` only when they summarize visual direction rather than define a screen.
- Save optional design mockups from other tools under `work/<project-name>/design/mocks/`.
- If implementation needs bitmap icons, illustrations, backgrounds, or UI element cutouts, save them under `work/<project-name>/design/cut-assets/` and list each asset in `design/cut-assets/ASSET_MANIFEST.md`.
- Saved boards must be real non-empty image or PDF files. Placeholder text files with `.png`, `.jpg`, or `.pdf` extensions do not satisfy `design-check`.
- Do not treat generated UI text as final copy; transcribe only design direction and rebuild exact UI in code.

## Minimum Coverage

- One generated board for every required screen before implementation planning.
- Additional boards for materially different states or breakpoints.
- A coverage table in `imagegen-prompts.md` mapping screen -> state -> prompt -> saved image path -> build notes.
- `bin/dev-flow design-check <project-name>` must pass before planning or build starts.
