---
layout: post
title:  "Codex in Action"
date:   2026-04-03 14:00:00 +0800
last_modified_at: 2026-04-03 14:00:00 +0800
description: "全面介绍 OpenAI Codex 的核心能力、多种接入方式（桌面应用、CLI、IDE 插件、网页版）、定价计划及其与 Claude Code 的对比，是使用 Codex 的参考指南。"
categories: AI
tags:
  - OpenAI
  - Codex
  - AI 编程
  - 编程助手
  - 智能体

---

* Do not remove this line (it will not be displayed)
{:toc}

> [Codex](https://github.com/openai/codex) 是 OpenAI 打造的 AI 编程智能体（coding agent），由 ChatGPT 提供技术支持。官方定义为「助力构建并交付产品的 AI 编程智能体」—— 从常规 Pull Request 到复杂功能开发、代码重构与迁移，Codex 端到端完成；也可在后台自动化运行 Issue 分流、告警监控、CI/CD 等日常工作。相关背景可进一步阅读 [Builder.io 的深度对比分析](https://www.builder.io/blog/codex-vs-claude-code)。更多官方资源链接见本文末尾的[参考资料](#参考资料)。

# 什么是 Codex

Codex 是 OpenAI 的编程智能体，帮助开发者更快地编写、审查和交付代码。它可以配对在你的本地工具中使用，也可以委托到云端完成任务。

## 核心能力

根据[官方文档](https://developers.openai.com/codex)，Codex 能帮助你：

- **编写代码**：描述你想构建的内容，Codex 生成符合意图的代码，并适配你的项目结构与规范。
- **理解代码库**：阅读并解释复杂或遗留代码，帮助你理解团队如何组织系统。
- **审查代码**：分析代码以识别潜在 Bug、逻辑错误和未处理的边界情况。
- **调试修复**：追踪失败、诊断根因并给出有针对性的修复建议。
- **自动化开发任务**：执行重复性工作流，如重构、测试、迁移和配置任务，让你专注于更高层次的工程工作。

## 默认模型

> **注意**：GPT-4o 在 Codex 中不可用。Codex 目前默认使用 **GPT-5.1-Codex** 模型家族（Max 默认，可选 Mini）。Retired 或已移除的模型（包括 GPT-4o）无法恢复或作为 Legacy Tier 购买。可通过模型选择器（查看 "Legacy"）或 `-m` flag 或 `config.toml` 指定其他支持的模型。详细可用的模型列表见 [Models 文档](https://developers.openai.com/codex/models)。

# 多端使用方式

Codex 支持多种接入方式，所有方式都由同一个 ChatGPT 账号统一连接。

## Codex 应用（桌面 App）

Codex 桌面应用是「智能体式编码的指挥中心」：

- 支持 **macOS**（Apple Silicon）和 **Windows**。
- 内置 **Worktrees**（工作树）与 **云端环境**，允许多个智能体在多个项目间并行工作，将数周的开发周期缩短至数天。
- 支持 **Skills**（技能）与 **Automations**（自动化），可在后台无人值守运行。
- 自带 Git 功能，可在应用内完成分支切换、PR 创建等操作。

下载链接（[Quickstart 页面](https://developers.openai.com/codex/quickstart)）：

```bash
# macOS / Windows 下载地址
https://chatgpt.com/codex  → 下载 App
```

## CLI（命令行）

Codex CLI 是轻量级编程智能体，直接在终端运行，支持 **macOS、Linux、Windows**（Windows 为实验性支持，推荐使用 WSL）。

### 安装方式

```bash
# npm
npm install -g @openai/codex

# Homebrew
brew install codex
```

### 核心功能

CLI 支持的功能与 App 类似，具体包括（参考 [CLI 文档](https://developers.openai.com/codex/cli)）：

| 功能 | 说明 |
| :--- | :--- |
| 交互式 TUI | 运行 `codex` 启动交互式终端会话 |
| 模型切换 | 使用 `/model` 在 GPT-5.4、GPT-5.3-Codex 等模型间切换 |
| 图片输入 | 附加截图或设计稿，让 Codex 同时阅读 |
| 本地代码审查 | 在 commit 或 push 前使用独立 Codex 代理审查代码 |
| 子代理（Subagents） | 使用子代理并行化复杂任务 |
| 网页搜索 | 让 Codex 搜索网络获取最新信息 |
| 云端任务 | 在终端内启动 Codex Cloud 任务并应用 diff |
| 脚本化 | 使用 `exec` 命令自动化重复工作流 |
| MCP 支持 | 通过 Model Context Protocol 连接第三方工具 |
| 审批模式 | 选择 Codex 执行编辑或运行命令前的审批级别 |

## IDE 插件

Codex 提供编辑器插件，支持以下 IDE：

- **VSCode**（官方扩展：[vscode:extension/openai.chatgpt](vscode:extension/openai.chatgpt)）
- **Cursor**（[cursor:extension/openai.chatgpt](cursor:extension/openai.chatgpt)）
- **Windsurf**（[windsurf:extension/openai.chatgpt](windsurf:extension/openai.chatgpt)）
- **VSCode Insiders**

安装后 Codex 扩展出现在侧边栏，默认为 Agent 模式，可读取文件、运行命令、在项目目录中写入更改。

## 网页版

直接访问 [chatgpt.com/codex](https://chatgpt.com/codex) 使用，支持：

- 连接 GitHub 仓库
- 实时监控任务进度
- 在云端隔离沙箱中运行任务
- 在 diff 视图中审查结果并直接创建 Pull Request

# 核心概念与功能

## Skills（技能）

Skills 让 Codex 超越单纯写代码，直接参与将 PR 变成产品的工作，例如代码理解、原型构建、文档编写，并与团队标准保持一致。

- 每个项目根目录可放置 `AGENTS.md` 文件（类似本博客的 `CLAUDE.md`），定义 Codex 在该项目中遵循的规范和上下文。
- 社区可在 [OpenAI 博客](https://developers.openai.com/blog/skills-agents-sdk) 查看用 Skills 加速开源维护的案例。

> **与 Claude Code 的 `CLAUDE.md` 的区别**：Claude Code 仅支持 `CLAUDE.md`，Codex（和 Cursor、Builder.io）支持 `AGENTS.md` 标准。如果多工具团队使用同一个指令文件，`AGENTS.md` 可避免维护多份同步文件。详见 [Builder.io 的对比分析](https://www.builder.io/blog/codex-vs-claude-code)。

## Automations（自动化）

Automations 让 Codex 无需提示即可自动运行，处理「问题分流、告警监控、CI/CD」等日常但重要的工作，使你专注于构建本身。

## Worktrees（工作树）

内置 Git worktree 支持，多个智能体可以在同一项目的不同分支上并行工作，互不干扰。

## Subagents（子代理）

使用子代理并行化复杂任务，Codex 可以同时处理多个方向的问题，再汇总结果。

## Cloud（云端环境）

Codex Cloud 提供：

- **隔离沙箱**：每个任务在独立沙箱中运行，带有你的仓库和环境配置。
- **互联网访问**：可选开启云端任务的互联网访问权限。
- **更大的虚拟机**：Business plan 可用更大规格虚拟机加速云端任务。

## GitHub 集成

Codex 的 GitHub 集成是其相对于其他编程智能体的显著优势：

- **自动代码审查**：安装 GitHub App 后，可为整个团队开启自动 PR 审查。它会在 PR 中添加内联评论，你可以要求它修复问题，并在 PR 页面直接审查和合并。
- **Issue 中 @Codex**：在任何 Issue 或 PR 中 @Codex，它会自动接手处理。
- **与 CLI 行为一致**：GitHub UI 中的提示词与 CLI 中的效果相同，相同的模型、相同的配置、相同的行为，确保一致的体验。

参考 [Builder.io 的评测](https://www.builder.io/blog/codex-vs-claude-code)：Codex 的 GitHub 集成「能发现团队会错过的真正有难度的 Bug，在行内评论，可以要求它修复问题，在后台运行，可以在 PR 中审查和更新，然后合并」，而 Claude Code 的 GitHub 集成「评论冗长但找不到明显的 Bug，无法以有效方式要求修复」。

## Slack 集成

可在 Slack 中直接 @Codex 执行任务，详见 [Slack 集成文档](https://developers.openai.com/codex/integrations/slack)。

## Plugins（插件）

Plugins 将可复用工作流打包，方便连接 Codex 到你依赖的工具和服务，并在团队间共享。Plugin 可组合一个或多个 Skills、可选的 App 集成或 MCP 服务器配置，是可安装的分发单元。详见 [Plugins 文档](https://developers.openai.com/codex/plugins)。

## MCP（Model Context Protocol）

Codex 支持 MCP，可连接第三方工具获取额外的上下文和功能。详细见 [MCP 文档](https://developers.openai.com/codex/mcp)。

# 定价计划

Codex 包含在标准 ChatGPT 套餐中，同时也支持纯 API 按量付费。

## 各计划包含内容

| 功能 | Plus | Pro | Business | Enterprise |
| :--- | :--- | :--- | :--- | :--- |
| 网页 / CLI / IDE / iOS 版 Codex | Yes | Yes | Yes | Yes |
| GitHub 自动代码审查 | No | No | Yes | Yes |
| Slack 集成 | No | No | Yes | Yes |
| 最新模型（GPT-5.4、GPT-5.3-Codex） | Yes | Yes | Yes | Yes |
| GPT-5.4-mini（更高用量限制） | No | Yes | No | No |
| 6 倍本地和云端任务用量限制 | No | Yes | No | No |
| 10 倍代码审查次数 | No | Yes | No | No |
| GPT-5.3-Codex-Spark（研究预览） | No | Yes | No | No |
| API 按量付费（仅 CLI/SDK/IDE） | No | No | Yes（Flexible） | Yes |
| 企业级安全控制（SCIM、EKM、RBAC） | No | No | No | Yes |
| 数据驻留与合规 API | No | No | No | Yes |
| 审核日志与用量监控 | No | No | No | Yes |

> 当前限时优惠：符合条件的 ChatGPT Business 工作区在团队成员开始使用 Codex 时可获得最高 **$500** 额度。详见[官方条款](https://help.openai.com/en/articles/20001150-codex-for-business-promotion-earn-up-to-500-in-credits)。

## 用量限制参考

Plus 用户（5 小时窗口内）：

| 模型 | 本地消息数 | 云端任务数 | 每周代码审查次数 |
| :--- | :--- | :--- | :--- |
| GPT-5.4 | 33–168 | No | No |
| GPT-5.4-mini | 110–560 | No | No |
| GPT-5.3-Codex | 45–225 | 10–60 | 10–25 |

Pro 用户（5 小时窗口内）：

| 模型 | 本地消息数 | 云端任务数 | 每周代码审查次数 |
| :--- | :--- | :--- | :--- |
| GPT-5.4 | 223–1120 | No | No |
| GPT-5.4-mini | 743–3733 | No | No |
| GPT-5.3-Codex | 300–1500 | 50–400 | 100–250 |

> 注意：本地消息与云端任务的用量共享同一个 **5 小时窗口**。详细最新的费率信息见 [Codex 定价页面](https://developers.openai.com/codex/pricing)。

## 节省用量的技巧

- 控制 Prompt 大小，只提供必要的上下文。
- 减少 `AGENTS.md` 的体积，必要时使用嵌套方式分层注入。
- 限制使用的 MCP 服务器数量，不需要时禁用。
- 日常任务切换到 GPT-5.4-mini，延长约 2.5x–3.3x 的本地消息限制。

# Codex vs Claude Code

[Builder.io 的深度对比](https://www.builder.io/blog/codex-vs-claude-code)（2026 年 4 月更新）从多个维度分析了两者：

## 各维度对比

| 维度 | 胜出 | 说明 |
| :--- | :--- | :--- |
| 智能体能力 | Tie | 三者功能趋同，Codex 行为与 Claude Code 非常接近 |
| 模型与推理控制 | Tie | Codex 提供更多推理级别选项（low/medium/high/minimal） |
| 定价与用量 | **Codex** | 相同价格下 Codex 用量更慷慨；GPT-5 Codex 效率约为 Claude Sonnet 的 2 倍 |
| UX 与权限 | Claude Code | Claude Code 的 TUI 更成熟，权限系统有所改进但仍偶有摩擦 |
| 功能深度 | Claude Code | Claude Code 在配置深度、hooks、slash commands 上更丰富 |
| 指令文件标准 | **Codex** | Claude Code 只支持 CLAUDE.md；Codex 支持 AGENTS.md（Cursor、Builder.io 也支持），多工具团队可共用同一套指令文件 |
| GitHub 集成 | **Codex** | Codex GitHub App 自动审查能发现真正有难度的 Bug；Claude Code 评论冗长但抓不住明显问题 |
| 开放性 | **Codex** | Codex CLI [完全开源](https://github.com/openai/codex)，可自由定制；Claude Code 为闭源 |

## Builder.io 的选择

Builder.io 选择使用 Codex 作为核心编码智能体，主要原因：

1. **GitHub 集成优秀**——安装后开启自动代码审查，能发现真正有难度的 Bug，支持 @Codex 在 Issue 中直接处理，形成从发现到修复的闭环。
2. **定价更有利**——$20 的 Plus 计划比 Claude 同价位更耐用，$200 的 Pro 几乎不遇到上限。
3. **同一公司训练模型**——工具和模型均由 OpenAI 打造，优化端到端体验，且没有中间商差价。
4. **指令文件统一**——使用 `AGENTS.md` 标准，与 Cursor、Builder.io 共用同一套规范。

## 推理行为的细节差异

根据 Builder.io 的实际观察：

- **Codex**：推理时间略长，但 token 输出速度让人感觉更快（可见的 tokens/s 输出）。
- **Claude Code**：推理次数略少，但可见输出 token 稍慢。在 Cursor 内切换模型也有类似感受：GPT-5 Codex 模型推理时间更长，Sonnet 推理更少但代码输出略慢，Opus 更明显。

两种风格并无绝对优劣，偏好因人而异。

## 模型感受数据

Builder.io 对比了用户情绪评分：

> 在 GPT-5 Codex、GPT-5 Mini 和 Claude Sonnet 中，GPT-5 Codex 平均获得 **40% 更高评分**。

这与效率数据吻合——在相近成本下，GPT-5 Codex 带来更好的实际体验。

## GitHub 集成：核心差异所在

这是 Builder.io 选择 Codex 的最主要原因。两者在 GitHub 上的表现差异显著：

| 方面 | Codex | Claude Code |
|| :--- | :--- |
| PR 审查质量 | 能发现团队会错过的真正有难度的 Bug | 评论冗长但找不到明显的 Bug |
| 交互方式 | 行内评论，可要求修复，在后台运行，可直接合并 | 无法以有效方式要求修复 |
| Issue 处理 | 可 @Codex 在任何 Issue 或 PR 中直接接手 | 不支持 Issue 中的 @ 处理 |
| 与 CLI 一致性 | GitHub UI 与 CLI 使用相同的提示词、模型和配置 | 行为存在差异 |

Builder.io 的评价是：Codex 的 GitHub 集成「从发现问题到修复的闭环无缝衔接」，而 Claude Code 的集成「体验糟糕」。

Builder.io 的团队工作流（不局限于终端用户）：

- 设计师直接在 Builder.io 中通过提示词和类 Figma 可视化编辑器使用 Codex 更新站点和应用
- 完成后直接发送 PR，工程师审查合并
- 所有人使用相同的代码库、相同的模型、相同的 `AGENTS.md`

## 常见问题解答

**2026 年 Codex 是否仍然优于 Claude Code？**

Codex 在 GitHub 集成和定价上仍然胜出。但 Claude Code 已显著缩小差距——更好的 UX、VS Code 扩展、网页 IDE 和 Cowork 模式。如何选择取决于工作流：重度终端用户、重视 GitHub 自动化选 Codex；需要更多配置选项和 hooks 选 Claude Code。

**预算有限选哪个？**

Codex Pro 性价比更高——更低的价位获得更多用量，同时捆绑 ChatGPT、图像生成和视频生成，而不仅仅是编程计划。

**可以同时使用两者吗？**

可以，很多团队也这样做——用 Codex 处理后台 GitHub 任务，用 Claude Code 处理终端会话（需要更多 slash commands 和 hooks）。

**Cursor 仍然相关吗？**

仍然相关。Cursor 在 IDE 体验上仍然领先，对从 VS Code 转过来的开发者最熟悉。Bugbot 在代码审查上也表现出色。

**Claude Code 仍然不支持 AGENTS.md 吗？**

截至本文写作时确认，Claude Code 仅支持 `CLAUDE.md`。如果想一个指令文件通用于所有工具，为 Codex、Cursor、Builder.io 使用 `AGENTS.md`，再为 Claude Code 维护一份同步的 `CLAUDE.md`。

**三个工具可以一起用吗？**

可以。Builder.io 的做法是：在视觉层之上使用这些智能体，设计师和产品经理不需要在终端操作，通过类 Figma 编辑器与 Codex 或 Claude Code 交互，所有人最终在同一个代码库上工作，PR 从另一端出来。

# 快速上手

## 第一步：选择接入方式

| 场景 | 推荐方式 |
| :--- | :--- |
| 多项目并行、团队协作 | [Codex App](#codex-应用桌面-app) |
| 终端重度用户、自动化脚本 | [Codex CLI](#cli命令行) |
| IDE 内联使用、不切换上下文 | [IDE 插件](#ide-插件) |
| 云端任务、远程协作、PR 自动化 | [网页版](#网页版) |
| 接入自有系统 | [Codex SDK](https://developers.openai.com/codex/sdk) |

## 第二步：连接 ChatGPT 账号

所有接入方式均支持使用 ChatGPT 账号登录（Plus/Pro/Business/Edu/Enterprise）或 OpenAI API Key 登录。使用 API Key 时部分功能（如 Cloud Threads）可能不可用。

## 第三步：创建 Git 检查点

Codex 会修改代码库，建议在每个任务前后创建 Git checkpoint 方便回滚：

```bash
git checkout -b feature/codex-task-1
# 任务完成后
git checkout main && git branch -D feature/codex-task-1
```

## 第四步：编写 AGENTS.md（推荐）

在项目根目录创建 `AGENTS.md`，定义 Codex 在该项目中应遵循的规范、代码风格、常用命令等。Codex 会自动读取并遵循。例如本博客仓库的 `CLAUDE.md` 就是类似作用。详见 [Builder.io 的 AGENTS.md 指南](https://www.builder.io/blog/agents-md)。

准备好后，前往[参考资料](#参考资料)获取所有官方资源链接。

# 参考资料

| 分类 | 内容 | 链接 |
| :--- | :--- | :--- |
| 官方 | Codex 官方首页 | [chatgpt.com/codex](https://chatgpt.com/codex) |
| 官方 | OpenAI Codex 中文页 | [openai.com/zh-Hans-CN/codex](https://openai.com/zh-Hans-CN/codex/) |
| 官方 | GitHub 仓库（CLI 开源） | [github.com/openai/codex](https://github.com/openai/codex) |
| 官方 | 开发者文档 | [developers.openai.com/codex](https://developers.openai.com/codex) |
| 官方 | 定价与用量限制 | [developers.openai.com/codex/pricing](https://developers.openai.com/codex/pricing) |
| 官方 | 快速入门指南 | [developers.openai.com/codex/quickstart](https://developers.openai.com/codex/quickstart) |
| 官方 | CLI 详细文档 | [developers.openai.com/codex/cli](https://developers.openai.com/codex/cli) |
| 官方 | App 文档 | [developers.openai.com/codex/app](https://developers.openai.com/codex/app) |
| 官方 | IDE 插件文档 | [developers.openai.com/codex/ide](https://developers.openai.com/codex/ide) |
| 官方 | GitHub 集成 | [developers.openai.com/codex/integrations/github](https://developers.openai.com/codex/integrations/github) |
| 官方 | Slack 集成 | [developers.openai.com/codex/integrations/slack](https://developers.openai.com/codex/integrations/slack) |
| 官方 | Codex SDK | [developers.openai.com/codex/sdk](https://developers.openai.com/codex/sdk) |
| 官方 | 使用条款（Plus/Pro） | [help.openai.com — your data](https://help.openai.com/en/articles/5722486-how-your-data-is-used-to-improve-model-performance) |
| 社区 | Reddit r/codex | [reddit.com/r/codex](https://www.reddit.com/r/codex/) |
| 第三方 | Builder.io — Codex vs Claude Code 对比 | [builder.io/blog/codex-vs-claude-code](https://www.builder.io/blog/codex-vs-claude-code) |
| 博客 | Builder.io — Writing a good AGENTS.md | [builder.io/blog/agents-md](https://www.builder.io/blog/agents-md) |
| 博客 | Builder.io — Cursor Tips | [builder.io/blog/cursor-tips](https://www.builder.io/blog/cursor-tips) |
| 博客 | Builder.io — Claude Code Tips | [builder.io/blog/claude-code](https://www.builder.io/blog/claude-code) |
| 开源 | Chirpy 主题使用指南（本文参考格式） | [2026-03-21-chirpy-theme-in-action](/_posts/2026-03-21-chirpy-theme-in-action.markdown) |
