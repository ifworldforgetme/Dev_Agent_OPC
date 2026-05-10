#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RUN_ID="smoke_$$"
UI_BLOCK="$ROOT/work/__${RUN_ID}_ui_block"
DELEGATED="$ROOT/work/__${RUN_ID}_delegated"
INVALID="$ROOT/work/__${RUN_ID}_invalid"
ADAPTER_OUT="/private/tmp/dev-agent-opc-${RUN_ID}-adapters"
UI_BLOCK_OUT="/private/tmp/dev-flow-${RUN_ID}-ui-block.out"
INVALID_OUT="/private/tmp/dev-flow-${RUN_ID}-invalid.out"
EXCEPTION_OUT="/private/tmp/dev-flow-${RUN_ID}-exception.out"

cleanup() {
  rm -rf "$UI_BLOCK" "$DELEGATED" "$INVALID" "$ADAPTER_OUT" "$UI_BLOCK_OUT" "$INVALID_OUT" "$EXCEPTION_OUT"
}
trap cleanup EXIT

write_file() {
  local path="$1"
  shift
  mkdir -p "$(dirname "$path")"
  printf '%s\n' "$@" > "$path"
}

write_valid_png() {
  local path="$1"
  mkdir -p "$(dirname "$path")"
  printf 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+/p9sAAAAASUVORK5CYII=' \
    | base64 -d > "$path"
}

cd "$ROOT"

bash -n bin/dev-flow
bin/dev-flow list >/dev/null

bin/dev-flow init "$(basename "$UI_BLOCK")" >/dev/null
grep -q 'UI_FLOW="required"' "$UI_BLOCK/.dev-flow/applicability.env"
write_file "$UI_BLOCK/ideas/idea-brief.md" \
  "# Idea Brief" \
  "" \
  "Build a customer-facing dashboard app." \
  "The UI must be polished and responsive." \
  "The workflow must block planning before design exists."
write_file "$UI_BLOCK/specs/SPEC.md" \
  "# Spec" \
  "" \
  "Create a browser dashboard with navigation, cards, and empty state." \
  "Implementation will live under apps/web." \
  "The workflow should require design and imagegen boards first."
if bin/dev-flow phase "$(basename "$UI_BLOCK")" plan "Attempt planning without design" >"$UI_BLOCK_OUT" 2>&1; then
  cat "$UI_BLOCK_OUT" >&2
  echo "Expected UI project planning to fail before design." >&2
  exit 1
fi
grep -q "Phase verification failed: $(basename "$UI_BLOCK")/design" "$UI_BLOCK_OUT"

bin/dev-flow init "$(basename "$INVALID")" >/dev/null
write_file "$INVALID/ideas/idea-brief.md" \
  "# Idea Brief" "" "Build a UI." "Use delegated visual direction." "Audit invalid image artifacts."
write_file "$INVALID/specs/SPEC.md" \
  "# Spec" "" "Create a UI." "Require imagegen boards." "This is an audit fixture."
write_file "$INVALID/design/DESIGN.md" \
  "# Design" "" "## Direction" "Use a polished interface." "This file is intentionally sufficient."
write_file "$INVALID/design/VISUAL_SYSTEM.md" \
  "# Visual System" "" "## Palette" "Use neutral surfaces." "Use visible action states."
write_file "$INVALID/design/SCREEN_ACCEPTANCE.md" \
  "# Screen Acceptance" "" "## Dashboard" "- Required states: default." "- Required imagegen boards: dashboard."
write_file "$INVALID/design/imagegen-prompts.md" \
  "# Imagegen Prompts" "" "## Required Coverage" "- Dashboard board." "## Prompts" "Use case: ui-mockup"
write_file "$INVALID/design/imagegen/dashboard.png" "not a real png"
if bin/dev-flow design-check "$(basename "$INVALID")" --allow-no-reference >"$INVALID_OUT" 2>&1; then
  cat "$INVALID_OUT" >&2
  echo "Expected invalid imagegen artifact to fail." >&2
  exit 1
fi
grep -q "Invalid imagegen artifact" "$INVALID_OUT"

bin/dev-flow init "$(basename "$DELEGATED")" >/dev/null
write_file "$DELEGATED/ideas/idea-brief.md" \
  "# Idea Brief" "" "Build a habit tracker." "The user delegated visual direction." "The app needs onboarding and dashboard screens."
write_file "$DELEGATED/specs/SPEC.md" \
  "# Spec" "" "Create onboarding and dashboard screens." "Support default, empty, loading, error, and success states." "Use imagegen boards before implementation."
write_file "$DELEGATED/design/DESIGN.md" \
  "# Design" "" "## UX Problem" "Users need quick setup and trusted progress." "## Direction" "Use imagegen boards as the visual target."
write_file "$DELEGATED/design/VISUAL_SYSTEM.md" \
  "# Visual System" "" "## Palette" "Neutral surfaces and one action color." "## Components" "Cards, tabs, and buttons need states."
write_file "$DELEGATED/design/SCREEN_ACCEPTANCE.md" \
  "# Screen Acceptance" "" "## Onboarding" "- Required states: default, loading, error, success." "- Required imagegen boards: onboarding default." "" "## Dashboard" "- Required states: default, empty, loading, selected, success." "- Required imagegen boards: dashboard empty."
write_file "$DELEGATED/design/imagegen-prompts.md" \
  "# Imagegen Prompts" "" "## Required Coverage" "- Onboarding board." "- Dashboard board." "" "## Screen Coverage" "| Screen | State | Prompt summary | Saved image path | Build notes |" "|---|---|---|---|---|" "| Onboarding | Default | Habit setup | design/imagegen/onboarding-default.png | Use as visual target |" "| Dashboard | Empty | Empty dashboard | design/imagegen/dashboard-empty.png | Use as visual target |" "" "## Prompts" "Use case: ui-mockup"
write_valid_png "$DELEGATED/design/imagegen/onboarding-default.png"
write_valid_png "$DELEGATED/design/imagegen/dashboard-empty.png"
bin/dev-flow design-check "$(basename "$DELEGATED")" --allow-no-reference >/dev/null
grep -q 'UI_REFERENCES="delegated"' "$DELEGATED/.dev-flow/applicability.env"
bin/dev-flow phase "$(basename "$DELEGATED")" plan "Plan implementation after delegated design" >/dev/null

write_file "$DELEGATED/tasks/PLAN.md" \
  "# Plan" "" "## Task 1" "Build the static UI under apps/web." "Acceptance: source exists, functional QA passes, monkey QA passes, and visual comparison is scored."
write_file "$DELEGATED/apps/web/index.html" \
  "<!doctype html>" \
  "<html lang=\"en\"><head><meta charset=\"utf-8\"><title>Audit</title></head><body><main><h1>Habit Tracker</h1><button>Create habit</button></main></body></html>"
write_file "$DELEGATED/reviews/VERIFICATION.md" \
  "# Verification" "" "## Result" "The static UI source exists." "The workflow checks passed."
write_file "$DELEGATED/reviews/FUNCTIONAL_TEST.md" \
  "# Functional Test" "" "## Commands / Devices" "Static HTML source inspection." "## Flows Checked" "- Open dashboard." "- Locate primary action." "## Result" "Critical fixture flow passed."
write_file "$DELEGATED/reviews/MONKEY_TEST.md" \
  "# Monkey Test" "" "## Scope" "Static fixture exploratory checks." "## Events / Inputs" "- Repeated navigation-safe reload." "- Invalid interaction scan." "## Result" "No blocking workflow issues found."
write_file "$DELEGATED/reviews/VISUAL_COMPARISON.md" \
  "# Visual Comparison" "" "Overall score: 92/100" "" "## Compared Inputs" "- design/imagegen/onboarding-default.png" "- design/imagegen/dashboard-empty.png" "## Score Breakdown" "- Layout and hierarchy: 18/20" "- Component fidelity: 18/20" "- State coverage: 19/20" "- Responsiveness: 18/20" "- Polish: 19/20" "## Differences" "- None blocking." "## Decision" "Pass."
write_file "$DELEGATED/reviews/REVIEW.md" \
  "# Review" "" "## Correctness" "The fixture exercises the workflow checks." "## Decision" "Ready for workflow ship-check."
write_file "$DELEGATED/ship/LAUNCH.md" \
  "# Launch" "" "## Summary" "Workflow fixture reached ship-check." "## Go / No-Go" "Go for workflow validation."
bin/dev-flow phase "$(basename "$DELEGATED")" build "Implement audited UI slice" >/dev/null
bin/dev-flow verify-phase "$(basename "$DELEGATED")" build >/dev/null
bin/dev-flow verify-phase "$(basename "$DELEGATED")" test >/dev/null
bin/dev-flow qa-check "$(basename "$DELEGATED")" >/dev/null
write_file "$DELEGATED/reviews/EXCEPTION.md" \
  "# Exception" "" "## Flow" "Dashboard exception path." "## Result" "This fixture verifies that screenshots become mandatory only after an exception is recorded."
if bin/dev-flow qa-check "$(basename "$DELEGATED")" >"$EXCEPTION_OUT" 2>&1; then
  cat "$EXCEPTION_OUT" >&2
  echo "Expected exception QA to require screenshot evidence." >&2
  exit 1
fi
grep -q "Exception or blocked-flow record found" "$EXCEPTION_OUT"
write_valid_png "$DELEGATED/reviews/visual-screenshots/dashboard-exception.png"
bin/dev-flow qa-check "$(basename "$DELEGATED")" >/dev/null
bin/dev-flow ship-check "$(basename "$DELEGATED")" >/dev/null

bin/dev-flow package-adapters "$ADAPTER_OUT" >/dev/null

echo "dev-flow smoke passed"
