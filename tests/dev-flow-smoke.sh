#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RUN_ID="smoke_$$"
UI_BLOCK="$ROOT/work/__${RUN_ID}_ui_block"
LIGHT_UI="$ROOT/work/__${RUN_ID}_light_ui"
DELEGATED="$ROOT/work/__${RUN_ID}_delegated"
INVALID="$ROOT/work/__${RUN_ID}_invalid"
SVG_ONLY="$ROOT/work/__${RUN_ID}_svg_only"
SVG_LEAK="$ROOT/work/__${RUN_ID}_svg_leak"
SVG_CUT_ALLOWED="$ROOT/work/__${RUN_ID}_svg_cut_allowed"
SELF_RENDERED_PNG="$ROOT/work/__${RUN_ID}_self_rendered_png"
MISSING_COVERAGE="$ROOT/work/__${RUN_ID}_missing_coverage"
SCREENSHOT_SWAP="$ROOT/work/__${RUN_ID}_screenshot_swap"
DRAFT_PATH="$ROOT/work/__${RUN_ID}_draft_path"
NO_CUTS="$ROOT/work/__${RUN_ID}_no_cuts"
AI_MISSING_HTML="$ROOT/work/__${RUN_ID}_ai_missing_html"
FIGMA_GOOD="$ROOT/work/__${RUN_ID}_figma_good"
FIGMA_SECTION_BOUNDARY="$ROOT/work/__${RUN_ID}_figma_section_boundary"
FIGMA_MISSING_SOURCE="$ROOT/work/__${RUN_ID}_figma_missing_source"
FIGMA_BAD_EXPORT="$ROOT/work/__${RUN_ID}_figma_bad_export"
API_PROJECT="$ROOT/work/__${RUN_ID}_api"
AGENT_PROJECT="$ROOT/work/__${RUN_ID}_agent"
ENV_PROJECT="$ROOT/work/__${RUN_ID}_env"
BAD_ENV="$ROOT/work/__${RUN_ID}_bad_env"
LEGACY_PROJECT="$ROOT/work/__${RUN_ID}_legacy"
BAD_VISUAL="$ROOT/work/__${RUN_ID}_bad_visual"
ADAPTER_OUT="/private/tmp/dev-agent-${RUN_ID}-adapters"
INSTALL_DEST="/private/tmp/dev-agent-${RUN_ID}-install"
INSTALL_WORKSPACE="/private/tmp/dev-agent-${RUN_ID}-workspace"
UI_BLOCK_OUT="/private/tmp/dev-flow-${RUN_ID}-ui-block.out"
LIGHT_UI_NEXT_OUT="/private/tmp/dev-flow-${RUN_ID}-light-ui-next.out"
INVALID_OUT="/private/tmp/dev-flow-${RUN_ID}-invalid.out"
EXCEPTION_OUT="/private/tmp/dev-flow-${RUN_ID}-exception.out"
SVG_ONLY_OUT="/private/tmp/dev-flow-${RUN_ID}-svg-only.out"
SVG_LEAK_OUT="/private/tmp/dev-flow-${RUN_ID}-svg-leak.out"
SVG_CUT_ALLOWED_OUT="/private/tmp/dev-flow-${RUN_ID}-svg-cut-allowed.out"
SELF_RENDERED_PNG_OUT="/private/tmp/dev-flow-${RUN_ID}-self-rendered-png.out"
MISSING_COVERAGE_OUT="/private/tmp/dev-flow-${RUN_ID}-missing-coverage.out"
SCREENSHOT_SWAP_OUT="/private/tmp/dev-flow-${RUN_ID}-screenshot-swap.out"
DRAFT_PATH_OUT="/private/tmp/dev-flow-${RUN_ID}-draft-path.out"
AI_MISSING_HTML_OUT="/private/tmp/dev-flow-${RUN_ID}-ai-missing-html.out"
FIGMA_MISSING_SOURCE_OUT="/private/tmp/dev-flow-${RUN_ID}-figma-missing-source.out"
FIGMA_BAD_EXPORT_OUT="/private/tmp/dev-flow-${RUN_ID}-figma-bad-export.out"
API_OUT="/private/tmp/dev-flow-${RUN_ID}-api.out"
AGENT_OUT="/private/tmp/dev-flow-${RUN_ID}-agent.out"
ENV_OUT="/private/tmp/dev-flow-${RUN_ID}-env.out"
BAD_ENV_OUT="/private/tmp/dev-flow-${RUN_ID}-bad-env.out"
DOCTOR_OUT="/private/tmp/dev-flow-${RUN_ID}-doctor.out"
BAD_VISUAL_OUT="/private/tmp/dev-flow-${RUN_ID}-bad-visual.out"
TRACE_MISSING_HTML_OUT="/private/tmp/dev-flow-${RUN_ID}-trace-missing-html.out"
NEXT_UI_OUT="/private/tmp/dev-flow-${RUN_ID}-next-ui.out"

cleanup_path() {
  local path
  for path in "$@"; do
    [[ -e "$path" ]] || continue
    rm -rf "$path" 2>/dev/null || {
      find "$path" -name .DS_Store -delete 2>/dev/null || true
      rm -rf "$path"
    }
  done
}

cleanup() {
  cleanup_path "$UI_BLOCK" "$LIGHT_UI" "$DELEGATED" "$INVALID" "$SVG_ONLY" "$SVG_LEAK" "$SVG_CUT_ALLOWED" "$SELF_RENDERED_PNG" "$MISSING_COVERAGE" "$SCREENSHOT_SWAP" "$DRAFT_PATH" "$NO_CUTS" "$AI_MISSING_HTML" "$FIGMA_GOOD" "$FIGMA_SECTION_BOUNDARY" "$FIGMA_MISSING_SOURCE" "$FIGMA_BAD_EXPORT" "$API_PROJECT" "$AGENT_PROJECT" "$ENV_PROJECT" "$BAD_ENV" "$LEGACY_PROJECT" "$BAD_VISUAL" "$ADAPTER_OUT" "$INSTALL_DEST" "$INSTALL_WORKSPACE" "$UI_BLOCK_OUT" "$LIGHT_UI_NEXT_OUT" "$INVALID_OUT" "$EXCEPTION_OUT" "$SVG_ONLY_OUT" "$SVG_LEAK_OUT" "$SVG_CUT_ALLOWED_OUT" "$SELF_RENDERED_PNG_OUT" "$MISSING_COVERAGE_OUT" "$SCREENSHOT_SWAP_OUT" "$DRAFT_PATH_OUT" "$AI_MISSING_HTML_OUT" "$FIGMA_MISSING_SOURCE_OUT" "$FIGMA_BAD_EXPORT_OUT" "$API_OUT" "$AGENT_OUT" "$ENV_OUT" "$BAD_ENV_OUT" "$DOCTOR_OUT" "$BAD_VISUAL_OUT" "$TRACE_MISSING_HTML_OUT" "$NEXT_UI_OUT"
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

write_html_description() {
  local path="$1"
  local title="$2"
  mkdir -p "$(dirname "$path")"
  printf '%s\n' \
    '<!doctype html>' \
    '<html lang="en">' \
    '<head><meta charset="utf-8"><title>'"$title"'</title></head>' \
    '<body>' \
    '<main data-screen="'"$title"'">' \
    '<h1>'"$title"'</h1>' \
    '<section data-purpose="semantic-design-description">' \
    '<p>Layout hierarchy, components, state, colors, spacing, typography, interactions, and implementation notes for the approved design image.</p>' \
    '</section>' \
    '</main>' \
    '</body>' \
    '</html>' > "$path"
}

assert_max_lines() {
  local path="$1"
  local max_lines="$2"
  local actual
  actual="$(wc -l < "$path" | tr -d ' ')"
  if [[ "$actual" -gt "$max_lines" ]]; then
    echo "Document too long: $path has $actual lines, expected <= $max_lines." >&2
    exit 1
  fi
}

cd "$ROOT"

bash -n bin/dev-flow
bin/dev-flow list >/dev/null
bin/dev-flow manifest >/dev/null
bin/dev-flow command dev >/dev/null
bin/dev-flow command dev-agent >/dev/null
bin/dev-flow agent code-reviewer >/dev/null
bin/dev-flow agent opc-code-reviewer >/dev/null
bin/dev-flow command figma-design >/dev/null
bin/dev-flow command figma-library >/dev/null
for removed_command in pm agent plan test review; do
  if bin/dev-flow command "$removed_command" >/dev/null 2>&1; then
    echo "Expected helper command to be removed from public flow surface: $removed_command" >&2
    exit 1
  fi
done
grep -q '"stableId": "dev-agent"' dev-agent/dev-agent.manifest.json
grep -q '"userVisibleEntry": "/dev agent"' dev-agent/dev-agent.manifest.json
grep -q '"/dev-agent"' dev-agent/dev-agent.manifest.json
grep -q '"roles"' dev-agent/dev-agent.manifest.json
grep -q '"gates"' dev-agent/dev-agent.manifest.json
grep -q 'bin/dev-flow is the only execution navigator' AGENTS.md
grep -q 'bin/dev-flow status <project-name>' AGENTS.md
grep -q 'bin/dev-flow next <project-name>' AGENTS.md
grep -q 'Do not start by bulk-reading Markdown' AGENTS.md
grep -q '唯一执行导航器' README.md
grep -q 'bin/dev-flow status <project-name>' dev-agent/native/skills/dev-agent/SKILL.md
grep -q 'bin/dev-flow next <project-name>' dev-agent/native/skills/dev-agent/SKILL.md
grep -q 'Do not bulk-read Markdown' dev-agent/commands/dev.md

node -e '
const fs = require("fs");
const names = (dir, ext) => fs.readdirSync(dir)
  .filter((file) => file.endsWith(ext))
  .map((file) => file.slice(0, -ext.length))
  .sort();
const canonical = names("dev-agent/commands", ".md");
const claude = names("dev-agent/.claude/commands", ".md");
const gemini = names("dev-agent/.gemini/commands", ".toml");
const missing = (expected, actual) => expected.filter((name) => !actual.includes(name));
const extra = (actual, expected) => actual.filter((name) => !expected.includes(name));
const problems = [];
const claudeMissing = missing(canonical, claude);
const geminiMissing = missing(canonical, gemini);
const claudeExtra = extra(claude, canonical);
const geminiExtra = extra(gemini, canonical);
if (claudeMissing.length) problems.push(`Claude missing: ${claudeMissing.join(", ")}`);
if (geminiMissing.length) problems.push(`Gemini missing: ${geminiMissing.join(", ")}`);
if (claudeExtra.length) problems.push(`Claude extra: ${claudeExtra.join(", ")}`);
if (geminiExtra.length) problems.push(`Gemini extra: ${geminiExtra.join(", ")}`);
if (gemini.includes("planning")) problems.push("Gemini command planning.toml is stale; use plan.toml");
for (const removed of ["pm", "agent", "plan", "test", "review"]) {
  if (canonical.includes(removed)) problems.push(`Removed helper command still exists: ${removed}`);
  if (claude.includes(removed)) problems.push(`Claude removed helper command still exists: ${removed}`);
  if (gemini.includes(removed)) problems.push(`Gemini removed helper command still exists: ${removed}`);
}
if (problems.length) {
  console.error("Adapter command parity failed:");
  for (const problem of problems) console.error(`- ${problem}`);
  process.exit(1);
}
'

if rg -n 'manual design-system comps|another explicitly approved source|manual-design|local-approved|approved design assets or cut assets|no bitmap cut assets|bitmap cut assets are needed|as approved design assets or cut assets' dev-agent/.claude/commands dev-agent/.gemini/commands >/dev/null; then
  rg -n 'manual design-system comps|another explicitly approved source|manual-design|local-approved|approved design assets or cut assets|no bitmap cut assets|bitmap cut assets are needed|as approved design assets or cut assets' dev-agent/.claude/commands dev-agent/.gemini/commands >&2
  echo "Adapter command drift: stale design-source or cut-asset rules found." >&2
  exit 1
fi
if rg -n 'No bitmap cut assets required' bin/dev-flow dev-agent/templates >/dev/null; then
  rg -n 'No bitmap cut assets required' bin/dev-flow dev-agent/templates >&2
  echo "Stale cut-asset opt-out wording found." >&2
  exit 1
fi
grep -q 'Satisfy `dev-agent/references/design-artifacts.md`' AGENTS.md
grep -q 'Satisfy `dev-agent/references/design-artifacts.md`' DEV_FLOW.md
grep -q 'Satisfy `dev-agent/references/design-artifacts.md`' dev-agent/commands/design.md
grep -q 'Satisfy `dev-agent/references/design-artifacts.md`' dev-agent/skills/design-flow/SKILL.md
grep -q 'Satisfy `dev-agent/references/design-artifacts.md`' dev-agent/skills/frontend-ui-engineering/SKILL.md
grep -q 'Satisfy `dev-agent/references/design-artifacts.md`' dev-agent/templates/project/design-artifacts.md
grep -q 'satisfy `dev-agent/references/figma-handoff.md`' dev-agent/commands/design.md
grep -q 'satisfy `dev-agent/references/figma-handoff.md`' dev-agent/skills/design-flow/SKILL.md
grep -q 'dev-agent/references/figma-handoff.md' dev-agent/templates/project/figma-handoff.md
if rg -n 'Valid Source type values|Allowed `Source type`|manual-design|local-approved|SVG/XML sketches|SVG files may|Browser, Playwright|browser/simulator/runtime screenshots|semantic HTML companion|HTML companions|imagegen/GPT Image high-fidelity|formal producers|designer-upload|uploaded-approved|external-design|Figma frames created from those captures|Source type` set to `figma`|Keep SVG|SVG files under' AGENTS.md DEV_FLOW.md README.md dev-agent/commands dev-agent/.claude/commands dev-agent/.gemini/commands dev-agent/skills dev-agent/agents dev-agent/templates/project >/dev/null; then
  rg -n 'Valid Source type values|Allowed `Source type`|manual-design|local-approved|SVG/XML sketches|SVG files may|Browser, Playwright|browser/simulator/runtime screenshots|semantic HTML companion|HTML companions|imagegen/GPT Image high-fidelity|formal producers|designer-upload|uploaded-approved|external-design|Figma frames created from those captures|Source type` set to `figma`|Keep SVG|SVG files under' AGENTS.md DEV_FLOW.md README.md dev-agent/commands dev-agent/.claude/commands dev-agent/.gemini/commands dev-agent/skills dev-agent/agents dev-agent/templates/project >&2
  echo "Design contract drift: non-authoritative files must point to references and gates instead of restating hard source rules." >&2
  exit 1
fi
if rg -n 'artifact contract|approved asset|approved design|Figma|SVG|HTML companion|DESIGN_ARTIFACTS|FIGMA_HANDOFF|ASSET_MANIFEST|design-artifacts' dev-agent/agents/product-designer.md >/dev/null; then
  rg -n 'artifact contract|approved asset|approved design|Figma|SVG|HTML companion|DESIGN_ARTIFACTS|FIGMA_HANDOFF|ASSET_MANIFEST|design-artifacts' dev-agent/agents/product-designer.md >&2
  echo "product-designer must stay a design-judgment persona, not an artifact schema contract." >&2
  exit 1
fi
assert_max_lines dev-agent/skills/design-flow/SKILL.md 180
assert_max_lines dev-agent/skills/frontend-ui-engineering/SKILL.md 280
assert_max_lines dev-agent/commands/design.md 20
assert_max_lines dev-agent/commands/build.md 20
assert_max_lines dev-agent/commands/ui.md 20
assert_max_lines dev-agent/agents/product-designer.md 30

bin/dev-flow init "$(basename "$API_PROJECT")" --type api >/dev/null
grep -q 'PROJECT_SCHEMA_VERSION="4"' "$API_PROJECT/.dev-flow/schema.env"
grep -q 'PROJECT_TYPE="api"' "$API_PROJECT/.dev-flow/schema.env"
grep -q 'UI_FLOW="disabled"' "$API_PROJECT/.dev-flow/applicability.env"
grep -q 'UI_DESIGN_ASSETS="disabled"' "$API_PROJECT/.dev-flow/applicability.env"
grep -q 'AGENT_CONTRACT="auto"' "$API_PROJECT/.dev-flow/applicability.env"
grep -q 'SHIP_FLOW="auto"' "$API_PROJECT/.dev-flow/applicability.env"
! test -f "$API_PROJECT/tasks/PDCA.md"
write_file "$API_PROJECT/ideas/idea-brief.md" \
  "# Idea Brief" "" "Build a JSON API." "No customer-facing UI is in scope." "The workflow should not require design assets."
write_file "$API_PROJECT/product/PRD.md" \
  "# PRD" "" "Build a JSON API." "MVP scope is one small HTTP API." "No customer-facing UI is in scope."
write_file "$API_PROJECT/specs/SPEC.md" \
  "# Spec" "" "Create a small HTTP API." "Implementation will live under apps/api." "UI design is out of scope."
bin/dev-flow phase "$(basename "$API_PROJECT")" build "Build API implementation without UI design" >"$API_OUT" 2>&1
grep -q "Updated $(basename "$API_PROJECT") to phase: build" "$API_OUT"

bin/dev-flow init "$(basename "$AGENT_PROJECT")" --type agent >/dev/null
grep -q 'AGENT_CONTRACT="required"' "$AGENT_PROJECT/.dev-flow/applicability.env"
write_file "$AGENT_PROJECT/ideas/idea-brief.md" \
  "# Idea Brief" "" "Build an agent automation." "The automation needs safe tool use and explicit escalation."
write_file "$AGENT_PROJECT/product/PRD.md" \
  "# PRD" "" "Build an agent automation." "MVP scope is one workflow with clear human approval points." "The output must fail closed on unclear tools or permissions."
write_file "$AGENT_PROJECT/specs/SPEC.md" \
  "# Spec" "" "Build an agent automation." "## Agent Runtime Contract" "Job: process the requested workflow." "Tools and permissions: read project files; ask before external writes." "Failure recovery and escalation: record blockers and ask the user when the tool or permission boundary is unclear."
bin/dev-flow verify-phase "$(basename "$AGENT_PROJECT")" spec >"$AGENT_OUT" 2>&1

bin/dev-flow init "$(basename "$ENV_PROJECT")" --type api >/dev/null
test -f "$ENV_PROJECT/.dev-flow/HOST_REQUIREMENTS.md"
bin/dev-flow env-check "$(basename "$ENV_PROJECT")" >"$ENV_OUT" 2>&1
grep -q "Host environment check passed" "$ENV_OUT"

bin/dev-flow init "$(basename "$BAD_ENV")" --type api >/dev/null
write_file "$BAD_ENV/.dev-flow/HOST_REQUIREMENTS.md" \
  "# Host Requirements: $(basename "$BAD_ENV")" "" \
  "## Requirements" "" \
  "| Capability | Scope | Required by | Verify command | Required | Permission | Status | Notes |" \
  "|---|---|---|---|---|---|---|---|" \
  "| Android SDK | work/project | Android release build | adb version | yes | user install | missing | Must be installed on host, not under work. |"
if bin/dev-flow env-check "$(basename "$BAD_ENV")" >"$BAD_ENV_OUT" 2>&1; then
  cat "$BAD_ENV_OUT" >&2
  echo "Expected missing host SDK requirement to fail env-check." >&2
  exit 1
fi
grep -q "Invalid host requirement scope" "$BAD_ENV_OUT"
grep -q "Blocked host requirement: Android SDK" "$BAD_ENV_OUT"

bin/dev-flow init "$(basename "$LEGACY_PROJECT")" --type api >/dev/null
rm -f "$LEGACY_PROJECT/.dev-flow/schema.env" "$LEGACY_PROJECT/.dev-flow/HOST_REQUIREMENTS.md" "$LEGACY_PROJECT/tasks/IMPLEMENTATION_TRACE.md"
if bin/dev-flow doctor "$(basename "$LEGACY_PROJECT")" >"$DOCTOR_OUT" 2>&1; then
  cat "$DOCTOR_OUT" >&2
  echo "Expected doctor to fail on missing schema and implementation trace." >&2
  exit 1
fi
grep -q "Missing schema" "$DOCTOR_OUT"
grep -q "Missing template file: .dev-flow/HOST_REQUIREMENTS.md" "$DOCTOR_OUT"
grep -q "Missing template file: tasks/IMPLEMENTATION_TRACE.md" "$DOCTOR_OUT"
bin/dev-flow migrate "$(basename "$LEGACY_PROJECT")" --type api >/dev/null
bin/dev-flow doctor "$(basename "$LEGACY_PROJECT")" >/dev/null
grep -q 'PROJECT_SCHEMA_VERSION="4"' "$LEGACY_PROJECT/.dev-flow/schema.env"
grep -q 'PROJECT_TYPE="api"' "$LEGACY_PROJECT/.dev-flow/schema.env"
test -f "$LEGACY_PROJECT/.dev-flow/HOST_REQUIREMENTS.md"
! test -f "$LEGACY_PROJECT/tasks/PDCA.md"

bin/dev-flow init "$(basename "$UI_BLOCK")" >/dev/null
grep -q 'PROJECT_SCHEMA_VERSION="4"' "$UI_BLOCK/.dev-flow/schema.env"
grep -q 'PROJECT_TYPE="ui"' "$UI_BLOCK/.dev-flow/schema.env"
grep -q 'AGENT_CONTRACT="auto"' "$UI_BLOCK/.dev-flow/applicability.env"
grep -q 'UI_FLOW="required"' "$UI_BLOCK/.dev-flow/applicability.env"
grep -q 'UI_DESIGN_ASSETS="auto"' "$UI_BLOCK/.dev-flow/applicability.env"
grep -q 'SHIP_FLOW="auto"' "$UI_BLOCK/.dev-flow/applicability.env"
bin/dev-flow phase "$(basename "$UI_BLOCK")" design "Prepare design execution brief" --force >/dev/null
bin/dev-flow next "$(basename "$UI_BLOCK")" >"$NEXT_UI_OUT"
grep -q "Type: ui" "$NEXT_UI_OUT"
grep -q "Execution navigator: follow this brief" "$NEXT_UI_OUT"
grep -q "Next command: Use local flow: design" "$NEXT_UI_OUT"
grep -q "Load:" "$NEXT_UI_OUT"
grep -q "dev-agent/commands/design.md" "$NEXT_UI_OUT"
grep -q "dev-agent/skills/design-flow/SKILL.md" "$NEXT_UI_OUT"
grep -q "product/PRD.md" "$NEXT_UI_OUT"
grep -q "Required outputs:" "$NEXT_UI_OUT"
grep -q "design/DESIGN.md" "$NEXT_UI_OUT"
grep -q "Requirement source" "$NEXT_UI_OUT"
grep -q "Gate before next phase:" "$NEXT_UI_OUT"
grep -q "bin/dev-flow design-check $(basename "$UI_BLOCK")" "$NEXT_UI_OUT"
grep -q "After pass:" "$NEXT_UI_OUT"
write_file "$UI_BLOCK/ideas/idea-brief.md" \
  "# Idea Brief" \
  "" \
  "Build a customer-facing dashboard app." \
  "The UI must be polished and responsive." \
  "The workflow must block build before design exists."
write_file "$UI_BLOCK/product/PRD.md" \
  "# PRD" "" "Build a customer-facing dashboard app." "The product must feel trustworthy." "Build must wait for design."
write_file "$UI_BLOCK/product/USER_STORIES.md" \
  "# User Stories" "" "- As a user, I can understand my dashboard quickly." "- As a user, I can recover from empty states." "- As a user, I can act from the primary CTA."
write_file "$UI_BLOCK/product/ACCEPTANCE.md" \
  "# Acceptance" "" "- Dashboard requirements are documented." "- Empty states are documented." "- Design is required before build."
write_file "$UI_BLOCK/product/METRICS.md" \
  "# Metrics" "" "- Activation success." "- Primary action completion." "- Visual readiness gate pass rate."
write_file "$UI_BLOCK/specs/SPEC.md" \
  "# Spec" \
  "" \
  "Create a browser dashboard with navigation, cards, and empty state." \
  "Implementation will live under apps/web." \
  "The workflow should require design and approved design assets first."
if bin/dev-flow phase "$(basename "$UI_BLOCK")" build "Attempt build without design" >"$UI_BLOCK_OUT" 2>&1; then
  cat "$UI_BLOCK_OUT" >&2
  echo "Expected UI project build to fail before design." >&2
  exit 1
fi
grep -q "Phase verification failed: $(basename "$UI_BLOCK")/design" "$UI_BLOCK_OUT"

bin/dev-flow init "$(basename "$LIGHT_UI")" >/dev/null
write_file "$LIGHT_UI/ideas/idea-brief.md" \
  "# Idea Brief" "" "Build a simple customer-facing status page." "Use delegated visual direction." "Formal design boards are not required for this fixture."
write_file "$LIGHT_UI/product/PRD.md" \
  "# PRD" "" "Build a compact status page." "MVP scope is one page with an empty state." "No visual QA or formal asset handoff is required."
write_file "$LIGHT_UI/specs/SPEC.md" \
  "# Spec" "" "Create a static status page under apps/web." "Use DESIGN.md, VISUAL_SYSTEM.md, and SCREEN_ACCEPTANCE.md." "Formal assets may be none."
write_file "$LIGHT_UI/design/DESIGN.md" \
  "# Design" "" "## UX Problem" "Users need a clear status page." "## Recommended Direction" "Use a simple one-page layout." "## Alternatives Considered" "- Full dashboard: too much." "## Information Architecture" "Status page only." "## Interaction Model" "Read status and use one action." "## Visual System" "Neutral product surface." "## Design Artifacts" "No formal assets required for this lightweight scope." "## Build Implications" "Build from acceptance and visual system."
write_file "$LIGHT_UI/design/VISUAL_SYSTEM.md" \
  "# Visual System" "" "## Reference Influence" "Delegated visual direction." "## Palette" "Neutral surfaces with one action color." "## Typography" "Readable product scale." "## Spacing and Layout" "Simple responsive stack." "## Components and Motion" "Button and status badge states." "## Forbidden Patterns" "No generic gradients."
write_file "$LIGHT_UI/design/SCREEN_ACCEPTANCE.md" \
  "# Screen Acceptance" "" "## Status" "- Requirement source: specs/SPEC.md." "- Required content: title, status badge, empty-state copy, primary action." "- Required states: default, empty, loading, error." "- Breakpoints: 320, 768, 1440." "- Design assets / visual source: none; implement from DESIGN.md and VISUAL_SYSTEM.md." "- Visual acceptance: clear hierarchy and responsive spacing." "- Accessibility acceptance: primary action keyboard reachable."
write_file "$LIGHT_UI/design/REFERENCE_BOARD.md" \
  "# Reference Board" "" "## Delegated Direction" "Use a quiet product utility style." "## Patterns" "- Compact hierarchy." "- One obvious action."
bin/dev-flow design-check "$(basename "$LIGHT_UI")" --allow-no-reference >/dev/null
write_file "$LIGHT_UI/tasks/IMPLEMENTATION_TRACE.md" \
  "# Implementation Trace" "" "## Screen Trace" "| Screen | State | Implementation target | Approved asset | Design source | HTML companion | Cut assets | Test evidence | Status |" "|---|---|---|---|---|---|---|---|---|" "| Status | Default | apps/web/index.html | none | none | none | none | reviews/VERIFICATION.md | implemented |"
write_file "$LIGHT_UI/apps/web/index.html" \
  "<!doctype html>" \
  "<html lang=\"en\"><head><meta charset=\"utf-8\"><title>Status</title></head><body><main><h1>Status</h1><button>Refresh</button></main></body></html>"
write_file "$LIGHT_UI/reviews/VERIFICATION.md" \
  "# Verification" "" "## Result" "Static status page source exists." "Lightweight UI build does not require formal design assets."
bin/dev-flow phase "$(basename "$LIGHT_UI")" build "Implement lightweight UI without formal assets" >/dev/null
bin/dev-flow verify-phase "$(basename "$LIGHT_UI")" build >/dev/null
bin/dev-flow next "$(basename "$LIGHT_UI")" >"$LIGHT_UI_NEXT_OUT"
grep -q "Workflow is at the final applicable phase" "$LIGHT_UI_NEXT_OUT"

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
  "# Screen Acceptance" "" "## Dashboard" "- Requirement source: specs/SPEC.md." "- Required content: dashboard body." "- Required states: default." "- Breakpoints: 320, 768, 1440." "- Required design assets: design/approved/dashboard.png." "- Visual acceptance: follows the board." "- Accessibility acceptance: primary action reachable."
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
  "# Screen Acceptance" "" "## Dashboard" "- Requirement source: specs/SPEC.md." "- Required content: dashboard body." "- Required states: default." "- Breakpoints: 320, 768, 1440." "- Required design assets: design/approved/dashboard.svg." "- Visual acceptance: follows the final board." "- Accessibility acceptance: primary action reachable."
write_file "$SVG_ONLY/design/DESIGN_ARTIFACTS.md" \
  "# Design Artifacts" "" "## Required Coverage" "- Dashboard board." "## Screen Coverage" "| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |" "|---|---|---|---|---|---|---|---|" "| Dashboard | Default | manual-design | manual://svg-draft | design/approved/dashboard.svg | svg draft | approved | Structure draft only |"
write_valid_svg "$SVG_ONLY/design/approved/dashboard.svg"
if bin/dev-flow design-check "$(basename "$SVG_ONLY")" --allow-no-reference >"$SVG_ONLY_OUT" 2>&1; then
  cat "$SVG_ONLY_OUT" >&2
  echo "Expected SVG-only approved design artifact to fail." >&2
  exit 1
fi
grep -q "Missing final approved design asset" "$SVG_ONLY_OUT"

bin/dev-flow init "$(basename "$SVG_LEAK")" >/dev/null
write_file "$SVG_LEAK/ideas/idea-brief.md" \
  "# Idea Brief" "" "Build a UI." "Use delegated visual direction." "Audit SVG files leaking into implementation-ready design folders."
write_file "$SVG_LEAK/specs/SPEC.md" \
  "# Spec" "" "Create a UI." "Require raster approved boards and a manifested SVG element asset." "This is an audit fixture."
write_file "$SVG_LEAK/design/DESIGN.md" \
  "# Design" "" "## UX Problem" "Users need a polished interface." "## Recommended Direction" "Use a focused dashboard." "## Alternatives Considered" "- SVG sketch: too weak as a final artifact." "## Information Architecture" "Dashboard only." "## Interaction Model" "Primary action only." "## Visual System" "Neutral product surface." "## Design Artifacts" "Approved design asset required." "## Build Implications" "Build from final raster board and manifested SVG element assets."
write_file "$SVG_LEAK/design/VISUAL_SYSTEM.md" \
  "# Visual System" "" "## Reference Influence" "Delegated visual direction." "## Palette" "Use neutral surfaces." "## Typography" "Readable product scale." "## Spacing and Layout" "Dense but clear." "## Components and Motion" "Buttons have visible states." "## Forbidden Patterns" "No SVG sketches as final design assets."
write_file "$SVG_LEAK/design/SCREEN_ACCEPTANCE.md" \
  "# Screen Acceptance" "" "## Dashboard" "- Requirement source: specs/SPEC.md." "- Required content: dashboard body." "- Required states: default." "- Breakpoints: 320, 768, 1440." "- Required design assets: design/approved/dashboard.png." "- Visual acceptance: follows the final raster board." "- Accessibility acceptance: primary action reachable."
write_file "$SVG_LEAK/design/DESIGN_ARTIFACTS.md" \
  "# Design Artifacts" "" "## Required Coverage" "- Dashboard board." "## Screen Coverage" "| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |" "|---|---|---|---|---|---|---|---|" "| Dashboard | Default | designer-upload | upload://smoke/dashboard-final | design/approved/dashboard.png | 1440x900 png | approved | Use as visual target |"
write_valid_png "$SVG_LEAK/design/approved/dashboard.png"
write_valid_svg "$SVG_LEAK/design/approved/wireframe.svg"
write_valid_svg "$SVG_LEAK/design/cut-assets/primary-icon.svg"
write_file "$SVG_LEAK/design/cut-assets/ASSET_MANIFEST.md" \
  "# Cut Assets" "" "## Decision" "- CUT_ASSETS_REQUIRED: yes" "" "## Asset Manifest" "| Asset | Source approved asset | Source region / frame | Output path | Format | Alpha | Runtime path | Usage | Notes |" "|---|---|---|---|---|---|---|---|---|" "| Primary icon | design/approved/dashboard.png | x=24 y=24 w=96 h=96 | design/cut-assets/primary-icon.svg | SVG | no | apps/web/assets/primary-icon.svg | Primary action icon | SVG cut asset is allowed; failure should come from design/approved/wireframe.svg |"
if bin/dev-flow asset-check "$(basename "$SVG_LEAK")" >"$SVG_LEAK_OUT" 2>&1; then
  cat "$SVG_LEAK_OUT" >&2
  echo "Expected SVG file under design/approved to fail." >&2
  exit 1
fi
grep -q "Forbidden SVG/XML file under design/approved" "$SVG_LEAK_OUT"

bin/dev-flow init "$(basename "$SVG_CUT_ALLOWED")" >/dev/null
write_file "$SVG_CUT_ALLOWED/ideas/idea-brief.md" \
  "# Idea Brief" "" "Build a UI." "Use delegated visual direction." "Allow SVG element assets while keeping SVG out of approved design boards."
write_file "$SVG_CUT_ALLOWED/specs/SPEC.md" \
  "# Spec" "" "Create a UI." "Use a formal approved board and an SVG runtime icon derived from it." "This is an audit fixture."
write_file "$SVG_CUT_ALLOWED/design/DESIGN.md" \
  "# Design" "" "## UX Problem" "Users need a polished interface." "## Recommended Direction" "Use a designer-uploaded board and a derived SVG icon asset." "## Alternatives Considered" "- SVG board as reference: forbidden." "## Information Architecture" "Dashboard only." "## Interaction Model" "Primary action only." "## Visual System" "Neutral product surface." "## Design Artifacts" "Approved raster board plus SVG element asset." "## Build Implications" "Build layout from the raster board; use the SVG only as an element asset."
write_file "$SVG_CUT_ALLOWED/design/VISUAL_SYSTEM.md" \
  "# Visual System" "" "## Reference Influence" "Delegated visual direction." "## Palette" "Use neutral surfaces." "## Typography" "Readable product scale." "## Spacing and Layout" "Dense but clear." "## Components and Motion" "Buttons have visible states." "## Forbidden Patterns" "No SVG screen reference or screenshot-as-design."
write_file "$SVG_CUT_ALLOWED/design/SCREEN_ACCEPTANCE.md" \
  "# Screen Acceptance" "" "## Dashboard" "- Requirement source: specs/SPEC.md." "- Required content: dashboard body." "- Required states: default." "- Breakpoints: 320, 768, 1440." "- Required design assets: design/approved/dashboard.png." "- Visual acceptance: follows the approved raster board." "- Accessibility acceptance: primary action reachable."
write_file "$SVG_CUT_ALLOWED/design/DESIGN_ARTIFACTS.md" \
  "# Design Artifacts" "" "## Required Coverage" "- Dashboard board." "## Screen Coverage" "| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |" "|---|---|---|---|---|---|---|---|" "| Dashboard | Default | designer-upload | upload://smoke/dashboard-final | design/approved/dashboard.png | 1440x900 png | approved | Use as layout and visual target |"
write_file "$SVG_CUT_ALLOWED/design/REFERENCE_BOARD.md" \
  "# Reference Board" "" "## Delegated Direction" "Use a formal raster board for screen layout." "## Patterns" "- SVG is allowed only as a derived element asset." "- Runtime icon path is recorded in cut asset manifest."
write_file "$SVG_CUT_ALLOWED/design/cut-assets/ASSET_MANIFEST.md" \
  "# Cut Assets" "" "## Decision" "- CUT_ASSETS_REQUIRED: yes" "" "## Asset Manifest" "| Asset | Source approved asset | Source region / frame | Output path | Format | Alpha | Runtime path | Usage | Notes |" "|---|---|---|---|---|---|---|---|---|" "| Primary icon | design/approved/dashboard.png | icon mark from approved board | design/cut-assets/primary-icon.svg | SVG | yes | apps/web/assets/primary-icon.svg | Primary action icon | SVG element asset only; not a layout reference |"
write_valid_png "$SVG_CUT_ALLOWED/design/approved/dashboard.png"
write_valid_svg "$SVG_CUT_ALLOWED/design/cut-assets/primary-icon.svg"
bin/dev-flow asset-check "$(basename "$SVG_CUT_ALLOWED")" >"$SVG_CUT_ALLOWED_OUT" 2>&1
bin/dev-flow design-check "$(basename "$SVG_CUT_ALLOWED")" --allow-no-reference >/dev/null

bin/dev-flow init "$(basename "$SELF_RENDERED_PNG")" >/dev/null
write_file "$SELF_RENDERED_PNG/ideas/idea-brief.md" \
  "# Idea Brief" "" "Build a UI." "Use delegated visual direction." "Audit a self-rendered SVG screenshot renamed as a final PNG."
write_file "$SELF_RENDERED_PNG/specs/SPEC.md" \
  "# Spec" "" "Create a UI." "Require a real formal design producer." "This is an audit fixture."
write_file "$SELF_RENDERED_PNG/design/DESIGN.md" \
  "# Design" "" "## UX Problem" "Users need a polished interface." "## Recommended Direction" "Use a formal provider output." "## Alternatives Considered" "- Self-rendered SVG screenshot: not a formal design asset." "## Information Architecture" "Dashboard only." "## Interaction Model" "Primary action only." "## Visual System" "Neutral product surface." "## Design Artifacts" "Approved asset required." "## Build Implications" "Build from a formal provider asset only."
write_file "$SELF_RENDERED_PNG/design/VISUAL_SYSTEM.md" \
  "# Visual System" "" "## Reference Influence" "Delegated visual direction." "## Palette" "Use neutral surfaces." "## Typography" "Readable product scale." "## Spacing and Layout" "Dense but clear." "## Components and Motion" "Buttons have visible states." "## Forbidden Patterns" "No self-rendered SVG screenshots as final design assets."
write_file "$SELF_RENDERED_PNG/design/SCREEN_ACCEPTANCE.md" \
  "# Screen Acceptance" "" "## Dashboard" "- Requirement source: specs/SPEC.md." "- Required content: dashboard body." "- Required states: default." "- Breakpoints: 320, 768, 1440." "- Required design assets: design/approved/dashboard.png." "- Visual acceptance: follows a formal design producer output." "- Accessibility acceptance: primary action reachable."
write_file "$SELF_RENDERED_PNG/design/DESIGN_ARTIFACTS.md" \
  "# Design Artifacts" "" "## Required Coverage" "- Dashboard board." "## Screen Coverage" "| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |" "|---|---|---|---|---|---|---|---|" "| Dashboard | Default | local-approved | local-render://svg-wireframe-to-png | design/approved/dashboard.png | 1440x900 png | approved | Should fail because this is a self-rendered SVG/HTML screenshot renamed as PNG |"
write_file "$SELF_RENDERED_PNG/design/REFERENCE_BOARD.md" \
  "# Reference Board" "" "## Delegated Direction" "Use a formal provider output, not a self-rendered SVG/HTML screenshot." "## Patterns" "- Provider provenance must be explicit." "- Runtime captures are QA evidence only."
write_file "$SELF_RENDERED_PNG/design/cut-assets/ASSET_MANIFEST.md" \
  "# Cut Assets" "" "## Decision" "- CUT_ASSETS_REQUIRED: no" "- Rationale: fixture uses CSS and platform icons only."
write_valid_png "$SELF_RENDERED_PNG/design/approved/dashboard.png"
if bin/dev-flow design-check "$(basename "$SELF_RENDERED_PNG")" --allow-no-reference >"$SELF_RENDERED_PNG_OUT" 2>&1; then
  cat "$SELF_RENDERED_PNG_OUT" >&2
  echo "Expected self-rendered SVG/HTML screenshot PNG provenance to fail." >&2
  exit 1
fi
grep -q "Invalid formal design source" "$SELF_RENDERED_PNG_OUT"

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
  "# Screen Acceptance" "" "## Dashboard" "- Requirement source: specs/SPEC.md." "- Required content: dashboard body." "- Required states: default." "- Breakpoints: 320, 768, 1440." "- Required design assets: design/approved/dashboard.png." "- Visual acceptance: follows the board." "- Accessibility acceptance: primary action reachable." "" "## Settings" "- Requirement source: specs/SPEC.md." "- Required content: settings controls." "- Required states: default." "- Breakpoints: 320, 768, 1440." "- Required design assets: design/approved/settings.png." "- Visual acceptance: follows the board." "- Accessibility acceptance: controls reachable."
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
  "# Screen Acceptance" "" "## Dashboard" "- Requirement source: specs/SPEC.md." "- Required content: dashboard body." "- Required states: default." "- Breakpoints: 320, 768, 1440." "- Required design assets: design/approved/dashboard.png." "- Visual acceptance: follows the board." "- Accessibility acceptance: primary action reachable."
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
  "# Screen Acceptance" "" "## Dashboard" "- Requirement source: specs/SPEC.md." "- Required content: dashboard body." "- Required states: default." "- Breakpoints: 320, 768, 1440." "- Required design assets: design/approved/dashboard.png." "- Visual acceptance: follows the board." "- Accessibility acceptance: primary action reachable."
write_file "$DRAFT_PATH/design/DESIGN_ARTIFACTS.md" \
  "# Design Artifacts" "" "## Required Coverage" "- Dashboard board." "## Screen Coverage" "| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |" "|---|---|---|---|---|---|---|---|" "| Dashboard | Default | designer-upload | upload://smoke/draft-dashboard | design/drafts/dashboard.png | 1440x900 png | approved | Should fail because approved asset path points to drafts |"
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
  "# Spec" "" "Create a dashboard UI." "Use approved design assets." "No cut assets are needed."
write_file "$NO_CUTS/design/DESIGN.md" \
  "# Design" "" "## UX Problem" "Users need a polished interface." "## Recommended Direction" "Use a focused dashboard with system icons." "## Alternatives Considered" "- Custom bitmap icons: unnecessary for this fixture." "## Information Architecture" "Dashboard only." "## Interaction Model" "Primary action only." "## Visual System" "Neutral product surface." "## Design Artifacts" "Approved asset required." "## Build Implications" "Build from verified design artifact contract."
write_file "$NO_CUTS/design/VISUAL_SYSTEM.md" \
  "# Visual System" "" "## Reference Influence" "Delegated visual direction." "## Palette" "Use neutral surfaces." "## Typography" "Readable product scale." "## Spacing and Layout" "Dense but clear." "## Components and Motion" "Buttons have visible states." "## Forbidden Patterns" "No generic AI gradients."
write_file "$NO_CUTS/design/SCREEN_ACCEPTANCE.md" \
  "# Screen Acceptance" "" "## Dashboard" "- Requirement source: specs/SPEC.md." "- Required content: dashboard body." "- Required states: default." "- Breakpoints: 320, 768, 1440." "- Required design assets: design/approved/dashboard.png." "- Visual acceptance: follows the board." "- Accessibility acceptance: primary action reachable."
write_file "$NO_CUTS/design/DESIGN_ARTIFACTS.md" \
  "# Design Artifacts" "" "## Required Coverage" "- Dashboard board." "## Screen Coverage" "| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |" "|---|---|---|---|---|---|---|---|" "| Dashboard | Default | designer-upload | upload://smoke/no-cuts-dashboard | design/approved/dashboard.png | 1440x900 png | approved | Use as visual target |"
write_file "$NO_CUTS/design/REFERENCE_BOARD.md" \
  "# Reference Board" "" "## Delegated Direction" "Use a focused product dashboard with neutral surfaces." "## Patterns" "- Clear hierarchy." "- System icons only."
write_file "$NO_CUTS/design/cut-assets/ASSET_MANIFEST.md" \
  "# Cut Assets" "" "## Decision" "- CUT_ASSETS_REQUIRED: no" "- Rationale: this fixture uses CSS and platform icons only." "" "## Recommended Later" "| Idea | Future path | Notes |" "|---|---|---|" "| Optional badge | design/cut-assets/future-badge.svg | Future backlog only; not required for current gate. |"
write_valid_png "$NO_CUTS/design/approved/dashboard.png"
bin/dev-flow design-check "$(basename "$NO_CUTS")" --allow-no-reference >/dev/null
bin/dev-flow asset-check "$(basename "$NO_CUTS")" >/dev/null

bin/dev-flow init "$(basename "$AI_MISSING_HTML")" >/dev/null
write_file "$AI_MISSING_HTML/design/SCREEN_ACCEPTANCE.md" \
  "# Screen Acceptance" "" "## Dashboard" "- Requirement source: specs/SPEC.md." "- Required content: dashboard body." "- Required states: default." "- Breakpoints: 320, 768, 1440." "- Required design assets: design/approved/dashboard.png." "- Visual acceptance: follows the generated board." "- Accessibility acceptance: primary action reachable."
write_file "$AI_MISSING_HTML/design/DESIGN_ARTIFACTS.md" \
  "# Design Artifacts" "" "## Required Coverage" "- Dashboard board." "## Screen Coverage" "| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |" "|---|---|---|---|---|---|---|---|" "| Dashboard | Default | imagegen | imagegen://smoke/dashboard | design/approved/dashboard.png | 1440x900 png | approved | Missing HTML companion should fail |"
write_file "$AI_MISSING_HTML/design/cut-assets/ASSET_MANIFEST.md" \
  "# Cut Assets" "" "## Decision" "- CUT_ASSETS_REQUIRED: no" "- Rationale: fixture uses CSS and platform icons only."
write_valid_png "$AI_MISSING_HTML/design/approved/dashboard.png"
if bin/dev-flow asset-check "$(basename "$AI_MISSING_HTML")" >"$AI_MISSING_HTML_OUT" 2>&1; then
  cat "$AI_MISSING_HTML_OUT" >&2
  echo "Expected missing AI design HTML description to fail." >&2
  exit 1
fi
grep -q "Missing AI design HTML description for screen: Dashboard" "$AI_MISSING_HTML_OUT"

bin/dev-flow init "$(basename "$FIGMA_GOOD")" >/dev/null
test -f "$FIGMA_GOOD/design/FIGMA_HANDOFF.md"
grep -q 'UI_FIGMA_HANDOFF="auto"' "$FIGMA_GOOD/.dev-flow/applicability.env"
write_file "$FIGMA_GOOD/ideas/idea-brief.md" \
  "# Idea Brief" "" "Build a UI using a Figma formalized design." "Use delegated visual direction." "Verify the Figma handoff contract."
write_file "$FIGMA_GOOD/specs/SPEC.md" \
  "# Spec" "" "Create a dashboard UI." "Use Figma frames as approved design source." "Export approved assets before implementation."
write_file "$FIGMA_GOOD/design/DESIGN.md" \
  "# Design" "" "## UX Problem" "Users need a polished interface." "## Recommended Direction" "Formalize the imagegen direction in Figma." "## Alternatives Considered" "- Raw imagegen only: harder to maintain." "## Information Architecture" "Dashboard only." "## Interaction Model" "Primary action only." "## Visual System" "Neutral product surface." "## Design Artifacts" "Figma frame export required." "## Build Implications" "Build from Figma-approved export."
write_file "$FIGMA_GOOD/design/VISUAL_SYSTEM.md" \
  "# Visual System" "" "## Reference Influence" "Delegated visual direction formalized in Figma." "## Palette" "Use neutral surfaces." "## Typography" "Readable product scale." "## Spacing and Layout" "Dense but clear." "## Components and Motion" "Buttons have visible states." "## Forbidden Patterns" "No generic AI gradients."
write_file "$FIGMA_GOOD/design/SCREEN_ACCEPTANCE.md" \
  "# Screen Acceptance" "" "## Dashboard" "- Requirement source: specs/SPEC.md." "- Required content: dashboard body." "- Required states: default." "- Breakpoints: 320, 768, 1440." "- Required design assets: design/approved/screens/dashboard.png." "- Visual acceptance: follows the Figma export." "- Accessibility acceptance: primary action reachable."
write_file "$FIGMA_GOOD/design/DESIGN_ARTIFACTS.md" \
  "# Design Artifacts" "" "## Required Coverage" "- Dashboard board." "## Screen Coverage" "| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |" "|---|---|---|---|---|---|---|---|" "| Dashboard | Default | figma-mcp | figma://smoke/file/dashboard-node | design/approved/screens/dashboard.png | Figma frame 1440x900 export @1x PNG | approved | Use as visual target |"
write_file "$FIGMA_GOOD/design/REFERENCE_BOARD.md" \
  "# Reference Board" "" "## Delegated Direction" "Use a Figma-formalized dashboard with neutral surfaces." "## Patterns" "- Clear hierarchy." "- Reusable component direction."
write_file "$FIGMA_GOOD/design/FIGMA_HANDOFF.md" \
  "# Figma Handoff" "" "## Decision" "- FIGMA_HANDOFF_REQUIRED: yes" "- Flow: imagegen exploration to Figma screen frame to approved export." "" "## Figma Sources" "| Screen | Figma source | Approved export | Role | Status | Notes |" "|---|---|---|---|---|---|" "| Dashboard | figma://smoke/file/dashboard-node | design/approved/screens/dashboard.png | screen-frame | approved | Formalized from imagegen direction |"
write_file "$FIGMA_GOOD/design/cut-assets/ASSET_MANIFEST.md" \
  "# Cut Assets" "" "## Decision" "- CUT_ASSETS_REQUIRED: no" "- Rationale: this fixture uses CSS and platform icons only."
write_valid_png "$FIGMA_GOOD/design/approved/screens/dashboard.png"
bin/dev-flow figma-check "$(basename "$FIGMA_GOOD")" >/dev/null
bin/dev-flow design-check "$(basename "$FIGMA_GOOD")" --allow-no-reference >/dev/null

cp -R "$FIGMA_GOOD" "$FIGMA_SECTION_BOUNDARY"
write_file "$FIGMA_SECTION_BOUNDARY/design/DESIGN_ARTIFACTS.md" \
  "# Design Artifacts" "" "## Required Coverage" "- Dashboard board." "## Screen Coverage" "| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |" "|---|---|---|---|---|---|---|---|" "| Dashboard | Default | designer-upload | upload://smoke/section-boundary | design/approved/screens/dashboard.png | 1440x900 png | approved | Use as visual target |" "" "## Figma Notes" "| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |" "|---|---|---|---|---|---|---|---|" "| Not Coverage | Default | figma | - | design/screenshots/not-coverage.png | - | draft | Should be ignored outside Screen Coverage |"
bin/dev-flow figma-check "$(basename "$FIGMA_SECTION_BOUNDARY")" >/dev/null

cp -R "$FIGMA_GOOD" "$FIGMA_MISSING_SOURCE"
write_file "$FIGMA_MISSING_SOURCE/design/DESIGN_ARTIFACTS.md" \
  "# Design Artifacts" "" "## Required Coverage" "- Dashboard board." "## Screen Coverage" "| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |" "|---|---|---|---|---|---|---|---|" "| Dashboard | Default | figma | - | design/approved/screens/dashboard.png | Figma frame 1440x900 export @1x PNG | approved | Missing Figma source should fail |"
if bin/dev-flow figma-check "$(basename "$FIGMA_MISSING_SOURCE")" >"$FIGMA_MISSING_SOURCE_OUT" 2>&1; then
  cat "$FIGMA_MISSING_SOURCE_OUT" >&2
  echo "Expected missing Figma source reference to fail." >&2
  exit 1
fi
grep -q "Missing Figma source reference for screen: Dashboard" "$FIGMA_MISSING_SOURCE_OUT"

cp -R "$FIGMA_GOOD" "$FIGMA_BAD_EXPORT"
write_file "$FIGMA_BAD_EXPORT/design/DESIGN_ARTIFACTS.md" \
  "# Design Artifacts" "" "## Required Coverage" "- Dashboard board." "## Screen Coverage" "| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |" "|---|---|---|---|---|---|---|---|" "| Dashboard | Default | figma | figma://smoke/file/dashboard-node | design/screenshots/dashboard.png | Figma frame 1440x900 export @1x PNG | approved | Approved export outside design/approved should fail |"
write_valid_png "$FIGMA_BAD_EXPORT/design/screenshots/dashboard.png"
if bin/dev-flow figma-check "$(basename "$FIGMA_BAD_EXPORT")" >"$FIGMA_BAD_EXPORT_OUT" 2>&1; then
  cat "$FIGMA_BAD_EXPORT_OUT" >&2
  echo "Expected Figma export outside design/approved to fail." >&2
  exit 1
fi
grep -q "Invalid Figma approved export for screen: Dashboard" "$FIGMA_BAD_EXPORT_OUT"

bin/dev-flow init "$(basename "$DELEGATED")" >/dev/null
write_file "$DELEGATED/ideas/idea-brief.md" \
  "# Idea Brief" "" "Build a habit tracker." "The user delegated visual direction." "The app needs onboarding and dashboard screens."
write_file "$DELEGATED/product/PRD.md" \
  "# PRD" "" "Build a habit tracker." "Onboarding and dashboard are in MVP." "Visual direction is delegated to the agent."
write_file "$DELEGATED/product/USER_STORIES.md" \
  "# User Stories" "" "- As a user, I can complete onboarding." "- As a user, I can review habit progress." "- As a user, I can recover from empty and error states."
write_file "$DELEGATED/product/ACCEPTANCE.md" \
  "# Acceptance" "" "- Onboarding has approved design coverage." "- Dashboard has approved design coverage." "- QA evidence proves the implemented screens."
write_file "$DELEGATED/product/METRICS.md" \
  "# Metrics" "" "- Setup completion." "- Dashboard engagement." "- Visual comparison score."
write_file "$DELEGATED/specs/SPEC.md" \
  "# Spec" "" "Create onboarding and dashboard screens." "Support default, empty, loading, error, and success states." "Use approved design assets before implementation."
write_file "$DELEGATED/design/DESIGN.md" \
  "# Design" "" "## UX Problem" "Users need quick setup and trusted progress." "## Recommended Direction" "Use approved design assets as the visual target." "## Alternatives Considered" "- Text-only UI: too weak." "## Information Architecture" "Onboarding and dashboard." "## Interaction Model" "Primary setup flow and dashboard review." "## Visual System" "Neutral surfaces with one action color." "## Design Artifacts" "- design/approved/onboarding-default.png" "- design/approved/dashboard-empty.png" "## Build Implications" "Use SCREEN_ACCEPTANCE.md and approved design assets during implementation."
write_file "$DELEGATED/design/VISUAL_SYSTEM.md" \
  "# Visual System" "" "## Reference Influence" "Delegated visual direction from product goals." "## Palette" "Neutral surfaces and one action color." "## Typography" "Readable product scale." "## Spacing and Layout" "Cards and sections use stable spacing." "## Components and Motion" "Cards, tabs, and buttons need states." "## Forbidden Patterns" "No generic AI gradients or nested card stacks."
write_file "$DELEGATED/design/SCREEN_ACCEPTANCE.md" \
  "# Screen Acceptance" "" "## Onboarding" "- Requirement source: specs/SPEC.md." "- Required content: setup title, habit input, primary action." "- Required states: default, loading, error, success." "- Breakpoints: 320, 768, 1440." "- Required design assets: design/approved/onboarding-default.png." "- Visual acceptance: follows the onboarding board hierarchy." "- Accessibility acceptance: primary action keyboard reachable." "" "## Dashboard" "- Requirement source: specs/SPEC.md." "- Required content: habit cards, progress summary, primary action." "- Required states: default, empty, loading, selected, success." "- Breakpoints: 320, 768, 1440." "- Required design assets: design/approved/dashboard-empty.png." "- Visual acceptance: follows the dashboard board hierarchy." "- Accessibility acceptance: cards and actions keyboard reachable."
write_file "$DELEGATED/design/DESIGN_ARTIFACTS.md" \
  "# Design Artifacts" "" "## Required Coverage" "- Onboarding board." "- Dashboard board." "" "## Screen Coverage" "| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |" "|---|---|---|---|---|---|---|---|" "| Onboarding | Default | imagegen | imagegen://smoke/onboarding-default | design/approved/onboarding-default.png | 1440x900 png | approved | Use as visual target. HTML: design/approved/html/onboarding-default.html |" "| Dashboard | Empty | gpt-image-2 | gpt-image-2://smoke/dashboard-empty | design/approved/dashboard-empty.png | 1440x900 png | approved | Use as visual target. HTML: design/approved/html/dashboard-empty.html |"
write_file "$DELEGATED/design/DESIGN_IMAGE_DESCRIPTIONS.md" \
  "# Design Image HTML Descriptions" "" "## Description Coverage" "| Screen | State | Source image | HTML description | Status | Notes |" "|---|---|---|---|---|---|" "| Onboarding | Default | design/approved/onboarding-default.png | design/approved/html/onboarding-default.html | approved | Semantic companion for generated image |" "| Dashboard | Empty | design/approved/dashboard-empty.png | design/approved/html/dashboard-empty.html | approved | Semantic companion for generated image |"
write_file "$DELEGATED/design/REFERENCE_BOARD.md" \
  "# Reference Board" "" "## Delegated Direction" "Use calm, polished, product-grade habit tracking screens." "## Patterns" "- Onboarding is focused and low-friction." "- Dashboard emphasizes progress and next action."
write_valid_png "$DELEGATED/design/approved/onboarding-default.png"
write_valid_png "$DELEGATED/design/approved/dashboard-empty.png"
write_html_description "$DELEGATED/design/approved/html/onboarding-default.html" "Onboarding Default"
write_html_description "$DELEGATED/design/approved/html/dashboard-empty.html" "Dashboard Empty"
write_valid_png "$DELEGATED/design/cut-assets/primary-icon.png"
write_file "$DELEGATED/design/cut-assets/ASSET_MANIFEST.md" \
  "# Cut Assets" "" "## Decision" "- CUT_ASSETS_REQUIRED: yes" "" "## Asset Manifest" "| Asset | Source approved asset | Source region / frame | Output path | Format | Alpha | Runtime path | Usage | Notes |" "|---|---|---|---|---|---|---|---|---|" "| Primary icon | design/approved/onboarding-default.png | x=24 y=24 w=96 h=96 | design/cut-assets/primary-icon.png | PNG 2x | yes | apps/web/assets/primary-icon.png | Primary action icon | Derived from approved board |"
bin/dev-flow design-check "$(basename "$DELEGATED")" --allow-no-reference >/dev/null
grep -q 'UI_REFERENCES="delegated"' "$DELEGATED/.dev-flow/applicability.env"
printf '%s\n' 'AUTOMATED_QA="required"' 'VISUAL_QA="required"' >> "$DELEGATED/.dev-flow/applicability.env"

write_file "$DELEGATED/tasks/PLAN.md" \
  "# Plan" "" "## Design Handoff" "Implement from DESIGN.md, VISUAL_SYSTEM.md, SCREEN_ACCEPTANCE.md, and approved design assets under design/approved/." "" "## Task 1" "Build the static UI under apps/web." "Acceptance: source exists, functional QA passes, monkey QA passes, and VISUAL_COMPARISON.md scores the implemented screens."
write_file "$DELEGATED/tasks/IMPLEMENTATION_TRACE.md" \
  "# Implementation Trace" "" "## Screen Trace" "| Screen | State | Implementation target | Approved asset | Design source | HTML companion | Cut assets | Test evidence | Status |" "|---|---|---|---|---|---|---|---|---|" "| Onboarding | Default | apps/web/index.html | design/approved/onboarding-default.png | imagegen://smoke/onboarding-default | none | design/cut-assets/primary-icon.png | reviews/FUNCTIONAL_TEST.md | planned |" "| Dashboard | Empty | apps/web/index.html | design/approved/dashboard-empty.png | gpt-image-2://smoke/dashboard-empty | design/approved/html/dashboard-empty.html | none | reviews/FUNCTIONAL_TEST.md | planned |"
if bin/dev-flow verify-phase "$(basename "$DELEGATED")" build >"$TRACE_MISSING_HTML_OUT" 2>&1; then
  cat "$TRACE_MISSING_HTML_OUT" >&2
  echo "Expected missing implementation trace HTML companion to fail." >&2
  exit 1
fi
grep -q "Missing implementation trace HTML companion for screen: Onboarding" "$TRACE_MISSING_HTML_OUT"
write_file "$DELEGATED/tasks/IMPLEMENTATION_TRACE.md" \
  "# Implementation Trace" "" "## Screen Trace" "| Screen | State | Implementation target | Approved asset | Design source | HTML companion | Cut assets | Test evidence | Status |" "|---|---|---|---|---|---|---|---|---|" "| Onboarding | Default | apps/web/index.html | design/approved/onboarding-default.png | imagegen://smoke/onboarding-default | design/approved/html/onboarding-default.html | design/cut-assets/primary-icon.png | reviews/FUNCTIONAL_TEST.md | planned |" "| Dashboard | Empty | apps/web/index.html | design/approved/dashboard-empty.png | gpt-image-2://smoke/dashboard-empty | design/approved/html/dashboard-empty.html | none | reviews/FUNCTIONAL_TEST.md | planned |"
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
! test -f "$DELEGATED/tasks/PDCA.md"
bin/dev-flow ship-check "$(basename "$DELEGATED")" >/dev/null

bin/dev-flow package-adapters "$ADAPTER_OUT" >/dev/null
test -f "$ADAPTER_OUT/codex/commands/dev.md"
test -f "$ADAPTER_OUT/codex/commands/dev-agent.md"
! test -e "$ADAPTER_OUT/codex/commands/dev-flow.md"
! test -e "$ADAPTER_OUT/codex/commands/dev-role.md"
! test -e "$ADAPTER_OUT/codex/commands/dev-next.md"
! test -e "$ADAPTER_OUT/codex/commands/dev-check.md"
test -f "$ADAPTER_OUT/claude-code/.claude/commands/dev.md"
test -f "$ADAPTER_OUT/claude-code/.claude/commands/dev-agent.md"
test -f "$ADAPTER_OUT/claude-code/.claude/commands/api.md"
test -f "$ADAPTER_OUT/claude-code/.claude/commands/debug.md"
test -f "$ADAPTER_OUT/claude-code/.claude/commands/security.md"
test -f "$ADAPTER_OUT/claude-code/.claude/commands/ui.md"
! test -e "$ADAPTER_OUT/claude-code/.claude/commands/pm.md"
! test -e "$ADAPTER_OUT/claude-code/.claude/commands/agent.md"
! test -e "$ADAPTER_OUT/claude-code/.claude/commands/plan.md"
! test -e "$ADAPTER_OUT/claude-code/.claude/commands/test.md"
! test -e "$ADAPTER_OUT/claude-code/.claude/commands/review.md"
! test -e "$ADAPTER_OUT/claude-code/.claude/commands/dev-flow.md"
! test -e "$ADAPTER_OUT/claude-code/.claude/commands/dev-role.md"
! test -e "$ADAPTER_OUT/claude-code/.claude/commands/dev-next.md"
! test -e "$ADAPTER_OUT/claude-code/.claude/commands/dev-check.md"
test -f "$ADAPTER_OUT/gemini/dev-flow-quality/commands/dev.toml"
test -f "$ADAPTER_OUT/gemini/dev-flow-quality/commands/dev-agent.toml"
test -f "$ADAPTER_OUT/gemini/dev-flow-quality/commands/api.toml"
test -f "$ADAPTER_OUT/gemini/dev-flow-quality/commands/debug.toml"
test -f "$ADAPTER_OUT/gemini/dev-flow-quality/commands/security.toml"
test -f "$ADAPTER_OUT/gemini/dev-flow-quality/commands/ui.toml"
! test -e "$ADAPTER_OUT/gemini/dev-flow-quality/commands/pm.toml"
! test -e "$ADAPTER_OUT/gemini/dev-flow-quality/commands/agent.toml"
! test -e "$ADAPTER_OUT/gemini/dev-flow-quality/commands/plan.toml"
! test -e "$ADAPTER_OUT/gemini/dev-flow-quality/commands/test.toml"
! test -e "$ADAPTER_OUT/gemini/dev-flow-quality/commands/review.toml"
! test -e "$ADAPTER_OUT/gemini/dev-flow-quality/commands/planning.toml"
! test -e "$ADAPTER_OUT/gemini/dev-flow-quality/commands/dev-flow.toml"
! test -e "$ADAPTER_OUT/gemini/dev-flow-quality/commands/dev-role.toml"
! test -e "$ADAPTER_OUT/gemini/dev-flow-quality/commands/dev-next.toml"
! test -e "$ADAPTER_OUT/gemini/dev-flow-quality/commands/dev-check.toml"
! test -e "$ADAPTER_OUT/codex/commands/opc-flow.md"
! test -e "$ADAPTER_OUT/claude-code/.claude/commands/opc-flow.md"
! test -e "$ADAPTER_OUT/gemini/dev-flow-quality/commands/opc-flow.toml"
test -x "$ADAPTER_OUT/runtime/bin/dev-flow"
test -f "$ADAPTER_OUT/runtime/AGENTS.md"
test -f "$ADAPTER_OUT/runtime/DEV_FLOW.md"
test -f "$ADAPTER_OUT/runtime/dev-agent/dev-agent.manifest.json"
test -f "$ADAPTER_OUT/runtime/tests/dev-flow-smoke.sh"
test -d "$ADAPTER_OUT/runtime/dev-agent/templates/project"
test -f "$ADAPTER_OUT/runtime/dev-agent/templates/project/host-requirements.md"
! test -f "$ADAPTER_OUT/runtime/dev-agent/templates/project/pdca.md"
! find "$ADAPTER_OUT" -path '*/work/*' -o -path '*/dist/*' | grep -q .

mkdir -p "$INSTALL_DEST/commands" "$INSTALL_DEST/skills/dev-agent-opc" "$INSTALL_DEST/dev-agent-opc-runtime/bin"
touch "$INSTALL_DEST/commands/opc-flow.md" "$INSTALL_DEST/commands/opc-role.md" "$INSTALL_DEST/commands/dev-flow.md" "$INSTALL_DEST/commands/dev-role.md" "$INSTALL_DEST/commands/dev-next.md" "$INSTALL_DEST/commands/dev-check.md" "$INSTALL_DEST/skills/dev-agent-opc/SKILL.md" "$INSTALL_DEST/dev-agent-opc-runtime/bin/dev-flow"
bin/dev-flow install codex --scope user --dest "$INSTALL_DEST" >/dev/null
test -f "$INSTALL_DEST/commands/dev.md"
test -f "$INSTALL_DEST/commands/dev-agent.md"
! test -e "$INSTALL_DEST/commands/dev-flow.md"
! test -e "$INSTALL_DEST/commands/dev-role.md"
! test -e "$INSTALL_DEST/commands/dev-next.md"
! test -e "$INSTALL_DEST/commands/dev-check.md"
test -f "$INSTALL_DEST/skills/dev-agent/SKILL.md"
! test -e "$INSTALL_DEST/skills/design-flow/SKILL.md"
! test -e "$INSTALL_DEST/commands/design.md"
! test -e "$INSTALL_DEST/commands/opc-flow.md"
! test -e "$INSTALL_DEST/commands/opc-role.md"
! test -e "$INSTALL_DEST/skills/dev-agent-opc/SKILL.md"
! test -e "$INSTALL_DEST/dev-agent-opc-runtime"
test -x "$INSTALL_DEST/dev-agent-runtime/bin/dev-flow"
test -f "$INSTALL_DEST/dev-agent-runtime/dev-agent/dev-agent.manifest.json"
"$INSTALL_DEST/dev-agent-runtime/bin/dev-flow" list >/dev/null
mkdir -p "$INSTALL_WORKSPACE"
(
  cd "$INSTALL_WORKSPACE"
  "$INSTALL_DEST/dev-agent-runtime/bin/dev-flow" init runtime_probe --type api >/dev/null
  "$INSTALL_DEST/dev-agent-runtime/bin/dev-flow" status runtime_probe >/dev/null
)
test -d "$INSTALL_WORKSPACE/work/runtime_probe/.dev-flow"
! test -d "$INSTALL_DEST/dev-agent-runtime/work/runtime_probe"
bin/dev-flow uninstall codex --scope user --dest "$INSTALL_DEST" >/dev/null
! test -e "$INSTALL_DEST/commands/dev.md"
! test -e "$INSTALL_DEST/commands/dev-agent.md"
! test -e "$INSTALL_DEST/skills/dev-agent/SKILL.md"
! test -e "$INSTALL_DEST/dev-agent-runtime"

echo "dev-flow smoke passed"
