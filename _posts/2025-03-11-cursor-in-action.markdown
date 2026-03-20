---
layout: post
title:  "Cursor in Action"
date:   2025-03-11 12:30:00 +0800
categories: ML
tags:
  - Cursor
  - Machine Learning

---

* Do not remove this line (it will not be displayed)
{:toc}


# 背景介绍

> Built to make you extraordinarily productive, **Cursor** is the best way to code with AI.

`Cursor` 是 `VS Code` 的一个分支。这使我们能够专注于与 AI 进行编码的最佳方式，同时提供熟悉的文本编辑体验。

![cursor0](/assets/images/202503/cursor0.png)

Cursor 背后的公司于 2023 年在旧金山成立，主要开发利用 LLM 从基层建立的 IDE。创始团队目前 2 位已获得 OpenAI 的投资：

* Aman Sanger，2022 年毕业于麻省理工学院数学与计算机科学专业，Abelian AI 联合创始人
* Michael Truell，2022 年毕业于麻省理工学院数学与计算机科学专业。

可以通过作者 Aman Sanger 在[Twitter 上的一个视频](https://twitter.com/amanrsanger/status/1615539968772050946?cxt=HHwWhMDU8djCxussAAAA)来评测它的功能，这个视频一共执行了五条指令：

1. Build the `SearchResult component showing file icons, names, and paths
2. Connect this component to redux
3. How do I add a keyboard shortcut in electron?
4. Where in the code are shortcuts and redux reducers to open file search
5. Make cmd+p with label File Search open file search





# 常用功能


## [Cursor Tab](https://cursor.com/docs/tab/overview) (选项卡)

`Tab` is a specialized Cursor model for autocompletion. The more you use it, the better it becomes as you inject intent by accepting `Tab` or rejecting `Escape` suggestions. With `Tab`, you can:

* Modify multiple lines at once
* Add import statements when missing
* Jump within and across files for coordinated edits
* Get suggestions based on recent changes, linter errors and accepted edits


`Cursor Tab` 是本地的自动补全功能。它是一个更强大的 Copilot，能够建议整个差异，并具有特别好的记忆。由自定义模型驱动，`Cursor Tab` 可以：

* 在光标周围建议编辑，而不仅仅是插入额外的代码。
* 同时修改多行。
* 根据您最近的更改和 linter 错误提出建议。

免费用户可以免费获得 2000 个建议。专业版和商业版计划可以获得无限建议。

> 用户界面

当 Cursor 仅添加额外文本时，补全将以灰色文本显示。如果建议修改现有代码，它将作为差异弹出窗口出现在当前行的右侧。

![cursor1](/assets/images/202503/cursor1.png)

![cursor2](/assets/images/202503/cursor2.png)

可以通过按 `Tab` 接受建议，或通过按 `Esc` 拒绝建议。要逐字部分接受建议，请按 `Ctrl/⌘ →`。要拒绝建议，只需继续输入，或使用 `Escape` 取消/隐藏建议。

每次按键或光标移动时，Cursor 将尝试根据您最近的更改提出建议。然而，Cursor 并不总是会显示建议；有时模型预测没有需要更改的内容。

Cursor 可以对当前行上方一行到下方两行进行更改。

> 切换

要打开或关闭此功能，请将鼠标悬停在应用程序右下角状态栏上的“Cursor Tab”图标上。

> 在写评论时 Tab 会妨碍我，我该怎么办？

可以通过进入 `Cursor Settings` > `Tab Completion` 并取消选中“在评论中触发”来禁用评论中的 `Cursor Tab`。


## [Codebase Indexing](https://cursor.com/cn/docs/context/codebase-indexing) (代码库索引)

为了更好、更准确地使用 `@codebase` 或 `Ctrl/⌘ Enter` 获取代码库答案，用户可以索引用户的代码库。在后台，Cursor 为用户代码库中的每个文件计算嵌入，并将使用这些嵌入来提高代码库答案的准确性。

用户的代码库索引将自动与用户最新的代码库更改同步。

用户代码库索引的状态在 `Cursor 设置` > `功能` > `代码库索引` 下。

![cursor5](/assets/images/202503/cursor5.png)

> 高级设置

默认情况下，Cursor 将索引用户代码库中的所有文件。

用户还可以展开**显示设置**部分以访问更多高级选项。在这里，**用户可以决定是否要为新仓库启用自动索引，并配置 Cursor 在仓库索引期间将忽略的文件**，除了用户的 `.gitignore` 设置。

**如果用户的项目中有任何大型内容文件，AI 确实不需要读取，[忽略这些文件](https://cursordocs.com/docs/context/ignore-files)可能会提高答案的准确性**。


> 基本用法

在 Cursor 的 AI 输入框中，例如在 Cmd K、聊天或终端 Cmd K，用户可以通过输入 `@` 符号来使用 @ 符号。弹出菜单将出现，列出建议，并会根据用户的输入自动过滤，仅显示最相关的建议。

用户可以使用上下箭头键在建议列表中导航。用户可以按 `Enter` 选择一个建议。如果建议是一个类别，例如**文件**，建议将被过滤，仅显示该类别中最相关的项目。

![cursor6](/assets/images/202503/cursor6.png)

用户可以使用上下箭头键在选定的 Cmd K @ 符号列表中导航，按 Enter 展开/折叠选定的上下文项。对于文件引用，用户可以使用 `Ctrl/⌘ M` 切换文件读取策略。有关文件读取策略的更多信息，请[点击这里](https://cursordocs.com/docs/context/@-symbols/@-files#cmd-k-chunking-strategy)。



## [Rules](https://cursor.com/docs/context/rules)

Rules provide system-level instructions to Agent and Inline Edit. They are persistent context, preferences, or workflows for your projects.

Cursor supports four types of rules:

1. **Project Rules**. Stored in `.cursor/rules`, version-controlled and scoped to your codebase.
2. **User Rules**. Global to your Cursor environment. Defined in settings and always applied.
3. **Team Rules**. Team-wide rules managed from the dashboard. Available on Team and Enterprise plans.
4. **AGENTS.md**. Agent instructions in markdown format. Simple alternative to `.cursor/rules`.

> How rules work?

**Large language models don't retain memory between completions. Rules provide persistent, reusable context at the prompt level**.

When applied, rule contents are included at the start of the model context. This gives the AI consistent guidance for generating code, interpreting edits, or helping with workflows.

> Best practices

Good rules are focused, actionable, and scoped.

* Keep rules under 500 lines
* Split large rules into multiple, composable rules
* Provide concrete examples or referenced files
* Avoid vague guidance. Write rules like clear internal docs
* Reuse rules when repeating prompts in chat



### [配置规则](https://cursor.document.top/tips/usage/set-rules/)

Cursor 的 `.cursorrules` 功能为 AI 助手提供了一个定制化的 Prompt。

通过在项目的根目录放置 `.cursorrules` 文件，我们可以在这个文件里提供更多用与 Cursor 编辑的上下问，比如可以：

1. 指定项目的技术栈
2. 设定开发规范
3. 引导 AI 的问题解决思路
4. 创建自定义指令

这样的预设能显著提高 Curosr 生成代码的准确性和相关性，使其更好地符合项目需求。

### 参考其他人的规则

* [Cursor Directory](https://cursor.directory/)
* [cursorlist](https://cursorlist.com/)
* [awesome-cursorrules](https://github.com/PatrickJS/awesome-cursorrules)

这些仓库都维护了各种开发语言的规则。可以选择适合自己的直接使用，或者参考修改一份。

### 自动生成规则

可以在这个网站描述自己的需求然后生成规则 https://cursorrules.agnt.one/


More: https://docs.cursor.com/context/rules-for-ai


## [Cursor Agent](https://cursor.com/docs/agent/overview)

Agent is Cursor's assistant that can complete complex coding tasks independently, run terminal commands, and edit code. Access in sidepane with
`Cmd+I`.

Learn more about [how agents work](https://cursor.com/learn/agents) and help your build faster.


### [Browser](https://cursor.com/docs/agent/browser) (浏览器)

Agent can control a web browser to test applications, audit accessibility, convert designs into code, and more. With full access to console logs and network traffic, Agent can debug issues and automate comprehensive testing workflows.

### [Tools](https://cursor.com/docs/agent/tools) (工具)

A list of all tools available to modes within the Agent, which you can enable or disable when building your own [custom modes](https://cursor.com/docs/agent/modes#custom).

To understand how tool calling works under the hood, see our [tool calling fundamentals](https://cursor.com/learn/tool-calling).





# Tips

## 安装

Cursor 是一款集成了 AI 技术的代码编辑器，支持多种操作系统，包括 Windows、macOS 和 Linux。

> 注册与登录

首次使用 Cursor 时，需要注册一个新账号或使用已有账号进行登录。注册过程简单，只需填写必要的个人信息。登录后，可以创建新项目或打开已有项目。

> 使用功能

Cursor 提供了强大的代码生成和优化功能。用户可以通过输入需求或描述来生成代码，并与代码进行对话以获取反馈和建议。

## 导入扩展、主题、设置和快捷键

可以通过一键将已有的 VS Code 配置导入到 Cursor。导航到 `Cursor Settings` > `General` > `Account`。

## 为什么不使用扩展？

作为一个独立应用程序，Cursor 对编辑器的 UI 有更多控制，从而实现更大的 AI 集成。我们的一些功能，如 `Cursor Tab` 和 `CMD-K`，作为现有编码环境的插件是不可行的。

## Cursor 特定的设置面板

可以通过点击右上角的齿轮按钮，按 `Ctrl/⌘ + Shift + J`，或使用 `Ctrl/⌘ + Shift + P` 并输入 `Cursor Settings` 来打开 Cursor 特定的设置面板。

## 为什么 Cursor 中的活动栏是水平的？

活动栏默认是水平的，以节省聊天空间。如果更喜欢正常的垂直活动栏，可以前往 VS Code 设置，将 `workbench.activityBar.orientation` 设置为 `vertical`，然后重启 Cursor。

## 有关定价信息

请访问 [Cursor Pricing](https://cursor.com/pricing)。Cursor 提供多个订阅层级以满足用户的需求。

* 爱好者
  + 14 天 专业试用（250 次快速 premium 模型使用）
  + 50 次慢速 premium 模型使用
  + 2000 次 完成 使用

* 专业版
  + 每月 500 次快速 premium 模型使用
  + 无限次慢速 premium 模型使用
  + 无限次 完成 完成
  + 每月 10 次 o1+mini 使用

* 企业版
  + 使用信息与 专业版 相同
  + 全组织强制隐私模式
  + 集中团队计费
  + 带有使用统计的管理员仪表板
  + SAML/OIDC 单点登录

> Premium 模型

`GPT-4`、`GPT-4o` 和 `Claude 3.5 Sonnet` 都被视为 **premium** 模型。每次请求 `Claude 3.5 Haiku` 被计为 `1/3` 次 **premium** 模型请求。

> 专业试用

所有新用户均可获得 14 天的专业试用，允许访问所有专业功能和 250 次快速 **premium** 模型请求。在 14 天期满后，未升级的用户将恢复到爱好者计划。

> 快速和慢速请求

默认情况下，Cursor 服务器会尽量为所有用户提供快速 premium 模型请求。然而，在高峰期，快速 premium 信用用尽的用户将被转移到慢速池，这基本上是等待快速 premium 请求可用的用户队列。

这个队列是公平的，Cursor 将尽一切可能保持队列尽可能短。然而，如果需要更多快速 premium 信用且不想等待，可以在[设置页面](https://cursor.com/settings)上添加更多请求。

> 检查您的使用情况

可以在 Cursor 设置 页面上检查使用情况。也可以在 Cursor 应用程序内访问此页面，路径为 `Cursor Settings` > `General` > `Account`，并按“管理订阅”以供专业用户使用，或“管理”以供企业用户使用。

Cursor 使用情况每月重置，基于用户的订阅开始日期。

# 对话技巧

* **多用 Git 保存分阶段提交可用的代码**，虽然 Cursor 生成代码的能力很强，但是有时生成大量的代码被 Accept All 后容易让整个项目运行失败，建议分阶段提交代码，这样遇到问题可以回滚。

* **一个 Cursor 窗口打开一整个项目**，Cursor 默认的上下文目录就是这个目录，如果这个目录的范围太大或者太小都不利于代码生成。

* Cursor 有时会只给出修改的部分代码，其它则忽略掉，这样在 Accept All 后会破坏已有的代码。**可以在全局 rules 里写明要生成完整的代码，也可以在对话的时候强调**。


# [Privacy Policy](https://www.cursor.com/privacy)

**TLDR**

* If you enable "Privacy Mode" in Cursor's settings: **zero data retention will be enabled, and none of your code will ever be stored or trained on by us or any third-party.**

* If you choose to keep "Privacy Mode" off, we collect telemetry and usage data. This may include prompts, editor actions, code snippets, and edits made to this code. We use this data to evaluate and improve our AI features.

* With "Privacy Mode" off, if you use autocomplete, Fireworks (our inference provider) may also collect prompts to improve inference speed.

**Other notes**

* Even if you use your API key, your requests will still go through our backend! That's where we do our final prompt building.

* **If you choose to index your codebase, Cursor will upload your codebase in small chunks to our server to compute embeddings, but all plaintext code ceases to exist after the life of the request. The embeddings and metadata about your codebase (hashes, file names) may be stored in our database, but none of your code is**.

* **We temporarily cache file contents on our servers to reduce latency and network usage**. The files are encrypted using unique client-generated keys, and these encryption keys only exist on our servers for the duration of a request. All cached file contents are temporary, never permanently stored, and never used as training data when privacy mode is enabled.


# [Changelog](https://www.cursor.com/changelog)

https://www.cursor.com/changelog

## 0.49.x - April 15, 2025

### Automated and improved rules

You can now generate rules directly from a conversation using the `/Generate Cursor Rules` command. This is useful when you want to capture the existing context of a conversation to reuse later.

For `Auto Attached` rules with path patterns defined, Agent will now automatically apply the right rules when reading or writing files

We’ve also fixed a long-standing issue where `Always` attached rules now persist across longer conversations. Agent can now also edit rules reliably.

![cursor6](/assets/images/202504/cursor6.png)

![cursor1](/assets/images/202504/cursor1.png)

![cursor4](/assets/images/202504/cursor4.png)

More: https://docs.cursor.com/context/rules

### More accessible history

Chat history has moved into the command palette. You can access it from the "Show history button" in Chat as well as through the `Show Chat History` command

![cursor3](/assets/images/202504/cursor3.png)


### Making reviews easier

Reviewing agent generated code is now easier with a built-in diff view at the end of each conversation. You'll find the `Review changes` button at the bottom of chat after a message from the agent.

### Images in MCP

You can now pass images as part of the context in MCP servers. This helps when screenshots, UI mocks, or diagrams add essential context to a question or prompt.


### Improved agent terminal control

We've added more control for you over terminals started by the agent. **Commands can now be edited before they run**, or skipped entirely. We've also renamed "Pop-out" to "Move to background" to better reflect what it does.


### Global ignore files

You can now define [global ignore](https://docs.cursor.com/context/ignore-files) patterns that apply across all projects via your user-level settings. This keeps noisy or sensitive files like build outputs or secrets out of prompts, without needing per-project configuration.

**Ignore Files** - Control which files Cursor’s AI features and indexing can access using `.cursorignore` and `.cursorindexingignore`

Cursor reads and indexes your project’s codebase to power its features. You can control which directories and files Cursor can access by adding a `.cursorignore` file to your root directory.

Cursor makes its best effort to block access to files listed in `.cursorignore` from:

* Codebase indexing
* Code accessible by [Tab](https://docs.cursor.com/tab/overview), [Chat](https://docs.cursor.com/chat/overview), and [⌘K](https://docs.cursor.com/cmdk/overview)
* Code accessible via [@ symbol references](https://docs.cursor.com/context/@-symbols/overview)

> Note: Tool calls initiated by Cursor’s Chat feature to services like Terminal and MCP servers are not currently able to block access to code governed by `.cursorignore`

**Global Ignore Files** - You can now define ignore patterns that apply across all projects via your user-level settings. This keeps noisy or sensitive files like build outputs or secrets out of prompts, without needing per-project configuration.


**Why Ignore Files?** - There are two common reasons to configure Cursor to ignore portions of your codebase:

* **Security**

While your codebase is not permanently stored on Cursor’s servers or the LLMs that power its features, you may still want to restrict access to certain files for security reasons, such as files containing API keys, database credentials, and other secrets.

Cursor makes its best effort to block access to ignored files, but due to unpredictable LLM behavior, we cannot guarantee these files will never be exposed.

* **Performance**

If you work in a monorepo or very large codebase where significant portions are irrelevant to the code you’re developing, you might consider configuring Cursor to ignore these parts of the application.

By excluding irrelevant parts of the codebase, Cursor will index large codebases faster and find files with more speed and accuracy when searching for context.

Cursor is designed to support large codebases and is skilled at assessing file relevancy, but the ignore feature is helpful when using a codebase that is especially large or includes files immaterial to your development.

**Configuring `.cursorignore`**

To implement Cursor’s ignore feature, add a `.cursorignore` file to the root of your codebase’s directory and list the directories and files to be ignored.

The `.cursorignore` file uses pattern matching syntax identical to that used in `.gitignore` files.

Basic Pattern Examples

{% highlight bash %}
# Ignore specific file `config.json`
config.json

# Ignore `dist` directory and all files inside
dist/

# Ignore all files with a `.log` extension
*.log
{% endhighlight %}

Advanced Pattern Examples

{% highlight bash %}
# Ignore entire codebase
*

# Do not ignore `app` directory
!app/

# Ignores logs directories in any directory
**/logs
{% endhighlight %}

### New models

We've recently added many more [models](https://docs.cursor.com/settings/models) you can use. Try out Gemini 2.5 Pro, Gemini 2.5 Flash, Grok 3, Grok 3 Mini, GPT-4.1, o3 and o4-mini from model settings.


**Models** - Comprehensive guide to Cursor’s models: features, pricing, context windows, and hosting details for Chat and CMD+K


![cursor5](/assets/images/202504/cursor5.png)


## 2.0 - Oct 29, 2025

### 多智能体

在我们的全新编辑器中管理智能代理，侧边栏可查看和管理你的代理与计划。

在单个提示下最多可并行运行八个代理。为避免文件冲突，系统会使用 Git worktree 或远程机器。每个代理都在其各自隔离的代码库副本中运行。

### Composer 组合器

隆重推出我们的首款智能代理编码模型。Composer 是一款前沿模型，比同等智能的模型快 4 倍。

### 浏览器（正式版）

Agent 的浏览器功能在 1.7 版本以测试版上线，如今已正式发布（GA）。我们在 2.0 中进一步支持 企业 团队使用 Browser。浏览器现已可内嵌在编辑器中，并提供强大的新工具，用于选择元素并将 DOM 信息转发给代理。了解更多关于使用浏览器的详情。


### 性能提升

Cursor 使用**语言服务器协议**（`LSP`）来提供特定语言的功能，例如跳转到定义、悬停提示、诊断等。我们大幅提升了所有语言的 LSP 加载和使用性能。在使用代理助手并查看差异时，提升尤为明显。针对大型项目，Python 和 TypeScript 的 LSP 现在默认运行更快，并会根据可用 RAM 动态提升内存上限。我们还修复了多处内存泄漏，并优化了整体内存占用。



## 2.1 - Nov 21, 2025

### 改进的 Plan 模式

在创建计划时，Cursor 会先提出一些澄清性问题，以提升计划质量。现在 Cursor 提供了交互式界面，让你可以更方便地回答这些问题。你还可以使用 `⌘+F` 在生成的计划中进行搜索。

### AI 代码评审

你现在可以在 Cursor 中直接通过 AI 代码评审来发现并修复 bug。它会检查你的改动并找出问题，你可以在侧边栏中查看。这也是对 Bugbot 的补充。Bugbot 运行在你的代码托管平台上，如 GitHub（包括 Enterprise Server）、GitLab 等。

## 2.2 - Dec 10, 2025

### 调试模式

调试模式可以帮助你查明问题根源，并修复那些难以复现或理解的棘手 Bug。智能体不会立刻开始写代码，而是先提出假设、插入日志语句，并利用运行时信息精确定位问题，然后再进行有针对性的修复。

![cursor_changelog1](/assets/images/202601/cursor_changelog1.png)

More:

* [重磅推出 Debug Mode：带运行时日志的 Agent](https://cursor.com/cn/blog/debug-mode)
* [何时使用 Debug 模式](https://cursor.com/cn/docs/agent/modes#debug)

**Debug 模式最适合用于处理：**

1. 可复现的棘手 bug 或回归问题
2. 性能问题和内存泄漏

**调试模式使用提示：**

1. **提供详细上下文**：你对 bug 及其复现方式描述得越详细，Agent 就能添加越多相关的监控和埋点。
2. **按照复现步骤执行**：执行 Agent 提供的步骤，确保日志能捕获到实际问题。
3. **必要时多次复现**：多次复现 bug 可以帮助 Agent 识别比较棘手的问题。

**工作原理：**

1. **探索并提出假设**：Agent 会探索相关文件、构建上下文，并针对潜在根因生成假设。
2. **添加埋点**：Agent 会添加日志语句，将数据发送到运行在 Cursor 扩展中的本地调试服务器。
3. **复现 Bug**：Debug Mode 会让你复现 Bug 并提供具体步骤。这能让你始终参与其中，并确保 Agent 捕获到真实的运行时行为。
4. **分析日志**：复现完成后，Agent 会审查收集到的日志，根据运行时证据识别真正的根因。
5. **进行针对性修复**：Agent 会执行有针对性的修复，直接处理根因——通常只需要改动几行代码。
6. **验证并清理**：你可以重新执行复现步骤来验证修复。一旦确认，Agent 会移除所有埋点。

### 浏览器布局和样式编辑器

借助全新的浏览器侧边栏和组件树，同时进行设计与编码。移动元素、更新颜色、测试布局并实时调整 CSS，然后使用 agent 将更改即时应用到你的代码库中。你也可以选中多个元素，通过文字描述你想要的修改，让 agent 自动完成视觉调整。

More: [Cursor Browser 的可视化编辑器](https://cursor.com/cn/blog/browser-visual-editor)


### 多智能体评估

在并行运行多个 Agent 时，Cursor 现在会自动对所有运行结果进行评估，并推荐最佳方案。被选中的 Agent 会附带一条注释，说明其被选中的原因。对最佳方案的评估只会在所有并行 Agent 全部完成之后进行。

![cursor_changelog4](/assets/images/202601/cursor_changelog4.png)

### 置顶对话

在 Agent 侧边栏中，将对话置顶到顶部以便日后查阅。

![cursor_changelog5](/assets/images/202601/cursor_changelog5.png)



## 2.4 - Jan 22, 2026


### 子代理（Subagents）

子代理是独立的代理，用于专门处理父代理任务中彼此独立的部分。它们并行运行，使用各自的上下文，并且可以配置自定义提示词、工具访问权限和模型。

这样可以带来更快的整体执行速度、在主对话中提供更聚焦的上下文，以及针对每个子任务的专业能力。Cursor 默认提供用于分析你的代码库、运行终端命令和执行并行工作流的子代理。这些子代理会自动帮助提升你在编辑器和 [Cursor CLI](https://cursor.com/docs/cli/overview) 中的代理对话质量。你也可以按需定义自定义子代理。访问我们的[文档](https://cursor.com/docs/context/subagents)了解更多信息。


### 技能

Cursor 现在在编辑器和 [CLI](https://cursor.com/docs/cli/overview) 中支持 [Agent Skills](https://cursor.com/docs/context/skills)。当与特定领域的知识和工作流相关时，Agent 可以发现并应用这些技能。你也可以通过斜杠命令菜单来调用某个技能。


子代理、技能与图像生成
Agents 正在你的整个代码库中处理越来越复杂、运行时间更长的任务。本次版本引入了新的 agent 框架改进，以实现更好的上下文管理，并在编辑器和 CLI 中带来了许多提升使用体验的修复。

#子代理（Subagents）
子代理是独立的代理，用于专门处理父代理任务中彼此独立的部分。它们并行运行，使用各自的上下文，并且可以配置自定义提示词、工具访问权限和模型。

0:15

这样可以带来更快的整体执行速度、在主对话中提供更聚焦的上下文，以及针对每个子任务的专业能力。

Cursor 默认提供用于分析你的代码库、运行终端命令和执行并行工作流的子代理。这些子代理会自动帮助提升你在编辑器和 Cursor CLI 中的代理对话质量。

你也可以按需定义自定义子代理。访问我们的文档了解更多信息。

#技能
Cursor 现在在编辑器和 CLI 中支持 Agent Skills。当与特定领域的知识和工作流相关时，Agent 可以发现并应用这些技能。你也可以通过斜杠命令菜单来调用某个技能。

0:11

在 `SKILL.md` 文件中定义技能，其中可以包含自定义命令、脚本，以及用于根据当前任务增强 Agent 能力的说明。与始终生效的声明式 [rules](https://cursor.com/docs/context/rules) 相比，技能更适合用于[动态上下文发现](https://cursor.com/blog/dynamic-context-discovery)和过程式的“操作指南”类说明。这样既能让 Agent 拥有更高的灵活性，又能让上下文保持聚焦。


### 图像生成

直接通过 Cursor 的智能体生成图像。你可以用文字描述图像，或上传参考图片来引导底层图像生成模型（Google Nano Banana Pro）。

生成的图像会以内联预览的形式返回，并默认保存到你的项目 `assets/` 文件夹中。这对于创建 UI 原型图、产品素材以及可视化架构图非常有用。



### Cursor Blame 责任追踪

在企业版中，[Cursor Blame](https://cursor.com/docs/integrations/cursor-blame) 在传统 git blame 的基础上加入 AI 归因，让你能清楚看到哪些代码是由 AI 生成、哪些是由人工编写。

在审查或回顾代码时，每一行都会链接到生成该行代码的会话摘要，为你提供更改背后的上下文和推理过程。Cursor Blame 会区分来自 Tab 自动补全、Agent 运行（按模型细分）以及人工编辑的代码。它还可以帮助你跟踪整个团队代码库中的 AI 使用模式。



### 来自 Agent 的澄清提问

在 Plan 和 Debug 模式下供 Agent 使用的交互式问答工具，现在允许 Agent 在任何对话中提出澄清问题。

在等待你的回复时，Agent 可以继续阅读文件、进行编辑或运行命令，并在你的回答到达后立即将其纳入后续操作。你还可以通过指示自定义子 Agent 和技能 "use the ask question tool"，来构建使用此工具的自定义子 Agent 和技能。








# Q&A

## What is a `.mdc` file?

https://forum.cursor.com/t/what-is-a-mdc-file/50417

Q: When adding a new rule file to `cursor/rules`, cursor automatically creates a `.mdc` file. There is no mention of this file type or how the actual description of the rule should be formatted.

A:

![cursor2](/assets/images/202504/cursor2.png)


# 高级功能


## [模式](https://cursor.com/cn/docs/agent/modes) (Mode)

**Agent 提供针对特定任务优化的不同模式**。每种模式都启用了不同的能力和工具，以匹配你的工作流程需求。了解 [Agent 的工作原理](https://cursor.com/learn/agents)和[工具调用基础](https://cursor.com/learn/tool-calling)将帮助你为当前任务选择合适的模式。

| **模式** | **适用场景** | **能力** | **工具**
| -- | -- | -- | --
| [Agent](https://cursor.com/cn/docs/agent/modes#agent) | 复杂功能、重构 | 自主探索、多文件编辑 | 启用全部工具
| [Ask](https://cursor.com/cn/docs/agent/modes#ask) | 学习、规划、提问 | 只读探索，无自动修改 | 仅启用搜索工具
| [Plan](https://cursor.com/cn/docs/agent/modes#plan) | 需要规划的复杂功能 | 在执行前创建详细计划，并提出澄清性问题 | 启用全部工具
| [Debug](https://cursor.com/cn/docs/agent/modes#debug) | 棘手 Bug、回归问题 | 生成假设、日志埋点、运行时分析 | 全部工具 + 调试服务器


### Agent

适用于复杂编码任务的默认模式。Agent 会自主探索你的代码库、编辑多个文件、运行命令并修复错误，以完成你的请求。

![agent_mode2](/assets/images/202601/agent_mode2.png)

### Ask

用于学习和探索的只读模式。Ask 会搜索你的代码库并提供答案，且不会对代码做出任何更改——非常适合在修改代码前先理解代码。

![agent_mode3](/assets/images/202601/agent_mode3.png)

### Plan

Plan 模式会在编写任何代码之前先创建详细的实现计划。Agent 会分析你的代码库、提出澄清性问题，并生成一个可在构建前编辑的审阅用计划。在聊天输入框中按 `Shift+Tab` 以切换到 Plan 模式。**当你输入表明任务较为复杂的关键词时，Cursor 也会自动建议切换到该模式**。

#### 工作原理

1. Agent 会先提出一些澄清性问题，以了解你的需求
2. 分析你的代码库以获取相关上下文
3. 创建一份完整的实现计划
4. 你可以通过聊天或 Markdown 文件审阅并编辑该计划
5. 准备就绪后，点击构建该计划

计划会以临时虚拟文件的形式打开，你可以查看和编辑。要将计划保存到你的工作区，点击 “Save to workspace”，它会被存储到 `.cursor/plans/` 中，方便后续查阅、团队协作和编写文档。

#### 何时使用 Plan 模式

Plan 模式最适合：

* 具有多种可行方案的复杂功能
* 涉及许多文件或多个系统的任务
* 需求不清晰、需要先探索再厘清范围的工作
* 你希望先审查整体方案的架构决策

**对于一些简单、能很快完成的改动，或者你已经做过很多次的任务，直接使用 Agent 模式就可以了**。

#### 从计划重新开始

**有时 Agent 生成的内容和你想要的不一致。与其通过后续提示一点点修补，不如回到计划本身**。先回滚这些更改，然后把计划写得更具体、更清晰，再重新运行。这样通常比在中途修 Agent 更快，而且结果也更干净。

> **对于较大的改动，多花一些时间制定一个精确、范围清晰的计划。最难的部分往往是先弄清楚应该做什么改动——这更适合由人来完成。给出合适的指令后，再把具体实现交给 Agent。**


### Debug

调试模式可以帮助你查明问题根源，并修复那些难以复现或理解的棘手 Bug。智能体不会立刻开始写代码，而是先提出假设、插入日志语句，并利用运行时信息精确定位问题，然后再进行有针对性的修复。

![agent_mode4](/assets/images/202601/agent_mode4.png)

#### 何时使用 Debug 模式

Debug 模式最适合用于：

* **能复现但想不明白原因的 Bug**：你知道有问题，但单靠读代码看不出明显原因
* **竞态条件和时序问题**：依赖执行顺序或异步行为的问题
* **性能问题和内存泄漏**：需要运行时性能分析（profiling）才能搞清楚的问题
* **回归问题（以前能用现在坏了）**：当你需要追踪到底改了什么时

当标准 Agent 交互难以处理某个 Bug 时，**Debug 模式提供了一种不同的思路——依赖运行时证据，而不是凭猜测去修复**。

#### 工作原理

1. **探索并提出假设**：Agent 会探索相关文件、构建上下文，并针对潜在根因生成多个假设。
2. **添加埋点**：Agent 会添加日志语句，将数据发送到运行在 Cursor 扩展中的本地调试服务器。
3. **复现 Bug**：Debug Mode 会让你复现 Bug 并提供具体步骤。这能让你始终参与其中，并确保 Agent 捕获到真实的运行时行为。
4. **分析日志**：复现完成后，Agent 会审查收集到的日志，根据运行时证据识别真正的根因。
5. **进行针对性修复**：Agent 会执行有针对性的修复，直接处理根因——通常只需要改动几行代码。
6. **验证并清理**：你可以重新执行复现步骤来验证修复。一旦确认，Agent 会移除所有埋点。

#### 调试模式使用提示

* **提供详细上下文**：你对 bug 及其复现方式描述得越详细，Agent 的监控和埋点效果就会越好。请包含错误信息、堆栈跟踪和具体步骤。
* **严格按照复现步骤执行**：执行 Agent 提供的步骤，确保日志能捕获到实际问题。
* **必要时多次复现**：多次复现 bug 可以帮助 Agent 识别比较棘手的问题，比如竞态条件。
* **明确期望行为与实际行为**：帮助 Agent 理解应该发生什么，以及现在实际发生了什么。













## [Agent Review](https://cursor.com/cn/docs/agent/review#agent-review)

> 你现在可以在 Cursor 中直接通过 AI 代码评审来发现并修复 bug。它会检查你的改动并找出问题，你可以在侧边栏中查看。这也是对 Bugbot 的补充。Bugbot 运行在你的代码托管平台上，如 GitHub（包括 Enterprise Server）、GitLab 等。

Agent Review 会以专用模式运行 Cursor Agent，专注于发现你 diff 中的缺陷。该工具会逐行分析提议的变更，并在你合并前标记潜在问题。

使用 Agent Review 有两种方式：在 agent diff 中使用，或在 Source Control 选项卡中使用。

* Agent Diff
  + 查看 Agent 差异的结果：在收到响应后，点击 Review，然后点击 Find Issues，以分析建议的修改并生成后续建议。

* Source Control
  + 审查所有相对于主分支的更改：打开 Source Control 选项卡并运行 Agent Review，以检查本地更改与主分支之间的所有差异。


**计费**

运行 Agent Review 会触发一次 Agent 运行，并按使用量计费。



## [Bugbot](https://cursor.com/cn/docs/bugbot)

> 想在 PR 上自动完成代码审查吗？试试 Bugbot，它会在每个 pull request 上自动执行高级分析，及早发现问题并给出改进建议。

Bugbot 会审查 Pull Request，并发现漏洞、安全问题和代码质量问题。

**工作原理**

Bugbot 会分析 PR 的 diff，并留下包含说明和修复建议的评论。它会在每次 PR 更新时自动运行，或在手动触发时运行。

* 在每次 PR 更新时运行**自动审查**
* 通过在任意 PR 下评论 `cursor review` 或 `bugbot run` 进行**手动触发**
* 将现有 PR 评论作为上下文：读取 GitHub PR 评论（顶层与内联），以避免重复建议并基于先前反馈继续改进
* 在 Cursor 中修复 链接会直接在 Cursor 中打开相关问题
* 在 Web 中修复 链接会直接在 `cursor.com/agents` 打开相关问题

**计费**

Bugbot 提供两个套餐：免费版 和 专业版。

免费套餐：每位付费方案用户每月可获得有限次数的免费 PR 评审。团队中每位成员都有各自的免费评审次数。达到上限后，评审将暂停，直至下一个计费周期。您可随时升级到付费的 Bugbot 方案以享受无限次评审。



## [Agent Skills](https://cursor.com/cn/docs/context/skills)

Agent Skills 是一种用于为 AI Agent 扩展专门能力的开放标准。Skills 将特定领域的知识和工作流打包，Agent 可以利用这些内容来执行特定任务。

### 什么是技能？

技能是一个可移植、支持版本控制的包，用于让 Agent 学会如何执行特定领域的任务。技能既可以包含说明性指令，也可以包含 Agent 可运行的脚本或代码。

![agent_skills](/assets/images/202601/agent_skills.png)


### 技能的工作原理

Cursor 启动时，会自动从技能目录中发现并加载技能，并将它们提供给 Agent 使用。Agent 会看到所有可用技能，并根据当前上下文决定何时调用它们。你也可以在 Agent 对话中输入 `/` 并搜索技能名称来手动调用技能。

### 技能目录

技能会自动从以下位置加载：

![agent_skills2](/assets/images/202601/agent_skills2.png)

每个技能应为一个包含 `SKILL.md` 文件的文件夹：

{% highlight bash %}
.cursor/
└── skills/
    └── my-skill/
        └── SKILL.md
{% endhighlight %}

技能还可以包含脚本、参考文件和资源等可选目录：

{% highlight bash %}
.cursor/
└── skills/
    └── deploy-app/
        ├── SKILL.md
        ├── scripts/
        │   ├── deploy.sh
        │   └── validate.py
        ├── references/
        │   └── REFERENCE.md
        └── assets/
            └── config-template.json
{% endhighlight %}

### SKILL.md 文件格式

每个 Skill 都在带有 YAML 前置信息（frontmatter）的 `SKILL.md` 文件中定义：

{% highlight markdown %}
---
name: my-skill
description: 简要描述此技能的功能及使用时机。
---

# 我的技能

为 Agent 提供的详细指令。

## 使用时机

- 在以下情况使用此技能...
- 此技能适用于...

## 指令

- 为 Agent 提供的分步指导
- 特定领域的约定
- 最佳实践和模式
- 如需向用户澄清需求,请使用提问工具
{% endhighlight %}

> Frontmatter 字段

![agent_skills3](/assets/images/202601/agent_skills3.png)

### 禁用自动调用

默认情况下，当 agent 判断某个 skill 相关时，会自动应用该 skill。将 `disable-model-invocation` 设为 **true**，可以让该 skill 的行为类似传统的斜杠命令（slash command），只有当你在聊天中显式输入 `/skill-name` 时，才会被包含进上下文。


### 在技能中包含脚本

技能可以包含 `scripts/` 目录，内含可由代理运行的可执行代码。在 `SKILL.md` 文件中使用相对于技能根目录的相对路径引用这些脚本。

{% highlight markdown %}
---
name: deploy-app
description: 将应用部署到预发布或生产环境。在部署代码时使用,或当用户提及部署、发布或环境时使用。
---

# Deploy App

Deploy the application using the provided scripts.

## Usage

Run the deployment script: `scripts/deploy.sh <environment>`

Where `<environment>` is either `staging` or `production`.

## Pre-deployment Validation

Before deploying, run the validation script: `python scripts/validate.py`
{% endhighlight %}

当技能被调用时，agent 会读取这些指令并执行引用的脚本。脚本可以使用任何语言编写，例如 Bash、Python、JavaScript，或 agent 实现所支持的任何其他可执行格式。

> **脚本应是自包含的，提供有用的错误信息，并能优雅地处理各种边界情况。**

### 可选目录

Skills 支持以下可选目录：

![agent_skills4](/assets/images/202601/agent_skills4.png)

**请让主 `SKILL.md` 文件保持简洁，将详细参考资料放在单独的文件中**。这样可以更高效地利用上下文，因为 Agents 会按需逐步加载资源——**只在需要时才加载**。

### 查看技能

要查看已发现的技能：

1. 打开 **Cursor Settings**（Mac 上为 `Cmd+Shift+J`，Windows/Linux 上为 Ctrl+Shift+J）
2. 前往 **Rules**
3. 技能会显示在 **Agent Decides** 部分中

### 从 GitHub 安装技能

可以从 GitHub 仓库导入技能：

1. 打开 **Cursor Settings** → **Rules**
2. 在 **Project Rules** 部分，点击 **Add Rule**
3. 选择 **Remote Rule (Github)**
4. 输入 GitHub 仓库的 URL


### 将规则和命令迁移到技能

Cursor 在 2.4 中内置了一个 `/migrate-to-skills` 技能，帮助你将现有的动态规则和斜杠命令转换为技能。

该迁移技能会转换：

* **Dynamic rules**：使用 "Apply Intelligently" 配置的规则——即 alwaysApply: false（或未定义）且未定义 globs 模式的规则。这些会被转换为标准技能。
* **Slash commands**：用户级和工作区级命令都会被转换为带有 disable-model-invocation: true 的技能，从而保留其显式调用行为。

**迁移步骤：**

1. 在 Agent 聊天中输入 `/migrate-to-skills`
2. Agent 会识别符合条件的规则和命令并将其转换为技能
3. 在 `.cursor/skills/` 中查看生成的技能

> **具有 alwaysApply: true 或特定 globs 模式的规则不会被迁移，因为它们有与技能行为不同的显式触发条件。用户规则也不会被迁移，因为它们不存储在文件系统中。**


### 了解更多

Agent Skills 是一项开放标准。详见 [agentskills.io](https://agentskills.io/home)。




## [Cursor CLI](https://cursor.com/cn/docs/cli/overview)

借助 Cursor CLI，你可以直接在终端与 AI 代理交互，以编写、审阅和修改代码。无论你偏好交互式终端界面，还是为脚本与 CI 流水线进行输出式自动化，CLI 都能在你的工作环境中提供强大的编码协助。

{% highlight bash %}
# 安装
curl https://cursor.com/install -fsS | bash

# 运行交互式会话
agent
{% endhighlight %}

![cursor_cli](/assets/images/202601/cursor_cli.png)

![cursor_cli2](/assets/images/202601/cursor_cli2.png)

![cursor_cli3](/assets/images/202601/cursor_cli3.png)

![cursor_cli4](/assets/images/202601/cursor_cli4.png)

![cursor_cli5](/assets/images/202601/cursor_cli5.png)

### 交互模式

与代理开启对话会话，用于阐述你的目标、审阅建议的更改并批准命令：

{% highlight bash %}
# 启动交互式会话
agent

# 使用初始提示启动
agent "重构认证模块以使用 JWT 令牌"
{% endhighlight %}

### 非交互模式

在脚本、CI 流水线或自动化等非交互场景下使用打印模式：

{% highlight bash %}
# 使用特定提示和模型运行
agent -p "find and fix performance issues" --model "gpt-5"

# 包含 git 变更以供审查
agent -p "review these changes for security issues" --output-format text
{% endhighlight %}


### 模式

命令行界面支持与编辑器相同的模式。可通过斜杠命令、键盘快捷键或 `--mode` 参数在不同模式之间切换。有关每种模式的详细信息，请参见 [Agent 模式](https://cursor.com/docs/agent/modes)。

![cursor_cli6](/assets/images/202601/cursor_cli6.png)


### 交由 Cloud Agent 接管

将你的对话推送到 [Cloud Agent](https://cursor.com/docs/cloud-agent)，让其在你离开时继续运行。在任意消息前加上 `&` 即可：

{% highlight bash %}
# 向 Cloud Agent 发送任务
& refactor the auth module and add comprehensive tests
{% endhighlight %}

在网页或移动端访问 [cursor.com/agents](https://cursor.com/agents)，继续处理你的 Cloud Agent 任务。


### 会话

继续之前的对话，在多次交互中保持上下文：

{% highlight bash %}
# List all previous chats
agent ls

# Resume latest conversation
agent resume

# 恢复指定对话
agent --resume="chat-id-here"
{% endhighlight %}


## [子代理](https://cursor.com/cn/docs/context/subagents)

子代理是 Cursor 主代理可以将任务委派给的专业化 AI 助手。每个子代理都在自己的上下文窗口中运行，处理特定类型的工作，并将结果返回给父代理。使用子代理可以拆解复杂任务、并行开展工作，并在主对话中保留上下文。

![cursor_subagent](/assets/images/202601/cursor_subagent.png)


### 子代理如何运作

当 Agent 遇到复杂任务时，它可以自动启动一个子代理。子代理会收到包含所有必要上下文的提示（prompt），自主执行，并在结束时返回一条包含结果的最终消息。子代理在全新的上下文中启动。父代理会在提示中加入相关信息，因为子代理无法访问之前的对话历史。

子代理可以以两种模式之一运行：

![cursor_subagent2](/assets/images/202601/cursor_subagent2.png)

### 内置子代理

Cursor 包含三个内置子代理，用于自动处理上下文占用较大的操作。这些子代理是基于对代理对话的分析而设计的，尤其是那些触及上下文窗口上限的场景。

![cursor_subagent3](/assets/images/202601/cursor_subagent3.png)

> 为什么存在这些子代理

这三类操作有一些共同特征：它们会生成噪声较多的中间结果，需要专门的提示词和工具，并且可能消耗大量上下文。将它们作为子代理运行，可以解决多个问题：

* **上下文隔离** — 中间输出保留在子代理内部，主代理只会看到最终总结。
* **模型灵活性** — Explore 子代理默认使用更快的模型，这样可以在主代理执行一次搜索的时间内并行运行 10 次搜索。
* **专用配置** — 每个子代理都有针对其特定任务优化的提示词和工具访问权限。
* **成本效益** — 更快的模型成本更低。把高 token 开销的工作隔离到使用合适模型的子代理中，可以降低整体成本。

**你不需要配置这些子代理。Agent 会在合适的时候自动使用它们。**

### 何时使用 subagent

![cursor_subagent4](/assets/images/202601/cursor_subagent4.png)

> 如果你发现自己正为一个简单、单一用途的任务（例如 "generate a changelog" 或 "format imports"）创建 subagent，考虑改用一个 [skill](https://cursor.com/docs/context/skills)。





# [Dashboard](https://cursor.com/cn/dashboard)

![cursor_dashboard](/assets/images/202512/cursor_dashboard.png)

![cursor_dashboard5](/assets/images/202512/cursor_dashboard5.png)

## 两个指标数据

* Lines of Agent Edits
* Tabs Accepted

![cursor_dashboard2](/assets/images/202512/cursor_dashboard2.png)

We released a change in late August 2025 that improved the accuracy of our analytics. This change is only available for users on Cursor 1.5+. Check [the documentation (使用分析)](https://cursor.com/cn/docs/account/teams/analytics) for more info.


![cursor_dashboard3](/assets/images/202512/cursor_dashboard3.png)

![cursor_dashboard4](/assets/images/202512/cursor_dashboard4.png)

## Usage 用量统计

![cursor_dashboard6](/assets/images/202512/cursor_dashboard6.png)

通过[这个工具脚本](https://github.com/gerryyang2025/my-tools/blob/master/cursor-usage/cursor-usage-analyze.py)可以用来分析 Cursor 输出的 Usage 使用情况：

![cursor-usage-key-metrics-analysis-sample](/assets/images/202512/cursor-usage-key-metrics-analysis-sample.png)

Auto 模型使用分析：

![cursor-usage-key-metrics-analysis-auto](/assets/images/202512/cursor-usage-key-metrics-analysis-auto.png)

Composer-1 模型使用分析：

![cursor-usage-key-metrics-analysis-composer-1](/assets/images/202512/cursor-usage-key-metrics-analysis-composer-1.png)




{% highlight python %}
# Sample data
SAMPLE_DATA = """Date,Kind,Model,Max Mode,Input (w/ Cache Write),Input (w/o Cache Write),Cache Read,Output Tokens,Total Tokens,Cost
2025-12-02T01:46:34.592Z,Included,auto,No,21865,0,68608,3043,93516,0.06
2025-12-01T13:15:54.637Z,Included,auto,No,26134,0,404992,9107,440233,0.19
2025-12-01T12:56:34.058Z,Included,auto,No,136654,0,853248,26477,1016379,0.54
2025-12-01T12:49:10.345Z,Included,auto,No,26323,0,190720,4617,221660,0.11
"""
{% endhighlight %}

各字段说明：

* Date
  + 使用时间戳，格式为 YYYY-MM-DDThh:mm:ss.sssZ，表示一次 AI 请求发生的时间。

* Kind
  + 表示该次使用是否被计入额度或账单。
  + **Included** 表示该次使用包含在订阅额度内，未产生额外费用（可能为免费额度或订阅内额度）。

* Model
  + 使用的 AI 模型，这里显示为 **auto**，表示 Cursor 自动选择合适的模型（如 GPT-4、Claude 等）。

* Max Mode
  + 是否开启了“最大模式”（通常是更长的上下文或更强的推理能力）。
  + **No** 表示未开启。

* Input (w/ Cache Write)
  + 带缓存写入的输入 Token 数量。
  + 指本次请求中，模型写入缓存的输入内容所占用的 Token 数。

* Input (w/o Cache Write)
  + 不带缓存写入的输入 Token 数量。
  + 指本次请求中，未写入缓存的输入内容所占用的 Token 数。

* Cache Read
  + 从缓存中读取的 Token 数量。
  + 如果本次请求中复用了之前缓存的内容，这里会显示读取的 Token 数。

* Output Tokens
  + 模型生成的输出 Token 数量。

* Total Tokens
  + 本次请求的总 Token 数量 = Input (w/ Cache Write) + Input (w/o Cache Write) + Cache Read + Output Tokens。

* Cost
  + 本次请求的费用（美元）。
  + 如果为 0.00 或很小，表示该次使用在免费额度内或已包含在订阅中。


## 如何通过 Cursor 的缓存机制优化成本

为什么需要缓存？

AI 模型处理 Token 时会产生计算成本。在很多场景中，**相同的输入会被重复处理**，比如：

* 相同的系统提示（System Prompt）
* 重复的代码片段
* 项目中的常量定义
* 通用的配置信息

缓存机制将这些计算结果存储起来，下次遇到相同内容时直接复用，避免重复计算。


Input (w/ Cache Write) - 写入缓存的输入

* 含义：本次请求中，**首次出现且值得缓存的内容**
* 会被存储到缓存中供后续使用
* 会计算成本（因为是首次处理）
* 示例：你在项目中第一次询问 "解释这个函数的作用"，这个问题的处理结果会被缓存


Input (w/o Cache Write) - 不写入缓存的输入

* 含义：**不存储到缓存的输入内容**
* 会计算成本（需要实时处理）
* 通常是因为内容：
  + 太独特，重复概率低
  + 包含敏感信息
  + 内容过长不适合缓存

Cache Read - 从缓存读取

* 含义：**从之前缓存中直接读取的内容**
* **也计费，只是成本比较低**（参考：https://cursor.com/cn/docs/models）
* **这是成本优化的关键指标**


执行过程示例：

{% highlight text %}
用户提问： "优化这段排序算法代码"
↓
Cursor 检查缓存：
   1. 是否有相同的 "优化这段排序算法代码" 请求？→ 直接返回
   2. 是否有相似的排序算法相关问题？→ 部分复用
   3. 完全没有？→ 全新处理
↓
如果是全新处理：
   - `Input (w/ Cache Write)` 增加
   - 结果存入缓存
↓
如果是缓存命中：
   - `Cache Read` 增加
   - `Input (w/ Cache Write)` 为 0
{% endhighlight %}

## Cost 成本计算公式

Cursor 中的 Cost 是基于**实际计费的 Token 数量**和**模型定价**计算得出的。按**每百万 tokens 计价**

> Cost = 输入 Token 数 × 输入单价 + 缓存写入 * 缓存写入单价 + 缓存读取 * 缓存读取单价 + 输出 Token 数 × 输出单价

Cursor 使用 混合模型（Auto 模式），不同模型价格不同。

### Auto 模式

启用 Auto 后，Cursor 会根据当前负载情况，为当前任务自动选择最适合且可靠性最高的高级模型。该功能还能检测到输出质量下降，并自动切换模型以解决问题。

![cursor_dashboard9](/assets/images/202512/cursor_dashboard9.png)


### Max 模式

通常，Cursor 使用 200k tokens（约 15,000 行代码）的上下文窗口。Max 模式会将少数模型的上下文窗口扩展到其支持的最大长度。这样速度会稍慢、成本也更高。它对 Gemini 2.5 Flash、Gemini 3 Pro、GPT 4.1 和 Grok 4 尤其适用，因为这些模型的上下文窗口都大于 200k。


# [Models](https://cursor.com/cn/docs/models)

## 支持的模型列表

Cursor 支持各大模型提供商的所有顶尖代码模型。

![cursor_dashboard7](/assets/images/202512/cursor_dashboard7.png)

## 上下文窗口

[上下文窗口](https://cursor.com/cn/learn/context)是指 LLM 在一次处理中可以同时考虑的最大 token 数量（包括文本和代码），其中既包含输入提示词，也包含模型生成的输出内容。

Cursor 中的每个对话都有自己的上下文窗口。在一次会话中，包含的提示词、附加文件和回复越多，加入的上下文就越多，可用的上下文窗口就会被逐渐占满。

在 Cursor 中了解更多[如何使用上下文](https://cursor.com/cn/learn/context)。

> 上下文限制

每个 AI 模型的上下文限制各不相同，一旦触及该限制，模型将不再接受更多消息。因此，许多 AI 工具会向用户提示他们距离该限制还有多近，或提供对当前对话进行压缩与总结的方式，以保持在限制之内。

![cursor_dashboard10](/assets/images/202512/cursor_dashboard10.png)


**默认上下文 200k**

在 Cursor 中，“默认上下文 200k”指的是**模型在单次请求中能够处理的上下文窗口大小为 200,000 tokens**。

![cursor_dashboard15](/assets/images/202512/cursor_dashboard15.png)


**什么是上下文窗口？**

* 上下文窗口 = 模型一次性能“看到”和处理的 tokens 数量上限
* 包括：**输入 + 输出的总和**
* 就像模型的工作内存或短期记忆

{% highlight text %}
模型实际处理的上下文大小 =
    Input (w/ Cache Write) +
    Input (w/o Cache Write) +
    Output Tokens
{% endhighlight %}

> 注意：
>
> 1. 上下文窗口 = 输入 + 输出，不能超过模型限制
> 2. Cache Read 不占用上下文，这是节省空间的关键

**通俗比喻**

* 想象一本 只能翻阅 200 页的书
* 模型只能阅读这 200 页内容来回答问题
* 超出部分它“看不到”


**容量感知：**

200,000 tokens ≈
- 150,000 个英文单词
- 300 页书的内容
- 约 5000 行代码（含注释）

**在 Cursor 中的体现：**

{% highlight text %}
你的请求结构：
┌─────────────────────────────────────┐
│ 系统提示 (System Prompt): ~2k tokens │
│ 你的问题 (User Query): ~1k tokens    │
│ 相关文件内容: ~50k tokens             │ ← Cursor 自动添加
│ 对话历史: ~50k tokens                │ ← 之前的问答
│ 模型回答: ~10k tokens                │
└─────────────────────────────────────┘
总计：~113k tokens < 200k
{% endhighlight %}

**上下文窗口的影响：**

**正面影响**

* 项目感知能力增强
  + Cursor 能看到更多相关文件
  + 理解代码之间的依赖关系

* 长对话记忆
  + 记住之前 50-100 个问答
  + 保持对话连贯性

* 复杂任务处理

{% highlight bash %}
# 可以一次性要求：
"分析整个项目的架构，找出性能瓶颈，然后为每个模块提供优化建议"
{% endhighlight %}

**潜在问题**

* 成本增加
  + 更大的上下文 = 更多的输入 tokens
  + 每次请求都包含大量内容

* 性能考虑
  + 处理 200k tokens 比处理 10k tokens 慢
  + 需要更多的计算资源




## Cursor 如何构建上下文


200k 上下文包括：

1. 系统指令 (5%)      - Cursor 的默认指令
2. 项目配置文件 (10%)  - `.cursorrules`
3. 打开的文件 (30-60%) - 你当前编辑/查看的文件
4. 对话历史 (20-40%)  - 本次会话的所有问答
5. 你的新问题 (1-5%)  - 本次输入的问题
6. 预留空间 (5-10%)   - 给模型的回答





## [模型与价格](https://cursor.com/cn/docs/models-and-pricing)

Cursor 支持来自 OpenAI、Anthropic、Google 等的所有最新一代代码模型。每个个人方案都包含**两个用量池**，方便你在智能水平、速度和成本之间找到合适的平衡。

### 用量池

有两个独立的用量池，每个都会在你的月度计费周期**重置**：

* **Auto + Composer**：当选择 Auto 或 Composer 2 时，包含的用量会显著增加。专为日常代理式编码设计，成本更低。
* **API**：按模型的 API 价格计费。个人套餐每月至少包含 $20 的 API 用量 (更高档位包含更多) ，并可根据需要额外付费购买用量。

这两个用量池都可以在你的编辑器设置和你的[用量仪表盘](https://cursor.com/cn/dashboard/usage)中查看。


### Auto + Composer 用量池

Auto 允许 Cursor 选择在智能能力、成本效益和可靠性之间取得平衡的模型。它适用于日常任务。

> Auto 定价

![cursor_price1](/assets/images/202603/cursor_price1.png)

> Composer 定价

Composer 2 是 Cursor 自研的模型，专门针对代理式编码 (agentic coding) 进行了强化训练。Auto 和 Composer 2 都从这个用量池中选取模型。

![cursor_price2](/assets/images/202603/cursor_price2.png)


### API 池

当你选择特定模型 (或使用 Premium 路由) 时，使用量将按该模型对应的 API 费率从 API 池中扣减。

所有价格均为每百万 tokens 的费用，数据来源于各提供商的 API 定价：(**以下是 2026年3月20日 显示的价格**)

![cursor_price3](/assets/images/202603/cursor_price3.png)


### 套餐

所有个人套餐都包含无限制的 Tab 补全、所有模型上的扩展 Agent 使用限额、对 Bugbot 的访问权限，以及对 Cloud Agents 的访问权限。

![cursor_price4](/assets/images/202603/cursor_price4.png)

> **由于不同模型的 API 成本不同，你选择的模型会影响所含用量的消耗速度**。

![cursor_price5](/assets/images/202603/cursor_price5.png)



### 历史记录

Cursor [套餐](https://cursor.com/docs/account/pricing)的使用量按各模型 API 的计费标准计算。例如，Pro 套餐中包含的 20 美元用量，会根据你选择的模型及其价格逐步消耗。

编辑器会根据你当前的使用情况显示使用额度。所有价格均按**每百万 tokens 计价**。

![cursor_dashboard8](/assets/images/202512/cursor_dashboard8.png)

这些价格来自各模型的 API 文档：

* [OpenAI 定价](https://openai.com/api/pricing/)
* [Anthropic 定价](https://www.anthropic.com/pricing#api)
* [Google Gemini 定价](https://ai.google.dev/gemini-api/docs/pricing)




## [推出 Composer 2](https://cursor.com/cn/blog/composer-2) (Mar 19, 2026)

它具备前沿水准的编码能力，定价为每百万输入 token 0.50、每百万输出 token 2.50，使其成为兼顾智能与成本的全新最优组合。

![composer-2-scatter-r4](/assets/images/202603/composer-2-scatter-r4.png)

我们正在快速提升模型质量。Composer 2 在我们衡量的所有[基准测试](https://cursor.com/blog/cursorbench)上都取得了大幅提升，其中包括 Terminal-Bench 2.01 和 SWE-bench Multilingual：

![composer-2-terminal-bench-score-r9](/assets/images/202603/composer-2-terminal-bench-score-r9.png)

![composer_compare](/assets/images/202603/composer_compare.png)

这些质量提升来自我们首次进行的持续预训练运行，为进一步扩展强化学习奠定了更强的基础。我们通过[强化学习](https://cursor.com/blog/self-summarization)训练 Composer 处理[长周期](https://cursor.com/blog/self-driving-codebases)编程任务的能力。Composer 2 能够解决需要数百个操作的高难度任务。

此外，**我们还提供了一个智能水平相同但速度更快的变体，定价为每百万输入 token 1.50、每百万输出 token 7.50，成本低于其他快速模型**。我们将把快速版设为默认选项。完整详情请参见我们的[模型文档](https://cursor.com/docs/models/cursor-composer-2)。

![composer-speed-cost-r12](/assets/images/202603/composer-speed-cost-r12.png)

对于个人方案，Composer 用量属于[独立的用量池](https://cursor.com/docs/models-and-pricing#usage-pools)，并包含充足的使用额度。




# [Cursor Learn](https://cursor.com/cn/learn)

本课程将教你如何借助 AI 提升编程效率。它并不是一门讲授机器学习或如何训练自有模型的课程，而是面向使用 AI 模型与工具编写软件的开发者的实用课程。

要真正用好 AI 工具，你需要理解模型的工作原理、模型的不同类型，以及它们的局限。

打个比方：想象你要从城这头到那头。有很多出行方式可选：

* 走路。免费，但更耗时。
* 骑车。要花点钱，稍快一些。
* 开车。最贵，但最快。

你可以在时间、金钱、可靠性和投入之间做取舍。





# Others

## [Cursor Composer 1 vs Claude 4.5 Sonnet: The better coding model](https://composio.dev/blog/cursor-composer-1-vs-claude-4-5-sonnet-the-better-coding-model) (Nov 11, 2025)

The AI coding race is heating up again. After OpenAI, Anthropic, and Google, Cursor has stepped into the game with its new model, **Composer 1**, a coding-focused agent model that’s said to be **4x faster than other models with similar intelligence**.

It’s said to output code at lightning speed, reason through large contexts, and even outperform models like **GPT-5** and **Claude Sonnet** in engineering workflows.

![cursor-composer1](/assets/images/202512/cursor-composer1.png)



# Refer

* https://github.com/getcursor/cursor
* https://www.cursor.com/features
* https://www.cursor.com/en
* [Cursor 中文文档](https://cursordocs.com/)
* [Cursor 英文文档](https://cursor.com/docs)
* https://cursor.document.top/
* [Transcript for Cursor Team: Future of Programming with AI - Lex Fridman Podcast #447](https://lexfridman.com/cursor-team-transcript)

