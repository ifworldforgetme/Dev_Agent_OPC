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
  · <a href="#使用方式">使用方式</a>
  · <a href="#usage">Usage</a>
</p>

<p align="center">
  <a href="#发布日志"><img alt="Version" src="https://img.shields.io/badge/version-v0.5-blue.svg"></a>
  <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-green.svg"></a>
  <a href="DEV_FLOW.md"><img alt="Dev Agent Runtime" src="https://img.shields.io/badge/dev--agent-runtime-111827.svg"></a>
  <img alt="Process Gated" src="https://img.shields.io/badge/process-gated-f97316.svg">
  <img alt="PDCA Ready" src="https://img.shields.io/badge/PDCA-ready-14b8a6.svg">
</p>

<p align="center">
  由 <strong>Kevin KE / laoke.ai</strong> 创建和维护，并与 <strong>Codex-5.5</strong> 协作完成。
  <br>
  Created and maintained by <strong>Kevin KE / laoke.ai</strong>, worked with <strong>Codex-5.5</strong>.
</p>

---

## 中文

Dev Agent OPC 是一套给 AI Coding Agent 使用的交付型工作流。它把模糊想法推进到可验证交付：从 `idea → spec → design → plan → build → test → review → ship`，每一步都有角色责任、产物要求和质量门禁。

它适合 OPC、独立开发者、小型业务团队，以及希望让 Codex、Claude Code、Gemini、OpenClaw 或 OpenCode 更稳定完成软件、网站、工具和 Agent 工作流交付的人。

### 目录

- [定位与价值](#定位与价值)
- [使用方式](#使用方式)
- [安装与更新](#安装与更新)
- [流程管控](#流程管控)
- [发布日志](#发布日志)

### 定位与价值

Dev Agent OPC 的目标不是增加一组提示词，而是给 Agent 一个可执行的交付操作系统：

- **连续推进**：让 Agent 按 `idea → spec → design → plan → build → test → review → ship` 推进，减少跳过需求、跳过设计、直接写代码的情况。
- **角色补位**：把产品、设计、工程、测试、安全、审查和发布责任写进流程，小团队也能获得更完整的开发闭环。
- **产物可追踪**：PRD、SPEC、设计资产、任务计划、测试记录、review 结论和 launch notes 都有明确位置。
- **门禁自动化**：`bin/dev-flow` 可以检查阶段产物、QA、PDCA、发布准备和本地项目状态。
- **对话直接调用**：安装后用户只需要记住 `/dev agent`，后续用自然语言描述目标即可。

### 使用方式

#### 安装使用

安装后，从主入口开始：

```text
/dev agent
```

你可以直接用自然语言描述目标，Dev Agent 会判断该进入哪个 flow、是否需要角色参与，以及下一步要补齐哪些产物：

```text
/dev agent 帮我把这个产品想法梳理成可执行方案，并推进到 spec 和任务计划。

/dev agent 这是一个官网改版项目，请先完成设计 flow，不要直接进入实现。

/dev agent 帮我检查当前项目下一步该做什么，缺哪些门禁产物。

/dev agent 请用产品设计师视角评估这个 UI 方案，并给出可落地修改建议。

/dev agent 当前版本准备发布，帮我做发布前质量检查和 go/no-go 判断。
```

#### 非安装使用

如果只是临时使用，也可以把仓库地址或本地路径发给当前 Agent，让它读取 `AGENTS.md` 和 `DEV_FLOW.md` 后按流程执行：

```text
请使用 Dev Agent OPC 作为本次任务的自动化开发流程：
https://github.com/KevinKE93/Dev_Agent_OPC

按 idea → spec → design → plan → build → test → review → ship 推进。
如果某个阶段不适用，请说明原因；如果质量门禁缺失，请补齐后再继续。
```

本地路径也可以：

```text
请使用本地 Dev Agent OPC：
/path/to/Dev_Agent_OPC
```

### 安装与更新

推荐使用 Native Skill & Agent 安装方式。默认 `native` 模式只暴露一个顶层技能 `dev-agent`、主入口 `/dev agent` 和兼容别名 `/dev-agent`。内部 workflow skills 会留在 `dev-agent-runtime/` 中，不会把全局技能列表变乱。

首次安装：

```bash
git clone https://github.com/KevinKE93/Dev_Agent_OPC.git
cd Dev_Agent_OPC

bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope user
```

已经 clone 到本地时：

```bash
cd "/path/to/Dev_Agent_OPC"
bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope user
```

支持的 host：`codex`、`claude-code`、`gemini`、`openclaw`、`opencode`。

更新已安装版本：

```bash
cd "/path/to/Dev_Agent_OPC"
git pull --ff-only

bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope user
```

卸载：

```bash
bin/dev-flow uninstall codex --scope user
bin/dev-flow uninstall claude-code --scope user
```

安装、更新或卸载后，重启对应的 Agent 工具以重新加载 skills 和 commands。如需把所有内部 workflow skills 也作为顶层 skills 展开安装，可显式使用 `--mode full`，但一般不建议。

### 流程管控

Dev Agent OPC 的核心价值是把“让 Agent 做事”变成有状态、有证据、有门禁的交付流程：

- **阶段门禁**：idea、pm、agent、spec、design、plan、build、test、review、ship 都有对应产物和检查点。
- **项目状态恢复**：`bin/dev-flow status` 和 `bin/dev-flow next` 可以恢复当前阶段、下一步、上下文加载范围和待补产物。
- **PDCA 交付循环**：每轮交付都记录 Plan、Do、Check、Act，避免只留下零散实现记录。
- **环境边界**：宿主机 SDK、模拟器、MCP、凭证和系统服务记录在 host requirements 中，不混进项目 runtime。
- **质量证据**：测试、review、发布检查和项目自定义 `bin/check` 可以组合成交付前 go/no-go。
- **UI 更严格**：customer-facing UI 会额外要求参考输入、正式设计资产、screen acceptance、implementation trace、功能测试、monkey 测试和视觉对比评分。

### 发布日志

- `v0.5`：支持 native 安装，并可在对话中通过 `/dev agent` 直接调用 Dev Agent；稳定 ID 为 `dev-agent`，保留 `/dev-agent` 作为兼容别名。
- `v0.3`：增加宿主机环境合同、`env-check`、schema v3，以及 host SDK / project dependency / runtime artifact 的边界。
- `v0.2`：增加结构化门禁、项目模板、runtime 打包、doctor/migrate、Figma/design 资产合约和更严格的 UI 交付流程。

---

## English

Dev Agent OPC is a delivery workflow for AI coding agents. It moves rough ideas into verifiable output through `idea → spec → design → plan → build → test → review → ship`, with role ownership, required artifacts, and executable quality gates at every step.

It is built for OPCs, independent builders, small business teams, and anyone who wants Codex, Claude Code, Gemini, OpenClaw, or OpenCode to ship complete software, websites, tools, and agent workflows more reliably.

### Table Of Contents

- [Positioning And Value](#positioning-and-value)
- [Usage](#usage)
- [Install And Update](#install-and-update)
- [Process Controls](#process-controls)
- [Release Notes](#release-notes)

### Positioning And Value

Dev Agent OPC is not just another prompt pack. It gives agents an executable delivery operating model:

- **Continuous delivery flow**: keep `idea → spec → design → plan → build → test → review → ship` moving in order, reducing skipped requirements, skipped design, and random coding.
- **Role coverage**: product, design, engineering, test, security, review, and release responsibilities are represented in the workflow.
- **Traceable artifacts**: PRDs, specs, design assets, task plans, test records, review decisions, and launch notes have clear homes.
- **Automated gates**: `bin/dev-flow` checks phase outputs, QA evidence, PDCA records, release readiness, and local project state.
- **Conversation-native invocation**: after installation, users only need to remember `/dev agent` and describe the target in natural language.

### Usage

#### Installed Usage

After installation, start from the main entrypoint:

```text
/dev agent
```

Describe the goal in natural language. Dev Agent will decide which flow to run,
which role is useful, and which artifacts or gates are missing:

```text
/dev agent Turn this product idea into an executable spec and task plan.

/dev agent This is a website redesign. Run the design flow first and do not start implementation yet.

/dev agent Check the current project state and tell me the next required gate.

/dev agent Review this UI direction as a product designer and give implementation-ready changes.

/dev agent This version is ready for release. Run pre-ship quality checks and give me a go/no-go decision.
```

#### Non-Installed Usage

For a one-off task, point the agent at this repository and ask it to read `AGENTS.md` and `DEV_FLOW.md`:

```text
Use Dev Agent OPC as the automatic development workflow for this task:
https://github.com/KevinKE93/Dev_Agent_OPC

Move through idea → spec → design → plan → build → test → review → ship.
If a stage does not apply, explain why. If a quality gate is missing, complete it before continuing.
```

Local path reference also works:

```text
Use local Dev Agent OPC:
/path/to/Dev_Agent_OPC
```

### Install And Update

Native Skill & Agent installation is the recommended path. The default `native` mode exposes one top-level `dev-agent` skill, the visible `/dev agent` entrypoint, and the `/dev-agent` compatibility alias. Internal workflow skills stay inside `dev-agent-runtime/` instead of cluttering the global skill list.

First install:

```bash
git clone https://github.com/KevinKE93/Dev_Agent_OPC.git
cd Dev_Agent_OPC

bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope user
```

If the repository is already cloned locally:

```bash
cd "/path/to/Dev_Agent_OPC"
bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope user
```

Supported hosts: `codex`, `claude-code`, `gemini`, `openclaw`, `opencode`.

Update an installed copy:

```bash
cd "/path/to/Dev_Agent_OPC"
git pull --ff-only

bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope user
```

Uninstall:

```bash
bin/dev-flow uninstall codex --scope user
bin/dev-flow uninstall claude-code --scope user
```

Restart the target agent app after installing, updating, or uninstalling so it reloads skills and commands. Use `--mode full` only when you intentionally want every internal workflow skill installed as a top-level skill.

### Process Controls

Dev Agent OPC turns agent work into a stateful, evidenced, gated delivery process:

- **Phase gates**: idea, pm, agent, spec, design, plan, build, test, review, and ship each have expected outputs and checks.
- **Project recovery**: `bin/dev-flow status` and `bin/dev-flow next` recover the active phase, next action, context scope, and missing artifacts.
- **PDCA delivery loop**: every delivery cycle records Plan, Do, Check, and Act instead of leaving scattered implementation notes.
- **Environment boundary**: host SDKs, simulators, MCP servers, credentials, and services are recorded in host requirements instead of project runtime output.
- **Quality evidence**: tests, review, release checks, and project-local `bin/check` can be combined into a pre-delivery go/no-go decision.
- **Stricter UI path**: customer-facing UI adds reference intake, formal design assets, screen acceptance, implementation trace, functional tests, monkey tests, and visual comparison scoring.

### Release Notes

- `v0.5`: Adds native installation and conversation-level invocation through `/dev agent`; the stable ID is `dev-agent`, with `/dev-agent` kept as a compatibility alias.
- `v0.3`: Adds the host environment contract, `env-check`, schema v3, and clear boundaries between host SDKs, project dependencies, and runtime artifacts.
- `v0.2`: Adds structured gates, project templates, runtime packaging, doctor/migrate checks, Figma/design asset contracts, and stricter UI delivery.

---

## License

MIT. See [`LICENSE`](LICENSE).

## Acknowledgements / 致谢

Based on and extending [@AddyOsmani Agent Skills](https://github.com/addyosmani/agent-skills).
