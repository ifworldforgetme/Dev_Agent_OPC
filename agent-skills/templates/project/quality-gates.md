# Quality Gates: {{PROJECT}}

Project-specific verification belongs here. Keep commands runnable from this project folder and mirror them in `bin/check` when they become stable.

## Default Gate
- [ ] Required workflow folders exist
- [ ] Schema and status ledgers exist
- [ ] Context loading guidance exists
- [ ] Reference intake exists for customer-facing UI work
- [ ] Approved design assets exist under `design/approved/` before UI implementation, when UI applies
- [ ] `bin/dev-flow design-check {{PROJECT}}` passes before UI implementation, when UI applies
- [ ] `tasks/IMPLEMENTATION_TRACE.md` maps required UI screens to implementation targets and evidence, when UI applies

## Add When The Project Has Code
- [ ] Lint
- [ ] Type check
- [ ] Unit tests
- [ ] Build
- [ ] Browser or device smoke test, when user-facing
- [ ] Functional flow test, when user-facing
- [ ] Monkey or exploratory stress test, when user-facing
- [ ] Current planned UI implementation batch is complete or explicitly blocked before visual comparison, when user-facing
- [ ] Visual comparison score is at least 90/100 against approved design assets, when user-facing
- [ ] `tasks/PDCA.md` records Current Cycle, Plan, Do, Check, and Act evidence for the current cycle
- [ ] `bin/dev-flow doctor {{PROJECT}}`, before delivery
- [ ] `bin/dev-flow qa-check {{PROJECT}}`, before delivery for customer-facing UI
