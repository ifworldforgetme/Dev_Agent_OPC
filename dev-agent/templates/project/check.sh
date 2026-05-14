#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_dirs=(.dev-flow bin)
for d in "${required_dirs[@]}"; do
  [[ -d "$ROOT/$d" ]] || { echo "Missing directory: $d" >&2; exit 1; }
done

required_files=(.dev-flow/state.env .dev-flow/schema.env .dev-flow/applicability.env .dev-flow/context.md .dev-flow/HOST_REQUIREMENTS.md bin/check)
for f in "${required_files[@]}"; do
  [[ -f "$ROOT/$f" ]] || { echo "Missing file: $f" >&2; exit 1; }
done

if [[ -d "$ROOT/design" ]]; then
  for f in design/DESIGN.md design/VISUAL_SYSTEM.md design/SCREEN_ACCEPTANCE.md; do
    [[ -f "$ROOT/$f" ]] || { echo "Missing design file: $f" >&2; exit 1; }
  done
fi

echo "Default workflow gate passed for $(basename "$ROOT")."
