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
  <a href="#发布日志"><img alt="Version" src="https://img.shields.io/badge/version-v0.5-blue.svg"></a>
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

### 目录

- [它解决什么](#它解决什么)
- [快速开始](#快速开始)
- [高价值功能](#高价值功能)
- [UI 与设计自动化管控](#ui-与设计自动化管控)
- [与 agent-skills 的关系](#与-agent-skills-的关系)
- [发布日志](#发布日志)

### 它解决什么

- 把想法拆成可执行规格，而不是直接进入随机编码。
- 给 UI 项目增加强制设计环节，先产出正式设计图、视觉规范和界面验收标准，再开发。
- 让计划、实现、测试、审查、发布都有证据，而不是靠一句“已完成”。
- 把角色责任写进流程，减少小团队缺产品、缺设计、缺测试带来的返工。
- 支持临时引用、全局安装、项目安装和跨 Agent 平台适配。

### 快速开始

#### 方式一：安装 Native Skill & Agent（推荐）

如果你希望 Codex、Claude Code 等工具在不同项目里都能复用这套流程，推荐安装
native 入口。默认 `native` 模式只暴露一个顶层技能 `dev-agent`、一个主入口
`/dev agent` 和兼容别名 `/dev-agent`，内部的 `design-flow`、`pm-flow`、
`code-review-and-quality` 等 workflow skills 会保留在 `dev-agent-runtime/`
中，不会污染全局技能列表。

首次安装：

```bash
git clone https://github.com/KevinKE93/Dev_Agent_OPC.git
cd Dev_Agent_OPC

bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope user
```

已经 clone 到本地时，直接在仓库目录执行安装即可：

```bash
cd "/path/to/Dev_Agent_OPC"
bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope user
```

支持的 host：`codex`、`claude-code`、`gemini`、`openclaw`、`opencode`。

常用 native 入口：

```text
/dev agent flow design <project-name>
/dev agent flow pm <project-name>
/dev agent role product-designer
/dev agent next <project-name>
/dev agent check ship-check <project-name>
/dev-agent flow design <project-name>
```

更新已安装版本：

```bash
cd "/path/to/Dev_Agent_OPC"
git pull --ff-only

bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope user
```

安装或更新后，重启对应的 Agent 工具以重新加载 skills 和 commands。

如需把所有内部 skills 也作为顶层 skills 展开安装，可显式使用 `--mode full`；
一般不建议，因为会重新出现 `$design-flow`、`$pm-flow` 这类内部技能名。

卸载：

```bash
bin/dev-flow uninstall codex --scope user
bin/dev-flow uninstall claude-code --scope user
```

#### 方式二：GitHub 引用，不安装

把 GitHub 仓库地址发给你的 AI Coding Agent，让它按 Dev Agent OPC 执行本次任务：

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

#### 方式三：本地路径引用，不安装

如果仓库已经在本机，也可以把本地路径直接交给 Agent：

```text
请使用本地 Dev Agent OPC 作为本次任务的自动化开发流程：
/path/to/Dev_Agent_OPC

先读取该目录下的 AGENTS.md 和 DEV_FLOW.md，再按任务需要加载 agent-skills/ 下的相关
skills、agents 和 references。项目产物必须放在当前项目的 work/<project-name>/ 下。
```

#### 方式四：指定某个 Flow 执行

你可以让 Agent 只跑某个阶段，也可以指定项目类型：

```text
请只执行 Dev Agent OPC 的 design flow。
产出视觉方向、设计规范、screen acceptance、approved design assets 和 cut-assets manifest。
暂时不要进入 build。
```

常用 flow：`idea`、`pm`、`agent`、`spec`、`design`、`figma-design`、`figma-library`、`plan`、`build`、`test`、`review`、`ship`。

项目类型：`ui`、`agent`、`api`、`library`、`docs`。

### 高价值功能

Dev Agent OPC 的价值不是“多几个提示词”，而是让 Agent 按交付链路自动推进：

- **一键进入流程**：通过 `/dev agent` 直接在模型 Agent 中调用工作流、角色、下一步恢复和检查门禁；`/dev-agent` 保留为兼容别名。
- **从想法到发布的连续管控**：把 `idea → spec → design → plan → build → test → review → ship` 串成清晰路径，减少 Agent 跳步、乱写代码或忘记验收。
- **阶段产物可追踪**：每一步都有对应交付物，例如 PRD、SPEC、设计包、任务计划、测试记录、review 结论和 launch notes。
- **自动化质量门禁**：`bin/dev-flow` 会检查阶段产物、设计资产、QA 记录、PDCA、发布准备和本地项目检查，避免只靠一句“完成了”。
- **角色化协作**：产品、设计、工程、测试、安全、审查和发布角色可以按需调用；发布前可组合 review / security / test 视角做 go/no-go 判断。
- **适合小团队和 OPC**：把产品、设计、测试、审查这些容易缺位的环节固化成 Agent 可执行流程。

### UI 与设计自动化管控

对网站、App、dashboard、工具界面等 customer-facing UI，Dev Agent OPC 会把视觉质量前移到实现之前：

- **先有设计依据再开发**：要求参考输入、视觉方向、screen acceptance 和正式设计资产，避免 Agent 直接凭感觉写 UI。
- **正式资产可追溯**：开发依据应来自 imagegen/GPT Image、Figma/Figma MCP、设计师上传或明确来源的设计工具导出；运行截图和本地 HTML mock 只能作为草稿或 QA 证据。
- **每个屏幕都有验收标准**：关键页面要覆盖默认、空状态、加载、错误、成功、禁用、长内容和窄屏等状态。
- **实现映射不丢失**：`tasks/IMPLEMENTATION_TRACE.md` 把 screen acceptance、approved asset、代码目标和测试证据关联起来。
- **QA 不只看功能**：交付前需要功能测试、monkey 测试和视觉对比评分；高保真交付默认要求视觉对比达到 90/100 以上。
- **异常才保留截图证据**：正常流程用结构化记录和评分，只有阻塞或异常时才要求运行截图，降低无意义截图堆积。

### 与 agent-skills 的关系

Dev Agent OPC 基于 Addy Osmani 的 [`agent-skills`](https://github.com/addyosmani/agent-skills)，保留其工程 skills、personas 和 references 作为底座，并在其上增加 native 安装、`dev-agent` 入口、项目状态、质量门禁和面向交付的端到端流程。

### 发布日志

- `v0.5`：native 入口改为用户可见的 `/dev agent`，底层稳定 ID 为 `dev-agent`，并保留 `/dev-agent` 作为兼容别名。
- `v0.4`：新增 native 安装方式，默认只暴露总技能和命名空间命令，可直接在模型 Agent 中调用 flow、role、next 和 gate；内部 workflow skills 留在 runtime 中，避免全局技能列表混乱。
- `v0.3`：增加宿主机环境合同、`env-check`、schema v3，以及 host SDK / project dependency / runtime artifact 的边界。
- `v0.2`：增加结构化门禁、项目模板、runtime 打包、doctor/migrate、Figma/design 资产合约和更严格的 UI 交付流程。

---

## English

Dev Agent OPC is an automatic development workflow for AI coding agents. It moves a rough idea into a shippable result through `idea → spec → design → plan → build → test → review → ship`, with clear role ownership, required artifacts, and executable quality gates.

It is more than a prompt pack that asks an agent to “write better code.” It gives the agent a small product team operating model: product manager, architect, designer, engineer, QA, reviewer, and release owner responsibilities are represented in the flow. It is built for OPCs, independent builders, small business teams, and teams using Codex, Claude Code, Gemini, OpenClaw, or OpenCode to ship complete software, websites, tools, and agent-powered workflows.

### Table Of Contents

- [What It Solves](#what-it-solves)
- [Quick Start](#quick-start)
- [High-Value Features](#high-value-features)
- [UI And Design Automation](#ui-and-design-automation)
- [Relationship To agent-skills](#relationship-to-agent-skills)
- [Release Notes](#release-notes)

### What It Solves

- Turns vague ideas into buildable specs before coding starts.
- Forces UI work through design boards, visual rules, and screen acceptance before implementation.
- Requires evidence for planning, implementation, testing, review, and launch.
- Adds role responsibilities that small teams often miss when they lack dedicated product, design, or QA staff.
- Supports temporary reference usage, global installation, project installation, and multi-host adapter packaging.

### Quick Start

#### Option 1: Install Native Skill & Agent (Recommended)

If you want to reuse Dev Agent OPC across Codex, Claude Code, and other agent
hosts, install the native entrypoints. The default `native` mode exposes one
top-level `dev-agent` skill, the visible `/dev agent` entrypoint, and the
`/dev-agent` compatibility alias. Internal workflow skills such as
`design-flow`, `pm-flow`, and `code-review-and-quality` stay inside
`dev-agent-runtime/` instead of cluttering the global skill list.

First install:

```bash
git clone https://github.com/KevinKE93/Dev_Agent_OPC.git
cd Dev_Agent_OPC

bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope user
```

If the repository is already cloned locally, install from that checkout:

```bash
cd "/path/to/Dev_Agent_OPC"
bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope user
```

Supported hosts: `codex`, `claude-code`, `gemini`, `openclaw`, `opencode`.

Common native entrypoints:

```text
/dev agent flow design <project-name>
/dev agent flow pm <project-name>
/dev agent role product-designer
/dev agent next <project-name>
/dev agent check ship-check <project-name>
/dev-agent flow design <project-name>
```

Update an installed copy:

```bash
cd "/path/to/Dev_Agent_OPC"
git pull --ff-only

bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope user
```

Restart the target agent app after installing or updating so it reloads skills
and commands.

Use `--mode full` only when you intentionally want every internal workflow skill
installed as a top-level skill. In most setups, native mode is cleaner.

Uninstall:

```bash
bin/dev-flow uninstall codex --scope user
bin/dev-flow uninstall claude-code --scope user
```

#### Option 2: Reference From GitHub Without Installing

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

#### Option 3: Reference A Local Path Without Installing

If the repository already exists on the machine, point the agent at the local
path:

```text
Use local Dev Agent OPC as the automatic development workflow for this task:
/path/to/Dev_Agent_OPC

Read AGENTS.md and DEV_FLOW.md from that directory first, then load only the
relevant skills, agents, and references under agent-skills/. Project artifacts
must stay under the active project's work/<project-name>/ folder.
```

#### Option 4: Run A Specific Flow

You can run one phase only, or set the project type:

```text
Run only the Dev Agent OPC design flow.
Produce visual direction, design rules, screen acceptance, approved design assets, and the cut-assets manifest.
Do not start build yet.
```

Common flows: `idea`, `pm`, `agent`, `spec`, `design`, `figma-design`, `figma-library`, `plan`, `build`, `test`, `review`, `ship`.

Project types: `ui`, `agent`, `api`, `library`, `docs`.

### High-Value Features

Dev Agent OPC is not just more prompting. It gives agents an operating process
for delivery:

- **Native workflow entrypoint**: call flows, roles, next steps, and gates directly through `/dev agent`; `/dev-agent` remains as a compatibility alias.
- **End-to-end delivery control**: keep `idea → spec → design → plan → build → test → review → ship` moving in order, reducing skipped planning, random coding, and weak handoffs.
- **Traceable phase artifacts**: each step has concrete outputs such as PRDs, specs, design packages, task plans, test evidence, review findings, and launch notes.
- **Executable quality gates**: `bin/dev-flow` checks phase outputs, design assets, QA evidence, PDCA records, release readiness, and project-local checks.
- **Role-based collaboration**: invoke product, design, engineering, test, security, review, and ship perspectives when they are useful.
- **Built for small teams and OPCs**: product, design, QA, review, and release discipline become agent-operable instead of relying on memory.

### UI And Design Automation

For websites, apps, dashboards, and customer-facing tools, Dev Agent OPC moves
visual quality before implementation:

- **Design before code**: require references, visual direction, screen acceptance, and approved design assets before the agent starts UI implementation.
- **Traceable formal sources**: approved UI assets should come from imagegen/GPT Image, Figma/Figma MCP, designer uploads, or explicitly sourced design exports. Runtime screenshots and local HTML mocks stay as drafts or QA evidence.
- **Acceptance per screen**: key screens cover default, empty, loading, error, success, disabled, long-content, and narrow-screen states when relevant.
- **Implementation trace**: `tasks/IMPLEMENTATION_TRACE.md` links screen acceptance, approved assets, implementation targets, and test evidence.
- **QA beyond functionality**: delivery needs functional tests, monkey tests, and visual comparison scoring; high-fidelity delivery expects at least 90/100 visual comparison.
- **Screenshots only for exceptions**: normal QA uses structured records and scores; screenshots are required when a flow is blocked or exceptional.

### Relationship To agent-skills

Dev Agent OPC builds on Addy Osmani's [`agent-skills`](https://github.com/addyosmani/agent-skills). It keeps that engineering skill foundation and adds native installation, the `dev-agent` entrypoint, project state, executable gates, and an end-to-end delivery operating process.

### Release Notes

- `v0.5`: Renames the native entrypoint to the visible `/dev agent`, uses `dev-agent` as the stable ID, and keeps `/dev-agent` as a compatibility alias.
- `v0.4`: Adds native installation with one top-level skill and namespaced commands, so model agents can call flows, roles, next steps, and gates directly. Internal workflow skills stay inside the runtime to keep the global skill list clean.
- `v0.3`: Adds the host environment contract, `env-check`, schema v3, and clear boundaries between host SDKs, project dependencies, and runtime artifacts.
- `v0.2`: Adds structured gates, project templates, runtime packaging, doctor/migrate checks, Figma/design asset contracts, and stricter UI delivery.

---

## License

MIT. See [`LICENSE`](LICENSE).
