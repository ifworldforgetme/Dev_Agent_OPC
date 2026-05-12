<p align="center">
  <img src="assets/readme-hero.png" alt="Dev Agent OPC hero banner" width="100%">
</p>

<h1 align="center">Dev Agent OPC</h1>

<p align="center">
  <strong>Automatic Dev Agent from idea → spec → design → plan → build → test → review → ship</strong>
  <br>
  <strong>面向 OPC 与小型业务团队的自动化开发 Agent 工作流</strong>
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
  <a href="agent-skills/"><img alt="Agent Workflow" src="https://img.shields.io/badge/agent-workflow-111827.svg"></a>
  <img alt="Design Gated" src="https://img.shields.io/badge/design-gated-f97316.svg">
  <img alt="PDCA Ready" src="https://img.shields.io/badge/PDCA-ready-14b8a6.svg">
</p>

<p align="center">
  由 <strong>Kevin KE / laoke.ai</strong> 创建和维护，并与 <strong>Codex-5.5</strong> 协作完成。
  <br>
  Created and maintained by <strong>Kevin KE / laoke.ai</strong>, worked with <strong>Codex-5.5</strong>.
</p>

---

## 中文

Dev Agent OPC 是一套给 AI Coding Agent 使用的自动化开发流程。它把一个模糊想法推进成可交付结果：从 `idea → spec → design → plan → build → test → review → ship`，每一步都有清晰的角色责任、产物要求和质量门禁。

它不是只提醒 Agent “写得更好一点”的提示词集合，而是一套面向真实交付的工作流：让 Agent 像一个小型产品开发团队一样工作，承担产品经理、架构师、设计师、工程师、测试、评审和发布负责人等职责。它特别适合 OPC、独立开发者、小型业务团队，以及需要用 Codex、Claude Code、Gemini、OpenClaw 或 OpenCode 交付完整软件/网站/工具的团队。

### 它解决什么

- 把想法拆成可执行规格，而不是直接进入随机编码。
- 给 UI 项目增加强制设计环节，先产出正式设计图、视觉规范和界面验收标准，再开发。
- 让计划、实现、测试、审查、发布都有证据，而不是靠一句“已完成”。
- 把角色责任写进流程，减少小团队缺产品、缺设计、缺测试带来的返工。
- 支持临时引用、全局安装、项目安装和跨 Agent 平台适配。

### 快速开始

#### 方式一：临时引用，不安装

把仓库地址发给你的 AI Coding Agent，让它按 Dev Agent OPC 执行本次任务：

```text
请使用 Dev Agent OPC 作为本次任务的自动化开发流程：
https://github.com/KevinKE93/Dev_Agent_OPC

先读取 AGENTS.md 和 DEV_FLOW.md，再按任务需要加载 agent-skills/ 下的相关 skills、agents 和 references。
请按 idea → spec → design → plan → build → test → review → ship 推进。
如果某个阶段不适用，请说明原因；如果质量门禁缺失，请补齐后再继续。
```

如果是 UI 或网站项目，建议补一句：

```text
本次任务是 UI 项目。必须先完成设计图、视觉规范、screen acceptance 和 approved design assets，
再进入实现。QA 需要功能测试、monkey 测试和视觉对比；只有异常或阻塞时才需要截图证据。
```

#### 方式二：安装到全局工作区

如果你希望 Codex、Claude Code 等工具在不同项目里都能复用这套流程，可以让 Agent 在本仓库中执行全局安装：

```text
请把 Dev Agent OPC 安装到我的全局工作区，目标 host 是 codex，scope 使用 user。
如果当前平台支持 runtime 或可执行门禁，请一并保留；不要复制 work/ 或 dist/ 输出。
```

手动安装时只需要选择 host：

```bash
bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope user
```

支持的 host：`codex`、`claude-code`、`gemini`、`openclaw`、`opencode`。

#### 方式三：指定某个 flow 执行

你可以让 Agent 只跑某个阶段，也可以指定项目类型：

```text
请只执行 Dev Agent OPC 的 design flow。
产出视觉方向、设计规范、screen acceptance、approved design assets 和 cut-assets manifest。
暂时不要进入 build。
```

常用 flow：`idea`、`pm`、`agent`、`spec`、`design`、`figma-design`、`plan`、`build`、`test`、`review`、`ship`。

项目类型：`ui`、`agent`、`api`、`library`、`docs`。

### 核心流程与责任

| 阶段 | 角色责任 | 主要产物 |
|---|---|---|
| Idea | 理清目标、用户、约束和成功标准 | idea brief |
| Spec | 把想法变成可构建规格 | product/technical spec |
| Design | 产出视觉方向、正式设计图和界面验收标准 | design boards, visual system, screen acceptance |
| Plan | 拆解可验证任务，建立实现映射 | implementation plan, trace |
| Build | 按计划实现，保留变更证据 | working code, implementation notes |
| Test | 验证功能、边界和回归风险 | functional test, monkey test, QA evidence |
| Review | 从质量、架构、安全、体验角度审查 | review report |
| Ship | 整理发布、回滚、后续迭代和 PDCA | launch notes, PDCA |

可选扩展阶段包括 `pm`、`agent`、`figma-design` 和 `figma-library`，用于更复杂的产品定义、Agent 流程设计或 Figma 设计系统沉淀。

### UI 与设计门禁

Dev Agent OPC 对 UI 项目默认更严格：不能用运行截图、浏览器截图、低保真草图或本地 HTML mock 代替正式设计图。`design/approved/` 中的开发依据应来自 imagegen/GPT Image、Figma/Figma MCP、设计师上传、已批准的设计工具导出或明确记录来源的正式设计资产。

设计阶段需要记录：

- 参考和视觉方向：`design/REFERENCE_BOARD.md`
- 视觉规范：`design/VISUAL_SYSTEM.md`
- 界面验收：`design/SCREEN_ACCEPTANCE.md`
- 正式设计资产映射：`design/DESIGN_ARTIFACTS.md`
- 切图、透明 PNG、图标矩阵、spritesheet 或动画帧：`design/cut-assets/ASSET_MANIFEST.md`
- 实现映射：`tasks/IMPLEMENTATION_TRACE.md`

正常 QA 以功能测试、monkey 测试和视觉对比为主；只有异常或流程阻塞时才要求截图证据。

### 仓库结构

```text
agent-skills/   Skills, agents, commands, references, templates
bin/dev-flow    Local runtime and executable gates
docs/           Maintainer docs
assets/         README media assets
work/           Runtime project output, ignored by git
```

`work/` 是运行时目录，干净 checkout 中不需要存在，也不会作为可复用工作流的一部分发布。

### 发布状态

`v0.2` 增加了结构化门禁、项目模板、runtime 打包、doctor/migrate 检查、Figma/design 资产合约和更严格的 UI 交付流程。`main` 用于发布，`dev` 用于默认迭代。

### 与 agent-skills 的关系

Dev Agent OPC 基于 Addy Osmani 的 [`agent-skills`](https://github.com/addyosmani/agent-skills)。`agent-skills` 提供了非常扎实的工程 skills、commands、personas 和 references；Dev Agent OPC 不替代它，而是在这个基础上增加一层面向 OPC 和小型业务团队的自动化交付流程。

换句话说，`agent-skills` 是高质量工程技能底座，Dev Agent OPC 更关注如何把这些能力组织成一个可以从想法持续推进到发布的 Agent operating process。

| 维度 | agent-skills 提供的基础 | Dev Agent OPC 的扩展 |
|---|---|---|
| 工作层级 | 可复用的工程 skills 和命令 | idea → spec → design → plan → build → test → review → ship 的端到端流程 |
| 目标场景 | 提升 AI coding agent 的工程质量 | 帮助 OPC、独立开发者和小团队完成可交付产品 |
| 角色责任 | Specialist personas 和工程检查表 | 产品、Agent 流程、设计、开发、测试、审查、发布的责任链 |
| UI 交付 | 前端工程和质量建议 | 正式设计资产、视觉规范、screen acceptance 和 implementation trace 的硬门禁 |
| 执行约束 | Markdown workflow guidance | runtime checks、doctor/migrate、asset/design/QA/PDCA/ship gates |
| 项目管理 | Skills 仓库结构 | `work/<project>` 运行态项目空间、阶段状态、交付证据和回滚记录 |
| 平台落地 | 多 Agent host 适配思路 | adapter + runtime 双层分发，区分规则提示层和可执行门禁层 |

这种扩展保留了上游项目的工程精神，同时把使用方式调整为更适合小团队真实交付的软件开发流程。

---

## English

Dev Agent OPC is an automatic development workflow for AI coding agents. It moves a rough idea into a shippable result through `idea → spec → design → plan → build → test → review → ship`, with clear role ownership, required artifacts, and executable quality gates.

It is more than a prompt pack that asks an agent to “write better code.” It gives the agent a small product team operating model: product manager, architect, designer, engineer, QA, reviewer, and release owner responsibilities are represented in the flow. It is built for OPCs, independent builders, small business teams, and teams using Codex, Claude Code, Gemini, OpenClaw, or OpenCode to ship complete software, websites, tools, and agent-powered workflows.

### What It Solves

- Turns vague ideas into buildable specs before coding starts.
- Forces UI work through design boards, visual rules, and screen acceptance before implementation.
- Requires evidence for planning, implementation, testing, review, and launch.
- Adds role responsibilities that small teams often miss when they lack dedicated product, design, or QA staff.
- Supports temporary reference usage, global installation, project installation, and multi-host adapter packaging.

### Quick Start

#### Option 1: Reference It Temporarily

Give the repository URL to your AI coding agent and ask it to follow Dev Agent OPC for the current task:

```text
Use Dev Agent OPC as the automatic development workflow for this task:
https://github.com/KevinKE93/Dev_Agent_OPC

Read AGENTS.md and DEV_FLOW.md first, then load only the relevant skills, agents, and references under agent-skills/.
Move through idea → spec → design → plan → build → test → review → ship.
If a stage does not apply, explain why. If a quality gate is missing, complete it before continuing.
```

For UI or website work, add:

```text
This is a UI project. Complete design boards, visual rules, screen acceptance, and approved design assets before implementation.
QA must include functional testing, monkey testing, and visual comparison. Screenshots are required only for exceptions or blocked flows.
```

#### Option 2: Install It Globally

To reuse the workflow across Codex, Claude Code, or other hosts, ask your agent to install it from this repository:

```text
Install Dev Agent OPC into my global workspace. The target host is codex and the scope is user.
If the platform supports runtime or executable gates, keep them available. Do not copy work/ or dist/ outputs.
```

Manual install:

```bash
bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope user
```

Supported hosts: `codex`, `claude-code`, `gemini`, `openclaw`, `opencode`.

#### Option 3: Run A Specific Flow

You can run one phase only, or set the project type:

```text
Run only the Dev Agent OPC design flow.
Produce visual direction, design rules, screen acceptance, approved design assets, and the cut-assets manifest.
Do not start build yet.
```

Common flows: `idea`, `pm`, `agent`, `spec`, `design`, `figma-design`, `plan`, `build`, `test`, `review`, `ship`.

Project types: `ui`, `agent`, `api`, `library`, `docs`.

### Core Flow And Responsibilities

| Stage | Responsibility | Primary Output |
|---|---|---|
| Idea | Clarify goal, user, constraints, and success criteria | idea brief |
| Spec | Convert the idea into a buildable product/technical spec | product/technical spec |
| Design | Produce visual direction, formal boards, and screen acceptance | design boards, visual system, screen acceptance |
| Plan | Break work into verifiable tasks and trace implementation targets | implementation plan, trace |
| Build | Implement planned slices with evidence | working code, implementation notes |
| Test | Validate behavior, edge cases, and regression risk | functional test, monkey test, QA evidence |
| Review | Review quality, architecture, security, and UX | review report |
| Ship | Prepare launch, rollback, next cycle, and PDCA | launch notes, PDCA |

Optional extension stages include `pm`, `agent`, `figma-design`, and `figma-library` for deeper product definition, agent workflow design, or Figma design-system work.

### UI And Design Gates

Dev Agent OPC is stricter for UI work by default. Runtime screenshots, browser captures, low-fidelity sketches, and local HTML mocks cannot replace formal design assets. Development targets under `design/approved/` should come from imagegen/GPT Image, Figma/Figma MCP, designer uploads, approved design-tool exports, or another formal source with provenance.

The design phase records:

- References and visual direction: `design/REFERENCE_BOARD.md`
- Visual rules: `design/VISUAL_SYSTEM.md`
- Screen acceptance: `design/SCREEN_ACCEPTANCE.md`
- Approved asset mapping: `design/DESIGN_ARTIFACTS.md`
- Cut assets, transparent PNGs, icon matrices, spritesheets, or animation frames: `design/cut-assets/ASSET_MANIFEST.md`
- Implementation mapping: `tasks/IMPLEMENTATION_TRACE.md`

Normal QA relies on functional tests, monkey tests, and visual comparison. Screenshots are required only when an exception or blocked flow needs evidence.

### Repository Layout

```text
agent-skills/   Skills, agents, commands, references, templates
bin/dev-flow    Local runtime and executable gates
docs/           Maintainer docs
assets/         README media assets
work/           Runtime project output, ignored by git
```

`work/` is runtime state. It does not need to exist in a clean checkout and is not published as part of the reusable workflow.

### Release Status

`v0.2` adds structured gates, project templates, runtime packaging, doctor/migrate checks, Figma/design asset contracts, and stricter UI delivery. `main` is used for releases and `dev` is the default iteration branch.

### Relationship To agent-skills

Dev Agent OPC builds on Addy Osmani's [`agent-skills`](https://github.com/addyosmani/agent-skills). `agent-skills` provides a strong foundation of engineering skills, commands, personas, and references. Dev Agent OPC does not replace that work; it adds an operating layer for OPCs and small business teams that need an agent to move work from idea to shipped output.

In short, `agent-skills` is a high-quality engineering skill foundation. Dev Agent OPC focuses on turning those capabilities into an agent operating process for continuous delivery.

| Area | Foundation From agent-skills | Dev Agent OPC Extension |
|---|---|---|
| Working layer | Reusable engineering skills and commands | End-to-end idea → spec → design → plan → build → test → review → ship flow |
| Target use case | Better engineering quality for AI coding agents | Shippable product delivery for OPCs, independent builders, and small teams |
| Role ownership | Specialist personas and engineering checklists | Product, agent workflow, design, engineering, QA, review, and release responsibility chain |
| UI delivery | Frontend engineering and quality guidance | Hard gates for approved design assets, visual rules, screen acceptance, and implementation trace |
| Execution control | Markdown workflow guidance | Runtime checks, doctor/migrate, asset/design/QA/PDCA/ship gates |
| Project management | Skills repository structure | `work/<project>` runtime workspace, phase state, delivery evidence, and rollback notes |
| Platform distribution | Multi-host adapter direction | Adapter + runtime distribution, separating prompt guidance from executable gates |

The extension keeps the upstream engineering spirit while shaping it into a practical software delivery process for smaller teams.

---

## Based On

Dev Agent OPC is based on [Addy Osmani's `agent-skills`](https://github.com/addyosmani/agent-skills). We keep that attribution explicit because the upstream project provides the engineering skill foundation this workflow builds on.

## License

MIT. See [`LICENSE`](LICENSE).
