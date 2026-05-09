# AGENTS.md

This file provides guidance to AI coding agents (Claude Code, Cursor, Copilot, Antigravity, etc.) when working with code in this repository.

## Repository Overview

A cross-agent workflow pack for senior software engineering. Skills are packaged
instructions, references, and optional scripts that extend Claude, Codex,
Gemini, OpenCode, OpenClaw, and other compatible coding agents.

## OpenCode and OpenClaw Integration

OpenCode and OpenClaw integrations use a **skill-driven execution model**
powered by installed `SKILL.md` folders, command snippets when the host supports
them, and this repository's lifecycle rules.

### Core Rules

- If a task matches a skill, you MUST invoke it
- Skills are located in `skills/<skill-name>/SKILL.md` or the host's native skill directory
- Never implement directly if a skill applies
- Always follow the skill instructions exactly (do not partially apply them)

### Intent → Skill Mapping

The agent should automatically map user intent to skills:

- Product definition / PRD / user stories → `pm-flow` when product scope needs definition
- AI agent or automation workflow → `agent-flow` when agent behavior, tools, memory, approvals, operations, or evals are part of the work
- Feature / new functionality → `spec-driven-development`, `design-flow` for user-facing work, then `planning-and-task-breakdown`, `incremental-implementation`, `test-driven-development`
- Planning / breakdown → `planning-and-task-breakdown`
- Bug / failure / unexpected behavior → `debugging-and-error-recovery`
- Code review → `code-review-and-quality`
- Refactoring / simplification → `code-simplification`
- API or interface design → `api-and-interface-design`
- UX, visual design, reference intake, or screen acceptance before planning → `design-flow`
- UI implementation, visual polish, or screenshot-based UI QA → `frontend-ui-engineering`
- Customer-facing UI with no references → ask for reference images/software unless the user explicitly delegates visual direction

### Lifecycle Mapping

Some hosts support custom slash commands and some only support prompt snippets or
intent mapping. In all cases, the agent must internally follow this lifecycle:

- DEFINE → `idea-refine`, `pm-flow` when product scope is applicable, `agent-flow` when agent behavior is applicable, then `spec-driven-development`
- DESIGN → `design-flow` (reference intake, visual system, screen acceptance)
- PLAN → `planning-and-task-breakdown`
- BUILD → `incremental-implementation` + `test-driven-development`
- VERIFY → `debugging-and-error-recovery`; for customer-facing UI also `frontend-ui-engineering` visual QA
- REVIEW → `code-review-and-quality`
- SHIP → `shipping-and-launch`

### Execution Model

For every request:

1. Determine if any skill applies (even 1% chance)
2. Invoke the appropriate skill using the `skill` tool
3. Follow the skill workflow strictly
4. Only proceed to implementation after required steps (spec, plan, etc.) are complete

### Anti-Rationalization

The following thoughts are incorrect and must be ignored:

- "This is too small for a skill"
- "I can just quickly implement this"
- "I’ll gather context first"

Correct behavior:

- Always check for and use skills first

This ensures OpenCode behaves similarly to Claude Code with full workflow enforcement.

## Orchestration: Personas, Skills, and Commands

This repo has three composable layers. They have different jobs and should not be confused:

- **Skills** (`skills/<name>/SKILL.md`) — workflows with steps and exit criteria. The *how*. Mandatory hops when an intent matches.
- **Personas** (`agents/<role>.md`) — roles with a perspective and an output format. The *who*. Use `product-designer` for customer-facing UX/design and `ui-quality-reviewer` for screenshot-based UI review.
- **Commands** (`commands/*.md`, `.claude/commands/*.md`, `.gemini/commands/*.toml`) — user-facing entry points. The *when*. The orchestration layer.

Composition rule: **the user, a command, or host intent mapping is the orchestrator. Personas do not invoke other personas.** A persona may invoke skills.

The only multi-persona orchestration pattern this repo endorses is **parallel fan-out with a merge step** — used by `/ship` or the `ship` command to run `code-reviewer`, `security-auditor`, and `test-engineer` concurrently and synthesize their reports. Do not build a "router" persona that decides which other persona to call; that's the job of commands and intent mapping.

See [agents/README.md](agents/README.md) for the decision matrix and [references/orchestration-patterns.md](references/orchestration-patterns.md) for the full pattern catalog.

**Claude Code interop:** the personas in `agents/` work as Claude Code subagents (auto-discovered from this plugin's `agents/` directory) and as Agent Teams teammates (referenced by name when spawning). Two platform constraints align with our rules: subagents cannot spawn other subagents, and teams cannot nest. Plugin agents silently ignore the `hooks`, `mcpServers`, and `permissionMode` frontmatter fields.

## Creating a New Skill

### Directory Structure

```
skills/
  {skill-name}/           # kebab-case directory name
    SKILL.md              # Required: skill definition
    references/           # Optional: loaded only when needed
    scripts/              # Optional: executable scripts
      {script-name}.sh    # Bash scripts (preferred)
```

### Naming Conventions

- **Skill directory**: `kebab-case` (e.g. `web-quality`)
- **SKILL.md**: Always uppercase, always this exact filename
- **Scripts**: `kebab-case.sh` (e.g., `deploy.sh`, `fetch-logs.sh`)
- **Zip file**: Only create release zips when packaging for a surface that requires them.

### SKILL.md Format

```markdown
---
name: {skill-name}
description: {One sentence describing when to use this skill. Include trigger phrases like "Deploy my app", "Check logs", etc.}
---

# {Skill Title}

{Brief description of what the skill does.}

## How It Works

{Numbered list explaining the skill's workflow}

## Usage

```bash
bash /mnt/skills/user/{skill-name}/scripts/{script}.sh [args]
```

**Arguments:**
- `arg1` - Description (defaults to X)

**Examples:**
{Show 2-3 common usage patterns}

## Output

{Show example output users will see}

## Present Results to User

{Template for how Claude should format results when presenting to users}

## Troubleshooting

{Common issues and solutions, especially network/permissions errors}
```

### Best Practices for Context Efficiency

Skills are loaded on-demand — only the skill name and description are loaded at startup. The full `SKILL.md` loads into context only when the agent decides the skill is relevant. To minimize context usage:

- **Keep SKILL.md under 500 lines** — put detailed reference material in separate files
- **Write specific descriptions** — helps the agent know exactly when to activate the skill
- **Use progressive disclosure** — reference supporting files that get read only when needed
- **Prefer scripts over inline code** — script execution doesn't consume context (only output does)
- **File references work one level deep** — link directly from SKILL.md to supporting files

### Script Requirements

- Scripts are optional. Add them only when deterministic execution is better than instructions.
- Use `#!/usr/bin/env bash` shebang for Bash scripts
- Use `set -e` for fail-fast behavior
- Write status messages to stderr: `echo "Message" >&2`
- Write machine-readable output (JSON) to stdout
- Include a cleanup trap for temp files
- Reference the script path as `/mnt/skills/user/{skill-name}/scripts/{script}.sh`

### Packaging

After creating or updating a skill:

```bash
../bin/dev-flow package-adapters
```

This creates adapter folders for Codex, Claude Code, Gemini CLI, OpenClaw, and OpenCode from the canonical `skills/`, `agents/`, `commands/`, and `references/` directories.

For direct installation from the repository root, use:

```bash
../bin/dev-flow install codex --scope user
../bin/dev-flow install claude-code --scope project
../bin/dev-flow install gemini --scope project
../bin/dev-flow install openclaw --scope user
../bin/dev-flow install opencode --scope project
```

### End-User Installation

Document these two installation methods for users:

- Codex App/CLI: copy skill folders to `~/.codex/skills/`; command snippets go under the generated `commands/` folder when the host supports them
- Claude Code: copy skill folders to `~/.claude/skills/` or project `.claude/skills/`; copy `.claude/commands/` for slash commands
- Claude.ai/API: upload or package each skill separately for that surface
- Gemini CLI: use the generated Gemini extension folder
- OpenClaw: copy skills to `~/.openclaw/skills/`, `~/.agents/skills/`, or workspace `skills/`; install command snippets where supported
- OpenCode: copy skills to `.opencode/skills/` or `~/.config/opencode/skills/`; copy `.opencode/commands/` where supported
