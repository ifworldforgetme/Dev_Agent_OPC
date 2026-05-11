# Quality Gates: {{PROJECT}}

Project-specific verification belongs here. Keep commands runnable from this project folder and mirror them in `bin/check` when they become stable.

## Default Gate
- [ ] Required workflow folders exist
- [ ] Schema and status ledgers exist
- [ ] Context loading guidance exists
- [ ] Reference intake exists for customer-facing UI work
- [ ] Approved design assets exist under `design/approved/` before UI implementation, when UI applies
- [ ] Draft, approved, and verification assets are stored in their proper directories
- [ ] Cut assets are listed under `design/cut-assets/ASSET_MANIFEST.md` when bitmap UI assets, icon matrices, spritesheets, or animation frames are needed
- [ ] `tasks/IMPLEMENTATION_TRACE.md` maps required UI screens to implementation targets, when UI applies

## Add When The Project Has Code
- [ ] Lint
- [ ] Type check
- [ ] Unit tests
- [ ] Build
- [ ] Browser or device smoke test, when user-facing
- [ ] Functional flow test, when user-facing
- [ ] Monkey or exploratory stress test, when user-facing
- [ ] Visual comparison score is at least 90/100 against approved design assets, when user-facing
- [ ] `tasks/PDCA.md` records Current Cycle, Plan, Do, Check, and Act evidence for the current cycle
- [ ] `bin/dev-flow doctor {{PROJECT}}`, before delivery
- [ ] `bin/dev-flow asset-check {{PROJECT}}`, before implementation planning for customer-facing UI
- [ ] `bin/dev-flow qa-check {{PROJECT}}`, before delivery for customer-facing UI
