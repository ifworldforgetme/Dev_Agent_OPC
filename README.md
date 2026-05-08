# Dev Flow Agent Skills

Lifecycle-driven development workflows for coding agents. The canonical skill,
persona, command, and reference source lives under `agent-skills/`; the root
helper script adds project state, UI quality gates, adapter packaging, and
adapter installation.

## Native Status

This repository is now adapter-ready, not tied to a single host.

- Codex App/CLI: installable as skill folders under `~/.codex/skills/`; command prompts are packaged as reusable snippets because custom slash-command support is host-dependent.
- Claude Code: installable as skills plus project slash commands under `.claude/commands/`.
- Gemini CLI: packaged as a Gemini extension with skills and lifecycle commands.
- OpenClaw: packaged as skills, personas, references, and command snippets for hosts that support them.
- OpenCode: packaged as `.opencode/skills`, `.opencode/agents`, and `.opencode/commands`.

Slash commands are not equally portable across every agent surface. The stable
contract is: skills are native where the host supports `SKILL.md` discovery;
commands are native where the host supports slash/custom command files; otherwise
they are installed as prompt shortcuts.

## Structure

- `agent-skills/skills/`: canonical `SKILL.md` workflows.
- `agent-skills/agents/`: specialist personas.
- `agent-skills/commands/`: platform-neutral lifecycle command prompts.
- `agent-skills/references/`: shared checklists and orchestration references.
- `agent-skills/.claude/commands/`: Claude Code command entry points.
- `agent-skills/.gemini/commands/`: Gemini command entry points.
- `bin/dev-flow`: local helper for project setup, gates, packaging, and adapter installation.
- `work/`: local project artifacts created by `bin/dev-flow init`.

## Start A Project

```bash
bin/dev-flow init <project-name>
bin/dev-flow status <project-name>
bin/dev-flow next <project-name>
```

Customer-facing UI should pass these gates before implementation and delivery:

```bash
bin/dev-flow reference-check <project-name> --required
bin/dev-flow design-check <project-name>
bin/dev-flow visual-check <project-name>
```

## Package Or Install

Generate disposable adapter output:

```bash
bin/dev-flow package-adapters
```

Install directly into a host scope:

```bash
bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope project
bin/dev-flow install gemini --scope project
bin/dev-flow install openclaw --scope user
bin/dev-flow install opencode --scope project
```

Use `--dest <path>` to install into a staging directory or a custom agent home.
Generated `dist/` output is disposable; regenerate it from `agent-skills/`
instead of editing it directly.
