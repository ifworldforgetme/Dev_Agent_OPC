# Host Requirements: {{PROJECT}}

Use this file for host-machine SDKs, CLIs, services, credentials, and permissions
that are required to run, build, test, or ship this project.

Do not install shared host SDKs inside the `{{PROJECT}}/` project runtime.
Project-local source, lockfiles, virtual environments, generated reviews, and
runtime artifacts may live under `{{PROJECT}}/`, but host tools should be
installed once on the machine or in the user's approved global tool/cache
locations.

## Policy

- Host environment: Xcode, Android SDK, Java/JDK, Node runtimes, Python runtimes,
  Docker, Playwright browsers, Figma MCP, package-manager caches, device
  simulators, and other shared SDKs.
- Project dependencies: source-level dependencies declared by this project, such
  as `package.json`, lockfiles, Swift Package manifests, Python project files,
  or per-project virtual environments.
- Runtime artifacts: build output, screenshots, visual QA evidence, generated
  design assets, test logs, and release artifacts. These should be rebuildable
  and ignored unless the project intentionally publishes them.
- Permission rule: if a host dependency requires admin/user approval, credentials,
  network access, simulator/device access, or a system service, record it here
  before attempting setup.

## Requirements

| Capability | Scope | Required by | Verify command | Required | Permission | Status | Notes |
|---|---|---|---|---|---|---|---|
| None yet | host | none | `true` | no | none | satisfied | Add required host SDKs or permissions when project code needs them. |

## Timing

- Idea, product, spec, and design may record likely host needs, but they should
  not run setup or block on missing SDKs unless that phase directly depends on
  the tool.
- Spec or Build should turn known platform and build assumptions into concrete rows.
- Build and QA should mark a capability `Required: yes` only when the current
  implementation slice depends on it, then run `bin/dev-flow env-check
  {{PROJECT}}` before using that host capability.
- Ship requires every release-scope host dependency to be satisfied or
  explicitly recorded as a blocker.
- Slow or permission-heavy setup can be handled by a separate environment-prep
  pass that audits the host and asks before installing shared SDKs or starting
  services.

## Common Examples

| Capability | Scope | Required by | Verify command | Required | Permission | Status | Notes |
|---|---|---|---|---|---|---|---|
| Node.js 22 | host | web app build | `node --version` | yes | user install | TODO | Example only; move to Requirements when needed. |
| Android SDK | host | Android release build | `adb version` | yes | user/system install | TODO | Example only; do not install inside `{{PROJECT}}/`. |
| Figma MCP | host | Figma-backed design handoff | `n/a` | no | user auth | TODO | Example only; requires explicit user connection. |

## Notes

- `bin/dev-flow env-check {{PROJECT}}` validates this contract but does not run
  arbitrary install commands from this file.
- If a required host dependency is missing, mark `Status` as `missing` or
  `blocked`; delivery gates should treat that as a blocker.
- Keep project dependency installation instructions in the project source docs,
  not in this host environment contract.
