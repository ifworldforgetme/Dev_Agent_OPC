# Figma Handoff: {{PROJECT}}

Use this after approved imagegen/GPT Image high-fidelity assets are formalized
into Figma screens, components, or a design-system library before implementation.

## Decision
- FIGMA_HANDOFF_REQUIRED: auto
- Flow: reference/spec direction -> imagegen/GPT Image approved raster/PDF -> semantic HTML companion -> Figma frame/component/library -> exported approved asset under `design/approved/`
- Draft warning: HTML/CSS mock captures and Figma frames created from those captures are reference drafts only, not approved design sources.
- Library required: no
- Rationale:

## Figma Sources
| Screen | Figma source | Approved export | Role | Status | Notes |
|---|---|---|---|---|---|

## Source Inputs
| Input | Source path or URL | Used for | Notes |
|---|---|---|---|

## Export Rules
- Export implementation-ready screen/state frames as PNG or PDF under `design/approved/screens/`.
- Export component boards or component-set snapshots under `design/approved/components/`.
- Record every Figma-backed approved export in `DESIGN_ARTIFACTS.md` with `Source type` set to `figma` or `figma-mcp`.
- Keep drafts, running-app screenshots, browser screenshots, simulator screenshots, local HTML/CSS mock captures, and Figma frames created from those captures out of `design/approved/`.
