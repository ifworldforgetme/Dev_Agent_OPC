#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RUN_ID="smoke_$$"
UI_BLOCK="$ROOT/work/__${RUN_ID}_ui_block"
DELEGATED="$ROOT/work/__${RUN_ID}_delegated"
INVALID="$ROOT/work/__${RUN_ID}_invalid"
SVG_ONLY="$ROOT/work/__${RUN_ID}_svg_only"
MISSING_COVERAGE="$ROOT/work/__${RUN_ID}_missing_coverage"
ADAPTER_OUT="/private/tmp/dev-agent-opc-${RUN_ID}-adapters"
UI_BLOCK_OUT="/private/tmp/dev-flow-${RUN_ID}-ui-block.out"
INVALID_OUT="/private/tmp/dev-flow-${RUN_ID}-invalid.out"
EXCEPTION_OUT="/private/tmp/dev-flow-${RUN_ID}-exception.out"
SVG_ONLY_OUT="/private/tmp/dev-flow-${RUN_ID}-svg-only.out"
MISSING_COVERAGE_OUT="/private/tmp/dev-flow-${RUN_ID}-missing-coverage.out"
PDCA_OUT="/private/tmp/dev-flow-${RUN_ID}-pdca.out"

cleanup() {
  rm -rf "$UI_BLOCK" "$DELEGATED" "$INVALID" "$SVG_ONLY" "$MISSING_COVERAGE" "$ADAPTER_OUT" "$UI_BLOCK_OUT" "$INVALID_OUT" "$EXCEPTION_OUT" "$SVG_ONLY_OUT" "$MISSING_COVERAGE_OUT" "$PDCA_OUT"
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

write_valid_svg() {
  local path="$1"
  mkdir -p "$(dirname "$path")"
  printf '%s\n' '<svg xmlns="http://www.w3.org/2000/svg" width="10" height="10"><rect width="10" height="10" fill="black"/></svg>' > "$path"
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
  "# Design" "" "## UX Problem" "Users need a polished interface." "## Recommended Direction" "Use a focused dashboard." "## Alternatives Considered" "- Basic page: too weak." "## Information Architecture" "Dashboard only." "## Interaction Model" "Primary action only." "## Visual System" "Neutral product surface." "## Design Artifacts" "Imagegen board required." "## Build Implications" "Build from the board."
write_file "$INVALID/design/VISUAL_SYSTEM.md" \
  "# Visual System" "" "## Reference Influence" "Delegated visual direction." "## Palette" "Use neutral surfaces." "## Typography" "Readable product scale." "## Spacing and Layout" "Dense but clear." "## Components and Motion" "Buttons have visible states." "## Forbidden Patterns" "No generic AI gradients."
write_file "$INVALID/design/SCREEN_ACCEPTANCE.md" \
  "# Screen Acceptance" "" "## Dashboard" "- Required content: dashboard body." "- Required states: default." "- Breakpoints: 320, 768, 1440." "- Required imagegen boards: design/imagegen/dashboard.png." "- Visual acceptance: follows the board." "- Accessibility acceptance: primary action reachable."
write_file "$INVALID/design/imagegen-prompts.md" \
  "# Imagegen Prompts" "" "## Required Coverage" "- Dashboard board." "## Screen Coverage" "| Screen | State | Prompt summary | Saved image path | Build notes |" "|---|---|---|---|---|" "| Dashboard | Default | Dashboard | design/imagegen/dashboard.png | Use as visual target |" "" "## Prompts" "Use case: ui-mockup"
write_file "$INVALID/design/imagegen/dashboard.png" "not a real png"
if bin/dev-flow design-check "$(basename "$INVALID")" --allow-no-reference >"$INVALID_OUT" 2>&1; then
  cat "$INVALID_OUT" >&2
  echo "Expected invalid imagegen artifact to fail." >&2
  exit 1
fi
grep -q "Invalid imagegen artifact" "$INVALID_OUT"

bin/dev-flow init "$(basename "$SVG_ONLY")" >/dev/null
write_file "$SVG_ONLY/ideas/idea-brief.md" \
  "# Idea Brief" "" "Build a UI." "Use delegated visual direction." "Audit SVG-only imagegen artifacts."
write_file "$SVG_ONLY/specs/SPEC.md" \
  "# Spec" "" "Create a UI." "Require final raster boards." "This is an audit fixture."
write_file "$SVG_ONLY/design/DESIGN.md" \
  "# Design" "" "## UX Problem" "Users need a polished interface." "## Recommended Direction" "Use a focused dashboard." "## Alternatives Considered" "- SVG-only draft: lacks final visual fidelity." "## Information Architecture" "Dashboard only." "## Interaction Model" "Primary action only." "## Visual System" "Neutral product surface." "## Design Artifacts" "Imagegen board required." "## Build Implications" "Build from the final board."
write_file "$SVG_ONLY/design/VISUAL_SYSTEM.md" \
  "# Visual System" "" "## Reference Influence" "Delegated visual direction." "## Palette" "Use neutral surfaces." "## Typography" "Readable product scale." "## Spacing and Layout" "Dense but clear." "## Components and Motion" "Buttons have visible states." "## Forbidden Patterns" "No generic AI gradients."
write_file "$SVG_ONLY/design/SCREEN_ACCEPTANCE.md" \
  "# Screen Acceptance" "" "## Dashboard" "- Required content: dashboard body." "- Required states: default." "- Breakpoints: 320, 768, 1440." "- Required imagegen boards: design/imagegen/dashboard.svg." "- Visual acceptance: follows the final board." "- Accessibility acceptance: primary action reachable."
write_file "$SVG_ONLY/design/imagegen-prompts.md" \
  "# Imagegen Prompts" "" "## Required Coverage" "- Dashboard board." "## Screen Coverage" "| Screen | State | Prompt summary | Saved image path | Build notes |" "|---|---|---|---|---|" "| Dashboard | Default | Dashboard | design/imagegen/dashboard.svg | Structure draft only |" "" "## Prompts" "Use case: svg draft"
write_valid_svg "$SVG_ONLY/design/imagegen/dashboard.svg"
if bin/dev-flow design-check "$(basename "$SVG_ONLY")" --allow-no-reference >"$SVG_ONLY_OUT" 2>&1; then
  cat "$SVG_ONLY_OUT" >&2
  echo "Expected SVG-only imagegen artifact to fail." >&2
  exit 1
fi
grep -q "Missing final imagegen" "$SVG_ONLY_OUT"

bin/dev-flow init "$(basename "$MISSING_COVERAGE")" >/dev/null
write_file "$MISSING_COVERAGE/ideas/idea-brief.md" \
  "# Idea Brief" "" "Build a UI." "Use delegated visual direction." "Audit missing screen coverage."
write_file "$MISSING_COVERAGE/specs/SPEC.md" \
  "# Spec" "" "Create dashboard and settings screens." "Require final boards per screen." "This is an audit fixture."
write_file "$MISSING_COVERAGE/design/DESIGN.md" \
  "# Design" "" "## UX Problem" "Users need two polished screens." "## Recommended Direction" "Use a dashboard and settings structure." "## Alternatives Considered" "- Single screen: incomplete." "## Information Architecture" "Dashboard and settings." "## Interaction Model" "Navigate between screens." "## Visual System" "Neutral product surface." "## Design Artifacts" "Imagegen boards required." "## Build Implications" "Build both screens from boards."
write_file "$MISSING_COVERAGE/design/VISUAL_SYSTEM.md" \
  "# Visual System" "" "## Reference Influence" "Delegated visual direction." "## Palette" "Use neutral surfaces." "## Typography" "Readable product scale." "## Spacing and Layout" "Dense but clear." "## Components and Motion" "Buttons have visible states." "## Forbidden Patterns" "No generic AI gradients."
write_file "$MISSING_COVERAGE/design/SCREEN_ACCEPTANCE.md" \
  "# Screen Acceptance" "" "## Dashboard" "- Required content: dashboard body." "- Required states: default." "- Breakpoints: 320, 768, 1440." "- Required imagegen boards: design/imagegen/dashboard.png." "- Visual acceptance: follows the board." "- Accessibility acceptance: primary action reachable." "" "## Settings" "- Required content: settings controls." "- Required states: default." "- Breakpoints: 320, 768, 1440." "- Required imagegen boards: design/imagegen/settings.png." "- Visual acceptance: follows the board." "- Accessibility acceptance: controls reachable."
write_file "$MISSING_COVERAGE/design/imagegen-prompts.md" \
  "# Imagegen Prompts" "" "## Required Coverage" "- Dashboard board only." "## Screen Coverage" "| Screen | State | Prompt summary | Saved image path | Build notes |" "|---|---|---|---|---|" "| Dashboard | Default | Dashboard | design/imagegen/dashboard.png | Use as visual target |" "" "## Prompts" "Use case: ui-mockup"
write_valid_png "$MISSING_COVERAGE/design/imagegen/dashboard.png"
if bin/dev-flow design-check "$(basename "$MISSING_COVERAGE")" --allow-no-reference >"$MISSING_COVERAGE_OUT" 2>&1; then
  cat "$MISSING_COVERAGE_OUT" >&2
  echo "Expected missing screen coverage to fail." >&2
  exit 1
fi
grep -q "Missing final imagegen board for screen: Settings" "$MISSING_COVERAGE_OUT"

bin/dev-flow init "$(basename "$DELEGATED")" >/dev/null
write_file "$DELEGATED/ideas/idea-brief.md" \
  "# Idea Brief" "" "Build a habit tracker." "The user delegated visual direction." "The app needs onboarding and dashboard screens."
write_file "$DELEGATED/specs/SPEC.md" \
  "# Spec" "" "Create onboarding and dashboard screens." "Support default, empty, loading, error, and success states." "Use imagegen boards before implementation."
write_file "$DELEGATED/design/DESIGN.md" \
  "# Design" "" "## UX Problem" "Users need quick setup and trusted progress." "## Recommended Direction" "Use imagegen boards as the visual target." "## Alternatives Considered" "- Text-only UI: too weak." "## Information Architecture" "Onboarding and dashboard." "## Interaction Model" "Primary setup flow and dashboard review." "## Visual System" "Neutral surfaces with one action color." "## Design Artifacts" "- design/imagegen/onboarding-default.png" "- design/imagegen/dashboard-empty.png" "## Build Implications" "Use SCREEN_ACCEPTANCE.md and imagegen boards during implementation."
write_file "$DELEGATED/design/VISUAL_SYSTEM.md" \
  "# Visual System" "" "## Reference Influence" "Delegated visual direction from product goals." "## Palette" "Neutral surfaces and one action color." "## Typography" "Readable product scale." "## Spacing and Layout" "Cards and sections use stable spacing." "## Components and Motion" "Cards, tabs, and buttons need states." "## Forbidden Patterns" "No generic AI gradients or nested card stacks."
write_file "$DELEGATED/design/SCREEN_ACCEPTANCE.md" \
  "# Screen Acceptance" "" "## Onboarding" "- Required content: setup title, habit input, primary action." "- Required states: default, loading, error, success." "- Breakpoints: 320, 768, 1440." "- Required imagegen boards: design/imagegen/onboarding-default.png." "- Visual acceptance: follows the onboarding board hierarchy." "- Accessibility acceptance: primary action keyboard reachable." "" "## Dashboard" "- Required content: habit cards, progress summary, primary action." "- Required states: default, empty, loading, selected, success." "- Breakpoints: 320, 768, 1440." "- Required imagegen boards: design/imagegen/dashboard-empty.png." "- Visual acceptance: follows the dashboard board hierarchy." "- Accessibility acceptance: cards and actions keyboard reachable."
write_file "$DELEGATED/design/imagegen-prompts.md" \
  "# Imagegen Prompts" "" "## Required Coverage" "- Onboarding board." "- Dashboard board." "" "## Screen Coverage" "| Screen | State | Prompt summary | Saved image path | Build notes |" "|---|---|---|---|---|" "| Onboarding | Default | Habit setup | design/imagegen/onboarding-default.png | Use as visual target |" "| Dashboard | Empty | Empty dashboard | design/imagegen/dashboard-empty.png | Use as visual target |" "" "## Prompts" "Use case: ui-mockup"
write_valid_png "$DELEGATED/design/imagegen/onboarding-default.png"
write_valid_png "$DELEGATED/design/imagegen/dashboard-empty.png"
bin/dev-flow design-check "$(basename "$DELEGATED")" --allow-no-reference >/dev/null
grep -q 'UI_REFERENCES="delegated"' "$DELEGATED/.dev-flow/applicability.env"
bin/dev-flow phase "$(basename "$DELEGATED")" plan "Plan implementation after delegated design" >/dev/null

write_file "$DELEGATED/tasks/PLAN.md" \
  "# Plan" "" "## Design Handoff" "Implement from DESIGN.md, VISUAL_SYSTEM.md, SCREEN_ACCEPTANCE.md, and imagegen boards under design/imagegen/." "" "## Task 1" "Build the static UI under apps/web." "Acceptance: source exists, functional QA passes, monkey QA passes, and VISUAL_COMPARISON.md scores the implemented screens."
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
  "# Visual Comparison" "" "Overall score: 89/100" "" "## Compared Inputs" "- design/imagegen/onboarding-default.png" "- design/imagegen/dashboard-empty.png" "## Screen Fidelity Matrix" "| Screen | Approved board path | Runtime surface | Fidelity score | Notes |" "|---|---|---|---|---|" "| Onboarding | design/imagegen/onboarding-default.png | apps/web/index.html | 45/50 | Good |" "| Dashboard | design/imagegen/dashboard-empty.png | apps/web/index.html | 44/50 | Good |" "## Score Breakdown" "- Layout and hierarchy: 18/20" "- Component fidelity: 18/20" "- State coverage: 17/20" "- Responsiveness: 18/20" "- Polish: 18/20" "## Differences" "- Minor but below high-fidelity bar." "## Decision" "Fail until score reaches 90/100."
write_file "$DELEGATED/reviews/REVIEW.md" \
  "# Review" "" "## Correctness" "The fixture exercises the workflow checks." "## Decision" "Ready for workflow ship-check."
write_file "$DELEGATED/ship/LAUNCH.md" \
  "# Launch" "" "## Summary" "Workflow fixture reached ship-check." "## Go / No-Go" "Go for workflow validation."
bin/dev-flow phase "$(basename "$DELEGATED")" build "Implement audited UI slice" >/dev/null
bin/dev-flow verify-phase "$(basename "$DELEGATED")" build >/dev/null
bin/dev-flow verify-phase "$(basename "$DELEGATED")" test >/dev/null
if bin/dev-flow qa-check "$(basename "$DELEGATED")" >/dev/null 2>&1; then
  echo "Expected visual score below 90 to fail." >&2
  exit 1
fi
write_file "$DELEGATED/reviews/VISUAL_COMPARISON.md" \
  "# Visual Comparison" "" "Overall score: 92/100" "" "## Compared Inputs" "- design/imagegen/onboarding-default.png" "- design/imagegen/dashboard-empty.png" "## Screen Fidelity Matrix" "| Screen | Approved board path | Runtime surface | Fidelity score | Notes |" "|---|---|---|---|---|" "| Onboarding | design/imagegen/onboarding-default.png | apps/web/index.html | 46/50 | Good |" "| Dashboard | design/imagegen/dashboard-empty.png | apps/web/index.html | 46/50 | Good |" "## Score Breakdown" "- Layout and hierarchy: 18/20" "- Component fidelity: 18/20" "- State coverage: 19/20" "- Responsiveness: 18/20" "- Polish: 19/20" "## Differences" "- None blocking." "## Decision" "Pass."
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
if bin/dev-flow pdca-check "$(basename "$DELEGATED")" >"$PDCA_OUT" 2>&1; then
  cat "$PDCA_OUT" >&2
  echo "Expected default PDCA template to fail before cycle evidence is recorded." >&2
  exit 1
fi
grep -q "Missing Do section evidence" "$PDCA_OUT"
write_file "$DELEGATED/tasks/PDCA.md" \
  "# PDCA" "" \
  "## Current Cycle" \
  "- Cycle ID: smoke-${RUN_ID}" \
  "- Scope: delegated UI delivery fixture." \
  "- Owner / agent: smoke test." \
  "- Checkpoint: ship-check." "" \
  "## Plan" \
  "- Objective: Deliver the delegated UI fixture from specs/SPEC.md, design/DESIGN.md, SCREEN_ACCEPTANCE.md, and tasks/PLAN.md." \
  "- Acceptance evidence: functional flow, monkey test, and visual comparison score at or above 90/100." \
  "- Quality gates: bin/dev-flow design-check, qa-check, pdca-check, and ship-check." "" \
  "## Do" \
  "- Implementation slices: built the static UI under apps/web/index.html." \
  "- Changed areas: apps/web, reviews, and launch evidence." \
  "- Build artifacts: project-local source under apps/web." "" \
  "## Check" \
  "- Verification evidence: reviews/VERIFICATION.md." \
  "- Functional test evidence: reviews/FUNCTIONAL_TEST.md." \
  "- Monkey test evidence: reviews/MONKEY_TEST.md." \
  "- UI visual comparison evidence: reviews/VISUAL_COMPARISON.md score 92/100 against imagegen boards." "" \
  "## Act" \
  "- Decision: standardize the imagegen to implementation handoff for this cycle." \
  "- Iterate / follow-up: keep the same qa-check and pdca-check gates for the next cycle." \
  "- Rollback or recovery notes: use ship/LAUNCH.md if a release needs recovery."
bin/dev-flow pdca-check "$(basename "$DELEGATED")" >/dev/null
bin/dev-flow ship-check "$(basename "$DELEGATED")" >/dev/null

bin/dev-flow package-adapters "$ADAPTER_OUT" >/dev/null

echo "dev-flow smoke passed"
