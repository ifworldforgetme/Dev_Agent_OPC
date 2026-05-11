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
  <a href="#发布状态"><img alt="Version" src="https://img.shields.io/badge/version-v0.2-blue.svg"></a>
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

#### 方式一：临时引用，不安装

在任何支持读取本地文件或 GitHub 仓库的 Coding Agent 中，直接把 Dev Agent OPC 当作工作流参考引用即可：

```text
请临时引用 Dev Agent OPC 作为本次任务的交付流程：
读取 <Dev_Agent_OPC>/AGENTS.md 和 DEV_FLOW.md，并只加载当前任务需要的
agent-skills/skills、agent-skills/agents、agent-skills/references。

本次任务使用 ui flow：先完成 spec -> design -> approved assets -> plan，
再进入 build -> test -> review -> ship。命令、状态文件和检查步骤由执行机器自动安排；
如果设计资产、QA 或 PDCA 门禁缺失，请停止并补齐，不要跳过。
```

也可以只指定某一个 flow：

```text
请按 Dev Agent OPC 的 design flow 执行，只产出视觉方向、设计规范、
screen acceptance、approved design assets 和 cut-assets manifest。
暂时不要进入实现阶段。
```

常用 flow 名称包括 `idea`、`pm`、`agent`、`spec`、`design`、`plan`、`build`、`test`、`review`、`ship`。
项目类型可以指定为 `ui`、`agent`、`api`、`library` 或 `docs`。`ui` 默认启用严格设计门禁；非 UI 类型默认关闭 UI 设计资产要求。

#### 方式二：安装到全局工作区

如果你希望 Codex、Claude Code、Gemini、OpenClaw 或 OpenCode 在不同项目中都能复用这套流程，
可以把 adapter 安装到用户级工作区。最简单的做法是让你的 Coding Agent 在本仓库中执行：

```text
请把 Dev Agent OPC 安装到 Codex 的全局工作区，使用 user scope。
如果平台支持可执行门禁，请同时保留 runtime 包；不要复制 work/ 或 dist/ 输出。
```

手动安装时只需要选择目标 host：

```bash
bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope user
```

支持的 host 名称：`codex`、`claude-code`、`gemini`、`openclaw`、`opencode`。
`--scope user` 表示全局可用；`--scope project` 表示只安装到当前项目。
只安装 adapter/skills 是规则提示层；如果需要机器可执行门禁，应使用仓库 runtime 或 adapter package 里的 `runtime/`。

#### 方式三：让 Agent 自动执行完整闭环

对于实际开发任务，推荐用自然语言指定目标和 flow，让模型和执行机器自动安排命令：

```text
使用 Dev Agent OPC 开发一个 <目标项目>，项目类型为 ui。
请按 idea -> spec -> design -> plan -> build -> test -> review -> ship 执行。
设计阶段必须有正式 approved design assets；QA 需要功能测试、monkey 测试和视觉对比；
交付前必须完成 PDCA 和 ship check。除非遇到阻塞，否则不要停在计划阶段。
```

修改流程包本身后，再运行仓库 smoke test。

### 交付流程

| 阶段 | 命令 | 主要产物 |
|---|---|---|
| 想法 | `idea` / `/idea` | 聚焦后的 idea brief |
| 产品 | `pm` / `/pm` | PRD、用户故事、指标、验收标准 |
| Agent 流程 | `agent` / `/agent` | 工具、权限、提示词、恢复机制、评估 |
| 规格 | `spec` / `/spec` | 可构建的产品和技术规格 |
| 设计 | `design` / `/design` | UX、视觉系统、屏幕验收标准、正式设计资产 |
| 计划 | `plan` / `/plan` | 小粒度、可验证的实现任务 |
| 开发 | `build` / `/build` | 带证据的实现切片 |
| 测试 | `test` / `/test` | 测试和回归证据 |
| 审查 | `review` / `/review` | 结构化质量审查 |
| 发布 | `ship` / `/ship` | 发布说明、go/no-go、回滚计划 |

阶段推进默认会检查此前适用阶段。`bin/dev-flow phase` 只记录状态，不代表对应工作已经完成。

### UI 与交付门禁

面向用户的 UI 任务需要先通过 reference/design/approved-assets 阶段，再进入实现。设计阶段会产出
`DESIGN.md`、`VISUAL_SYSTEM.md`、`SCREEN_ACCEPTANCE.md`、`DESIGN_ARTIFACTS.md`
和 `design/approved/` 下的正式布局图或状态图；实现后需要记录功能测试、monkey 测试和视觉对比评分。正常 QA
不要求截图，只有异常或流程阻塞时才需要截图证据。
`design/approved/` 的正式设计资产可以来自 imagegen/GPT Image、Figma MCP 或 Figma 导出、设计师上传、手工设计系统稿等已批准来源。
浏览器、Playwright、模拟器、本地 HTML/CSS、运行态截图、草图和原型图不能作为开发实现目标。
如果没有外部参考而由 Agent 负责视觉方向，需要写入 `design/REFERENCE_BOARD.md`。切图资产、透明 PNG、图标矩阵、spritesheet 或动画帧需要提供 manifest；如果不需要切图，也要显式记录原因。
进入开发计划前，`tasks/IMPLEMENTATION_TRACE.md` 需要把每个界面映射到实现目标、正式设计图、切图资产和测试证据。

```bash
bin/dev-flow reference-check my-project --required
bin/dev-flow asset-check my-project
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
  templates/       Project templates rendered by bin/dev-flow init/migrate
  lib/             Internal helpers for the local dev-flow runtime
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
bin/dev-flow install <host> --scope user
bin/dev-flow install <host> --scope project
bin/dev-flow package-adapters
```

生成的适配器目录属于构建输出，应从 `agent-skills/` 重新生成，不应手动编辑。adapter
目录提供规则提示层；`package-adapters` 额外生成 `runtime/`，包含 `bin/dev-flow`、模板和 smoke test，用于需要可执行门禁的平台用户。

### 发布状态

`v0.2` 增加了结构化门禁、项目模板、runtime 打包、doctor/migrate 检查和更严格的设计资产合约。
`main` 用于发布，`dev` 用于默认迭代；发布标签使用 `vX.Y` 格式，提交信息建议使用
Conventional Commits。

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

#### Option 1: Reference It Temporarily

In any coding agent that can read local files or a GitHub repository, reference
Dev Agent OPC as the operating workflow without installing it:

```text
Use Dev Agent OPC as the delivery workflow for this task.
Load <Dev_Agent_OPC>/AGENTS.md and DEV_FLOW.md, then load only the relevant
agent-skills/skills, agent-skills/agents, and agent-skills/references files.

Use the ui flow: spec -> design -> approved assets -> plan -> build -> test
-> review -> ship. Let the agent and execution machine choose the exact
commands and state updates. If design assets, QA evidence, or PDCA evidence are
missing, stop and complete the gate instead of skipping it.
```

You can also request one specific flow:

```text
Run only the Dev Agent OPC design flow. Produce visual direction, design
standards, screen acceptance, approved design assets, and the cut-assets
manifest. Do not start implementation yet.
```

Common flow names are `idea`, `pm`, `agent`, `spec`, `design`, `plan`, `build`,
`test`, `review`, and `ship`. Project types are `ui`, `agent`, `api`,
`library`, and `docs`. `ui` keeps strict design gates enabled; non-UI types
disable UI asset gates by default.

#### Option 2: Install It Globally

To reuse the workflow across Codex, Claude Code, Gemini, OpenClaw, or OpenCode
projects, install the adapter into the user workspace. The easiest path is to
ask your coding agent from inside this repository:

```text
Install Dev Agent OPC into the global Codex workspace with user scope.
If executable gates are supported, keep the runtime package available.
Do not copy work/ or dist/ outputs.
```

For manual installation, choose the target host:

```bash
bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope user
```

Supported hosts are `codex`, `claude-code`, `gemini`, `openclaw`, and
`opencode`. `--scope user` makes the workflow globally available; `--scope
project` installs it only for the current project. Installing adapters/skills
provides the rules prompt layer. For executable gates, use the repository
runtime or the `runtime/` folder emitted by the adapter package.

#### Option 3: Let the Agent Run the Loop

For real work, describe the target and flow in natural language and let the
model plus execution machine decide the exact commands:

```text
Use Dev Agent OPC to build <target project> as a ui project.
Run idea -> spec -> design -> plan -> build -> test -> review -> ship.
The design phase must include approved design assets. QA must include
functional testing, monkey testing, and visual comparison. Complete PDCA and
ship checks before delivery. Do not stop at planning unless blocked.
```

After changing the workflow pack itself, run the repository smoke test.

### Delivery Flow

| Stage | Command | Primary artifact |
|---|---|---|
| Idea | `idea` / `/idea` | Focused idea brief |
| Product | `pm` / `/pm` | PRD, stories, metrics, acceptance |
| Agent Flow | `agent` / `/agent` | Tools, permissions, prompts, recovery, evals |
| Spec | `spec` / `/spec` | Buildable product and technical spec |
| Design | `design` / `/design` | UX, visual system, screen acceptance, approved design assets |
| Plan | `plan` / `/plan` | Small verifiable tasks |
| Build | `build` / `/build` | Implemented slices with proof |
| Test | `test` / `/test` | Tests and regression evidence |
| Review | `review` / `/review` | Structured quality review |
| Ship | `ship` / `/ship` | Launch notes, go/no-go, rollback plan |

Phase changes verify prior applicable phases by default. `bin/dev-flow phase`
records state only; it does not replace the work itself.

### Quality Gates

Customer-facing UI work must pass reference intake, design checks, and approved
design asset coverage before implementation. After implementation, QA records functional
tests, monkey testing, and visual comparison. Screenshots are required only for
exceptions or blocked flows.
Final assets under `design/approved/` can come from imagegen/GPT Image, Figma MCP
or Figma exports, designer uploads, manual design-system comps, or another
explicitly approved source, and must be recorded in `DESIGN_ARTIFACTS.md`.
Browser, Playwright, simulator, local HTML/CSS, runtime screenshots, drafts, and
prototypes are not substitutes for approved design assets. Cut assets,
transparent PNGs, icon matrices, spritesheets, and animation frames need a
manifest; when none are needed, the design record must say so. Delegated visual
direction requires `design/REFERENCE_BOARD.md`, and UI build planning requires
`tasks/IMPLEMENTATION_TRACE.md`.

```bash
bin/dev-flow reference-check my-project --required
bin/dev-flow asset-check my-project
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
  templates/       Project templates rendered by bin/dev-flow init/migrate
  lib/             Internal helpers for the local dev-flow runtime
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
bin/dev-flow install <host> --scope user
bin/dev-flow install <host> --scope project
bin/dev-flow package-adapters
```

Generated adapter directories are build output. Regenerate them from
`agent-skills/` instead of editing them by hand. Adapter folders provide the
rules prompt layer; `package-adapters` also emits `runtime/` with `bin/dev-flow`,
templates, and smoke tests for users who need executable gates.

### Release Status

`v0.2` adds structured workflow gates, project templates, runtime packaging,
doctor/migrate checks, and stricter design asset contracts. `main` is used for
releases and `dev` is the default iteration branch. Release tags use the
`vX.Y` format, and commit messages should follow Conventional Commits.

---

## Based On

Dev Agent OPC builds on [Addy Osmani's `agent-skills`](https://github.com/addyosmani/agent-skills)
and adds a project-local workflow layer, product-management flow, AI-agent
product flow, visual quality gates, PDCA delivery evidence, adapter packaging,
and OpenClaw-oriented installation support.

## License

MIT. See [`LICENSE`](LICENSE).
