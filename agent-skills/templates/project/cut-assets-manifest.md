# Cut Assets: {{PROJECT}}

List bitmap icons, illustrations, UI cutouts, icon matrices, spritesheets, or animation frames cut from approved design assets when implementation needs them.
If no bitmap cut assets are required, record `CUT_ASSETS_REQUIRED: no` with a short rationale.

## Decision
- CUT_ASSETS_REQUIRED: TBD

## Asset Manifest
| Asset | Source approved asset | Source region / frame | Output path | Format | Alpha | Runtime path | Usage | Notes |
|---|---|---|---|---|---|---|---|---|

## Sprite / Matrix Rules
- Transparent PNG assets must preserve alpha.
- Icon matrices and spritesheets must record grid, frame size, frame order, anchor point, scale, and intended FPS or state mapping.
- Do not cut assets from drafts, browser screenshots, simulator captures, or runtime screenshots.
