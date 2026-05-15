#!/usr/bin/env bash
set -euo pipefail

CONTROL_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECT_ROOT="$(cd "$CONTROL_ROOT/.." && pwd)"

required_dirs=(state bin)
for d in "${required_dirs[@]}"; do
  [[ -d "$CONTROL_ROOT/$d" ]] || { echo "Missing directory: .dev-agent/$d" >&2; exit 1; }
done

required_files=(state/state.env state/schema.env state/applicability.env context.md HOST_REQUIREMENTS.md bin/check)
for f in "${required_files[@]}"; do
  [[ -f "$CONTROL_ROOT/$f" ]] || { echo "Missing file: .dev-agent/$f" >&2; exit 1; }
done

if [[ -d "$CONTROL_ROOT/design" ]]; then
  for f in design/DESIGN.md design/VISUAL_SYSTEM.md design/SCREEN_ACCEPTANCE.md; do
    [[ -f "$CONTROL_ROOT/$f" ]] || { echo "Missing design file: .dev-agent/$f" >&2; exit 1; }
  done
fi

echo "Default workflow gate passed for $(basename "$PROJECT_ROOT")."
