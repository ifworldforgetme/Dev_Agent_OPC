#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RUN_ID="smoke_$$"
UI_BLOCK="$ROOT/work/__${RUN_ID}_ui_block"
DELEGATED="$ROOT/work/__${RUN_ID}_delegated"
INVALID="$ROOT/work/__${RUN_ID}_invalid"
SVG_ONLY="$ROOT/work/__${RUN_ID}_svg_only"
MISSING_COVERAGE="$ROOT/work/__${RUN_ID}_missing_coverage"
SCREENSHOT_SWAP="$ROOT/work/__${RUN_ID}_screenshot_swap"
DRAFT_PATH="$ROOT/work/__${RUN_ID}_draft_path"
NO_CUTS="$ROOT/work/__${RUN_ID}_no_cuts"
API_PROJECT="$ROOT/work/__${RUN_ID}_api"
LEGACY_PROJECT="$ROOT/work/__${RUN_ID}_legacy"
BAD_VISUAL="$ROOT/work/__${RUN_ID}_bad_visual"
ADAPTER_OUT="/private/tmp/dev-agent-opc-${RUN_ID}-adapters"
UI_BLOCK_OUT="/private/tmp/dev-flow-${RUN_ID}-ui-block.out"
INVALID_OUT="/private/tmp/dev-flow-${RUN_ID}-invalid.out"
EXCEPTION_OUT="/private/tmp/dev-flow-${RUN_ID}-exception.out"
SVG_ONLY_OUT="/private/tmp/dev-flow-${RUN_ID}-svg-only.out"
MISSING_COVERAGE_OUT="/private/tmp/dev-flow-${RUN_ID}-missing-coverage.out"
SCREENSHOT_SWAP_OUT="/private/tmp/dev-flow-${RUN_ID}-screenshot-swap.out"
DRAFT_PATH_OUT="/private/tmp/dev-flow-${RUN_ID}-draft-path.out"
PDCA_OUT="/private/tmp/dev-flow-${RUN_ID}-pdca.out"
API_OUT="/private/tmp/dev-flow-${RUN_ID}-api.out"
DOCTOR_OUT="/private/tmp/dev-flow-${RUN_ID}-doctor.out"
BAD_VISUAL_OUT="/private/tmp/dev-flow-${RUN_ID}-bad-visual.out"

cleanup() {
  rm -rf "$UI_BLOCK" "$DELEGATED" "$INVALID" "$SVG_ONLY" "$MISSING_COVERAGE" "$SCREENSHOT_SWAP" "$DRAFT_PATH" "$NO_CUTS" "$API_PROJECT" "$LEGACY_PROJECT" "$BAD_VISUAL" "$ADAPTER_OUT" "$UI_BLOCK_OUT" "$INVALID_OUT" "$EXCEPTION_OUT" "$SVG_ONLY_OUT" "$MISSING_COVERAGE_OUT" "$SCREENSHOT_SWAP_OUT" "$DRAFT_PATH_OUT" "$PDCA_OUT" "$API_OUT" "$DOCTOR_OUT" "$BAD_VISUAL_OUT"
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

bin/dev-flow init "$(basename "$API_PROJECT")" --type api >/dev/null
grep -q 'PROJECT_SCHEMA_VERSION="2"' "$API_PROJECT/.dev-flow/schema.env"
grep -q 'PROJECT_TYPE="api"' "$API_PROJECT/.dev-flow/schema.env"
grep -q 'UI_FLOW="disabled"' "$API_PROJECT/.dev-flow/applicability.env"
grep -q 'UI_DESIGN_ASSETS="disabled"' "$API_PROJECT/.dev-flow/applicability.env"
write_file "$API_PROJECT/ideas/idea-brief.md" \
  "# Idea Brief" "" "Build a JSON API." "No customer-facing UI is in scope." "The workflow should not require design assets."
write_file "$API_PROJECT/specs/SPEC.md" \
  "# Spec" "" "Create a small HTTP API." "Implementation will live under apps/api." "UI design is out of scope."
bin/dev-flow phase "$(basename "$API_PROJECT")" plan "Plan API implementation without UI design" >"$API_OUT" 2>&1
grep -q "Updated $(basename "$API_PROJECT") to phase: plan" "$API_OUT"

bin/dev-flow init "$(basename "$LEGACY_PROJECT")" --type api >/dev/null
rm -f "$LEGACY_PROJECT/.dev-flow/schema.env" "$LEGACY_PROJECT/tasks/IMPLEMENTATION_TRACE.md"
if bin/dev-flow doctor "$(basename "$LEGACY_PROJECT")" >"$DOCTOR_OUT" 2>&1; then
  cat "$DOCTOR_OUT" >&2
  echo "Expected doctor to fail on missing schema and implementation trace." >&2
  exit 1
fi
grep -q "Missing schema" "$DOCTOR_OUT"
grep -q "Missing template file: tasks/IMPLEMENTATION_TRACE.md" "$DOCTOR_OUT"
bin/dev-flow migrate "$(basename "$LEGACY_PROJECT")" --type api >/dev/null
bin/dev-flow doctor "$(basename "$LEGACY_PROJECT")" >/dev/null
grep -q 'PROJECT_SCHEMA_VERSION="2"' "$LEGACY_PROJECT/.dev-flow/schema.env"
grep -q 'PROJECT_TYPE="api"' "$LEGACY_PROJECT/.dev-flow/schema.env"

bin/dev-flow init "$(basename "$UI_BLOCK")" >/dev/null
grep -q 'PROJECT_SCHEMA_VERSION="2"' "$UI_BLOCK/.dev-flow/schema.env"
grep -q 'PROJECT_TYPE="ui"' "$UI_BLOCK/.dev-flow/schema.env"
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
  "The workflow should require design and approved design assets first."
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
  "# Spec" "" "Create a UI." "Require approved design assets." "This is an audit fixture."
write_file "$INVALID/design/DESIGN.md" \
  "# Design" "" "## UX Problem" "Users need a polished interface." "## Recommended Direction" "Use a focused dashboard." "## Alternatives Considered" "- Basic page: too weak." "## Information Architecture" "Dashboard only." "## Interaction Model" "Primary action only." "## Visual System" "Neutral product surface." "## Design Artifacts" "Approved design asset required." "## Build Implications" "Build from the board."
write_file "$INVALID/design/VISUAL_SYSTEM.md" \
  "# Visual System" "" "## Reference Influence" "Delegated visual direction." "## Palette" "Use neutral surfaces." "## Typography" "Readable product scale." "## Spacing and Layout" "Dense but clear." "## Components and Motion" "Buttons have visible states." "## Forbidden Patterns" "No generic AI gradients."
write_file "$INVALID/design/SCREEN_ACCEPTANCE.md" \
  "# Screen Acceptance" "" "## Dashboard" "- Required content: dashboard body." "- Required states: default." "- Breakpoints: 320, 768, 1440." "- Required design assets: design/approved/dashboard.png." "- Visual acceptance: follows the board." "- Accessibility acceptance: primary action reachable."
write_file "$INVALID/design/DESIGN_ARTIFACTS.md" \
  "# Design Artifacts" "" "## Required Coverage" "- Dashboard board." "## Screen Coverage" "| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |" "|---|---|---|---|---|---|---|---|" "| Dashboard | Default | gpt-image-2 | gpt-image-2://smoke/dashboard | design/approved/dashboard.png | 1440x900 png | approved | Use as visual target |"
write_file "$INVALID/design/approved/dashboard.png" "not a real png"
if bin/dev-flow design-check "$(basename "$INVALID")" --allow-no-reference >"$INVALID_OUT" 2>&1; then
  cat "$INVALID_OUT" >&2
  echo "Expected invalid approved design artifact to fail." >&2
  exit 1
fi
grep -q "Invalid approved design artifact" "$INVALID_OUT"

bin/dev-flow init "$(basename "$SVG_ONLY")" >/dev/null
write_file "$SVG_ONLY/ideas/idea-brief.md" \
  "# Idea Brief" "" "Build a UI." "Use delegated visual direction." "Audit SVG-only approved design artifacts."
write_file "$SVG_ONLY/specs/SPEC.md" \
  "# Spec" "" "Create a UI." "Require final raster boards." "This is an audit fixture."
write_file "$SVG_ONLY/design/DESIGN.md" \
  "# Design" "" "## UX Problem" "Users need a polished interface." "## Recommended Direction" "Use a focused dashboard." "## Alternatives Considered" "- SVG-only draft: lacks final visual fidelity." "## Information Architecture" "Dashboard only." "## Interaction Model" "Primary action only." "## Visual System" "Neutral product surface." "## Design Artifacts" "Approved design asset required." "## Build Implications" "Build from the final board."
write_file "$SVG_ONLY/design/VISUAL_SYSTEM.md" \
  "# Visual System" "" "## Reference Influence" "Delegated visual direction." "## Palette" "Use neutral surfaces." "## Typography" "Readable product scale." "## Spacing and Layout" "Dense but clear." "## Components and Motion" "Buttons have visible states." "## Forbidden Patterns" "No generic AI gradients."
write_file "$SVG_ONLY/design/SCREEN_ACCEPTANCE.md" \
  "# Screen Acceptance" "" "## Dashboard" "- Required content: dashboard body." "- Required states: default." "- Breakpoints: 320, 768, 1440." "- Required design assets: design/approved/dashboard.svg." "- Visual acceptance: follows the final board." "- Accessibility acceptance: primary action reachable."
write_file "$SVG_ONLY/design/DESIGN_ARTIFACTS.md" \
  "# Design Artifacts" "" "## Required Coverage" "- Dashboard board." "## Screen Coverage" "| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |" "|---|---|---|---|---|---|---|---|" "| Dashboard | Default | manual-design | manual://svg-draft | design/approved/dashboard.svg | svg draft | approved | Structure draft only |"
write_valid_svg "$SVG_ONLY/design/approved/dashboard.svg"
if bin/dev-flow design-check "$(basename "$SVG_ONLY")" --allow-no-reference >"$SVG_ONLY_OUT" 2>&1; then
  cat "$SVG_ONLY_OUT" >&2
  echo "Expected SVG-only approved design artifact to fail." >&2
  exit 1
fi
grep -q "Missing final approved design asset" "$SVG_ONLY_OUT"

bin/dev-flow init "$(basename "$MISSING_COVERAGE")" >/dev/null
write_file "$MISSING_COVERAGE/ideas/idea-brief.md" \
  "# Idea Brief" "" "Build a UI." "Use delegated visual direction." "Audit missing screen coverage."
write_file "$MISSING_COVERAGE/specs/SPEC.md" \
  "# Spec" "" "Create dashboard and settings screens." "Require final boards per screen." "This is an audit fixture."
write_file "$MISSING_COVERAGE/design/DESIGN.md" \
  "# Design" "" "## UX Problem" "Users need two polished screens." "## Recommended Direction" "Use a dashboard and settings structure." "## Alternatives Considered" "- Single screen: incomplete." "## Information Architecture" "Dashboard and settings." "## Interaction Model" "Navigate between screens." "## Visual System" "Neutral product surface." "## Design Artifacts" "Approved design assets required." "## Build Implications" "Build both screens from boards."
write_file "$MISSING_COVERAGE/design/VISUAL_SYSTEM.md" \
  "# Visual System" "" "## Reference Influence" "Delegated visual direction." "## Palette" "Use neutral surfaces." "## Typography" "Readable product scale." "## Spacing and Layout" "Dense but clear." "## Components and Motion" "Buttons have visible states." "## Forbidden Patterns" "No generic AI gradients."
write_file "$MISSING_COVERAGE/design/SCREEN_ACCEPTANCE.md" \
  "# Screen Acceptance" "" "## Dashboard" "- Required content: dashboard body." "- Required states: default." "- Breakpoints: 320, 768, 1440." "- Required design assets: design/approved/dashboard.png." "- Visual acceptance: follows the board." "- Accessibility acceptance: primary action reachable." "" "## Settings" "- Required content: settings controls." "- Required states: default." "- Breakpoints: 320, 768, 1440." "- Required design assets: design/approved/settings.png." "- Visual acceptance: follows the board." "- Accessibility acceptance: controls reachable."
write_file "$MISSING_COVERAGE/design/DESIGN_ARTIFACTS.md" \
  "# Design Artifacts" "" "## Required Coverage" "- Dashboard board only." "## Screen Coverage" "| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |" "|---|---|---|---|---|---|---|---|" "| Dashboard | Default | figma-mcp | figma://smoke/dashboard | design/approved/dashboard.png | 1440x900 png | approved | Use as visual target |"
write_valid_png "$MISSING_COVERAGE/design/approved/dashboard.png"
if bin/dev-flow design-check "$(basename "$MISSING_COVERAGE")" --allow-no-reference >"$MISSING_COVERAGE_OUT" 2>&1; then
  cat "$MISSING_COVERAGE_OUT" >&2
  echo "Expected missing screen coverage to fail." >&2
  exit 1
fi
grep -q "Missing approved design asset for screen: Settings" "$MISSING_COVERAGE_OUT"

bin/dev-flow init "$(basename "$SCREENSHOT_SWAP")" >/dev/null
write_file "$SCREENSHOT_SWAP/ideas/idea-brief.md" \
  "# Idea Brief" "" "Build a UI." "Use delegated visual direction." "Audit screenshot masquerading as approved design."
write_file "$SCREENSHOT_SWAP/specs/SPEC.md" \
  "# Spec" "" "Create a UI." "Require design artifact contract." "This is an audit fixture."
write_file "$SCREENSHOT_SWAP/design/DESIGN.md" \
  "# Design" "" "## UX Problem" "Users need a polished interface." "## Recommended Direction" "Use a focused dashboard." "## Alternatives Considered" "- Browser screenshot: not a design board." "## Information Architecture" "Dashboard only." "## Interaction Model" "Primary action only." "## Visual System" "Neutral product surface." "## Design Artifacts" "Approved design asset required." "## Build Implications" "Build from verified design artifact contract."
write_file "$SCREENSHOT_SWAP/design/VISUAL_SYSTEM.md" \
  "# Visual System" "" "## Reference Influence" "Delegated visual direction." "## Palette" "Use neutral surfaces." "## Typography" "Readable product scale." "## Spacing and Layout" "Dense but clear." "## Components and Motion" "Buttons have visible states." "## Forbidden Patterns" "No generic AI gradients."
write_file "$SCREENSHOT_SWAP/design/SCREEN_ACCEPTANCE.md" \
  "# Screen Acceptance" "" "## Dashboard" "- Required content: dashboard body." "- Required states: default." "- Breakpoints: 320, 768, 1440." "- Required design assets: design/approved/dashboard.png." "- Visual acceptance: follows the board." "- Accessibility acceptance: primary action reachable."
write_file "$SCREENSHOT_SWAP/design/DESIGN_ARTIFACTS.md" \
  "# Design Artifacts" "" "## Required Coverage" "- Dashboard board." "## Screen Coverage" "| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |" "|---|---|---|---|---|---|---|---|" "| Dashboard | Default | browser-screenshot | design/screenshots/dashboard.png | design/approved/dashboard.png | 1440x900 png | approved | Should fail because screenshots are verification assets |"
write_valid_png "$SCREENSHOT_SWAP/design/approved/dashboard.png"
write_valid_png "$SCREENSHOT_SWAP/design/screenshots/dashboard.png"
if bin/dev-flow design-check "$(basename "$SCREENSHOT_SWAP")" --allow-no-reference >"$SCREENSHOT_SWAP_OUT" 2>&1; then
  cat "$SCREENSHOT_SWAP_OUT" >&2
  echo "Expected browser/local screenshot provenance to fail." >&2
  exit 1
fi
grep -q "Invalid formal design source" "$SCREENSHOT_SWAP_OUT"

bin/dev-flow init "$(basename "$DRAFT_PATH")" >/dev/null
write_file "$DRAFT_PATH/ideas/idea-brief.md" \
  "# Idea Brief" "" "Build a UI." "Use delegated visual direction." "Audit draft asset masquerading as approved."
write_file "$DRAFT_PATH/specs/SPEC.md" \
  "# Spec" "" "Create a UI." "Require formal approved design assets." "This is an audit fixture."
write_file "$DRAFT_PATH/design/DESIGN.md" \
  "# Design" "" "## UX Problem" "Users need a polished interface." "## Recommended Direction" "Use a focused dashboard." "## Alternatives Considered" "- Draft path: not approved." "## Information Architecture" "Dashboard only." "## Interaction Model" "Primary action only." "## Visual System" "Neutral product surface." "## Design Artifacts" "Approved asset required." "## Build Implications" "Build from approved design assets only."
write_file "$DRAFT_PATH/design/VISUAL_SYSTEM.md" \
  "# Visual System" "" "## Reference Influence" "Delegated visual direction." "## Palette" "Use neutral surfaces." "## Typography" "Readable product scale." "## Spacing and Layout" "Dense but clear." "## Components and Motion" "Buttons have visible states." "## Forbidden Patterns" "No generic AI gradients."
write_file "$DRAFT_PATH/design/SCREEN_ACCEPTANCE.md" \
  "# Screen Acceptance" "" "## Dashboard" "- Required content: dashboard body." "- Required states: default." "- Breakpoints: 320, 768, 1440." "- Required design assets: design/approved/dashboard.png." "- Visual acceptance: follows the board." "- Accessibility acceptance: primary action reachable."
write_file "$DRAFT_PATH/design/DESIGN_ARTIFACTS.md" \
  "# Design Artifacts" "" "## Required Coverage" "- Dashboard board." "## Screen Coverage" "| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |" "|---|---|---|---|---|---|---|---|" "| Dashboard | Default | manual-design | manual://draft-dashboard | design/drafts/dashboard.png | 1440x900 png | approved | Should fail because approved asset path points to drafts |"
write_valid_png "$DRAFT_PATH/design/drafts/dashboard.png"
if bin/dev-flow design-check "$(basename "$DRAFT_PATH")" --allow-no-reference >"$DRAFT_PATH_OUT" 2>&1; then
  cat "$DRAFT_PATH_OUT" >&2
  echo "Expected draft-path approved design asset to fail." >&2
  exit 1
fi
grep -q "Invalid approved design asset" "$DRAFT_PATH_OUT"

bin/dev-flow init "$(basename "$NO_CUTS")" >/dev/null
write_file "$NO_CUTS/ideas/idea-brief.md" \
  "# Idea Brief" "" "Build a UI." "Use delegated visual direction." "Verify no-cut-assets decision."
write_file "$NO_CUTS/specs/SPEC.md" \
  "# Spec" "" "Create a dashboard UI." "Use approved design assets." "No bitmap cut assets are needed."
write_file "$NO_CUTS/design/DESIGN.md" \
  "# Design" "" "## UX Problem" "Users need a polished interface." "## Recommended Direction" "Use a focused dashboard with system icons." "## Alternatives Considered" "- Custom bitmap icons: unnecessary for this fixture." "## Information Architecture" "Dashboard only." "## Interaction Model" "Primary action only." "## Visual System" "Neutral product surface." "## Design Artifacts" "Approved asset required." "## Build Implications" "Build from verified design artifact contract."
write_file "$NO_CUTS/design/VISUAL_SYSTEM.md" \
  "# Visual System" "" "## Reference Influence" "Delegated visual direction." "## Palette" "Use neutral surfaces." "## Typography" "Readable product scale." "## Spacing and Layout" "Dense but clear." "## Components and Motion" "Buttons have visible states." "## Forbidden Patterns" "No generic AI gradients."
write_file "$NO_CUTS/design/SCREEN_ACCEPTANCE.md" \
  "# Screen Acceptance" "" "## Dashboard" "- Required content: dashboard body." "- Required states: default." "- Breakpoints: 320, 768, 1440." "- Required design assets: design/approved/dashboard.png." "- Visual acceptance: follows the board." "- Accessibility acceptance: primary action reachable."
write_file "$NO_CUTS/design/DESIGN_ARTIFACTS.md" \
  "# Design Artifacts" "" "## Required Coverage" "- Dashboard board." "## Screen Coverage" "| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |" "|---|---|---|---|---|---|---|---|" "| Dashboard | Default | figma | figma://smoke/no-cuts-dashboard | design/approved/dashboard.png | 1440x900 png | approved | Use as visual target |"
write_file "$NO_CUTS/design/REFERENCE_BOARD.md" \
  "# Reference Board" "" "## Delegated Direction" "Use a focused product dashboard with neutral surfaces." "## Patterns" "- Clear hierarchy." "- System icons only."
write_file "$NO_CUTS/design/cut-assets/ASSET_MANIFEST.md" \
  "# Cut Assets" "" "## Decision" "- CUT_ASSETS_REQUIRED: no" "- Rationale: this fixture uses CSS and platform icons only."
write_valid_png "$NO_CUTS/design/approved/dashboard.png"
bin/dev-flow design-check "$(basename "$NO_CUTS")" --allow-no-reference >/dev/null
bin/dev-flow asset-check "$(basename "$NO_CUTS")" >/dev/null

bin/dev-flow init "$(basename "$DELEGATED")" >/dev/null
write_file "$DELEGATED/ideas/idea-brief.md" \
  "# Idea Brief" "" "Build a habit tracker." "The user delegated visual direction." "The app needs onboarding and dashboard screens."
write_file "$DELEGATED/specs/SPEC.md" \
  "# Spec" "" "Create onboarding and dashboard screens." "Support default, empty, loading, error, and success states." "Use approved design assets before implementation."
write_file "$DELEGATED/design/DESIGN.md" \
  "# Design" "" "## UX Problem" "Users need quick setup and trusted progress." "## Recommended Direction" "Use approved design assets as the visual target." "## Alternatives Considered" "- Text-only UI: too weak." "## Information Architecture" "Onboarding and dashboard." "## Interaction Model" "Primary setup flow and dashboard review." "## Visual System" "Neutral surfaces with one action color." "## Design Artifacts" "- design/approved/onboarding-default.png" "- design/approved/dashboard-empty.png" "## Build Implications" "Use SCREEN_ACCEPTANCE.md and approved design assets during implementation."
write_file "$DELEGATED/design/VISUAL_SYSTEM.md" \
  "# Visual System" "" "## Reference Influence" "Delegated visual direction from product goals." "## Palette" "Neutral surfaces and one action color." "## Typography" "Readable product scale." "## Spacing and Layout" "Cards and sections use stable spacing." "## Components and Motion" "Cards, tabs, and buttons need states." "## Forbidden Patterns" "No generic AI gradients or nested card stacks."
write_file "$DELEGATED/design/SCREEN_ACCEPTANCE.md" \
  "# Screen Acceptance" "" "## Onboarding" "- Required content: setup title, habit input, primary action." "- Required states: default, loading, error, success." "- Breakpoints: 320, 768, 1440." "- Required design assets: design/approved/onboarding-default.png." "- Visual acceptance: follows the onboarding board hierarchy." "- Accessibility acceptance: primary action keyboard reachable." "" "## Dashboard" "- Required content: habit cards, progress summary, primary action." "- Required states: default, empty, loading, selected, success." "- Breakpoints: 320, 768, 1440." "- Required design assets: design/approved/dashboard-empty.png." "- Visual acceptance: follows the dashboard board hierarchy." "- Accessibility acceptance: cards and actions keyboard reachable."
write_file "$DELEGATED/design/DESIGN_ARTIFACTS.md" \
  "# Design Artifacts" "" "## Required Coverage" "- Onboarding board." "- Dashboard board." "" "## Screen Coverage" "| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |" "|---|---|---|---|---|---|---|---|" "| Onboarding | Default | imagegen | imagegen://smoke/onboarding-default | design/approved/onboarding-default.png | 1440x900 png | approved | Use as visual target |" "| Dashboard | Empty | gpt-image-2 | gpt-image-2://smoke/dashboard-empty | design/approved/dashboard-empty.png | 1440x900 png | approved | Use as visual target |"
write_file "$DELEGATED/design/REFERENCE_BOARD.md" \
  "# Reference Board" "" "## Delegated Direction" "Use calm, polished, product-grade habit tracking screens." "## Patterns" "- Onboarding is focused and low-friction." "- Dashboard emphasizes progress and next action."
write_valid_png "$DELEGATED/design/approved/onboarding-default.png"
write_valid_png "$DELEGATED/design/approved/dashboard-empty.png"
write_valid_png "$DELEGATED/design/cut-assets/primary-icon.png"
write_file "$DELEGATED/design/cut-assets/ASSET_MANIFEST.md" \
  "# Cut Assets" "" "## Decision" "- CUT_ASSETS_REQUIRED: yes" "" "## Asset Manifest" "| Asset | Source approved asset | Source region / frame | Output path | Format | Alpha | Runtime path | Usage | Notes |" "|---|---|---|---|---|---|---|---|---|" "| Primary icon | design/approved/onboarding-default.png | x=24 y=24 w=96 h=96 | design/cut-assets/primary-icon.png | PNG 2x | yes | apps/web/assets/primary-icon.png | Primary action icon | Derived from approved board |"
bin/dev-flow design-check "$(basename "$DELEGATED")" --allow-no-reference >/dev/null
grep -q 'UI_REFERENCES="delegated"' "$DELEGATED/.dev-flow/applicability.env"
bin/dev-flow phase "$(basename "$DELEGATED")" plan "Plan implementation after delegated design" >/dev/null

write_file "$DELEGATED/tasks/PLAN.md" \
  "# Plan" "" "## Design Handoff" "Implement from DESIGN.md, VISUAL_SYSTEM.md, SCREEN_ACCEPTANCE.md, and approved design assets under design/approved/." "" "## Task 1" "Build the static UI under apps/web." "Acceptance: source exists, functional QA passes, monkey QA passes, and VISUAL_COMPARISON.md scores the implemented screens."
write_file "$DELEGATED/tasks/IMPLEMENTATION_TRACE.md" \
  "# Implementation Trace" "" "## Screen Trace" "| Screen | State | Implementation target | Approved asset | Cut assets | Test evidence | Status |" "|---|---|---|---|---|---|---|" "| Onboarding | Default | apps/web/index.html | design/approved/onboarding-default.png | design/cut-assets/primary-icon.png | reviews/FUNCTIONAL_TEST.md | planned |" "| Dashboard | Empty | apps/web/index.html | design/approved/dashboard-empty.png | none | reviews/FUNCTIONAL_TEST.md | planned |"
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
  "# Visual Comparison" "" "Overall score: 89/100" "" "## Compared Inputs" "- design/approved/onboarding-default.png" "- design/approved/dashboard-empty.png" "## Screen Fidelity Matrix" "| Screen | Approved asset path | Runtime surface | Fidelity score | Decision | Notes |" "|---|---|---|---|---|---|" "| Onboarding | design/approved/onboarding-default.png | apps/web/index.html | 45/50 | pass | Good |" "| Dashboard | design/approved/dashboard-empty.png | apps/web/index.html | 44/50 | pass | Good |" "## Score Breakdown" "- Layout and hierarchy: 18/20" "- Component fidelity: 18/20" "- State coverage: 17/20" "- Responsiveness: 18/20" "- Polish: 18/20" "## Differences" "- Minor but below high-fidelity bar." "## Decision" "Fail until score reaches 90/100."
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
  "# Visual Comparison" "" "Overall score: 92/100" "" "## Compared Inputs" "- design/approved/onboarding-default.png" "- design/approved/dashboard-empty.png" "## Screen Fidelity Matrix" "| Screen | Approved asset path | Runtime surface | Fidelity score | Decision | Notes |" "|---|---|---|---|---|---|" "| Onboarding | design/approved/onboarding-default.png | apps/web/index.html | 46/50 | pass | Good |" "| Dashboard | design/approved/dashboard-empty.png | apps/web/index.html | 46/50 | pass | Good |" "## Score Breakdown" "- Layout and hierarchy: 18/20" "- Component fidelity: 18/20" "- State coverage: 19/20" "- Responsiveness: 18/20" "- Polish: 19/20" "## Differences" "- None blocking." "## Decision" "Pass."
bin/dev-flow qa-check "$(basename "$DELEGATED")" >/dev/null
cp -R "$DELEGATED" "$BAD_VISUAL"
write_file "$BAD_VISUAL/reviews/VISUAL_COMPARISON.md" \
  "# Visual Comparison" "" "Overall score: 92/100" "" "## Compared Inputs" "- design/approved/onboarding-default.png" "- design/approved/dashboard-empty.png" "## Screen Fidelity Matrix" "| Screen | Approved asset path | Runtime surface | Fidelity score | Decision | Notes |" "|---|---|---|---|---|---|" "| Onboarding | design/approved/onboarding-default.png | apps/web/index.html | 46/50 | pass | Good |" "| Dashboard | design/approved/dashboard-empty.png |  | 46/50 |  | Missing runtime and decision should fail |" "## Score Breakdown" "- Layout and hierarchy: 18/20" "- Component fidelity: 18/20" "- State coverage: 19/20" "- Responsiveness: 18/20" "- Polish: 19/20" "## Differences" "- Missing row fields." "## Decision" "Fail."
if bin/dev-flow qa-check "$(basename "$BAD_VISUAL")" >"$BAD_VISUAL_OUT" 2>&1; then
  cat "$BAD_VISUAL_OUT" >&2
  echo "Expected incomplete visual matrix row to fail." >&2
  exit 1
fi
grep -q "Incomplete visual comparison row for screen: Dashboard" "$BAD_VISUAL_OUT"
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
  "- UI visual comparison evidence: reviews/VISUAL_COMPARISON.md score 92/100 against approved design assets." "" \
  "## Act" \
  "- Decision: standardize the approved-design to implementation handoff for this cycle." \
  "- Iterate / follow-up: keep the same qa-check and pdca-check gates for the next cycle." \
  "- Rollback or recovery notes: use ship/LAUNCH.md if a release needs recovery."
bin/dev-flow pdca-check "$(basename "$DELEGATED")" >/dev/null
bin/dev-flow ship-check "$(basename "$DELEGATED")" >/dev/null

bin/dev-flow package-adapters "$ADAPTER_OUT" >/dev/null
test -x "$ADAPTER_OUT/runtime/bin/dev-flow"
test -f "$ADAPTER_OUT/runtime/AGENTS.md"
test -f "$ADAPTER_OUT/runtime/DEV_FLOW.md"
test -f "$ADAPTER_OUT/runtime/tests/dev-flow-smoke.sh"
test -d "$ADAPTER_OUT/runtime/agent-skills/templates/project"
! find "$ADAPTER_OUT" -path '*/work/*' -o -path '*/dist/*' | grep -q .

echo "dev-flow smoke passed"
