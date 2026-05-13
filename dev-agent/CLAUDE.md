# Dev Agent Runtime For Claude

Claude Code should treat this directory as the Dev Agent OPC runtime source.
Use [AGENTS.md](AGENTS.md) for the full maintenance rules.

## Claude-Specific Notes

- Slash command source for Claude lives in `.claude/commands/`.
- Keep `.claude/commands/dev.md`, `.claude/commands/dev-agent.md`, and host-specific command adapters aligned with the canonical `commands/` files.
- Personas in `agents/` can be used as Claude Code subagents when the host supports discovery.
- Plugin-specific generated installs should be regenerated through `bin/dev-flow install` instead of edited in place.

## Verification

From the repository root:

```bash
tests/dev-flow-smoke.sh
bin/dev-flow install claude-code --scope user
```
