#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_dirs=(ideas product agent specs design design/references design/drafts design/mocks design/screenshots design/sources design/sources/imagegen design/sources/gpt-image design/sources/figma design/sources/uploads design/approved design/approved/screens design/approved/components design/cut-assets design/cut-assets/icons design/cut-assets/sprites design/cut-assets/illustrations design/cut-assets/backgrounds tasks reviews reviews/visual-screenshots ship apps packages .dev-flow)
for d in "${required_dirs[@]}"; do
  [[ -d "$ROOT/$d" ]] || { echo "Missing directory: $d" >&2; exit 1; }
done

required_files=(.dev-flow/state.env .dev-flow/schema.env .dev-flow/applicability.env .dev-flow/context.md design/reference-intake.md design/reference-links.md design/REFERENCE_BOARD.md design/DESIGN_ARTIFACTS.md design/cut-assets/ASSET_MANIFEST.md tasks/status.md tasks/quality-gates.md tasks/PDCA.md tasks/IMPLEMENTATION_TRACE.md reviews/FUNCTIONAL_TEST.md reviews/MONKEY_TEST.md reviews/VISUAL_COMPARISON.md)
for f in "${required_files[@]}"; do
  [[ -f "$ROOT/$f" ]] || { echo "Missing file: $f" >&2; exit 1; }
done

echo "Default workflow gate passed for $(basename "$ROOT")."
