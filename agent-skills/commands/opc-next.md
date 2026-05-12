---
description: Recover the current Dev Agent OPC project phase and print the next executable flow brief
---

Use this as `/opc-next <project-name>`.

Run `bin/dev-flow status <project-name>` and `bin/dev-flow next <project-name>`. If project-local `bin/dev-flow` is unavailable, use the installed `dev-agent-opc-runtime/bin/dev-flow`.

Load only the files named in the `next` brief, then continue with the listed command file, primary skill files, required outputs, blocker checks, gate, and follow-up `phase` command.
