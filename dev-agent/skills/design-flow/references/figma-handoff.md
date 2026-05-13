# Figma Handoff

Use this reference when a design package formalizes an approved high-fidelity
design image or user-supplied Figma source into Figma.

## When To Use

- For Codex-generated customer-facing UI, create or obtain approved imagegen/GPT
  Image high-fidelity raster/PDF design first, then use Figma screen frames when
  that output needs structured layout, reusable frame hierarchy, or stronger
  visual QA.
- Use a Figma library only when reusable tokens, component variants, or durable
  design-system work are needed.
- Skip Figma for simple one-off screens when a valid approved raster/PDF asset
  already gives enough implementation fidelity.
- Existing user-supplied Figma files can be source design input when the user
  explicitly provides them. HTML/CSS mock captures and Figma frames made from
  those captures are draft references only.

## Required Records

For every Figma-backed approved asset:

- `DESIGN_ARTIFACTS.md` has Source type `figma` or `figma-mcp`.
- Source reference is a Figma URL or `figma://...` reference with file/node context.
- Approved asset path points to a real PNG/PDF under `design/approved/`.
- `FIGMA_HANDOFF.md` maps the same Figma source to the same approved export.
- `bin/dev-flow figma-check <project-name>` passes before planning or build.

Do not use runtime screenshots, browser captures, simulator captures, SVG/XML
drafts, HTML/CSS mock captures, or prototype screenshots as approved Figma
exports.
