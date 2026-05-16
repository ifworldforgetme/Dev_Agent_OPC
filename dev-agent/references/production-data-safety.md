# Production Data Safety

Use this reference for QA, ship, and release verification in any project with
remote environments.

## Core Rule

Production and formal environments are not places for write-path smoke tests.
Production verification must be read-only or rejection-only unless the user
explicitly approves a named canary data plan in the current conversation.

Allowed production checks:

- Health endpoint
- Public/read-only configuration endpoint
- Missing-auth rejection
- Invalid-secret rejection
- Permission denied or validation rejection that cannot write data

Forbidden production smoke without explicit approval:

- Login that creates users, app users, sessions, or devices
- Successful webhook delivery
- Billing sync or purchase state mutation
- Upload, signed upload-url, or file metadata creation
- Creating tickets, orders, accounts, transactions, pets, reminders, exports, or
  any other business record

## Test And Staging

Write-path smoke belongs in test/staging. It must:

- Use identifiable prefixes such as `dev_smoke_*`, `idem_smoke_*`, or a run id
- Record enough ids to clean up deterministically
- Include cleanup evidence in the verification or launch notes
- Leave a read-only production verification path for final release checks

## Destructive Data Reset

Deleting all remote test or production data is a separate destructive operation.
Before running delete commands:

1. State the exact target environment.
2. State what is preserved, usually schema and seed/config rows.
3. Show row counts or a dry-run summary.
4. Wait for explicit user authorization in the current conversation.

Do not infer deletion authorization from a general request to ship, test, or
verify a release.
