<p align="center">
  <img src="assets/readme-hero.png" alt="Dev Agent OPC hero banner" width="100%">
</p>

<h1 align="center">Dev Agent OPC</h1>

<p align="center">
  <strong>面向 AI Coding Agent 的可验证交付工作流</strong>
  <br>
  <strong>Verifiable Delivery Workflow for AI Coding Agents</strong>
</p>

<p align="center">
  <a href="#中文">中文</a>
  · <a href="#english">English</a>
  · <a href="#快速开始">快速开始</a>
  · <a href="#quick-start">Quick Start</a>
</p>

<p align="center">
  <a href="#发布状态"><img alt="Version" src="https://img.shields.io/badge/version-v0.1-blue.svg"></a>
  <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-green.svg"></a>
  <a href="agent-skills/"><img alt="Agent Skills" src="https://img.shields.io/badge/agent--skills-compatible-111827.svg"></a>
  <img alt="PDCA Ready" src="https://img.shields.io/badge/PDCA-ready-14b8a6.svg">
  <img alt="UI Quality Gates" src="https://img.shields.io/badge/UI%20quality-gated-f97316.svg">
</p>

<p align="center">
  Created and maintained by <strong>Kevin KE / laoke.ai</strong>, worked with <strong>Codex-5.5</strong>.
  <br>
  由 <strong>Kevin KE / laoke.ai</strong> 创建和维护，并与 <strong>Codex-5.5</strong> 协作完成。
</p>

---

## 中文

### 项目定位

**Dev Agent OPC** 是一套面向 AI Coding Agent 的本地交付流程框架。它把产品定义、
Agent 流程设计、技术规格、UI 设计、实现、测试、审查和发布收敛到同一个可恢复、
可验证、可交接的工作流中，让 Agent 不只是写代码，而是围绕明确产物和质量门禁持续推进。

这个项目适合用于维护可复用的 Agent 工作方式：每个运行项目都放在 `work/<project-name>/`
下，根目录保持干净；核心工作流保存在 `agent-skills/`；`bin/dev-flow` 负责项目状态、
阶段检查、UI 质量门禁、PDCA 交接和适配器打包。对于需要精美界面或完整交付物的任务，
流程会要求先完成设计图和视觉规范，再进入开发和验证。

### 快速开始

查看可用流程：

```bash
bin/dev-flow list
bin/dev-flow command design
bin/dev-flow command build
bin/dev-flow refs
```

创建一个运行项目：

```bash
bin/dev-flow init my-project
bin/dev-flow status my-project
bin/dev-flow next my-project
```

推进阶段并验证：

```bash
bin/dev-flow phase my-project spec "Write buildable spec"
bin/dev-flow verify-phase my-project spec
bin/dev-flow check my-project
bin/dev-flow pdca-check my-project
bin/dev-flow ship-check my-project
```

修改流程包后运行冒烟测试：

```bash
tests/dev-flow-smoke.sh
```

### 交付流程

| 阶段 | 命令 | 主要产物 |
|---|---|---|
| 想法 | `idea` / `/idea` | 聚焦后的 idea brief |
| 产品 | `pm` / `/pm` | PRD、用户故事、指标、验收标准 |
| Agent 流程 | `agent` / `/agent` | 工具、权限、提示词、恢复机制、评估 |
| 规格 | `spec` / `/spec` | 可构建的产品和技术规格 |
| 设计 | `design` / `/design` | UX、视觉系统、屏幕验收标准、imagegen 设计图 |
| 计划 | `plan` / `/plan` | 小粒度、可验证的实现任务 |
| 开发 | `build` / `/build` | 带证据的实现切片 |
| 测试 | `test` / `/test` | 测试和回归证据 |
| 审查 | `review` / `/review` | 结构化质量审查 |
| 发布 | `ship` / `/ship` | 发布说明、go/no-go、回滚计划 |

阶段推进默认会检查此前适用阶段。`bin/dev-flow phase` 只记录状态，不代表对应工作已经完成。

### UI 与交付门禁

面向用户的 UI 任务需要先通过 reference/design/imagegen 阶段，再进入实现。设计阶段会产出
`DESIGN.md`、`VISUAL_SYSTEM.md`、`SCREEN_ACCEPTANCE.md` 和 `design/imagegen/`
下的布局图或状态图；实现后需要记录功能测试、monkey 测试和视觉对比评分。正常 QA
不要求截图，只有异常或流程阻塞时才需要截图证据。

```bash
bin/dev-flow reference-check my-project --required
bin/dev-flow design-check my-project
bin/dev-flow qa-check my-project
```

交付前必须补齐 `tasks/PDCA.md`。它记录当前周期、Plan、Do、Check、Act，确保决策、
证据、回滚和下一轮迭代不会丢失。

```bash
bin/dev-flow pdca-check my-project
bin/dev-flow ship-check my-project
```

### 仓库结构

```text
agent-skills/
  skills/          Canonical SKILL.md workflows
  agents/          Specialist agent personas
  commands/        Command prompts for agent hosts
  references/      Shared checklists, rubrics, and workflow references
  .claude/         Claude Code command files
  .gemini/         Gemini CLI command files
assets/            README and project media assets
bin/dev-flow       Local workflow CLI
DEV_FLOW.md        Detailed workflow documentation
AGENTS.md          Repository instructions for agents
work/              Runtime project state, created on demand and ignored by git
```

干净 checkout 中默认不需要 `work/`。只有运行 `bin/dev-flow init <project-name>` 时才会创建。

### 适配器

```bash
bin/dev-flow package-adapters
bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope project
bin/dev-flow install gemini --scope project
bin/dev-flow install openclaw --scope user
bin/dev-flow install opencode --scope project
```

生成的适配器目录属于构建输出，应从 `agent-skills/` 重新生成，不应手动编辑。

### 发布状态

`v0.1` 是第一个维护发布线。`main` 用于发布，`dev` 用于默认迭代；发布标签使用
`vX.Y` 格式，提交信息建议使用 Conventional Commits。

---

## English

### Project Positioning

**Dev Agent OPC** is a local delivery workflow framework for AI coding agents.
It brings product definition, agent workflow design, technical specification,
UI design, implementation, testing, review, and launch into one recoverable and
verifiable operating model.

The goal is to make agent work shippable. Runtime projects live under
`work/<project-name>/`, the reusable workflow source lives in `agent-skills/`,
and `bin/dev-flow` coordinates state, gates, UI quality checks, PDCA handoff,
and adapter packaging. For interface-heavy work, the flow requires design boards
and visual standards before implementation begins.

### Quick Start

Inspect the workflow pack:

```bash
bin/dev-flow list
bin/dev-flow command design
bin/dev-flow command build
bin/dev-flow refs
```

Create a runtime project:

```bash
bin/dev-flow init my-project
bin/dev-flow status my-project
bin/dev-flow next my-project
```

Move and verify:

```bash
bin/dev-flow phase my-project spec "Write buildable spec"
bin/dev-flow verify-phase my-project spec
bin/dev-flow check my-project
bin/dev-flow pdca-check my-project
bin/dev-flow ship-check my-project
```

Run the repo smoke test after changing the workflow pack:

```bash
tests/dev-flow-smoke.sh
```

### Delivery Flow

| Stage | Command | Primary artifact |
|---|---|---|
| Idea | `idea` / `/idea` | Focused idea brief |
| Product | `pm` / `/pm` | PRD, stories, metrics, acceptance |
| Agent Flow | `agent` / `/agent` | Tools, permissions, prompts, recovery, evals |
| Spec | `spec` / `/spec` | Buildable product and technical spec |
| Design | `design` / `/design` | UX, visual system, screen acceptance, imagegen boards |
| Plan | `plan` / `/plan` | Small verifiable tasks |
| Build | `build` / `/build` | Implemented slices with proof |
| Test | `test` / `/test` | Tests and regression evidence |
| Review | `review` / `/review` | Structured quality review |
| Ship | `ship` / `/ship` | Launch notes, go/no-go, rollback plan |

Phase changes verify prior applicable phases by default. `bin/dev-flow phase`
records state only; it does not replace the work itself.

### Quality Gates

Customer-facing UI work must pass reference intake, design checks, and imagegen
board coverage before implementation. After implementation, QA records functional
tests, monkey testing, and visual comparison. Screenshots are required only for
exceptions or blocked flows.

```bash
bin/dev-flow reference-check my-project --required
bin/dev-flow design-check my-project
bin/dev-flow qa-check my-project
```

Before delivery, complete `tasks/PDCA.md` and run the final gates:

```bash
bin/dev-flow pdca-check my-project
bin/dev-flow ship-check my-project
```

### Repository Layout

```text
agent-skills/
  skills/          Canonical SKILL.md workflows
  agents/          Specialist agent personas
  commands/        Command prompts for agent hosts
  references/      Shared checklists, rubrics, and workflow references
  .claude/         Claude Code command files
  .gemini/         Gemini CLI command files
assets/            README and project media assets
bin/dev-flow       Local workflow CLI
DEV_FLOW.md        Detailed workflow documentation
AGENTS.md          Repository instructions for agents
work/              Runtime project state, created on demand and ignored by git
```

`work/` is intentionally absent from a clean checkout and is created only when
`bin/dev-flow init <project-name>` runs.

### Adapters

```bash
bin/dev-flow package-adapters
bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope project
bin/dev-flow install gemini --scope project
bin/dev-flow install openclaw --scope user
bin/dev-flow install opencode --scope project
```

Generated adapter directories are build output. Regenerate them from
`agent-skills/` instead of editing them by hand.

### Release Status

`v0.1` is the first maintained release line. `main` is used for releases and
`dev` is the default iteration branch. Release tags use the `vX.Y` format, and
commit messages should follow Conventional Commits.

---

## Based On

Dev Agent OPC builds on [Addy Osmani's `agent-skills`](https://github.com/addyosmani/agent-skills)
and adds a project-local workflow layer, product-management flow, AI-agent
product flow, visual quality gates, PDCA delivery evidence, adapter packaging,
and OpenClaw-oriented installation support.

## License

MIT. See [`LICENSE`](LICENSE).
